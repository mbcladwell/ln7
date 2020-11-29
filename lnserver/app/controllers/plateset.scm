;; Controller plateset definition of lnserver
;; Please add your license header here.
;; This file is generated automatically by GNU Artanis.
(define-artanis-controller plateset) ; DO NOT REMOVE THIS LINE!!!

(use-modules (artanis utils)(artanis irregex)(srfi srfi-1)(dbi dbi)(web uri) (lnserver sys extra)(ice-9 match))

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
          (let ((id (get-c1 x))
                (assay-run-sys-name (result-ref x "assay_run_sys_name"))
                (assay-run-name (result-ref x "assay_run_name"))
		(assay-type-name (result-ref x "assay_type_name"))
		(hit-list-sys-name (result-ref x "hitlist_sys_name"))
		(hit-list-name (result-ref x "hitlist_name"))
		(descr (result-ref x "descr"))
		(nhits (get-c8 x))
		)
	      (cons (string-append "<tr><th><a href=\"/hitlist/gethlforarid?id=" id  "\">" assay-run-sys-name "</a></th><th>" assay-run-name "</th><th>" assay-type-name "</th><th>" hit-list-sys-name "</th><th>" hit-list-name "</th><th>" descr "</th><th>" nhits "</th><tr>")
		  prev)))
        '() a))


(define (get-hit-lists-for-prjid id rc)
  (let* ((sql (string-append "select assay_run.id, assay_run.assay_run_sys_name, assay_run.assay_run_name, assay_type.assay_type_name, hit_list.hitlist_sys_name, hit_list.hitlist_name, hit_list.descr, hit_list.n  FROM assay_run, plate_set, hit_list, assay_type WHERE assay_type.id=assay_run.assay_type_id AND hit_list.assay_run_id=assay_run.id  AND assay_run.plate_set_id=plate_set.id AND plate_set.project_id =" id ))
	(holder (DB-get-all-rows (:conn rc sql))))
	(string-concatenate (prep-hl-for-prj-rows holder))))



;;    (display holder)))

;; (get-hit-lists-for-prjid "1")

(plateset-define getps
		 (options #:conn #t)
		 (lambda (rc)
		   (let* (
			  (help-topic "plateset")
			  (id  (get-from-qstr rc "id"))
			  (sql (string-append "select plate_set.id, plate_set_sys_name, plate_set_name, descr, plate_type_name, num_plates, plate_format_id, plate_layout_name_id, plate_layout_name.replicates from plate_set, plate_type, plate_layout_name where plate_set.plate_type_id=plate_type.id AND plate_set.plate_layout_name_id=plate_layout_name.id AND plate_set.project_id =" id ))
			  (holder (DB-get-all-rows (:conn rc sql)))
			  (body  (string-concatenate  (prep-ps-for-prj-rows holder)) )
			  (assay-runs (get-assay-runs-for-prjid id rc))
			  (hit-lists (get-hit-lists-for-prjid id rc))
			  )      
		     (view-render "getps" (the-environment))
		     )))



;; (post "/plateset/editps"
;; 		  #:conn #t #:from-post 'qstr
;; 		 (lambda (rc)
;; 		   (cond 
;; 		    ((string=? (get-from-qstr rc "buttons") "group")
;; 		     (let*((qstr (:from-post rc 'get))
;; 			   (sql (assoc-ref qstr "plateset-id"))
;; 			   (help-topic "group")
;; 				    )
;; 				(view-render "test" (the-environment))))
;; 		    ((string=? (get-from-qstr rc "buttons") "reformat")
;; 		     (let*((help-topic "reformat")
;; 			   (sql "in reformat")
;; 				    )
;; 				(view-render "test" (the-environment))))
;; 		    ((string=? (get-from-qstr rc "buttons") "importradio")
;; 		     (let*((help-topic "platesets")
;; 			   (sql "in impradio")
;; 				    )
;; 				(view-render "test" (the-environment))))
;; 		    ((string=? (get-from-qstr rc "buttons") "exportradio")
;; 		     (let*((sql "in expradio")
;; 			   (help-topic "export")
;; 				    )
;; 				(view-render "test" (the-environment)))))
;; 		   ))


(post "/plateset/editps"
		  #:conn #t #:from-post 'qstr
		  (lambda (rc)
		    (let* ((help-topic "group")
			   (qstr  (:from-post rc 'get))
			   (a (delete #f (map (match-lambda (("plateset-id" x) x)(_ #f))  qstr)))
			   (b (map uri-decode  a))
			   (start (map string-split b (circular-list #\+))) ;;((1 2 96 1) (2 2 96 1))
			   (c (map string-append (circular-list "PS-") (map car start) ))
			   (d (map string-append c (circular-list " (")  ))
			   (ps-num-text (map string-append d (map cadr start) (circular-list ");")))
			   (tot-plates (apply + (map string->number (map cadr start))))
			   (format-equal? (apply equal? (map caddr start)))
			   (layout-equal? (apply equal? (map cadddr start)))
			   )
		      (if (and format-equal? layout-equal?)
			  (view-render "test" (the-environment))
			  (view-render "error" (the-environment))))))
		      

		      
		   ;; (cond 
		   ;;  ((string=? (get-from-qstr rc "buttons") "group")
		   ;;   (let*((qstr (:from-post rc 'get))
		   ;; 	   (sql (assoc-ref qstr "plateset-id"))
		   ;; 	   (help-topic "group")
		   ;; 		    )
		   ;; 		(view-render "test" (the-environment))))
		   ;; ))


;; ((plateset-id%5B%5D 1) (plateset-id%5B%5D 2) (buttons group) (import data) (export selected)) 



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
			  )      
		     (view-render "test" (the-environment)))))
