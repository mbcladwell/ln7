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
            (cons (string-append "<tr><th> <input type=\"radio\" id=\"" project_sys_name  "\" name=\"project-id\" value=\"" (number->string (cdr (car x)))   "\"></th><th><a href=\"/plateset/getps?id=" (number->string (cdr (car x))) "\">" project_sys_name "</a></th><th>" project_name "</th><th>" descr "</th></tr>")
		  prev)))
        '() a))



(project-define getall
		(lambda (rc)
    (let* ((help-topic "project")
	   (ret #f)
	   (holder '())
	   (dummy (dbi-query ciccio  "select id, project_sys_name, project_name, descr from project"  ))
	   (ret (dbi-get_row ciccio))
	   (dummy2 (while (not (equal? ret #f))     
		     (set! holder (cons ret holder))		   
		     (set! ret  (dbi-get_row ciccio))))
	   (body (string-concatenate (prep-project-rows holder)))
	   )
      (view-render "getall" (the-environment))
  )))

(project-define add
		(lambda (rc)
		  (let* ((help-topic "project"))
		    (view-render "add" (the-environment)))))


(project-define addaction
		(lambda (rc)
		  (let* ((help-topic "project")
			 (prj-name (get-from-qstr rc "pname"))
			 (descr (get-from-qstr rc "descr"))
			 (insert-string (string-append "select new_project('"  descr "', '" prj-name "', '" sid "')"))
			 (dummy (dbi-query ciccio insert-string))
			 )
		    (redirect-to rc "project/getall")
  )))

(project-define edit
		(lambda (rc)
		  (let* ((help-topic "project")
			 (ret #f)
			 (id (get-from-qstr rc "project-id"))
			 (query-string (string-append "select project_name, descr from project where id=" id ))
			 (dummy (dbi-query ciccio query-string))
			 (ret (dbi-get_row ciccio))
			 (descr (string-append "\"" (result-ref ret "descr") "\""))
			 (name (string-append "\"" (result-ref ret "project_name") "\""))
			 )
		    (view-render "edit" (the-environment)))))

(project-define editaction
		(lambda (rc)
		  (let* ((help-topic "project")
			 (prj-name (get-from-qstr rc "pname"))
			 (descr (get-from-qstr rc "descr"))
			 (id (get-from-qstr rc "id"))			 
			 (update-string (string-append "UPDATE project SET project_name=" prj-name ", descr=" descr "WHERE id=" id))
			 (dummy (dbi-query ciccio update-string))
			 )
;;		    (view-render "edit" (the-environment))
		    (redirect-to rc "project/getall")
  )))
