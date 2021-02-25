;; Controller users definition of lnserver
;; Please add your license header here.
;; This file is generated automatically by GNU Artanis.
(define-artanis-controller users) ; DO NOT REMOVE THIS LINE!!!
(use-modules (artanis utils)(artanis irregex)(srfi srfi-1)(dbi dbi) (lnserver sys extra))


(define (default-hmac passwd salt)
  (substring (string->sha-256 (string-append passwd salt)) 0 16))



(define (prep-user-rows a)
  (fold (lambda (x prev)
          (let ((id (get-c1 x))
		(group-name (result-ref x "usergroup"))
                (lnuser-name (result-ref x "lnuser"))
                (email (result-ref x "email"))
		)
            (cons (string-append "<tr><th> <input type=\"radio\" id=\"" id  "\" name=\"id\" value=\"" id   "\"></th><th> " id "</th><th> " group-name "</th><th> " lnuser-name "</th><th> " email "</th></tr>")
		  prev)))
        '() a))


(users-define getall
	      (options #:conn #t
		       #:cookies '(names prjid userid sid))
	      (lambda (rc)
		(let* ((help-topic "users")
		       (prjid (:cookies-value rc "prjid"))
		       (userid (:cookies-value rc "userid"))
		       (sid (:cookies-value rc "sid"))  
		       (sql "select person.id, person.usergroup, lnuser, email from person ORDER BY person.id DESC"  )
		       (holder (DB-get-all-rows(:conn rc sql)))
		       (body (string-concatenate (prep-user-rows holder)))
		       )
		  (view-render "getall" (the-environment))
		  )))


(users-define add
	      (options
		       #:cookies '(names prjid userid sid))

	      (lambda (rc)
		(let* ((help-topic "user")
		       (prjid (:cookies-value rc "prjid"))
		       (userid (:cookies-value rc "userid"))
		       (sid (:cookies-value rc "sid"))
		       )
		  (view-render "add" (the-environment)))))



(get "/users/addaction" #:conn #t
  (lambda (rc)
  (let*((salt (get-random-from-dev #:length 8 #:uppercase #f))
	(pre-pwd (get-from-qstr rc  "pw"))
	(name  (get-from-qstr rc "uname"))
	(usergroup (get-from-qstr rc "group"))
	(pwd  (default-hmac pre-pwd salt))
	(email (get-from-qstr rc "email"))
	(sql (string-append "insert into person (lnuser, passwd, salt, email, usergroup ) VALUES ('" name "', '" pwd "', '" salt "', '" email "', '" usergroup "')"))
	(dummy (:conn rc sql)))
    (redirect-to rc "/users/getall" ))
  ))





;; (users-define addaction
;; 		(lambda (rc)
;; 		  (let* ((help-topic "users")
;; 			 (user-name (get-from-qstr rc "uname"))
;; 			 (tags (get-from-qstr rc "tags"))
;; 			 (pw (get-from-qstr rc "pw"))			 
;; 			 (group (get-from-qstr rc "group"))			 
;; 			 (insert-string (string-append "select new_user('"  user-name "', '" tags "', '" pw "', '" group "')"))
;; 			 (dummy (dbi-query ciccio insert-string))
;; 			 )
;; 		    (redirect-to rc "users/getall")
;;   )))
