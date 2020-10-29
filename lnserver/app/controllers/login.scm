;; Controller login definition of postest
;; Please add your license header here.
;; This file is generated automatically by GNU Artanis.
(use-modules (artanis utils)(dbi dbi))
(define-artanis-controller login) ; DO NOT REMOVE THIS LINE!!!

(login-define login
  (lambda (rc)
  "<h1>This is login#auth</h1><p>Find me in app/views/login/login.html.tpl</p>"
  ;; TODO: add controller method `auth'
  ;; uncomment this line if you want to render view from template
  (let* ((login-failed (params rc "login_failed")))
    (view-render "login" (the-environment))
  )))

(define (get-salt)
(get-random-from-dev #:length 8 #:uppercase #f))


(define (default-hmac passwd salt)
  (substring (string->sha-256 (string-append passwd salt)) 0 16))

(define (get-name-for-id id rows)
  (if (null? (cdr rows)) #f
      (if  (= (cdaar rows) id) (cdadar rows)
      (get-name-for-id id (cdr rows)))))

(post "/auth"
      #:auth `(table person "lnuser" "passwd" ,default-hmac)
      #:session #t
      #:conn #t
      #:cookies '(names userid user )
      #:from-post 'qstr
      (lambda (rc)
	(cond
	 ((:session rc 'check) "auth ok (session)")
	 ((:auth rc) (:session rc 'spawn)
	  (let*((qstr (:from-post rc 'get))
		(name (car (assoc-ref qstr "lnuser")))
		(dummy (:cookies-set! rc 'user "lnuser" name))
		(mtable (map-table-from-DB (:conn rc)))
		(rows (car (list (mtable 'get 'lnuser #:columns '(id lnuser_name)))))
		(userid )
		(dummy (:cookies-set! rc 'userid "userid" ret)))     
	    "auth ok"))
	 (else (redirect-to rc "/login/login?login_failed=true")))))





