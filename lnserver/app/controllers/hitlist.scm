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
	      (cons (string-append "<tr><td><a href=\"/hitlist/gethlbyid?id=" id  "\">" hit-list-sys-name "</a></td><td>" hit-list-name "</td><td>" descr "</td><td>" nhits "</td><tr>")
		  prev)))
        '() a))


(hitlist-define gethlforarid
		(options #:conn #t)
  (lambda (rc)
    (let* ((help-topic "hitlist")
	   (id  (get-from-qstr rc "id")) ;; assay-run id
	   (sql (string-append "select id, hitlist_sys_name, hitlist_name, descr, n from hit_list where assay_run_id =" id ))
	   (holder (DB-get-all-rows (:conn rc sql)))
	   (body  (string-concatenate  (prep-hl-for-ar-rows holder)) ))  
      (view-render "gethlforarid" (the-environment))
      )))


(define (prep-hl-rows a)
  (fold (lambda (x prev)
          (let ((id (get-c1 x))
		(sample-sys-name (result-ref x "sample_sys_name"))
		(prj-id (get-c3 x ))
		(accs (result-ref x "accs_id")))
	      
	      (cons (string-append "<tr><td>"  sample-sys-name "</td><td>" prj-id "</td><td>" accs "</td><tr>")
		  prev)))
        '() a))


(hitlist-define gethlbyid
		(options #:conn #t
			 #:cookies '(names prjid lnuser userid group sid)
			 #:with-auth "login/login")
		(lambda (rc)
		  (let* ((help-topic "hitlist")
			 ;; (prjid (:cookies-value rc "prjid"))
			 ;; (userid (:cookies-value rc "userid"))
			 ;; (group (:cookies-value rc "group"))
			 ;; (sid (:cookies-value rc "sid"))
			 (prjid "1")
			 (get-ps-link (addquotes (string-append "/plateset/getps?id=" prjid)))
			 (ps-add-link (addquotes (string-append "/plateset/add?format=96&amp;type=master&amp;prjid=" prjid)))
					 (userid "1")
			 (group "admin")
			 (sid "0f1a05af5685af9ab62536720c9a74c1")
			 (hlid  (get-from-qstr rc "id")) ;; hit-list id
			 (sql (string-append "select sample.id, sample.sample_sys_name, sample.project_id, sample.accs_id  from hit_list, sample, hit_sample where sample.id=hit_sample.sample_id AND hit_list.id=hit_sample.hitlist_id AND hitlist_id =" hlid ))
			 (holder (DB-get-all-rows (:conn rc sql)))
			 (body  (string-concatenate  (prep-hl-rows holder)) ))
		    (view-render "gethlbyid" (the-environment)))))


(hitlist-define test
		(lambda (rc)
		  (let* ((help-topic "hitlist")
			 ;; (prjid (:cookies-value rc "prjid"))
			 ;; (userid (:cookies-value rc "userid"))
			 ;; (group (:cookies-value rc "group"))
			 ;; (sid (:cookies-value rc "sid"))
			 (prjid "1")
			 (get-ps-link (string-append "/plateset/getps?id=" prjid))
			 (ps-add-link (string-append "/plateset/add?format=96&type=master&prjid=" prjid))
			 (userid "1")
			 (group "admin")
			 (sid "0f1a05af5685af9ab62536720c9a74c1"))
		    (view-render "test" (the-environment)))))

