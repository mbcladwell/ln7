;; Controller assayrun definition of lnserver
;; Please add your license header here.
;; This file is generated automatically by GNU Artanis.
(define-artanis-controller assayrun) ; DO NOT REMOVE THIS LINE!!!

(use-modules (artanis utils)(artanis irregex)(srfi srfi-1)(dbi dbi)
	     (lnserver sys extra)(rnrs bytevectors)
	     (ice-9 textual-ports)(ice-9 rdelim)(web uri))


(define (prep-ar-for-r a)
  (fold (lambda (x prev)
          (let* ((assay-run-id (get-c1 x))	
		 (plate-order (get-c2 x))
		 (well (get-c3 x ))
		 (response (get-c4 x ))
		 (bkgrnd-sub (get-c5 x))
		 (norm (get-c6 x ))
		 (norm-pos (get-c7 x ))
		 (p-enhance (get-c8 x ))
		 (type (result-ref x "name" )))
            (cons (string-append  assay-run-id "\t" plate-order "\t" well "\t" response "\t" bkgrnd-sub "\t" norm "\t" norm-pos "\t" p-enhance "\t" type "\n")
		  prev)))
        '() a))

 


(define (prep-ar-stats-for-r a)
  (fold (lambda (x prev)
          (let* ((response-type (get-c1 x))	
		 (max-response (get-c2 x))
		 (min-response (get-c3 x ))
		 (mean-bkgrnd (get-c4 x ))
		 (std-dev-bkgrnd (get-c5 x))
		 (mean-pos (get-c6 x ))
		 (stdev-pos (get-c7 x ))
		 (mean-neg-3-sd (get-c8 x ))
		 (mean-neg-2-sd (get-c9 x ))
		 (mean-pos-3-sd (get-c10 x ))
		 (mean-pos-2-sd (get-c11 x ))
		 )
            (cons (string-append "\t" response-type "\t"  max-response "\t" min-response "\t" mean-bkgrnd "\t" std-dev-bkgrnd "\t"  mean-pos "\t"  stdev-pos "\t" mean-neg-3-sd "\t" mean-neg-2-sd "\t" mean-pos-3-sd "\t"  mean-pos-2-sd "\n")
		  prev)))
        '() a))



(define (get-assayrun-table-for-r id data-file-name rc)
  (let* ((table-header (string-append "assay.run.id\tplate.order\twell\tresponse\tbkgrnd.sub\tnorm\tnorm.pos\tp.enhance\ttype\n"))
	 (sql  (string-append "select assay_run_id, plate_order, well, response, bkgrnd_sub, norm, norm_pos, p_enhance, well_type.name from assay_result, assay_run, well_numbers, plate_layout_name, plate_layout, well_type where plate_layout_name.id=plate_layout.plate_layout_name_id AND plate_layout_name.plate_format_id=well_numbers.plate_format AND plate_layout.well_type_id=well_type.id AND plate_layout.well_by_col=assay_result.well AND assay_result.assay_run_id=assay_run.id AND assay_run.plate_layout_name_id=plate_layout_name.id AND well_numbers.by_row=assay_result.well AND assay_run_id=" id))
	 (holder (DB-get-all-rows (:conn rc sql)))
	 (body (string-append table-header (string-concatenate (prep-ar-for-r holder))))
	 (p  (open-output-file data-file-name)))
    (begin
      (put-string p body )
      (force-output p))))


;; (define (get-data-for-assayrun id data-file-name)
;;   (let* ((data-file data-file-name)
;; 	 (p  (open-output-file data-file)))
;;     (put-string p (get-assayrun-table-for-r id) )
;;     (force-output p)
;;     ))



(define (get-assayrun-stats-for-r id data-file-name rc)
  (let* ((table-header (string-append "response.type\tmax.response\tmin.response\tmean.bkgrnd\tstd.dev.bkgrnd\t mean.pos\t stdev.pos\tmean.neg.3.sd\tmean.neg.2.sd\tmean.pos.3.sd\t mean.pos.2.sd\n"))
	(holder (DB-get-all-rows (:conn rc  (string-append "select response_type,  max_response, min_response, mean_bkgrnd, std_dev_bkgrnd,  mean_pos,  stdev_pos, mean_neg_3_sd, mean_neg_2_sd, mean_pos_3_sd,  mean_pos_2_sd from assay_run_stats where assay_run_id=" id))))
	(body (string-append table-header (string-concatenate (prep-ar-stats-for-r holder))))
	(p  (open-output-file data-file-name)))
    (begin
      (put-string p body)
      (force-output p))))

;; response
;; 0 raw
;; 1 norm
;; 2 norm_pos
;; 3 p_enhanced
;; Threshold
;; 1  mean-pos
;; 2  mean-neg-2-sd
;; 3  mean-neg-3-sd


(define (prep-hl-for-ar-rows a)
  (fold (lambda (x prev)
          (let ((id (get-c1 x))
                (assay-run-sys-name (result-ref x "assay_run_sys_name"))
                (assay-run-name (result-ref x "assay_run_name"))
		(assay-type-name (result-ref x "assay_type_name"))
		(hit-list-sys-name (result-ref x "hitlist_sys_name"))
		(hit-list-name (result-ref x "hitlist_name"))
		(descr (result-ref x "descr"))
		(nhits (get-c8 x))
		)
	      (cons (string-append "<tr><th><a href=\"/hitlist/gethlforarid?id=" id  "\">" assay-run-sys-name "</a></th><th>" assay-run-name "</th><th>" assay-type-name "</th><th><a href=\"/hitlist/gethlbyid?id=" (substring hit-list-sys-name 3) "\">"  hit-list-sys-name "</a></th><th>"  hit-list-name "</th><th>" descr "</th><th>" nhits "</th><tr>")
		  prev)))
        '() a))



(define (get-hit-lists-for-arid id rc)
  (let* ((sql (string-append "select assay_run.id, assay_run.assay_run_sys_name, assay_run.assay_run_name, assay_type.assay_type_name, hit_list.hitlist_sys_name, hit_list.hitlist_name, hit_list.descr, hit_list.n  FROM assay_run, plate_set, hit_list, assay_type WHERE assay_type.id=assay_run.assay_type_id AND hit_list.assay_run_id=assay_run.id  AND assay_run.plate_set_id=plate_set.id AND assay_run.id =" id ))
	(holder (DB-get-all-rows (:conn rc sql))))
	(string-concatenate (prep-hl-for-ar-rows holder))))


(assayrun-define getid
		 (options #:conn #t #:cookies '(names id infile infile2 response threshold body))
(lambda (rc)
  (let* (
	 (help-topic "assayrun")
	 (id  (get-from-qstr rc "id"))
	  (prjid (:cookies-value rc "prjid"))
	  (userid (:cookies-value rc "userid"))
	  (group (:cookies-value rc "group"))
	  (sid (:cookies-value rc "sid"))
	 (infile (get-rand-file-name "ar" "txt"))
	 (infile2 (get-rand-file-name "ar2" "txt"))
	 (outfile (get-rand-file-name "ar" "png"))	  
	 (response "1")
	 (threshold "3")
	(sql (string-append "select assay_run.id, assay_run.assay_run_sys_name, assay_run.assay_run_name, assay_run.descr, assay_type.assay_type_name, plate_layout_name.sys_name, plate_layout_name.name FROM assay_run, assay_type, plate_layout_name WHERE assay_run.plate_layout_name_id=plate_layout_name.id AND assay_run.assay_type_id=assay_type.id AND assay_run.id =" id ))
	(holder (DB-get-all-rows (:conn rc sql)))
	(body (string-concatenate (prep-ar-rows holder)))
	(body-encode (htmlify body))
	;;(dummy (:cookies-set! rc 'body "body" body))
	(dummy3 (get-assayrun-table-for-r id (string-append "pub/" infile) rc))
	(dummy4 (get-assayrun-stats-for-r id (string-append "pub/" infile2) rc))
	(dummy5 (system (string-append "Rscript --vanilla ../lnserver/rscripts/plot-assayrun.R pub/" infile " pub/" infile2 " pub/" outfile " " response  " " threshold )))
	(outfile2 (string-append "\"../" outfile "\""))
	(hit-lists (get-hit-lists-for-arid id rc))	
	(hit-lists-encode (if  (equal? "" hit-lists) #f (htmlify hit-lists)))
	(idq (addquotes id))  ;; for passing to html
	(infileq (addquotes infile))
	(infile2q (addquotes infile2))
	(body-encodeq (addquotes body-encode))
	(hit-lists-encodeq (if hit-lists-encode (addquotes  hit-lists-encode) #f))
	)
;;    (view-render "test" (the-environment)))))
    (view-render "getarid" (the-environment)))))


(post "/assayrun/replot" #:from-post 'qstr
		 (lambda (rc)
		   (let* (
			  (help-topic "assayrun")
			  (id  (stripfix (:from-post rc 'get-vals "id")))
			  (infile (stripfix (:from-post rc 'get-vals "infile")))
			  (infile2 (stripfix (:from-post rc 'get-vals "infile2")))
			  (body-encode   (:from-post rc 'get-vals "bodyencode")) ;;body of the ar table
			  (body (dehtmlify  body-encode))
			  (hit-lists-encode (:from-post rc 'get-vals "hitlistsencode"))
			  (hit-lists (dehtmlify hit-lists-encode))
			  (outfile (get-rand-file-name "ar" "png"))	 
			  (response (stripfix (:from-post rc 'get-vals "response")))
			  (threshold (stripfix (:from-post rc 'get-vals "threshold")))
			  (manthreshold (stripfix (:from-post rc 'get-vals "manthreshold")))
			  (usethreshold (if (equal? manthreshold "") threshold manthreshold))
			  (rscript (string-append "Rscript --vanilla ../lnserver/rscripts/plot-assayrun.R pub/" infile " pub/" infile2 " pub/" outfile " " response  " " usethreshold ))
			  (dummy (system rscript))
			  (outfile2 (string-append "\"../" outfile "\""))
			  (id (addquotes id))  ;; for passing to html
			  (infile (addquotes infile))
			  (infile2 (addquotes infile2))
			  (body-encode (addquotes body-encode))
			  (hit-lists-encode (addquotes hit-lists-encode))
			  )
		     (view-render "replot" (the-environment)))))
	     ;;(view-render "test" (the-environment)))))



;; not finished maybe not used
(define (get-hl-for-ar-id arid )
  (lambda (rc)
 (let* ((help-topic "hitlist")
	 ;;(id  (get-from-qstr rc "id"))
	(sql (string-append "select id, hitlist_sys_name, hitlist_name, descr FROM hit_list WHERE  assay_run_id =" arid ))
	(holder (DB-get-all-rows(:conn rc sql)))
	(body (string-concatenate (prep-hl-rows holder))))
    (view-render "gethlforarid" (the-environment)))))

;; done before debug session established
(define (prep-hl-rows a)
  (fold (lambda (x prev)
          (let (
                (hit-list-sys-name (result-ref x "hitlist_sys_name"))
		(hit-list-name (result-ref x "hitlist_name"))
		(descr (result-ref x "descr"))
		)
            (cons (string-append "<tr><th><a href=\"/hitlist/getid?id=" (number->string (cdr (car x))) "\">" hit-list-sys-name "</a></th><th>" hit-list-name "</th><th>" descr "</th><tr>")
		  prev)))
        '() a))
