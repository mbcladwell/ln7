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
		 (type (get-c9 x))
		 (reps (get-c10 x ))
		 (trg (get-c11 x ))
		 (splid (get-c12 x ))
		 )
            (cons (string-append  assay-run-id "\t" plate-order "\t" well "\t" response "\t" bkgrnd-sub "\t" norm "\t" norm-pos "\t" p-enhance "\t" type "\t" reps "\t" trg "\t" splid "\n")
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

;; SELECT * FROM get_scatter_plot_data(?);

(define (get-assayrun-table-for-r arid data-file-name rc)
  (let* ((table-header (string-append "assay.run.id\tplate.order\twell\tresponse\tbkgrnd.sub\tnorm\tnorm.pos\tp.enhance\ttype\treps\ttrgt\tsmplid\n"))
	 ;;(sql  (string-append "select assay_run_id, plate_order, well, response, bkgrnd_sub, norm, norm_pos, p_enhance, well_type.name from assay_result, assay_run, well_numbers, plate_layout_name, plate_layout, well_type where plate_layout_name.id=plate_layout.plate_layout_name_id AND plate_layout_name.plate_format_id=well_numbers.plate_format AND plate_layout.well_type_id=well_type.id AND plate_layout.well_by_col=assay_result.well AND assay_result.assay_run_id=assay_run.id AND assay_run.plate_layout_name_id=plate_layout_name.id AND well_numbers.by_row=assay_result.well AND assay_run_id=" id))
	 (sql (string-append "SELECT * FROM get_scatter_plot_data(" arid ")"))
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
	      (cons (string-append "<tr><td>" assay-run-sys-name "</td><td>" assay-run-name "</td><td>" assay-type-name "</td><td><a href=\"/hitlist/gethlbyid?id=" (substring hit-list-sys-name 3) "\">"  hit-list-sys-name "</a></td><td>"  hit-list-name "</td><td>" descr "</td><td>" nhits "</td><tr>")
		  prev)))
        '() a))



(define (get-hit-lists-for-arid id rc)
  (let* ((sql (string-append "select assay_run.id, assay_run.assay_run_sys_name, assay_run.assay_run_name, assay_type.assay_type_name, hit_list.hitlist_sys_name, hit_list.hitlist_name, hit_list.descr, hit_list.n  FROM assay_run, plate_set, hit_list, assay_type WHERE assay_type.id=assay_run.assay_type_id AND hit_list.assay_run_id=assay_run.id  AND assay_run.plate_set_id=plate_set.id AND assay_run.id =" id ))
	(holder (DB-get-all-rows (:conn rc sql))))
	(string-concatenate (prep-hl-for-ar-rows holder))))


(define (prep-ar-rows-no-link a)
  ;; this differs from the one in extra.scm in that it does not provide AR-1 as hyperlink
  ;; i.e. you are already on the assay-run page so there is no need to link again
  (fold (lambda (x prev)
          (let* (
                (assay-run-sys-name (result-ref x "assay_run_sys_name"))
		(assay-run-name (result-ref x "assay_run_name"))
		(descr (result-ref x "descr"))
		(assay-type-name (result-ref x "assay_type_name"))
		(sys-name (result-ref x "sys_name"))
		(lytid (substring sys-name 4))
		(name (result-ref x "name"))
		)
            (cons (string-append "<tr><td>" assay-run-sys-name "</td><td>" assay-run-name "</td><td>" descr "</td><td>" assay-type-name "</td><td><a href=\"/layout/lytbyid?id=" lytid  "\">" sys-name "</a></td><td>" name "</td><tr>")
		  prev)))
        '() a))

;; Response
;; public static final int RAW = 0;
;; public static final int NORM = 1;
;; public static final int NORM_POS = 2;
;; public static final int P_ENHANCE = 3;
 
;; Metric
;; TopN = 1
;; Mean+2SD = 2
;; Mean+3SD = 3
;; >0% enhance = 4



(assayrun-define getarid
		 (options #:conn #t #:cookies '(names id infile infile2 response threshold body))
(lambda (rc)
  (let* (
	 (help-topic "assayrun")
	 (arid  (get-from-qstr rc "arid"))
	  (prjid (:cookies-value rc "prjid"))
	  (userid (:cookies-value rc "userid"))
	  (group (:cookies-value rc "group"))
	  (sid (:cookies-value rc "sid"))
	 (infile (get-rand-file-name "ar" "txt"))
	 (infile2 (get-rand-file-name "ar2" "txt"))
	 (outfile (get-rand-file-name "ar" "png"))
	 (hitfile (get-rand-file-name "hl" "txt"))
	 (response "1")
	 (threshold "3")
	(sql (string-append "select assay_run.id, assay_run.assay_run_sys_name, assay_run.assay_run_name, assay_run.descr, assay_type.assay_type_name, plate_layout_name.sys_name, plate_layout_name.name FROM assay_run, assay_type, plate_layout_name WHERE assay_run.plate_layout_name_id=plate_layout_name.id AND assay_run.assay_type_id=assay_type.id AND assay_run.id =" arid ))
	(holder (DB-get-all-rows (:conn rc sql)))
	(body (string-concatenate (prep-ar-rows-no-link holder)))
	(body-encode (htmlify body))
	;;(dummy (:cookies-set! rc 'body "body" body))
	(dummy3 (get-assayrun-table-for-r arid (string-append "pub/" infile) rc))
	(dummy4 (get-assayrun-stats-for-r arid (string-append "pub/" infile2) rc))
	(dummy5 (system (string-append "Rscript --vanilla ../lnserver/rscripts/plot-assayrun.R pub/" infile " pub/" infile2 " pub/" outfile " pub/" hitfile " " response  " " threshold )))
	(outfile2 (string-append "\"../" outfile "\""))
	(hit-lists (get-hit-lists-for-arid arid rc))	
	(hit-lists-encode (if  (equal? "" hit-lists) #f (htmlify hit-lists)))
	(aridq (addquotes arid))  ;; for passing to html
	(infileq (addquotes infile))
	(infile2q (addquotes infile2))
	(hitfileq (addquotes hitfile))
	(responseq (addquotes response))
	(thresholdq (addquotes threshold))
	(body-encodeq (addquotes body-encode))
	(hit-lists-encodeq (if hit-lists-encode (addquotes  hit-lists-encode) #f))
	)
   ;; (view-render "test" (the-environment)))))
    (view-render "getarid" (the-environment)))))


(define (get-hitlist-as-list f )
  ;;for counting and making int array for postgres
  (if (access? f R_OK)
      (let* (
	     (my-port (open-input-file f))
	     (ret #f)
	     (holder '())
	     (ret (stripfix (read-line my-port)))
	     (header (string-split ret #\tab))
	     (result (let* (
			    (ret (read-line my-port))
			    (dummy2 (while (not (eof-object? ret))
				      (if (equal? (car (string-split (stripfix ret) #\tab)) "") #f
					  (set! holder (cons (string-split (stripfix ret) #\tab) holder)))
				      (set! ret  (read-line my-port))))
			    )	 
		       holder)))
	     result)
      #f))


(post "/assayrun/replot"
      #:from-post 'qstr
      #:cookies '(names id infile infile2 response threshold body)
		 (lambda (rc)
		   (let* (
			  (help-topic "assayrun")
			  (prjid (:cookies-value rc "prjid"))
			  (sid (:cookies-value rc "sid"))
			  (arid  (stripfix (:from-post rc 'get-vals "arid")))
			  (infile (stripfix (:from-post rc 'get-vals "infile")))
			  (infile2 (stripfix (:from-post rc 'get-vals "infile2")))
			  (outfile (get-rand-file-name "ar" "png"))	 
			  (hitfile (get-rand-file-name "hl" "txt"))
			  ;;(hitfile (stripfix (:from-post rc 'get-vals "hitfile")))
			  (body-encode   (uri-decode (:from-post rc 'get-vals "bodyencode"))) ;;body of the ar table
			  (body (dehtmlify body-encode))
			  (hit-lists-encode (uri-decode (:from-post rc 'get-vals "hitlistsencode")))
			  (hit-lists (dehtmlify hit-lists-encode))
			  (response (stripfix (:from-post rc 'get-vals "response")))
			  (threshold (stripfix (:from-post rc 'get-vals "threshold")))
			  (manthreshold (stripfix (:from-post rc 'get-vals "manthreshold")))
			  (usethreshold (if (equal? manthreshold "") threshold manthreshold))
			  (rscript (string-append "Rscript --vanilla ../lnserver/rscripts/plot-assayrun.R pub/" infile " pub/" infile2 " pub/" outfile " pub/" hitfile " " response  " " usethreshold ))
			  (dummy (system rscript))
			  (gethitfile (string-append "../lnserver/pub/" hitfile))
			  (aslist (get-hitlist-as-list gethitfile))
			  (numhits (number->string (length aslist)))
			  (outfile2 (string-append "\"../" outfile "\""))
			  (aridq (addquotes arid))  ;; for passing to html
			  (responseq (addquotes response)) ;;needed for view hits but will change with replot
			  (thresholdq (addquotes usethreshold))  ;; "
			  (infileq (addquotes infile))
			  (infile2q (addquotes infile2))
			  (hitfileq (addquotes hitfile))
			  (numhitsq (addquotes numhits))
			  (body-encodeq (addquotes body-encode))
			  (hit-lists-encodeq (addquotes hit-lists-encode))
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
            (cons (string-append "<tr><td><a href=\"/hitlist/getid?id=" (number->string (cdr (car x))) "\">" hit-list-sys-name "</a></td><td>" hit-list-name "</td><td>" descr "</td><tr>")
		  prev)))
        '() a))




(define (prep-alldata a)
  ;; this differs from the one in extra.scm in that it does not provide AR-1 as hyperlink
  ;; i.e. you are already on the assay-run page so there is no need to link again
  (fold (lambda (x prev)
          (let* ( (assay-run-sys-name (result-ref x "assay_run_sys_name"))
		(plate-set-sys-name (result-ref x "plate_set_sys_name"))
		(plate-sys-name (result-ref x "plate_sys_name"))
		(plate-order (get-c4 x ))
		(well-name (result-ref x "well_name"))
		(type-well (result-ref x "type_well"))
		(by-col (get-c7 x))
		(response (get-c8 x))
		(bkgrnd-sub (get-c9 x))
		(norm (get-c10 x))
		(norm-pos (get-c11 x))
		(p-enhance (get-c12 x))
	     
		(sample-sys-name (result-ref x "sample_sys_name"))
		(accs-id (result-ref x "accs_id"))
		(target-name (result-ref x "target_name"))
		(target-accs (result-ref x "target_accs"))
		)
            (cons (string-append "<tr><td>" assay-run-sys-name "</td><td>" plate-set-sys-name "</td><td>" plate-sys-name "</td><td>" plate-order "</td><td>" well-name "</td><td>" type-well "</td><td>" by-col "</td><td>" response "</td><td>" bkgrnd-sub "</td><td>" norm "</td><td>" norm-pos "</td><td>" p-enhance "</td><td>" sample-sys-name "</td><td>" accs-id "</td><td>" target-name"</td><td>" target-accs "</td><tr>")
		  prev)))
        '() a))



(post "/assayrun/getalldata"
      #:from-post 'qstr
      #:cookies '(names sid prjid)
      #:conn #t
		 (lambda (rc)
		   (let* (
			  (help-topic "assayrun")
			  (prjid (:cookies-value rc "prjid"))
			  (sid (:cookies-value rc "sid"))
			  (arid  (stripfix (:from-post rc 'get-vals "arid")))
			  (sql (string-append "Select * from get_all_data_for_assay_run(" arid ")"))
			  (holder (DB-get-all-rows (:conn rc sql)))
			  (body (string-concatenate (prep-alldata holder)))
	
			  (aridq (addquotes arid))  ;; for passing to html
			  )
		    (view-render "getalldata" (the-environment)))))
	    ;; (view-render "test" (the-environment)))))
