;; Controller plateset definition of lnserver
;; Please add your license header here.
;; This file is generated automatically by GNU Artanis.
(define-artanis-controller plateset) ; DO NOT REMOVE THIS LINE!!!

(use-modules (artanis utils)(artanis irregex)(artanis cookie)
	     (srfi srfi-1)(dbi dbi)(web uri)
	     (srfi srfi-19)   ;; date time
	     (lnserver sys extra)(ice-9 match)
	     (srfi srfi-11) ;; let-values
	     (ice-9 textual-ports)(ice-9 rdelim)
	     )

(define (prep-ps-for-prj-rows a)
  (fold (lambda (x prev)
          (let* (
                (plate_set_sys_name (result-ref x "plate_set_sys_name"))
                (plate_set_name (result-ref x "plate_set_name"))
		(descr (result-ref x "descr"))
		(type (result-ref x "plate_type_name"))
		(numplates (get-c6 x))
		(format  (get-c7 x))
		(layout (get-c8 x))
		(reps (get-c9 x))
		(idval (string-append (number->string (cdr (car x))) "+" numplates "+" format "+" layout "+" reps ))
		)
            (cons (string-append "<tr><th> <input type=\"checkbox\" id=\"" plate_set_sys_name  "\" name=\"plateset-id\" value=\"" idval "\" onclick=\"handleChkbxClick()\"></th><th><a href=\"/plate/getpltforps?id=" (number->string (cdr (car x))) "\">" plate_set_sys_name "</a></th><th>" plate_set_name "</th><th>" descr "</th><th>" type "</th><th>" numplates "</th><th>" format "</th><th>" layout "</th><th>" reps "</th></tr>")
		  prev)))
        '() a))




(define (get-assay-runs-for-prjid id rc)
  (let* ((sql (string-append "select assay_run.id, assay_run.assay_run_sys_name, assay_run.assay_run_name, assay_run.descr, assay_type.assay_type_name, plate_layout_name.sys_name, plate_layout_name.name FROM assay_run, assay_type, plate_set, plate_layout_name WHERE assay_run.plate_layout_name_id=plate_layout_name.id AND assay_run.assay_type_id=assay_type.id AND assay_run.plate_set_id=plate_set.id AND plate_set.project_id =" id ))
	(holder (DB-get-all-rows (:conn rc sql))))
	 (string-concatenate (prep-ar-rows holder))))

(define (prep-hl-for-prj-rows a)
  (fold (lambda (x prev)
          (let* ((id (get-c1 x))
                (assay-run-sys-name (result-ref x "assay_run_sys_name"))
                (assay-run-name (result-ref x "assay_run_name"))
		(assay-type-name (result-ref x "assay_type_name"))
		(hit-list-sys-name (result-ref x "hitlist_sys_name"))
		(hit-list-id (substring hit-list-sys-name 3))
		(hit-list-name (result-ref x "hitlist_name"))
		(descr (result-ref x "descr"))
		(nhits (get-c8 x))
		)
	      (cons (string-append "<tr><th><a href=\"/assayrun/getid?id=" id  "\">" assay-run-sys-name "</a></th><th>" assay-run-name "</th><th>" assay-type-name "</th><th><a href=\"/hitlist/gethlbyid?id=" hit-list-id  "\">" hit-list-sys-name "</a></th><th>" hit-list-name "</th><th>" descr "</th><th>" nhits "</th><tr>")
		    prev)
	      ))
        '() a))



(define (get-hit-lists-for-prjid id rc)
  (let* ((sql (string-append "select assay_run.id, assay_run.assay_run_sys_name, assay_run.assay_run_name, assay_type.assay_type_name, hit_list.hitlist_sys_name, hit_list.hitlist_name, hit_list.descr, hit_list.n  FROM assay_run, plate_set, hit_list, assay_type WHERE assay_type.id=assay_run.assay_type_id AND hit_list.assay_run_id=assay_run.id  AND assay_run.plate_set_id=plate_set.id AND plate_set.project_id =" id ))
	(holder (DB-get-all-rows (:conn rc sql))))
	(string-concatenate (prep-hl-for-prj-rows holder))))



;;    (display holder)))

;; (get-hit-lists-for-prjid "1")

(plateset-define getps
		 (options #:conn #t #:cookies '(names prjid sid))
		 (lambda (rc)
		   (let* (
			  (help-topic "plateset")
			  (prjid  (get-from-qstr rc "id"))
			  (dummy (:cookies-set! rc 'prjid "prjid" prjid))
			  (sql (string-append "select plate_set.id, plate_set_sys_name, plate_set_name, plate_set.descr, plate_type_name, num_plates, plate_set.plate_format_id, plate_layout_name_id, plate_layout_name.replicates from plate_set, plate_type, plate_layout_name where plate_set.plate_type_id=plate_type.id AND plate_set.plate_layout_name_id=plate_layout_name.id AND plate_set.project_id =" prjid ))
			  (holder (DB-get-all-rows (:conn rc sql)))
			  (body  (string-concatenate  (prep-ps-for-prj-rows holder)) )
			  (assay-runs (get-assay-runs-for-prjid prjid rc))
			  (hit-lists (get-hit-lists-for-prjid prjid rc))
			  )      
		     (view-render "getps" (the-environment))
		     )))



(post "/plateset/editps"
		  #:conn #t #:from-post 'qstr
		  (lambda (rc)
		    (let* ((help-topic "plateset")	
			   ;;(qstr  (:from-post rc 'get))
			  ;; (a (delete #f (map (match-lambda (("plateset-id" x) x)(_ #f))  qstr)))
			  ;; (b (map uri-decode  a))
			  ;; (a   (:from-post rc 'get-vals "plateset-id"))
			   (b  (list (uri-decode (:from-post rc 'get-vals "plateset-id"))))
			   (activity (:from-post rc 'get-vals "activity"))
			   (dummy (cond
				   ((equal? activity "edit")
				    (let*-values((start (map string-split b (circular-list #\+))) ;;((1 2 96 1) (2 2 96 1))
					  (psid (caar start))
					  (sql (string-append "select plate_set_name, descr from plate_set where id=" psid ))
					  (holder   (car (DB-get-all-rows (:conn rc sql))))
					  (descr  (object->string (cdadr holder)))
					  (name (object->string (cdar holder)))
					  
					  )
				       #f)
				    )
				   ((equal? activity "group")
				    #f
				    )
				   ((equal? activity "reformat")
				    #f
				    )
				   (else
				    (view-render  "test" (the-environment) )))
				   )
			   ;;javascript prevents the selection of more than one plateset
			   
			   )
		      (cond
		       ((equal? activity "edit")
			(view-render "edit" (the-environment))
			)
		       (else #f))		     
		   )))


(plateset-define editaction
		(options #:conn #t #:cookies '(names prjid sid))
		(lambda (rc)
		  (let* ((help-topic "plateset")
			 (prjid (:cookies-ref rc 'prjid "prjid"))
			 (ps-name (get-from-qstr rc "psname"))
			 (descr (get-from-qstr rc "descr"))
			 (psid (get-from-qstr rc "psid"))			 
			 (sql (string-append "UPDATE plate_set SET plate_set_name='" ps-name "', descr='" descr "' WHERE id=" psid))
			 (dummy (:conn rc sql))
			 )
;;		    (view-render "test" (the-environment))
		    (redirect-to rc (string-append "plateset/getps?id="  prjid))
  )))



(post "/plateset/group"
		  #:conn #t #:from-post 'qstr
		  (lambda (rc)
		    (let* ((help-topic "group")
			   (today (date->string  (current-date) "~Y-~m-~d"))
			   (qstr  (:from-post rc 'get))
			   (a (delete #f (map (match-lambda (("plateset-id" x) x)(_ #f))  qstr)))
			   (b (map uri-decode  a))
			   (start (map string-split b (circular-list #\+))) ;;((1 2 96 1) (2 2 96 1))
			   (c (map string-append (circular-list "PS-")  (map car start) ))
			   (d (map string-append c (circular-list " (")  ))
			   (ps-num-text  (string-join (map string-append d (map cadr start) (circular-list ");"))))
			   (tot-plates (apply + (map string->number (map cadr start))))
			   (format-equal? (apply equal? (map caddr start)))
			   (layout-equal? (apply equal? (map cadddr start)))
			   (format (car (map caddr start)))
			   (lyt-id (car (map cadddr start)))
			   (sql2 (string-append "SELECT name, descr from plate_layout_name where id =" lyt-id))
			   (holder2    (car  (DB-get-all-rows (:conn rc sql2))))
			   (lyt-txt (string-append  (cdar  holder2)  "; "  (cdadr  holder2)) )			     			   
			   (sql3 (string-append "SELECT id, plate_type_name from plate_type"))
			   (holder3  (DB-get-all-rows (:conn rc sql3)))
			   (plate-types-pre '())
			   (plate-types (dropdown-contents-with-id holder3 plate-types-pre))
			   )
		      (if (and format-equal? layout-equal?)
			  (view-render "groupps" (the-environment))
			  (view-render "grouperror" (the-environment))))))
		      

		      
(plateset-define add
		 (options #:conn #t
			  #:cookies '(names prjid lnuser userid group sid))
		 (lambda (rc)
		   (let* ((help-topic "plateset")
			  (format (get-from-qstr rc "format"))
			  (type (get-from-qstr rc "type"))
			  (prjid (get-from-qstr rc "prjid"))
			  (userid (:cookies-value rc "userid"))
			  (group (:cookies-value rc "group"))
			  (sid (:cookies-value rc "sid"))
			  (reps 1)
			  (sql (string-append "select id, name from plate_layout_name WHERE plate_format_id =" format))
			  (holder  (DB-get-all-rows (:conn rc sql)))
			  (sample-layout-pre '())
			  (sample-layouts  (dropdown-contents-with-id holder sample-layout-pre))
			  (sql2 (if (= reps 0)				    
				    (string-append "SELECT id, target_layout_name_name FROM target_layout_name WHERE (project_id= " prjid "  OR project_id IS NULL )")   
				    (string-append "SELECT id, target_layout_name_name FROM target_layout_name WHERE (project_id= " prjid " AND reps = " (number->string reps) ") OR (project_id IS NULL AND reps = " (number->string reps) ")")))

			  (holder2  (DB-get-all-rows (:conn rc sql2)))
			  (target-layout-pre '())
			  (target-layouts  (dropdown-contents-with-id holder2 target-layout-pre))
			  
			  (sql3 (string-append "SELECT id, plate_type_name from plate_type"))
			  (holder3  (DB-get-all-rows (:conn rc sql3)))
			  (plate-types-pre '())
			  (plate-types (dropdown-contents-with-id holder3 plate-types-pre))
			  (trg-desc "(for assay plates only)")
			  (prjidq (addquotes prjid))
			  (useridq (addquotes userid))
			  (groupq (addquotes group))
			  (sidq (addquotes sid))

			  )      
		     (view-render "add" (the-environment)))))



(post "/plateset/createbygroup"
		  #:conn #t #:from-post 'qstr #:cookies '(names prjid sid)
		  (lambda (rc)
		    (let* ((help-topic "plateset")
			   (today (date->string  (current-date) "~Y-~m-~d"))
			   (qstr  (:from-post rc 'get))
			   (psname  (car (delete #f (map (match-lambda (("psname" x) x)(_ #f))  qstr))))
			   (descr   (car (delete #f (map (match-lambda (("descr" x) x)(_ #f))  qstr))))
			   (tot-plates (car (delete #f (map (match-lambda (("totplates" x) x)(_ #f))  qstr))))
			   (format  (car (delete #f (map (match-lambda (("format" x) x)(_ #f))  qstr))))
			   (type  (car (delete #f (map (match-lambda (("type" x) x)(_ #f))  qstr))))
			   (lyt-id  (car (delete #f (map (match-lambda (("lytid" x) x)(_ #f))  qstr))))
			   (cookies (rc-cookie rc))
			   (acook (:cookies-ref rc 'prjid "prjid"))
			   (prjid "1")
			   (sid "9999999999")
			    ;; see dbi.groupPlateSetsIntoNewPlateSet
			   ;;CREATE OR REPLACE FUNCTION new_plate_set_from_group(_descr VARCHAR(30),_plate_set_name VARCHAR(30), _num_plates INTEGER, _plate_format_id INTEGER, _plate_type_id INTEGER, _project_id INTEGER, _plate_layout_name_id INTEGER, _sessions_id VARCHAR(32))
			   ;; returns plate-set-id
			   (sql (string-append "SELECT new_plate_set_from_group('" descr "', '" psname "', " tot-plates ", " format ", " type ", " prjid ", " lyt-id ", '" sid "')"))

			   (psid (DB-get-all-rows (:conn rc sql)))
			   (sql2 (string-append "select plate_set.id, plate_set_sys_name, plate_set_name, plate_set.descr, plate_type_name, num_plates, plate_set.plate_format_id, plate_layout_name_id, plate_layout_name.replicates from plate_set, plate_type, plate_layout_name where plate_set.plate_type_id=plate_type.id AND plate_set.plate_layout_name_id=plate_layout_name.id AND plate_set.project_id =" prjid ))
			  (holder (DB-get-all-rows (:conn rc sql2)))
			  (body  (string-concatenate  (prep-ps-for-prj-rows holder)) )
			  (assay-runs (get-assay-runs-for-prjid prjid rc))
			  (hit-lists (get-hit-lists-for-prjid prjid rc))
			  
			   )
		      (view-render "getps" (the-environment))
		     ;; (view-render "test" (the-environment))
		      
		      )))


(define (transfer-data-to-server d)
  ;;this accepts a data transfer e.g. (:from-post rc 'get-vals "datatransfer")
  ;;which must be uri-decoded
  ;;the datatransfer is read by javascript on the client
  (let* (
	 (a (uri-decode d))
	;; (b (map list (cdr (string-split a #\newline))))
	 (temp-f (string-append "pub/" (get-rand-file-name "rnd" "txt")))
	 (p  (open-output-file temp-f))
	 (dummy (begin
		  (put-string p a )
		  (force-output p))))
    temp-f))



(define (process-ar-row lst results arid)
  (if (null? (cdr lst))
        (begin
	 (set! results  (string-append results "(" (number->string arid) ", " (caar lst) ", " (cadar lst) ", "  (caddar lst)   ")" ))
       results)
       (begin
	 (set! results (string-append results "("  (number->string arid) ", " (caar lst) ", " (cadar lst) ", "  (caddar lst)   ")," ))
	 (process-ar-row (cdr lst) results arid)) ))

    
(define (get-sql-assay-results-file f arid)
  ;;for processing the tab delimitted file on the server
  (if (access? f R_OK)
      (let* (
	     (my-port (open-input-file f))
	     (ret #f)
	     (holder '())
	     (message "")
	     (ret (stripfix (read-line my-port)))
	     (header (string-split ret #\tab))
	     (result (let* (
			    (ret (read-line my-port))
			    (dummy2 (while (not (eof-object? ret))
				      (if (equal? (car (string-split (stripfix ret) #\tab)) "") #f
					  (set! holder (cons (string-split (stripfix ret) #\tab) holder)))
				      (set! ret  (read-line my-port))))
			    (holder2 (process-ar-row holder "" arid))
			    (sql (string-append "INSERT INTO assay_result_pre (assay_run_id, plate_order, well, response) VALUES " holder2)))	 
				 sql)))
	     result)
      #f))
;; (if (and (string=? (car header) "plate")
;; 			     (string=? (cadr header) "well")
;; 			     (string=? (caddr header) "response"))


(define (process-list-into-pgarray lst results)
  ;; results is a string like "'{"2" "3" "4"}'" note the single quotes
 (if (null? (cdr lst))
        (begin
	 (set! results  (string-append results "\"" (number->string (cdar lst)) "\"" ))
       (string-append "'{" results  "}'"))
       (begin
	 (set! results  (string-append results "\"" (number->string (cdar lst)) "\","  ))
	 (process-list-into-pgarray (cdr lst) results)) ))

  
(define (make-threshold-hitlist threshold arid rc)
(let* ((sql (string-append "SELECT  well_sample.sample_id FROM assay_result, assay_run, plate_layout_name, plate_layout, plate_set, plate, plate_plate_set, well_numbers, well, well_sample WHERE assay_run.plate_set_id = plate_set.id AND assay_run.plate_layout_name_id = plate_layout_name.id AND assay_run.id=assay_result.assay_run_id AND assay_result.plate_order = plate_plate_set.plate_order AND assay_result.well = well.by_col AND plate_set.plate_layout_name_id = plate_layout_name.id AND plate_set.plate_format_id = well_numbers.plate_format AND plate_layout.well_by_col=well.by_col AND plate_set.id = plate_plate_set.plate_set_id AND plate_plate_set.plate_id = plate.id AND plate.id = well.plate_id AND well.by_col = well_numbers.by_col AND well_sample.well_id =  well.id AND well.by_col=well_numbers.by_col AND plate_layout_name.id= plate_layout.plate_layout_name_id AND plate_layout.well_type_id=1 AND assay_result.assay_run_id = " (number->string arid) " AND assay_result.norm > " (number->string threshold)  " ORDER BY assay_result.norm"))
       (all-hit-ids  (DB-get-all-rows(:conn rc sql)))
       (numhits (length all-hit-ids))
       (a (map car all-hit-ids))	 
       (results (process-list-into-pgarray a ""))
	 )
    (list numhits results)
    ))

(define (make-topN-hitlist name descr numhits arid sid rc)
  (let* ((sql (string-append "SELECT  well_sample.sample_id FROM assay_result, assay_run, plate_layout_name, plate_layout, plate_set, plate, plate_plate_set, well_numbers, well, well_sample WHERE assay_run.plate_set_id = plate_set.id AND assay_run.plate_layout_name_id = plate_layout_name.id AND assay_run.id=assay_result.assay_run_id AND assay_result.plate_order = plate_plate_set.plate_order AND assay_result.well = well.by_col AND plate_set.plate_layout_name_id = plate_layout_name.id AND plate_set.plate_format_id = well_numbers.plate_format AND plate_layout.well_by_col=well.by_col AND plate_set.id = plate_plate_set.plate_set_id AND plate_plate_set.plate_id = plate.id AND plate.id = well.plate_id AND well.by_col = well_numbers.by_col AND well_sample.well_id =  well.id AND well.by_col=well_numbers.by_col AND plate_layout_name.id= plate_layout.plate_layout_name_id AND plate_layout.well_type_id=1 AND assay_result.assay_run_id = " (number->string arid) " ORDER BY assay_result.norm limit "  numhits))
	 (all-hit-ids  (DB-get-all-rows(:conn rc sql)))
	 (a (map car all-hit-ids))	 
	 (results (process-list-into-pgarray a ""))
	 )
    results
    ))



(post "/plateset/impassdatadb"  #:conn #t #:from-post 'qstr
		 (lambda (rc)
		   (let* (
			  (help-topic "plateset")
			  ;;(filename (:from-post rc 'get-vals "myfile"))
			 ;; (a (:from-post rc 'get-vals "datatransfer"))
			  ;;(b (map list (cdr (string-split a #\newline))))
			  (datafile (uri-decode (:from-post rc 'get-vals "datafile")))
			  (psid (:from-post rc 'get-vals "psid"))
			  (num-plates (:from-post rc 'get-vals "numplates"))
			  (format (:from-post rc 'get-vals "format"))
			 ;; (rows-needed (:from-post rc 'get-vals "rows-needed"))
			  (assay-descr (:from-post rc 'get-vals "assay-descr"))
			  (ps-descr (uri-decode (:from-post rc 'get-vals "ps-descr")))
			  (control-loc (uri-decode (:from-post rc 'get-vals "controlloc")))
			  (assay-name (:from-post rc 'get-vals "assayname"))
			  (assay-type (:from-post rc 'get-vals "assay-type"))
			  (sql (string-append "SELECT id from assay_type where assay_type_name ='" assay-type "'"))
			  (assay-type-id (object->string (cdaar (DB-get-all-rows (:conn rc sql)))))
			  (lyt-sys-name (uri-decode (:from-post rc 'get-vals "lytsysname")))
			  (plt-lyt-name-id  (substring lyt-sys-name 4))
			  (algorithm (:from-post rc 'get-vals "algorithm"))
			  (hl-name (:from-post rc 'get-vals "hlname"))
			  (hl-descr (:from-post rc 'get-vals "hldescr"))
			  (session-id "1")
			  (sql2 (string-append "SELECT new_assay_run('" assay-name "', '" assay-descr  "', " assay-type-id ", " psid ", " plt-lyt-name-id ", " session-id ")"))
		  	  ;;(lyt-txt (string-append lyt-sys-name ";" lyt-name ))
			  (assay-run-id (cdaar (DB-get-all-rows (:conn rc sql2))))
			 ;; (assay-run-id 2)
			  (sql3 (get-sql-assay-results-file datafile assay-run-id))
			  (dummy (:conn rc sql3))
			  (sql4 (string-append "SELECT process_assay_run_data( " (number->string assay-run-id)  ")"))
			  (dummy (:conn rc sql4))
			  (dummy (sleep 5))
			  (threshold (cond
				      ((equal? algorithm "1")  ;;Top N
				       (let* ((numhits (:from-post rc 'get-vals "nhits"))
					      (pgarray (make-topN-hitlist hl-name hl-descr numhits assay-run-id session-id rc))
					      (sql (string-append "SELECT new_hit_list ('" hl-name "', '" hl-descr "', "  numhits ", " (number->string assay-run-id) ", " session-id ", " pgarray ")" ))
					      (dummy (:conn rc sql))
					      )	 #f) )
				      
				      ((equal? algorithm "2")  ;; mean(background) + 2SD
				       (let* ((sql (string-append "SELECT mean_neg_2_sd FROM assay_run_stats WHERE response_type = 2 AND assay_run_id=" (number->string assay-run-id )))
					      (threshold (cdaar (DB-get-all-rows (:conn rc sql))))
					      (results (make-threshold-hitlist threshold assay-run-id rc))
					      (sql2 (string-append "SELECT new_hit_list ('" hl-name "', '" hl-descr "', "  (number->string (car results)) ", " (number->string assay-run-id) ", " session-id ", "  (cadr results) ")" ))
					      (dummy (:conn rc sql2))
					      )
					 #f   ))
				       
				      ((equal? algorithm "3")  ;; mean(background) + 3SD
				       (let* ((sql (string-append "SELECT mean_neg_3_sd FROM assay_run_stats WHERE response_type = 2 AND assay_run_id=" (number->string assay-run-id )))
					      (threshold (cdaar (DB-get-all-rows (:conn rc sql))))
					      (results (make-threshold-hitlist threshold assay-run-id rc))
					      (sql2 (string-append "SELECT new_hit_list ('" hl-name "', '" hl-descr "', "  (number->string (car results)) ", " (number->string assay-run-id) ", " session-id ", "  (cadr results) ")" ))
					      (dummy (:conn rc sql2))
					      )
					 #f   ))
				      
				      ((equal? algorithm "4") ;; >0% enhanced
				       (let* ((sql (string-append "SELECT mean_pos FROM assay_run_stats WHERE response_type = 2 AND assay_run_id=" (number->string assay-run-id )))     
					      (threshold (cdaar (DB-get-all-rows (:conn rc sql))))
					      (results (make-threshold-hitlist threshold assay-run-id rc))
					      (sql2 (string-append "SELECT new_hit_list ('" hl-name "', '" hl-descr "', "  (number->string (car results)) ", " (number->string assay-run-id) ", " session-id ", "  (cadr results) ")" ))
					      (dummy (:conn rc sql2)))
					      					      
					 #f   ))					 
				      (else #f))))
		     
		     (redirect-to rc (string-append "plate/getpltforps?id" psid))
		   ;; (view-render "test" (the-environment))
		     )))



 ;; String insertSql = "SELECT new_hit_list ( ?, ?, ?, ?, ?, ?);";
 ;;      PreparedStatement insertPs =
 ;;          conn.prepareStatement(insertSql, Statement.RETURN_GENERATED_KEYS);
 ;;      insertPs.setString(1, _name);
 ;;      insertPs.setString(2, _description);
 ;;      insertPs.setInt(3, _num_hits);
 ;;      insertPs.setInt(4, _assay_run_id);
 ;;      insertPs.setInt(5, session_id);
 ;;      insertPs.setArray(6, conn.createArrayOf("INTEGER", hit_list));


;; CREATE OR REPLACE FUNCTION new_hit_list(_name VARCHAR(250), _descr VARCHAR(250), _num_hits INTEGER, _assay_run_id INTEGER, _sessions_id VARCHAR(32), hit_list integer[])
;;   RETURNS void AS
;; $BODY$
;; DECLARE
;;  hl_id INTEGER;
;;  hl_sys_name VARCHAR(10);
;;  s_id INTEGER;
;; BEGIN


;;   INSERT INTO hit_list(hitlist_name, descr, n, assay_run_id, sessions_id)
;;    VALUES (_name, _descr, _num_hits, _assay_run_id, _sessions_id)
;;    RETURNING id INTO hl_id;

;;     UPDATE hit_list SET hitlist_sys_name = 'HL-'|| hl_id WHERE id=hl_id;
    
;; FOR i IN 1.._num_hits loop
;;  INSERT INTO hit_sample(hitlist_id, sample_id)VALUES(hl_id, hit_list[i]);
;; END LOOP;

;; END;
;; $BODY$
;;   LANGUAGE plpgsql VOLATILE;



(post "/plateset/impdataaction"  #:conn #t #:from-post 'qstr
		 (lambda (rc)
		   (let* (
			  (help-topic "plateset")
			  (filename (:from-post rc 'get-vals "myfile"))
			  (a (:from-post rc 'get-vals "datatransfer"))
			  ;;(b (map list (cdr (string-split a #\newline))))
			  (temp-file (transfer-data-to-server a))
			  (psid (:from-post rc 'get-vals "psid"))
			  (num-plates (:from-post rc 'get-vals "num-plates"))
			  (format (:from-post rc 'get-vals "format"))
			  (rows-needed (:from-post rc 'get-vals "rows-needed"))
			  (descr (:from-post rc 'get-vals "descr"))
			  (ps-descr (uri-decode (:from-post rc 'get-vals "ps-descr")))
			  (control-loc (uri-decode (:from-post rc 'get-vals "control-loc")))
			  (lyt-sys-name (:from-post rc 'get-vals "lyt-sys-name"))
			  (lyt-name (uri-decode (:from-post rc 'get-vals "lyt-name")))			  
		  	 (lyt-txt (string-append lyt-sys-name ";" lyt-name ))
			  )
		     
		     (view-render "impdataaction" (the-environment))
		     ;;(view-render "test" (the-environment))
		     )))



(post "/plateset/importpsdata"
		  #:conn #t #:from-post 'qstr
		  (lambda (rc)
		    (let* ((help-topic "plateset")	
			   (all-ps-ids  (list (uri-decode (:from-post rc 'get-vals "plateset-id")))) ;;these are the checked ps-ids - should be only one
			   (activity (:from-post rc 'get-vals "activity"))
			  ;; (filename (:from-post rc 'get-vals "myfile"))
			  
			   (start (map string-split all-ps-ids (circular-list #\+))) ;;((1 2 96 1) (2 2 96 1))
			   (psid (caar start))
			   (sql (string-append "select plate_set.plate_set_name, plate_set.descr AS plate_set_descr, plate_set.num_plates, plate_set.plate_format_id, plate_set.plate_layout_name_id,  plate_layout_name.name AS lyt_name, plate_layout_name.descr,  plate_layout_name.control_loc,  plate_layout_name.sys_name from plate_set, plate_layout_name where plate_set.plate_layout_name_id = plate_layout_name.id AND plate_set.id=" psid ))
			   (holder   (car (DB-get-all-rows (:conn rc sql))))
			   (descr (assoc-ref holder "descr"))
			   (format (assoc-ref holder "plate_format_id"))
			   (name (object->string (assoc-ref holder "plate_set_name")))
			   (lyt-name  (object->string (assoc-ref holder "lyt_name")))
			   (lyt-sys-name (assoc-ref holder "sys_name"))
			   (ps-descr (uri-decode (object->string (assoc-ref holder "plate_set_descr"))))
			   (num-plates (assoc-ref holder "num_plates"))
			   (control-loc (assoc-ref holder "control_loc"))
			   (rows-needed (* num-plates format))
			   )
			(view-render "impdata" (the-environment))
		;;	(view-render "test" (the-environment))
				     
			)))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; client

;; (plateset-define cset
;; 		 (options #:cookies '(names prjid sid))
;; 		 (lambda (rc)
;; 		   (let* ((result "sometext")
;; 			  (dummy (:cookies-set! rc 'prjid "prjid" result))
;; 			  (result "empty")
;; 			  (cookies (rc-cookie rc)))
;; 		     (view-render "test" (the-environment)))))


(post "/cset"
      	      #:auth `(table person "lnuser" "passwd" "salt" ,my-hmac)
	      #:cookies '(names prjid sid lnuser)
		 (lambda (rc)
		   (let* ((result "sometext")
			  (dummy (:cookies-set! rc 'prjid "prjid" result))
			  (cookies (rc-cookie rc))
			  )
		     (view-render "test" (the-environment)))))


(plateset-define testcset
		 (lambda (rc)
		     (view-render "testcset" (the-environment))))



(plateset-define ref
		 (options #:cookies '(names prjid sid))
		 (lambda (rc)
		   (let* (			  			 
			  (result (:cookies-ref rc 'prjid "prjid"))
			  (cookies (rc-cookie rc))
			  )
		     (view-render "test" (the-environment)))))

(plateset-define value 
		 (options #:cookies '(names prjid))
		 (lambda (rc)
		   (let* (			  			 
			  (result (:cookies-value rc "prjid"))
			  (cookies (rc-cookie rc))
			  )
		     (view-render "test" (the-environment)))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; server

(plateset-define remove
		 (options #:cookies '(names prjid sid))
		 (lambda (rc)
		   (let* (			  
			  (dummy (:cookies-remove! rc "prjid"))
			  (cookies (rc-cookie rc))
			  )
			    (view-render "test" (the-environment)))))

(plateset-define check
		 (options #:cookies #t)
		 (lambda (rc)
		   (let* (			  			 
			  (result (:cookies-check rc "prjid"))			 
			  (cookies (rc-cookie rc))
			  )
		     (view-render "test" (the-environment)))))


 (plateset-define haskey
		 (options #:cookies #t)
		 (lambda (rc)
		   (let* (
			  (cookies (rc-cookie rc))
			  (result (cookie-has-key? cookies "prjid"))
			  )
		     (view-render "test" (the-environment)))))






;; (plateset-define addcookie
;; 		 (options #:cookies '(names prjid sid))
;; 		 (lambda (rc)
;; 		   (let* (
;; 			  (dummy (:cookies-set! rc 'prjid "prjid" "1000"))
;; 			  (cookcheck (:cookies-check rc "prjid"))
;; 			  (cookiesref (:cookies-ref rc 'prjid "prjid"))
;; 			  (cookies (rc-cookie rc))
;; 			  (cookhaskey (cookie-has-key? cookies "prjid"))
;; 			 )
;; 		     (view-render "test" (the-environment)))))


;; (plateset-define check
;; 		 (lambda (rc)
;; 		   (let* (			  			 
;; 			  (cookcheck (:cookies-check rc "prjid"))			 
;; 			  (cookiesref (:cookies-ref rc 'prjid "prjid"))
;; 			  (cookies (rc-cookie rc))
;; 			   (cookhaskey (cookie-has-key? cookies "prjid"))
;; 			  )
;; 		     (view-render "test" (the-environment)))))

;; (plateset-define delete
;; 		 (options #:cookies '(names prjid sid))
;; 		 (lambda (rc)
;; 		   (let* (			  
;; 			  (dummy (:cookies-remove! rc 'prjid))
;; 			  (cookcheck (:cookies-check rc "prjid"))
;; 			  (cookiesref (:cookies-ref rc 'prjid "prjid"))
;; 			  (cookies (rc-cookie rc))
;; 			  (cookhaskey (cookie-has-key? cookies "prjid"))			  
;; 			  )
;; 			    (view-render "test" (the-environment)))))

(post "/plateset/reformat"
      #:conn #t #:from-post 'qstr
      #:cookies '(names prjid userid sid)
      #:with-auth "login/login?destination=/plateset/reformat"
      (lambda (rc)
	(let* ((help-topic "reformat")
	       (prjid (:cookies-value rc "prjid"))
	       (userid (:cookies-value rc "userid"))
	       (sid (:cookies-value rc "sid"))
	       (today (date->string  (current-date) "~Y-~m-~d"))
	       (qstr  (:from-post rc 'get))
	       (a (delete #f (map (match-lambda (("plateset-id" x) x)(_ #f))  qstr)))
	       (b ( uri-decode  (car a)))
	       (start (string-split b  #\+)) ;;(1 2 96 1) 
	       (srcpsid  (car start) )
	       ;; ;;(ps-num-text  (string-join (map string-append d (map cadr start) (circular-list ");"))))
	       (srcnplates  ( string->number  (cadr start)))
	       (srcformat  (caddr start))
	       (destformat (number->string (* (string->number srcformat) 4)))
	       (srclytid  (cadddr start))
	       (sql2 (string-append "SELECT name, descr from plate_layout_name where id =" srclytid))
	       (holder2    (car  (DB-get-all-rows (:conn rc sql2))))
	       (srcspllyttxt (string-append  (cdar  holder2)  "; "  (cdadr  holder2)) )			     			   
	       (sql3 (string-append "SELECT id, plate_type_name from plate_type"))
	       (holder3  (DB-get-all-rows (:conn rc sql3)))
	       (plate-types-pre '())
	       (plate-types (dropdown-contents-with-id holder3 plate-types-pre))
	       (srclytidq  (addquotes srclytid))
	       (destformatq (addquotes destformat))
	       (srcpsidq  (addquotes srcpsid) )
	       
	       )		     
	  (view-render "reformatps" (the-environment))
	  
	  )))


(post "/plateset/reformatconfirm"
		  #:conn #t #:from-post 'qstr
		  (lambda (rc)
		    (let* ((help-topic "reformat")
			   (today (date->string  (current-date) "~Y-~m-~d"))
			   (srcpsid (:from-post rc 'get-vals "srcpsid"))
			   (destname (:from-post rc 'get-vals "destname"))
			   (destdescr (:from-post rc 'get-vals "destdescr"))
			   (desttype (:from-post rc 'get-vals "desttype"))
			   (destformat (:from-post rc 'get-vals "destformat"))
			   (destsamprep (:from-post rc 'get-vals "destsamprep"))
			   (desttargrep (:from-post rc 'get-vals "desttargrep"))
			   (srclytid (:from-post rc 'get-vals "srclytid"))
			   (trglytid (:from-post rc 'get-vals "trglytid")) ;;optional from select dropdown
			   
			   (srcnplates (:from-post rc 'get-vals "srcnplates"))
			   (destnplates (number->string (ceiling (/ (* (string->number srcnplates) (string->number destsamprep)) 4))))			   
			   (destlytdescr (string-append destsamprep "S" desttargrep "T"))
			  
			   (sql (string-append "select id, sys_name, name, descr FROM plate_layout_name, layout_source_dest WHERE layout_source_dest.src =" srcpsid  " AND layout_source_dest.dest = plate_layout_name.id AND plate_layout_name.descr='" destlytdescr "'"))
			   (holder     (car (DB-get-all-rows (:conn rc sql))))
			   (destlytid (number->string (assoc-ref holder "id")))
			   (destlytsysname (assoc-ref holder "sys_name"))
			   (destlytname (assoc-ref holder "name"))
			   (destlytdescr (assoc-ref holder "descr"))		
			   (destlyttxt (string-append destlytsysname ";" destlytname ";" destlytdescr))
			   (prjid "1")
			   (sql2 (string-append "SELECT id, target_layout_name_name FROM target_layout_name WHERE (project_id=" prjid " AND reps = " desttargrep ") OR (project_id IS NULL AND reps =" desttargrep ")"))
			   (holder2  (DB-get-all-rows (:conn rc sql2)))
			   (desttargetlyts (dropdown-contents-with-id holder2 '()))
			   (srcpsidq (addquotes srcpsid))
			   (destnameq (addquotes destname))
			   (destdescrq (addquotes destdescr))
			   (desttypeq (addquotes desttype))
			   (destformatq (addquotes destformat))
			   (destsamprepq (addquotes destsamprep))
			   (desttargrepq (addquotes desttargrep))
			   (srclytidq (addquotes srclytid))
			   (srcnplatesq (addquotes srcnplates))
			   (destlytidq (addquotes destlytid))
			  

			   )		     
			  (view-render "reformatconfirm" (the-environment))			 
		      )))


(post "/plateset/reformataction"
		  #:conn #t #:from-post 'qstr #:cookies #t
		  (lambda (rc)
		    (let* ((help-topic "reformat")
			   (today (date->string  (current-date) "~Y-~m-~d"))
			   ;;(prjid (:cookies-value rc "prjid"))
			   (prjid "1")
			   (srcpsid (:from-post rc 'get-vals "srcpsid"))
			   (destname (:from-post rc 'get-vals "destname"))
			   (destdescr (:from-post rc 'get-vals "destdescr"))
			   (desttype (:from-post rc 'get-vals "desttype"))
			   (destformat (:from-post rc 'get-vals "destformat"))
			   (destsamprep (:from-post rc 'get-vals "destsamprep"))
			   (desttargrep (:from-post rc 'get-vals "desttargrep"))
			   (srclytid (:from-post rc 'get-vals "srclytid"))
			   (destlytid (:from-post rc 'get-vals "destlytid"))
			   
			   (srcnplates (:from-post rc 'get-vals "srcnplates"))
			   (destnplates (number->string (ceiling (/ (* (string->number srcnplates) (string->number destsamprep)) 4))))			   
			   (destlytdescr (string-append destsamprep "S" desttargrep "T"))
			   ;;(sid (:cookies-value rc "sid"))
			   (sid "df4f759814491a9b85e40202c29fe11a")
			   (sql (string-append "SELECT reformat_plate_set("  srcpsid ", " srcnplates ", "  destsamprep  ", '" destdescr "', '" destname "', " destnplates", " destformat ", "  desttype ", "  prjid ", "  srclytid ", '" sid "', "  destlytid  ")"))
			   (holder    (car  (DB-get-all-rows (:conn rc sql))))
			   (destlytid (assoc-ref holder "reformat_plate_set"))
			   )
			   (view-render (string-append "/plateset/getps?id=" prjid) (the-environment))			 
		      )))
