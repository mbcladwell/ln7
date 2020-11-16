;; Controller test definition of lnserver
;; Please add your license header here.
;; This file is generated automatically by GNU Artanis.
(define-artanis-controller test) ; DO NOT REMOVE THIS LINE!!!


(define (get-salt)
(get-random-from-dev #:length 8 #:uppercase #f))


(define (my-hmac passwd salt)
  (substring (string->sha-256 (string-append passwd salt)) 0 16))

(define (checker username passwd)
  (let* ((check-user username)
	 (check-pwd passwd))
   #t ))


(get "/test/sessiontest"
     #:session #t
    ;; #:cookies '(names sid user project)
     ;;#:auth `(table person "lnuser" "passwd" "salt" ,my-hmac)
  (lambda (rc)
  "<h1>This is test#sessiontest</h1><p>Find me in app/views/test/test.html.tpl</p>"
  ;; TODO: add controller method `logtest'
  ;; uncomment this line if you want to render view from template
  (let*( (new-session (if (:session rc 'check ) #f  (:session rc 'spawn)))
	;;(dummy (:cookies-set! rc 'sid "sid" sidvar))
	(current  (:session rc 'check ))
	(getsid (:cookies-ref rc 'sid "sid" ))
;;	(auth-rc (:auth rc))
	)    
   (view-render "sessiontest" (the-environment)))
  ))

(get "/test/cookietest"
    ;; #:session #t
     #:cookies '(names sid user project)
     ;;#:auth `(table person "lnuser" "passwd" "salt" ,my-hmac)
  (lambda (rc)
  "<h1>This is test#cookietest</h1><p>Find me in app/views/test/cookietest.html.tpl</p>"
  (let*(
;;	(valid-session (:session rc 'check ) )
	;;(dummy (:cookies-set! rc 'sid "sid" sidvar))
	(getsid (:cookies-ref rc 'sid "sid" ))
;;	(auth-rc (:auth rc))
	)
   (view-render "cookietest" (the-environment)))
  ))


(get "/test/authtest"
  ;; #:auth '(table "lnuser" "passwd" my-hmac)
     ;;  #:from-post #t
     #:with-auth "/login/login"
  #:auth `(table person "lnuser" "passwd" "salt" ,my-hmac) 
  (lambda (rc)
  (let*(
	(check-value  (:auth rc))
	(requested-url "req-url")
	(header-sid (:session rc 'check))
	)    
   (view-render "authtest" (the-environment)))
  ))

