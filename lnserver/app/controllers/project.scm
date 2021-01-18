;; Controller project definition of lnserver
;; Please add your license header here.
;; This file is generated automatically by GNU Artanis.
(define-artanis-controller project) ; DO NOT REMOVE THIS LINE!!!

;; (use-modules (artanis utils) (ice-9 local-eval) (srfi srfi-1)
   ;;          (artanis irregex)(dbi dbi) (ice-9 textual-ports)(web uri)(ice-9 rdelim)(lnserver sys methods))

(use-modules (artanis utils)(artanis irregex)(srfi srfi-1)(dbi dbi) (lnserver sys extra))

(define (prep-project-rows a)
  (fold (lambda (x prev)
          (let (
                (project_sys_name (result-ref x "project_sys_name"))
                (project_name (result-ref x "project_name"))
		(descr (result-ref x "descr")))
            (cons (string-append "<tr><th> <input type=\"radio\" id=\"" project_sys_name  "\" name=\"prjid\" value=\"" (number->string (cdr (car x)))   "\"></th>

<th><a href=\"/plateset/getps?id=" (number->string (cdr (car x))) "\">" project_sys_name "</a></th>


<th>" project_name "</th><th>" descr "</th></tr>")
		  prev)))
        '() a))


;; <th><a href=\"/plateset/getps?id=" (number->string (cdr (car x))) "\" class=\"btn btn-primary btn-sm active\" role=\"button\" aria-pressed=\"true\">" project_sys_name "</a></th>
;; <th><a href=\"/plateset/getps?id=" (number->string (cdr (car x))) "\">" project_sys_name "</a></th>


;; (project-define getall
;; 		(lambda (rc)
;;     (let* ((help-topic "project")
;; 	   (ret #f)
;; 	   (holder '())
;; 	   (dummy (dbi-query ciccio  "select id, project_sys_name, project_name, descr from project"  ))
;; 	   (ret (dbi-get_row ciccio))
;; 	   (dummy2 (while (not (equal? ret #f))     
;; 		     (set! holder (cons ret holder))		   
;; 		     (set! ret  (dbi-get_row ciccio))))
;; 	   (body (string-concatenate (prep-project-rows holder)))
;; 	   )
;;       (view-render "getall" (the-environment))
;;   )))

(get "/project/getall" #:conn #t #:cookies #t
     (lambda (rc ) 
       (let* ( 
	      (help-topic "project")
	      (prjid "1")
	      (holder   (DB-get-all-rows (:conn rc "select id, project_sys_name, project_name, descr from project" )))  
	      (body (string-concatenate (prep-project-rows holder))))
	 (view-render "/getall" (the-environment)))))


(get "/project/add"
;;     #:with-auth "/login/login?destination=/project/add"
 ;;    #:from-post 'qstr
     (lambda (rc)     
       (let* ((help-topic "project"))
	 (view-render "/add" (the-environment)))
	  ))


(project-define addaction
		(options #:conn #t)
		(lambda (rc)
		  (let* ((help-topic "project")
			;; (qstr  (:from-post rc 'get))
			 (prj-name (get-from-qstr rc "pname"))
		       	 (descr (get-from-qstr rc "descr"))
			 (sid "99999")
			 (sql (string-append "select new_project('"  descr "', '" prj-name "', '" sid "')"))
			 (dummy (:conn rc sql))
			 )
		    (redirect-to rc "project/getall")
  )))

(project-define edit
		(options #:conn #t )
		(lambda (rc)
		  (let* ((help-topic "project")			
			 (prjid (get-from-qstr rc "prjid"))
			 (sql (string-append "select project_name, descr from project where id=" prjid ))
			 (holder   (car (DB-get-all-rows (:conn rc sql))))
			 (descr  (object->string (cdadr holder)))
			 (name (object->string (cdar holder)))
			 )
		    (view-render "edit" (the-environment)))))

(project-define editaction
		(options #:conn #t)
		(lambda (rc)
		  (let* ((help-topic "project")
			 (prj-name (get-from-qstr rc "pname"))
			 (descr (get-from-qstr rc "descr"))
			 (prjid (get-from-qstr rc "prjid"))			 
			 (sql (string-append "UPDATE project SET project_name='" prj-name "', descr='" descr "' WHERE id=" prjid))
			 (dummy (:conn rc sql))
			 )
;;		    (view-render "test" (the-environment))
		    (redirect-to rc "project/getall")
  )))
