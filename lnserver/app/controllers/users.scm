;; Controller users definition of lnserver
;; Please add your license header here.
;; This file is generated automatically by GNU Artanis.
(define-artanis-controller users) ; DO NOT REMOVE THIS LINE!!!
(use-modules (artanis utils)(artanis irregex)(srfi srfi-1)(dbi dbi) (lnserver sys extra))

(users-define get
  (lambda (rc)
  "<h1>This is users#get</h1><p>Find me in app/views/users/get.html.tpl</p>"
  ;; TODO: add controller method `get'
  ;; uncomment this line if you want to render view from template
  ;; (view-render "get" (the-environment))
  ))

(define (prep-user-rows a)
  (fold (lambda (x prev)
          (let (
                (lnuser_name (result-ref x "lnuser_name"))
                (tags (result-ref x "tags"))
		(descr (result-ref x "descr")))
            (cons (string-append "<tr><th> <input type=\"radio\" id=\"" project_sys_name  "\" name=\"project-id\" value=\"" (number->string (cdr (car x)))   "\"></th><th><a href=\"/plateset/getps?id=" (number->string (cdr (car x))) "\">" project_sys_name "</a></th><th>" project_name "</th><th>" descr "</th></tr>")
		  prev)))
        '() a))


(users-define getall
		(lambda (rc)
    (let* ((help-topic "users")
	   (ret #f)
	   (holder '())
	   (dummy (dbi-query ciccio  "select id, lnuser_name, tags from lnuser"  ))
	   (ret (dbi-get_row ciccio))
	   (dummy2 (while (not (equal? ret #f))     
		     (set! holder (cons ret holder))		   
		     (set! ret  (dbi-get_row ciccio))))
	   (body (string-concatenate (prep-user-rows holder)))
	   )
      (view-render "getall" (the-environment))
  )))
