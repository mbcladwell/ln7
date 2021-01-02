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
            (cons (string-append "<tr><th>" id-html "</th><th>" name "</th><th>" descr "</th><th>"   plate-format-id "</th><th>" replicates "</th><th>" targets "</th><th>"  use-edge "</th><th>" num-controls "</th><th>" unknown-n "</th><th>" control-loc "</th><th>" source-dest "</th><tr>")
		  prev)))
        '() a))

(define (get-format-for-layout-id id)
  (let* ((ret #f)
	(dummy (dbi-query ciccio  (string-append "select  plate_format_id from plate_layout_name where id="  id)))
	(ret (dbi-get_row ciccio)))
    (number->string (cdar ret))))

(define (get-layout-table-for-r id)
  (let* ((ret #f)
	(holder '())
	(table-header (string-append "format\twell\ttype\trow\trow.num\tcol\treplicates\ttargets\n"))
	(dummy (dbi-query ciccio  (string-append "select plate_format_id, by_col, well_type_id,row, row_num, col, plate_layout.replicates, plate_layout.target from plate_layout_name, plate_layout, well_numbers where plate_layout.well_by_col=well_numbers.by_col and plate_layout.plate_layout_name_id = plate_layout_name.id and well_numbers.plate_format=plate_layout_name.plate_format_id AND plate_layout.plate_layout_name_id =" id)))
	(ret (dbi-get_row ciccio))
	(dummy2 (while (not (equal? ret #f))     
		  (set! holder (cons ret holder))		   
		  (set! ret  (dbi-get_row ciccio))
		  
		  ))
	(body (string-concatenate (prep-lyt-for-r holder))))
    (string-append table-header body )))


(define (get-data-for-layout id data-file-name)
  (let* ((data-file data-file-name)
	 (p  (open-output-file data-file)))
    (put-string p (get-layout-table-for-r id) )
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
	       (options #:conn #t)
  (lambda (rc)
    (let* ((help-topic "layouts")
	   (sql  "select id, sys_name, name, descr, plate_format_id, replicates, targets, use_edge, num_controls, unknown_n, control_loc, source_dest from plate_layout_name")
	   (holder  (DB-get-all-rows (:conn rc sql)))
	   (body (string-concatenate (prep-lyt-rows holder))))
   (view-render "getall" (the-environment)))))


(layout-define lytbyid
	       (options #:conn #t)
	       (lambda (rc)
		 (let* (
			(help-topic "layouts")
			(id  (get-from-qstr rc "id"))
			(infile (get-rand-file-name "lyt" "txt"))
			(spl-out (get-rand-file-name "lyt" "png"))
			(spl-rep-out (get-rand-file-name "lyt" "png"))
			(trg-rep-out (get-rand-file-name "lyt" "png"))	 
			(outfile (string-append  (get-rand-file-name "lyt" "png")))
			(format (get-format-for-layout-id id))
			(sql (string-append "select id, sys_name, name, descr, plate_format_id, replicates, targets, use_edge, num_controls, unknown_n, control_loc, source_dest from plate_layout_name where id=" id))
			(holder (DB-get-all-rows (:conn rc sql)))
			(body (string-concatenate (prep-lyt-rows holder)))
			(dummy3 (get-data-for-layout id (string-append "pub/" infile)))
 			(dummy4 (system (string-append "Rscript --vanilla ../lnserver/rscripts/plot-layout.R pub/" infile " pub/" spl-out " pub/" spl-rep-out " pub/" trg-rep-out " " format)))
			(spl-out2 (string-append "\"../" spl-out "\"" ))
			(spl-rep-out2 (string-append "\"../" spl-rep-out "\""))
			(trg-rep-out2  (string-append "\"../" trg-rep-out "\"")))
		   (view-render "lytbyid" (the-environment))  )))



 (layout-define select
  (lambda (rc)
    (let* ((help-topic "layouts"))
      (view-render "select" (the-environment))
      )))

(define (count what list)
  ;;note you must set counter=0 in the let
  ;; works with list of strings ("1" "1" "1" "5")
   (if (null? (cdr list))
       (if (equal? what  (car list)) (set! counter (+ counter 1)))	
       ((if (equal? what (car list)) (set! counter (+ counter 1)))
	(count what (cdr list)))))

(define (get-types lst)
  ;;from the layout text extracts the second columns of types as a list
  ;;must set holder '()
  (if (null? (cdr lst))
      (set! holder (cons (cdr (string-split (caar lst) #\tab)) holder))
      (let ((c (set! holder (cons (cdr (string-split (caar lst) #\tab)) holder))))
	(get-types (cdr lst)))))

  
 (post "/viewlayout"   #:from-post 'qstr 
   (lambda (rc)
     (let* ((help-topic "layouts")
	    (infile (get-rand-file-name "lyt" "txt")) ;;do not incorporate the "pub" here because the html
	    (spl-out  (get-rand-file-name "lyt" "png")) ;; does not want the pub
 	    (spl-out2 (string-append "\"" spl-out "\""))
	    (cookies  (rc-cookie rc))
 	    (a (uri-decode (:from-post rc 'get-vals "datatransfer")))
	    (b (map list (cdr (string-split a #\newline))))
	    (holder '())
	    (dummy (get-types b))
	    (all-types (apply append holder))
	    (counter 0)
	    (dummy (count "1" all-types))
	    (nunk counter)
	    (counter 0)
	    (dummy (count "2" all-types))
	    (n2 counter)
	    (counter 0)
	    (dummy (count "3" all-types))
	    (n3 counter)
	    (counter 0)
	    (dummy (count "4" all-types))
	    (n4 counter)
	    (ncontrols (+ n2 n3 n4))
 	    (format (:from-post rc 'get-vals "format2"))
	    (file-port (open-output-file infile))
	    (dummy (display a file-port))
	    (dummy2 (force-output file-port))
	    (dummy (system (string-append "Rscript --vanilla rscripts/plot-review-layout.R pub/" infile " pub/" spl-out " " format ))))
    (view-render "viewlayout" (the-environment))
   )))




(layout-define updatedb
  (lambda (rc)
    (let* (
	  (file-name  (get-from-qstr rc "submit"))
	 (help-topic "layouts")

	)
   (view-render "success" (the-environment))
  )))

(layout-define success
  (lambda (rc)
    (let* (
	  (file-name  (get-from-qstr rc "submit"))
	 (help-topic "layouts")

	)
   (view-render "getall" (the-environment))
  )))

