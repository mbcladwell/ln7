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


;; 
;; this works
(post "/upload"  #:cookies '(names format infile )  #:from-post 'bv 
      (lambda (rc)
	(let*((help-topic "layouts")
	      (infile (get-rand-file-name "lyt" "txt"))
	      (spl-out (get-rand-file-name "lyt" "png"))
 	      (spl-out2 (string-append "\"../" spl-out "\""))
	      (cookies  (rc-cookie rc))
	      (a (utf8->string (rc-body rc)))
	      (dummy (:cookies-set! rc 'infile "infile" infile))
	      ;;(dummy2 (:cookies-set! rc 'spl-out2 "spl-out2" spl-out2))
	      ;;(format  (:cookies-ref rc 'format "format"))
	      (format  (:from-post rc 'get-vals "format"))
	      ;;(format "384")
	    ;;  (file-port (open-output-file infile))
	    ;;  (dummy (display a file-port))
	    ;;  (dummy2 (force-output file-port))
	    ;;  (origfile "test")
	    ;;  (dummy (system (string-append "Rscript --vanilla ../lnserver/rscripts/plot-review-layout.R " infile " " spl-out " " format )))
	      )
	  
	 ;; (redirect-to rc (string->uri "/viewlayout"))
	   (view-render "/upload" (the-environment))
;;	  #f
	  )))
 
  
;;  (layout-define viewlayout 
;;    (lambda (rc)
;;      (let* ((help-topic "layouts")
;; ;;	    (:cookies-set! rc 'cc "sid" "123321")
;;  	    ;;(body-content (utf8->string (rc-body rc)))
;; 	    (spl-out2 "blank")
;; 	    )
;;     (view-render "viewlayout" (the-environment))
;;    )))



;; this needs the r wrangling code
;; (layout-define viewlayout
;;   (lambda (rc)
;;     (let* ((help-topic "layouts")
;; 	   (origfile (get-from-qstr rc "origfile"))
;; 	   (infile  (get-from-qstr rc "infile"))
;; 	   (spl-out (get-rand-file-name "lyt" "png"))
;; 	   (dummy (system (string-append "Rscript --vanilla ../lnserver/rscripts/plot-review-layout.R " infile " " spl-out )))
;; 	   (spl-out2 (string-append "\"../" spl-out "\""))
;; 	  (body-content (utf8->string (rc-body rc))))
;;    (view-render "viewlayout" (the-environment))
;;   )))

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

