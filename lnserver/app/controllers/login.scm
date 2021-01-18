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


;; (post "/auth"
;;  #:auth `(table person "lnuser" "passwd" "salt" ,my-hmac)
;;  #:session #t
;;  #:conn #t
;;  #:cookies '(names userid user group requested-url sid ret)    
;;  #:from-post 'qstr
;;  (lambda (rc)
;;    (cond
;;     ((:session rc 'check)
;;      (let* ((dest (:from-post rc 'get "destination"))
;; 	    (requested-url  (if dest dest "/project/getall")))
;;        (redirect-to rc requested-url)))
;;     ((:auth rc)
;;      (let* (
;; 	    (sidvar (:session rc 'spawn))
;; 	;;   (dummy (:cookies-set! rc 'sid "sid" sidvar))
;; 	   (name (:from-post rc 'get "lnuser"))
;; 	   (dummy (:cookies-set! rc 'user "user" name))
;; 	   (sql "select id, lnuser, usergroup from person")
;; 	   (ret  (DB-get-all-rows (:conn rc sql)))  ;;this is in artanis/artanis/db.scm
;; 	   (id (get-id-for-name name ret))
;; 	   (group (get-group-for-name name ret))
;; 	   (dummy (:cookies-set! rc 'userid "userid" id))
;; 	   (dummy (:cookies-set! rc 'group "group" group))
;; 	   (dest (:from-post rc 'get "destination"))
;; 	   (requested-url  (if dest dest  "/project/getall")) )
;;        (redirect-to rc requested-url)))
;;     (else (redirect-to rc "/login/login?login_failed=Login_Failed!")))))


;; this works

;; (post "/auth"
;;  #:auth `(table person "lnuser" "passwd" "salt" ,my-hmac)
;;  #:session #t
;;  #:cookies '(names userid)
;;  (lambda (rc)
;;    (cond
;;     ((:session rc 'check) "auth ok (session)")
;;     ((:auth rc)
;;      (:session rc 'spawn)
;;      "auth ok")
;;     (else (redirect-to rc "/login/login?login_failed=true")))))


(post "/auth"
      #:cookies #t
      #:auth `(table person "lnuser" "passwd" "salt" ,my-hmac)
      #:session #t
      (lambda (rc)
	(let* (
	       ;; (check (:session rc 'check)))
	       (results (:auth rc)))
	  ;; (spawn (:session rc 'spawn)))	  
	  (view-render "test" (the-environment))
     )))


