;; Controller plateset definition of lnserver
;; Please add your license header here.
;; This file is generated automatically by GNU Artanis.
(define-artanis-controller plateset) ; DO NOT REMOVE THIS LINE!!!

(use-modules (artanis utils)(artanis irregex)(srfi srfi-1)(dbi dbi)(web uri)
	     (srfi srfi-19)   ;; date time
	     (lnserver sys extra)(ice-9 match)
	     (srfi srfi-11) ;; let-values
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
		 (options #:conn #t)
		 (lambda (rc)
		   (let* ((help-topic "plateset")
			  (format (get-from-qstr rc "format"))
			  (type (get-from-qstr rc "type"))
			  (reps 1)
			  (project-id "1")
			  (sql (string-append "select id, name from plate_layout_name WHERE plate_format_id =" format))
			  (holder  (DB-get-all-rows (:conn rc sql)))
			  (sample-layout-pre '())
			  (sample-layouts  (dropdown-contents-with-id holder sample-layout-pre))
			  (sql2 (if (= reps 0)				    
				    (string-append "SELECT id, target_layout_name_name FROM target_layout_name WHERE (project_id= " project-id "  OR project_id IS NULL )")   
				    (string-append "SELECT id, target_layout_name_name FROM target_layout_name WHERE (project_id= " project-id " AND reps = " (number->string reps) ") OR (project_id IS NULL AND reps = " (number->string reps) ")")))

			  (holder2  (DB-get-all-rows (:conn rc sql2)))
			  (target-layout-pre '())
			  (target-layouts  (dropdown-contents-with-id holder2 target-layout-pre))
			  
			  (sql3 (string-append "SELECT id, plate_type_name from plate_type"))
			  (holder3  (DB-get-all-rows (:conn rc sql3)))
			  (plate-types-pre '())
			  (plate-types (dropdown-contents-with-id holder3 plate-types-pre))
			  (trg-desc "(for assay plates only)")
			  
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
			   (sid "1")
			    ;; see dbi.groupPlateSetsIntoNewPlateSet
			   ;;CREATE OR REPLACE FUNCTION new_plate_set_from_group(_descr VARCHAR(30),_plate_set_name VARCHAR(30), _num_plates INTEGER, _plate_format_id INTEGER, _plate_type_id INTEGER, _project_id INTEGER, _plate_layout_name_id INTEGER, _sessions_id VARCHAR(32))
			   ;; returns plate-set-id
			   (sql (string-append "SELECT new_plate_set_from_group('" descr "', '" psname ", " tot-plates ", " format ", " type ", " prjid ", " lyt-id ", '" sid "')"))

			   
			  ;; (sql (string-append "select plate_set.id, plate_set_sys_name, plate_set_name, plate_set.descr, plate_type_name, num_plates, plate_set.plate_format_id, plate_layout_name_id, plate_layout_name.replicates from plate_set, plate_type, plate_layout_name where plate_set.plate_type_id=plate_type.id AND plate_set.plate_layout_name_id=plate_layout_name.id AND plate_set.project_id =" id ))
			  ;; (holder (DB-get-all-rows (:conn rc sql)))
			  ;; (body  (string-concatenate  (prep-ps-for-prj-rows holder)) )
			  ;; (assay-runs (get-assay-runs-for-prjid id rc))
			  ;; (hit-lists (get-hit-lists-for-prjid id rc))
			  
			   )
		      ;;(view-render "getps" (the-environment))
		      (view-render "test" (the-environment))
		      
		      )))


(plateset-define impdata
		 (options #:conn #t #:cookies '(names prjid sid))
		 (lambda (rc)
		   (let* (
			  (help-topic "plateset")
			  )      
		     (view-render "impdata" (the-environment))
		     )))



(plateset-define impacc
		 (options #:conn #t #:cookies '(names prjid sid))
		 (lambda (rc)
		   (let* (
			  (help-topic "plateset")
			  )      
		     (view-render "impacc" (the-environment))
		     )))

(plateset-define impbc
		 (options #:conn #t #:cookies '(names prjid sid))
		 (lambda (rc)
		   (let* (
			  (help-topic "plateset")
			  )      
		     (view-render "impbc" (the-environment))
		     )))




(plateset-define testadd
		 (options #:cookies '(names prjid sid))
		 (lambda (rc)
		   (let* ((dummy (:cookies-set! rc 'prjid "prjid" "1000"))
			  (cookies (rc-cookie rc))
			  (acookie (:cookies-ref rc 'prjid "prjid")))
			    (view-render "test" (the-environment)))))

(plateset-define testdelete
		 (options #:cookies '(names prjid sid))
		 (lambda (rc)
		   (let* ((dummy (:cookies-remove! rc "prjid"))
			  (cookies (rc-cookie rc))
			  (acookie (:cookies-ref rc 'prjid "prjid")))
			    (view-render "test" (the-environment)))))



(plateset-define test
		 (options #:cookies '(names prjid sid))
		 (lambda (rc)
		   (let* ((cookies (rc-cookie rc))
			  (acookie (:cookies-ref rc 'prjid "prjid")))
			  (view-render "test" (the-environment)))))



   

(post "/plateset/impassdatadb"  #:conn #t #:from-post 'qstr
		 (lambda (rc)
		   (let* (
			  (help-topic "plateset")
			  ;;(filename (:from-post rc 'get-vals "myfile"))
			  (a (uri-decode (:from-post rc 'get-vals "datatransfer")))
			  (b (map list (cdr (string-split a #\newline))))
			  (psid (:from-post rc 'get-vals "psid"))
			  (num-plates (:from-post rc 'get-vals "numplates"))
			  (format (:from-post rc 'get-vals "format"))
			 ;; (rows-needed (:from-post rc 'get-vals "rows-needed"))
			  (assay-descr (:from-post rc 'get-vals "assay-descr"))
			  (ps-descr (uri-decode (:from-post rc 'get-vals "ps-descr")))
			  (control-loc (uri-decode (:from-post rc 'get-vals "control-loc")))
			  (assay-name (:from-post rc 'get-vals "assayname"))
			  (assay-type (:from-post rc 'get-vals "assay-type"))
			  (sql (string-append "SELECT id from assay_type where assay_type_name =" assay-type))
			  (assay-type-id (DB-get-all-rows (:conn rc sql)))
			  (lyt-sys-name (uri-decode (:from-post rc 'get-vals "lyt-sys-name")))
			  (plt-lyt-name-id (substring lyt-sys-name 3))
			  (session-id "1")
			  (sql2 (string-append "SELECT new_assay_run(" assay-name ", " assay-descr  ", " assay-type-id ", " psid ", " plt-lyt-name-id ", " session-id ")"))
		  	 ;;(lyt-txt (string-append lyt-sys-name ";" lyt-name ))
			  )
		     
		   ;;  (view-render "impdassdatadb" (the-environment))
		    (view-render "test" (the-environment))
		     )))



(post "/plateset/impdataaction"  #:conn #t #:from-post 'qstr
		 (lambda (rc)
		   (let* (
			  (help-topic "plateset")
			  (filename (:from-post rc 'get-vals "myfile"))
			  (a (uri-decode (:from-post rc 'get-vals "datatransfer")))
			  (b (map list (cdr (string-split a #\newline))))
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
		  ;;   (view-render "test" (the-environment))
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

