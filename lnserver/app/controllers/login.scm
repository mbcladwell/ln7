;; Controller login definition of postest
;; Please add your license header here.
;; This file is generated automatically by GNU Artanis.

(define-artanis-controller login) ; DO NOT REMOVE THIS LINE!!!

(use-modules (lnserver sys extra))

;;(use-modules (artanis artanis)(artanis utils)(artanis irregex)
;;	     ((rnrs) #:select (define-record-type))	     
;;	     (srfi srfi-1)(dbi dbi) 
;;	     (ice-9 textual-ports)(ice-9 rdelim)(rnrs bytevectors)
;;	     (web uri)(ice-9 pretty-print))

(login-define login
	      (options #:cookies #t)
  (lambda (rc)
  "<h1>This is login#auth</h1><p>Find me in app/views/login/login.html.tpl</p>"
  ;; TODO: add controller method `auth'
  ;; uncomment this line if you want to render view from template
  (let* ((login-failed (params rc "login_failed"))
	 (help-topic "login"))
    (view-render "login" (the-environment))
  )))



(define (get-id-for-name name rows)
  (if (and  (null? (cdr rows))  (string=?  (cdadar rows) name))
      (number->string (cdaar rows))
      (if (string=?  (cdadar rows) name)
	   (number->string (cdaar rows))
	   (get-id-for-name name (cdr rows)))))


(define (get-group-for-name name rows)
  (if (and  (null? (cdr rows))  (string=?   (cdadar rows) name))
       (cdr (caddar rows))
      (if (string=?   (cdadar rows) name)
	   (cdr (caddar rows))
	   (get-group-for-name name (cdr rows)))))


(post "/auth"
 #:auth `(table person "lnuser" "passwd" "salt" ,my-hmac)
 #:session #t
 #:conn #t
 #:cookies #t ;; '(names userid lnuser group requested-url sid ret)    
  #:from-post 'qstr
 (lambda (rc)
   (cond
    ((:session rc 'check)
     (let* ((dest (:from-post rc 'get "destination"))
	    (requested-url  (if dest dest "/project/getall")))
       (redirect-to rc requested-url)))
    ((:auth rc)
     (let* (	    
	    (sid (:cookies-value rc "sid")) ;;this won't work - not in client yet
	    (name (:from-post rc 'get "lnuser"))
	    
	    (dummy (:cookies-set! rc 'lnuser "lnuser" name))
	    )
	  ;;  (sql "select id, lnuser, usergroup from person")
	  ;;  (ret  (DB-get-all-rows (:conn rc sql)))  ;;this is in artanis/artanis/db.scm
	  ;;  (id (get-id-for-name name ret))
	  ;;  (group (get-group-for-name name ret))
	  ;;  (dummy (:cookies-set! rc 'userid "userid" id))
	  ;;  (dummy (:cookies-set! rc 'group "group" group))
	  ;; (dest (:from-post rc 'get "destination"))
	  ;; (requested-url  (if dest dest  "/project/getall")) )
       ;;(redirect-to rc requested-url)
       (view-render "test" (the-environment))
       ))
    (else (redirect-to rc "/login/login?login_failed=Login_Failed!")))))


;; this works, note that session-spawn is not needed or you get 2 sessions

;; (post "/auth"
;;  #:auth `(table person "lnuser" "passwd" "salt" ,my-hmac)
;;  #:session #t
;;  #:cookies '(names userid)
;;  (lambda (rc)
;;    (cond
;;     ((:session rc 'check) "auth ok (session)")
;;     ((:auth rc)
;;      ;;(:session rc 'spawn)
;;      "auth ok")
;;     (else (redirect-to rc "/login/login?login_failed=true")))))


;; (post "/auth"
      
;;       #:auth `(table person "lnuser" "passwd" "salt" ,my-hmac)
;;       #:session #t
;;       (lambda (rc)
;; 	(let* (
	      
;; 	       (results (:auth rc)))
	 	  
;; 	  (view-render "test" (the-environment))
;;      )))


(login-define check
   (options    #:session #t)
 ;;     #:auth `(table person "lnuser" "passwd" "salt" ,my-hmac)
      
      (lambda (rc)
	(let* (
	       (check (:session rc 'check)))
	       ;;(results (:auth rc)))
	 	  
	  (view-render "test" (the-environment))
     )))

(login-define wauth
   (options  #:session #t  #:with-auth "/login/login")
 ;;     #:auth `(table person "lnuser" "passwd" "salt" ,my-hmac)
      
      (lambda (rc)
	(let* (
	       (check (:session rc 'check)))
	       ;;(results (:auth rc)))
	 	  
	  (view-render "test" (the-environment))
     )))

