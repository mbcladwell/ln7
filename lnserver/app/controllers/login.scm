;; Controller login definition of postest
;; Please add your license header here.
;; This file is generated automatically by GNU Artanis.

(define-artanis-controller login) ; DO NOT REMOVE THIS LINE!!!

(use-modules (artanis artanis)(artanis utils)(artanis irregex) ((rnrs) #:select (define-record-type))	     
	     (srfi srfi-1)(dbi dbi) (lnserver sys extra)
	      (ice-9 textual-ports)(ice-9 rdelim)(rnrs bytevectors)(web uri)(ice-9 pretty-print))

(login-define login
  (lambda (rc)
  "<h1>This is login#auth</h1><p>Find me in app/views/login/login.html.tpl</p>"
  ;; TODO: add controller method `auth'
  ;; uncomment this line if you want to render view from template
  (let* ((login-failed (params rc "login_failed")))
    (view-render "login" (the-environment))
  )))

;; (post "/login/login"
;;       #:from-post 'qstr
;;   (lambda (rc)
;;   "<h1>This is login#auth</h1><p>Find me in app/views/login/login.html.tpl</p>"
;;   ;; TODO: add controller method `auth'
;;   ;; uncomment this line if you want to render view from template
;;   (let* ((login-failed (params rc "login_failed")))
;;     (view-render "/login" (the-environment))
;;   )))




(define (get-salt)
(get-random-from-dev #:length 8 #:uppercase #f))


(define (default-hmac passwd salt)
  (substring (string->sha-256 (string-append passwd salt)) 0 16))


(define (get-id-for-name name rows)
  (if (and  (null? (cdr rows))  (string=?  (cdadar rows) name))
      (number->string (cdaar rows))
      (if (string=?  (cdadar rows) name)
	   (number->string (cdaar rows))
	   (get-id-for-name name (cdr rows)))))

;; (define (get-id-for-name name rows)
;;   (if (and  (null? (cdr rows))  (string=?  (object->string (cdadar rows)) name))
;;       (number->string (cdaar rows))
;;       (if (string=?  (object->string (cdadar rows)) name)
;; 	   (number->string (cdaar rows))
;; 	   (get-id-for-name name (cdr rows)))))


(post "/auth"
      #:auth `(table person "lnuser" "passwd" ,default-hmac)
      #:session #t
      #:conn #t
      #:cookies '(names userid user group requested-url sid ret)
      #:from-post 'qstr
      (lambda (rc)
	(cond
	 ((:session rc 'check) "auth ok (session)")
	 ((:auth rc) (:session rc 'spawn)
	  (let*((qstr (:from-post rc 'get))
	;;	(name (car (assoc-ref qstr "lnuser")))
		(dummy (:cookies-set! rc 'user "user" name))
		(sql "select id, lnuser from person")
		(ret   (DB-get-all-rows (:conn rc sql)))  ;;this is in artanis/artanis/db.scm
		(dummy (:cookies-set! rc 'ret "ret" ret))
		(id (get-id-for-name name ret))
		(dummy (:cookies-set! rc 'userid "userid" id))
		(dummy (:cookies-set! rc 'sid "sid" sid))
		(group "admin")
		(dummy (:cookies-set! rc 'group "group" group))
	;;	(dummy (:cookies-set! rc 'sid "sid" (:cookies-ref rc "sid" sid)))
		(requested-url "/test/logtest")
		)
	    (redirect-to rc requested-url)))
	 (else (redirect-to rc "/login/login?login_failed=true")))))





