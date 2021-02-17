;; Controller layout definition of lnserver
;; Please add your license header here.
;; This file is generated automatically by GNU Artanis.
(define-artanis-controller layout) ; DO NOT REMOVE THIS LINE!!!

;; https://web-artanis.com/docs/manual.html#org5cb8432
;; (add-to-load-path "/home/mbc/projects/ln4/")

(use-modules (artanis artanis)(artanis utils)(artanis irregex)	     
	     (srfi srfi-1)(dbi dbi) (lnserver sys extra)
	      (ice-9 textual-ports)(ice-9 rdelim)(rnrs bytevectors)(web uri)(ice-9 pretty-print))

(define (prep-lyt-rows a)
  (fold (lambda (x prev)
          (let* ((id (get-c1 x))
                (sys-name (result-ref x "sys_name"))
		(name (result-ref x "name"))
		(descr (result-ref x "descr"))
		(plate-format-id (get-c5 x))
		(replicates (get-c6 x))
		(targets (get-c7 x))
		(use-edge (get-c8 x))
		(num-controls (get-c9 x))
		(unknown-n (get-c10 x))
		(control-loc (result-ref x "control_loc"))
		(source-dest (result-ref x "source_dest"))
		(id-html (string-append "<a href=\"/layout/lytbyid?id=" id "\">" sys-name "</a>") ))
            (cons (string-append "<tr><td>" id-html "</th><td>" name "</td><td>" descr "</td>
<td>"   plate-format-id "</td><td>" replicates "</td><td>" targets "</td>
<td>"  use-edge "</td><td>" num-controls "</td><td>" unknown-n "</td><td>" control-loc "</td><td>" source-dest "</td><tr>")
		  prev)))
        '() a))

(define (get-format-for-layout-id id rc)
  (let* ((sql (string-append "select  plate_format_id from plate_layout_name where id="  id))
	(ret (DB-get-all-rows(:conn rc sql) )))
     (number->string (cdaar ret))))

(define (get-layout-table-for-r id rc)
  (let* ((table-header (string-append "format\twell\ttype\trow\trow.num\tcol\treplicates\ttargets\n"))
	 (sql (string-append "select plate_format_id, by_col, well_type_id,row, row_num, col, plate_layout.replicates, plate_layout.target from plate_layout_name, plate_layout, well_numbers where plate_layout.well_by_col=well_numbers.by_col and plate_layout.plate_layout_name_id = plate_layout_name.id and well_numbers.plate_format=plate_layout_name.plate_format_id AND plate_layout.plate_layout_name_id =" id))
	 (holder (DB-get-all-rows(:conn rc sql) ))
	(body (string-concatenate (prep-lyt-for-r holder))))
    (string-append table-header body )))


(define (get-data-for-layout id data-file-name rc)
  (let* ((data-file data-file-name)
	 (p  (open-output-file data-file)))
    (put-string p (get-layout-table-for-r id rc) )
    (force-output p)
    ))


(define (prep-lyt-for-r a)
  (fold (lambda (x prev)
          (let* ((format (get-c1 x))	
		 (well (get-c2 x))
		 (type (get-c3 x))
		 (row (result-ref x "row"))
		 (row-num (get-c5 x))
		 (col (result-ref x "col"))
		 (replicates (get-c7 x ))
		 (targets (get-c8 x )))
            (cons (string-append  format "\t" well "\t" type "\t" row "\t" row-num "\t" col "\t" replicates "\t" targets  "\n")
		  prev)))
        '() a))


(layout-define getall
	       (options #:conn #t
			#:cookies '(names prjid userid sid))
  (lambda (rc)
    (let* ((help-topic "layouts")
	     (prjid (:cookies-value rc "prjid"))
	       (userid (:cookies-value rc "userid"))
	       (sid (:cookies-value rc "sid"))
	       (sql  "select id, sys_name, name, descr, plate_format_id, replicates, targets, use_edge, num_controls, unknown_n, control_loc, source_dest from plate_layout_name")
	   (holder  (DB-get-all-rows (:conn rc sql)))
	   (body (string-concatenate (prep-lyt-rows holder))))
   (view-render "getall" (the-environment)))))


(layout-define lytbyid
	       (options #:conn #t
			    #:cookies '(names prjid userid sid))
	       (lambda (rc)
		 (let* (
			(help-topic "layouts")
			(prjid (:cookies-value rc "prjid"))
			(userid (:cookies-value rc "userid"))
			(sid (:cookies-value rc "sid"))
			(id  (get-from-qstr rc "id"))
			(infile (get-rand-file-name "lyt" "txt"))
			(spl-out (get-rand-file-name "lyt" "png"))
			(spl-rep-out (get-rand-file-name "lyt" "png"))
			(trg-rep-out (get-rand-file-name "lyt" "png"))	 
			(outfile (string-append  (get-rand-file-name "lyt" "png")))
			(format (get-format-for-layout-id id rc))
			(sql (string-append "select id, sys_name, name, descr, plate_format_id, replicates, targets, use_edge, num_controls, unknown_n, control_loc, source_dest from plate_layout_name where id=" id))
			(holder (DB-get-all-rows (:conn rc sql)))
			(body (string-concatenate (prep-lyt-rows holder)))
			(dummy3 (get-data-for-layout id (string-append "pub/" infile) rc))
 			(dummy4 (system (string-append "Rscript --vanilla rscripts/plot-layout.R pub/" infile " pub/" spl-out " pub/" spl-rep-out " pub/" trg-rep-out " " format)))
			(spl-out2 (string-append "\"../" spl-out "\"" ))
			(spl-rep-out2 (string-append "\"../" spl-rep-out "\""))
			(trg-rep-out2  (string-append "\"../" trg-rep-out "\"")))
		   (view-render "lytbyid" (the-environment))  )))



(layout-define select
	        (options 
			    #:cookies '(names prjid userid sid))
  (lambda (rc)
    (let* ((help-topic "layouts")
	   (prjid (:cookies-value rc "prjid"))
	   (userid (:cookies-value rc "userid"))
	   (sid (:cookies-value rc "sid")))
      (view-render "select" (the-environment))
      )))

(define cs (char-set #\space #\tab #\newline #\return))

(define (get-types lst holder)
  ;; get the second column of types
  ;; an element looks like ("1\t5\r") trim the \r; split on \t
  (cond
   ((null? (cdr lst))
    (set! holder (cons  (cdr (string-split (string-trim-both (caar lst) cs) #\tab))  holder))
     holder)
   ((cdr lst)
    (set! holder (cons (cdr (string-split (string-trim-both (caar lst) cs) #\tab))  holder))
    (get-types (cdr lst) holder))
    (else #f)))

(define (count what list counter)
  ;;count the string elements
  ;;input is ("1" "1" "1")
  (cond
   ((null? (cdr list))
    (if (equal? what  (car list)) (set! counter (+ counter 1)) #f)
    counter)
   ((cdr list)
    (if (equal? what (car list)) (set! counter (+ counter 1)) #f)
    (count what (cdr list) counter))
   (else #f)))


 (post "/viewlayout"   #:from-post 'qstr 
   (lambda (rc)
     (let* ((help-topic "layouts")
	    (infile (get-rand-file-name "lyt" "txt")) ;;do not incorporate the "pub" here because the html
	    (spl-out  (get-rand-file-name "lyt" "png")) ;; does not want the pub
 	    (spl-out2 (string-append "\"" spl-out "\""))
	    (cookies  (rc-cookie rc))
 	    (a (uri-decode (:from-post rc 'get-vals "datatransfer")))
	    (b (map list (cdr (string-split a #\newline))))
	    (holder (get-types b '()))
	    (all-types (apply append holder))	   
	    (nunks (count "1" all-types 0))
	    (n2 (count "2" all-types 0))
	    (n3 (count "3" all-types 0))
	    (n4 (count "4" all-types 0))
	    (nedge (count "5" all-types 0))
	    (ncontrols (+ n2 n3 n4))
 	    (format (:from-post rc 'get-vals "format2"))
	    (file-port (open-output-file (string-append "pub/" infile)))
	    (dummy (display a file-port))
	    (dummy2 (force-output file-port))
	    (dummy (system (string-append "Rscript --vanilla rscripts/plot-review-layout.R pub/" infile " pub/" spl-out " " format ))))
    (view-render "viewlayout" (the-environment))
   )))



 (define (prep-sql-suffix list sqlsuffix)
  ;;input is (88\t90\r)
  (cond
   ((null? (cdr list))
    (set! sqlsuffix (string-append sqlsuffix "(" (string-trim-both (caar list) cs) ", " (string-trim-both  (cadar list) cs)  ", 1, 1) "))
    sqlsuffix)
   ((cdr list)
    (set! sqlsuffix (string-append sqlsuffix "(" (string-trim-both  (caar list) cs) ", " (string-trim-both  (cadar list) cs)  ", 1, 1), "))
    (prep-sql-suffix (cdr list) sqlsuffix))
   (else #f)))


(define (get-sql-layout-file f)
  (if (access? f R_OK)
      (let* (
	     (my-port (open-input-file f))
	     (ret #f)
	     (holder '())
	     (message "")
	     (ret (read-line my-port))
	     (header (string-split ret #\tab))
	     (result (if (and (string=? (string-trim-both (car header) cs) "well")
			     (string=? (string-trim-both (cadr header) cs) "type"))
			  (let* (
				 (ret (read-line my-port))
				 (dummy2 (while (not (eof-object? ret))
					   (set! holder (cons (string-split ret #\tab) holder))
					   (set! ret (read-line my-port))))
				 (holder2 (prep-sql-suffix holder "")))		     
			    holder2))))	
	result)
      #f))


(post "/updatedb"  #:conn #t #:from-post 'qstr 
  (lambda (rc)
    (let* ((help-topic "layouts")
	  (infile (uri-decode (:from-post rc 'get-vals "infile")))
	  (format  (:from-post rc 'get-vals "format"))
	  (lytname (:from-post rc 'get-vals "lytname"))
	  (descr (:from-post rc 'get-vals "descr"))
	  (contloc (:from-post rc 'get-vals "contloc"))
	  (nunks  (:from-post rc 'get-vals "nunks"))
	  (ncontrols  (:from-post rc 'get-vals "ncontrols"))
	  (nedge (:from-post rc 'get-vals "nedge"))
	  (sql "TRUNCATE TABLE import_plate_layout")
	  (dummy (:conn rc sql))
	  (sqlsuffix (get-sql-layout-file (string-append "pub/" infile)))
	  (sqlprefix "INSERT INTO import_plate_layout (well_by_col, well_type_id, replicates, target) VALUES ")
	  (sql (string-append sqlprefix sqlsuffix))
	  (dummy (:conn rc sql))
	  (sql (string-append "SELECT create_layout_records('" lytname "', '" descr "', '" contloc "', " ncontrols ", " nunks ", " format ", " nedge ")"))
	  (dummy (:conn rc sql))
	  (dummy (sleep 5))
	)
   (redirect-to rc "/layout/getall" )
  )))



;; (layout-define success
;; 	       (lambda (rc)
;; 		 (let* ((help-topic "layouts"))		   
;;  (view-render "success" (the-environment)))
;; 	       ))
