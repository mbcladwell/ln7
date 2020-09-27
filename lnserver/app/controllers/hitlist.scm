;; Controller hitlist definition of lnserver
;; Please add your license header here.
;; This file is generated automatically by GNU Artanis.
(define-artanis-controller hitlist) ; DO NOT REMOVE THIS LINE!!!

(use-modules (artanis utils)(artanis irregex)(srfi srfi-1)(dbi dbi) (lnserver sys extra))


(define (prep-hl-for-ar-rows a)
  (fold (lambda (x prev)
          (let ((id (get-c1 x))
		(hit-list-sys-name (result-ref x "hitlist_sys_name"))
		(hit-list-name (result-ref x "hitlist_name"))
		(descr (result-ref x "descr"))
		(nhits (get-c5 x)))
	      (cons (string-append "<tr><th><a href=\"/hitlist/gethlbyid?id=" id  "\">" hit-list-sys-name "</a></th><th>" hit-list-name "</th><th>" descr "</th><th>" nhits "</th><tr>")
		  prev)))
        '() a))


(hitlist-define gethlforarid
  (lambda (rc)
    (let* ((ret #f)
	   (holder '())
	   (help-topic "hitlist")
	   (id  (get-from-qstr rc "id")) ;; assay-run id
	   (dummy (dbi-query ciccio (string-append "select id, hitlist_sys_name, hitlist_name, descr, n from hit_list where assay_run_id =" id )))
	   (ret (dbi-get_row ciccio))
	   (dummy2 (while (not (equal? ret #f))     
		     (set! holder (cons ret holder))		   
		     (set! ret  (dbi-get_row ciccio))))
	   (body  (string-concatenate  (prep-hl-for-ar-rows holder)) ))  
      (view-render "gethlforarid" (the-environment))
      )))


(define (prep-hl-rows a)
  (fold (lambda (x prev)
          (let ((id (get-c1 x))
		(sample-sys-name (result-ref x "sample_sys_name"))
		(prj-id (get-c3 x ))
		(accs (result-ref x "accs_id")))
	      
	      (cons (string-append "<tr><th>"  sample-sys-name "</th><th>" prj-id "</th><th>" accs "</th><tr>")
		  prev)))
        '() a))


(hitlist-define gethlbyid
		(lambda (rc)
		  (let* ((ret #f)
			 (holder '())
			 (help-topic "hitlist")
			 (id  (get-from-qstr rc "id")) ;; hit-list id
			 (dummy (dbi-query ciccio (string-append "select sample.id, sample.sample_sys_name, sample.project_id, sample.accs_id  from hit_list, sample, hit_sample where sample.id=hit_sample.sample_id AND hit_list.id=hit_sample.hitlist_id AND hitlist_id =" id )))
			 (ret (dbi-get_row ciccio))
			 (dummy2 (while (not (equal? ret #f))     
				   (set! holder (cons ret holder))		   
				   (set! ret  (dbi-get_row ciccio))))
			 (body  (string-concatenate  (prep-hl-rows holder)) ))
		    (view-render "gethlbyid" (the-environment)))))

