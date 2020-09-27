;; Controller plate definition of lnserver
;; Please add your license header here.
;; This file is generated automatically by GNU Artanis.
(define-artanis-controller plate) ; DO NOT REMOVE THIS LINE!!!

(use-modules (artanis utils)(artanis irregex)(srfi srfi-1)(dbi dbi) (lnserver sys extra))

(define (prep-plt-for-ps-rows a)
  (fold (lambda (x prev)
          (let (
                (plate-sys-name (result-ref x "plate_sys_name"))
		(barcode  (result-ref x "barcode") ))
            (cons (string-append "<tr><th><a href=\"plate/getwellsforplt?id=" (number->string (cdr (car x))) "\">" plate-sys-name "</a></th><th>" barcode  "</th></tr>")
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
            (cons (string-append "<tr><th>" assay-run-sys-name "</th><th><a href=\"hitlist/getid?id="  (number->string (cdr (car x))) "\">" hitlist-sys-name "</a></th><th>" hitlist-name "</th><th>" descr "</th><th>" n "</th><tr>")
		  prev)))
        '() a))



(plate-define getpltforps
  (lambda (rc)
 (let* ((ret #f)
	(holder '())
	(help-topic "plate")
	(id  (get-from-qstr rc "id"))
	(dummy (dbi-query ciccio (string-append "select plate_plate_set.plate_id, plate.plate_sys_name, plate.barcode from plate, plate_plate_set where plate_plate_set.plate_id=plate.id AND plate_plate_set.plate_set_id =" id )))
	(ret (dbi-get_row ciccio))
	(dummy2 (while (not (equal? ret #f))     
		  (set! holder (cons ret holder))		   
		  (set! ret  (dbi-get_row ciccio))))
	(body (string-concatenate (prep-plt-for-ps-rows holder)))
	(ret2 #f)
	(holder2 '())
	(dummy3 (dbi-query ciccio (string-append "select assay_run.id, assay_run.assay_run_sys_name, assay_run.assay_run_name, assay_run.descr, assay_type.assay_type_name, plate_layout_name.sys_name, plate_layout_name.name FROM assay_run, assay_type, plate_layout_name WHERE assay_run.plate_layout_name_id=plate_layout_name.id AND assay_run.assay_type_id=assay_type.id AND plate_set_id =" id )))
	(ret2 (dbi-get_row ciccio))
	(dummy4 (while (not (equal? ret2 #f))     
		  (set! holder2 (cons ret2 holder2))		   
		  (set! ret2  (dbi-get_row ciccio))))
	(body2 (string-concatenate (prep-ar-for-ps-rows holder2)))
	(ret3 #f)
	(holder3 '())
	(dummy5 (dbi-query ciccio (string-append "select hit_list.id, hitlist_sys_name, hitlist_name, hit_list.descr, n, assay_run_sys_name FROM hit_list, assay_run WHERE  hit_list.assay_run_id=assay_run.id AND assay_run.plate_set_id=" id )))
	(ret3 (dbi-get_row ciccio))
	(dummy6 (while (not (equal? ret3 #f))     
		  (set! holder3 (cons ret3 holder3))		   
		  (set! ret3  (dbi-get_row ciccio))))
	(body3 (string-concatenate (prep-hl-for-ps-rows holder3)))

	)
   (view-render "getpltforps" (the-environment)))))

