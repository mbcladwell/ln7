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
          (let ((id (get-c1 x))
		(group-name (result-ref x "usergroup"))
                (lnuser-name (result-ref x "lnuser_name"))
                (tags (result-ref x "tags"))
		)
            (cons (string-append "<tr><th> <input type=\"radio\" id=\"" id  "\" name=\"id\" value=\"" id   "\"></th><th>" id   "</th><th> " group-name "</th><th> " lnuser-name "</th><th>" tags "</th></tr>")
		  prev)))
        '() a))


(users-define getall
		(lambda (rc)
    (let* ((help-topic "users")
	   (ret #f)
	   (holder '())
	   (dummy (dbi-query ciccio  "select lnuser.id, lnuser_groups.usergroup, lnuser_name, tags from lnuser, lnuser_groups where lnuser_groups.id = lnuser.usergroup_id ORDER BY lnuser.id"  ))
	   (ret (dbi-get_row ciccio))
	   (dummy2 (while (not (equal? ret #f))     
		     (set! holder (cons ret holder))		   
		     (set! ret  (dbi-get_row ciccio))))
	   (body (string-concatenate (prep-user-rows holder)))
	   )
      (view-render "getall" (the-environment))
  )))


(users-define add
		(lambda (rc)
		  (let* ((help-topic "user"))
		    (view-render "add" (the-environment)))))


(users-define addaction
		(lambda (rc)
		  (let* ((help-topic "users")
			 (user-name (get-from-qstr rc "uname"))
			 (tags (get-from-qstr rc "tags"))
			 (pw (get-from-qstr rc "pw"))			 
			 (group (get-from-qstr rc "group"))			 
			 (insert-string (string-append "select new_user('"  user-name "', '" tags "', '" pw "', '" group "')"))
			 (dummy (dbi-query ciccio insert-string))
			 )
		    (redirect-to rc "users/getall")
  )))
