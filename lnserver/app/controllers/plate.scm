;; Controller plate definition of lnserver
;; Please add your license header here.
;; This file is generated automatically by GNU Artanis.
(define-artanis-controller plate) ; DO NOT REMOVE THIS LINE!!!

(use-modules (artanis utils)(artanis irregex)
	     (artanis cookie)
	     (srfi srfi-1)(dbi dbi)
	     (lnserver sys extra))

(define (prep-plt-for-ps-rows a)
  (fold (lambda (x prev)
          (let (
                (plate-sys-name (result-ref x "plate_sys_name"))
		(barcode  (result-ref x "barcode") )
		(order (get-c3 x )) ;;plate_order
		(type (result-ref x "plate_type_name"))
		(format (result-ref x "format")) ;;format
		)
            (cons (string-append "<tr><th><a href=\"getwellsforplt?id=" (number->string (cdr (car x))) "\">" plate-sys-name "</a></th><th>"  order  "</th><th>" type  "</th><th>"  format  "</th><th>" barcode  "</th></tr>")
		  prev)))
        '() a))


(define (prep-ar-for-ps-rows a)
  (fold (lambda (x prev)
          (let (
                (assay-run-sys-name (result-ref x "assay_run_sys_name"))
		(assay-run-name (result-ref x "assay_run_name"))
		(descr (result-ref x "descr"))
		(assay-type-name (result-ref x "assay_type_name"))
		(sys-name (result-ref x "sys_name"))
		(name (result-ref x "name"))
		)
            (cons (string-append "<tr><th><a href=\"../assayrun/getid?id="  (number->string (cdr (car x))) "\">" assay-run-sys-name "</a></th><th>" assay-run-name "</th><th>" descr "</th><th>" assay-type-name "</th><th>" sys-name "</th><th>" name "</th><tr>")
		  prev)))
        '() a))


(define (prep-hl-for-ps-rows a)
  (fold (lambda (x prev)
          (let (
                (hitlist-sys-name (result-ref x "hitlist_sys_name"))
		(hitlist-name (result-ref x "hitlist_name"))
		(descr (result-ref x "descr"))
		(n (get-c5 x ))
		(assay-run-sys-name (result-ref x "assay_run_sys_name"))
		)
            (cons (string-append "<tr><th>" assay-run-sys-name "</th><th><a href=\"/hitlist/gethlbyid?id="  (number->string (cdr (car x))) "\">" hitlist-sys-name "</a></th><th>" hitlist-name "</th><th>" descr "</th><th>" n "</th><tr>")
		  prev)))
        '() a))



(plate-define getpltforps
	      (options #:conn #t
		       #:cookies '(names prjid lnuser userid group sid)
		       #:with-auth "login/login")
	      (lambda (rc)
		(let* ((help-topic "plate")
		       (id  (get-from-qstr rc "id"))
		       (prjid (:cookies-value rc "prjid"))
		       (userid (:cookies-value rc "userid"))
		       (group (:cookies-value rc "group"))
		       (sid (:cookies-value rc "sid"))		
		       (get-ps-link (string-append "/plateset/getps?id=" prjid))
		       (ps-add-link (string-append "/plateset/add?format=96&type=master&prjid=" prjid))	    
		       (sql (string-append "SELECT plate.id, plate.plate_sys_name, plate_plate_set.plate_order,  plate_type.plate_type_name, plate_format.format, plate.barcode FROM plate_set, plate, plate_type, plate_format, plate_plate_set WHERE plate_plate_set.plate_set_id =" id " AND plate.plate_type_id = plate_type.id AND plate_plate_set.plate_id = plate.id AND plate_plate_set.plate_set_id = plate_set.id  AND plate_format.id = plate.plate_format_id ORDER BY plate_plate_set.plate_order DESC" ))
		       (holder (DB-get-all-rows (:conn rc sql)))
		       (body (string-concatenate (prep-plt-for-ps-rows holder)))
		       (sql2 (string-append "select assay_run.id, assay_run.assay_run_sys_name, assay_run.assay_run_name, assay_run.descr, assay_type.assay_type_name, plate_layout_name.sys_name, plate_layout_name.name FROM assay_run, assay_type, plate_layout_name WHERE assay_run.plate_layout_name_id=plate_layout_name.id AND assay_run.assay_type_id=assay_type.id AND plate_set_id =" id ))
		       (holder2 (DB-get-all-rows (:conn rc sql2)))
		       (body2 (string-concatenate (prep-ar-for-ps-rows holder2)))
		       (sql3 (string-append "select hit_list.id, hitlist_sys_name, hitlist_name, hit_list.descr, n, assay_run_sys_name FROM hit_list, assay_run WHERE  hit_list.assay_run_id=assay_run.id AND assay_run.plate_set_id=" id ))
		       (holder3 (DB-get-all-rows (:conn rc sql3)))
		       (body3 (string-concatenate (prep-hl-for-ps-rows holder3))))
		  (view-render "getpltforps" (the-environment))
		 ;; (view-render "test" (the-environment))
		  
		  )))


;;"SELECT plate_set.plate_set_sys_name,  plate.plate_sys_name, well_numbers.well_name, well.by_col, sample.sample_sys_name, sample.accs_id FROM plate_plate_set, plate_set, plate, sample, well_sample, well JOIN well_numbers ON ( well.by_col= well_numbers.by_col)  WHERE plate.id = well.plate_id AND well_sample.well_id=well.id AND well_sample.sample_id=sample.id AND well.plate_id = " pltid  "  AND plate_plate_set.plate_id = plate.id AND plate_plate_set.plate_set_id = plate_set.ID AND  well_numbers.plate_format = (SELECT plate_format_id  FROM plate_set WHERE plate_set.ID =  (SELECT plate_set_id FROM plate_plate_set WHERE plate_id = plate.ID LIMIT 1) ) ORDER BY plate.id DESC, well.by_col DESC"


;;  plate_set_sys_name | plate_sys_name | well_name | by_col | sample_sys_name | accs_id 

(define (prep-wells-for-plt-rows a)
  (fold (lambda (x prev)
          (let ((plt-set-sys-name (result-ref x "plate_set_sys_name"))
                (plate-sys-name (result-ref x "plate_sys_name"))
		(well-name  (result-ref x "well_name") )
		(order (get-c4 x )) ;; by_col
		(splsys (result-ref x "sample_sys_name"))
		(accs (result-ref x "accs_id"))
		)
            (cons (string-append "<tr><td>" plt-set-sys-name "</td><td>"  plate-sys-name "</td><td>"  well-name  "</td><td>" order  "</td><td>"  splsys  "</td><td>" accs  "</td></tr>")
		  prev)))
        '() a))



(plate-define getwellsforplt
	      (options #:conn #t
		       #:cookies '(names prjid lnuser userid group sid)
		       #:with-auth "login/login")
	      (lambda (rc)
		(let* ((help-topic "plate")
		       (pltid  (get-from-qstr rc "id"))
		      (prjid (:cookies-value rc "prjid"))
		       (userid (:cookies-value rc "userid"))
		       (group (:cookies-value rc "group"))
		       (sid (:cookies-value rc "sid"))		
		       (sql (string-append "SELECT plate_set.plate_set_sys_name,  plate.plate_sys_name, well_numbers.well_name, well.by_col, sample.sample_sys_name, sample.accs_id FROM plate_plate_set, plate_set, plate, sample, well_sample, well JOIN well_numbers ON ( well.by_col= well_numbers.by_col)  WHERE plate.id = well.plate_id AND well_sample.well_id=well.id AND well_sample.sample_id=sample.id AND well.plate_id = " pltid  "  AND plate_plate_set.plate_id = plate.id AND plate_plate_set.plate_set_id = plate_set.ID AND  well_numbers.plate_format = (SELECT plate_format_id  FROM plate_set WHERE plate_set.ID =  (SELECT plate_set_id FROM plate_plate_set WHERE plate_id = plate.ID LIMIT 1) ) ORDER BY plate.id DESC, well.by_col DESC" ))
		       (holder (DB-get-all-rows (:conn rc sql)))
		       (psid-pre (cdr (assoc "plate_set_sys_name" (car holder))))
		       (psid (substring psid-pre 3))
		       (body (string-concatenate (prep-wells-for-plt-rows holder)))
		       (psidq (addquotes psid))
		       )
		  (view-render "getwellsforplt" (the-environment))
		  ;;(view-render "test" (the-environment))
		  
		  )))


(post "/plate/getwellsforps"
	       #:conn #t
	       #:cookies '(names prjid lnuser userid group sid)
	       #:with-auth "login/login"
	       #:from-post 'qstr
	      (lambda (rc)
		(let* ((help-topic "plate")
		       (psid  (:from-post rc 'get "psid"))
		       (include-controls (:from-post rc 'get "includecontrols"))
		       (prjid (:cookies-value rc "prjid"))
		       (userid (:cookies-value rc "userid"))
		       (group (:cookies-value rc "group"))
		       (sid (:cookies-value rc "sid"))		
		       (sql (string-append "SELECT plate_set.plate_set_sys_name,  plate.plate_sys_name, well_numbers.well_name, well.by_col, sample.sample_sys_name, sample.accs_id FROM plate_plate_set, plate_set, plate, sample, well_sample, well JOIN well_numbers ON ( well.by_col= well_numbers.by_col)  WHERE plate.id = well.plate_id AND well_sample.well_id=well.id AND well_sample.sample_id=sample.id AND plate_plate_set.plate_set_id = " psid  "  AND plate_plate_set.plate_id = plate.id AND plate_plate_set.plate_set_id = plate_set.ID AND  well_numbers.plate_format = (SELECT plate_format_id  FROM plate_set WHERE plate_set.ID =" psid " ) ORDER BY plate.id DESC, well.by_col DESC" ))
		       (holder (DB-get-all-rows (:conn rc sql)))
		       (body (string-concatenate (prep-wells-for-plt-rows holder))))
		  (view-render "getwellsforps" (the-environment))
		       
		  ;;(view-render "test" (the-environment))
		  
		  )))

