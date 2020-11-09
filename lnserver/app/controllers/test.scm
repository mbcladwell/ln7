;; Controller test definition of lnserver
;; Please add your license header here.
;; This file is generated automatically by GNU Artanis.
(define-artanis-controller test) ; DO NOT REMOVE THIS LINE!!!
;;(use-modules (artanis cookie))

(load "/home/mbc/Downloads/ssql-fixed.scm")



(define (get-salt)
(get-random-from-dev #:length 8 #:uppercase #f))


(define (my-hmac passwd salt)
  (substring (string->sha-256 (string-append passwd salt)) 0 16))

(define (checker username passwd)
  (let* ((check-user username)
	 (check-pwd passwd))
   #t ))


(get "/sessiontest"
     #:session
     #t #:cookies '(names sid user project)
     #:auth `(table person "lnuser" "passwd" "salt" ,my-hmac)
  (lambda (rc)
  "<h1>This is test#logtest</h1><p>Find me in app/views/test/logtest.html.tpl</p>"
  ;; TODO: add controller method `logtest'
  ;; uncomment this line if you want to render view from template
  (let*((dummy (load "/home/mbc/Downloads/ssql-fixed.scm"))
	(sidvar (:session rc 'spawn))
	(dummy (:cookies-set! rc 'sid "sid" sidvar))
	(current  (:session rc 'check ))
	;;(sidvar (:cookies-ref rc 'sid "sid" ))
	(auth-rc (:auth rc))
	)
    
   (view-render "sessiontest" (the-environment)))
  ))


(post "/test/authtest"
      #:auth '(table "lnuser" "passwd" my-hmac)
      #:from-post #t
;;     #:auth '(table person "lnuser" "passwd" "salt" my-hmac) 
  (lambda (rc)
  (let*((dummy (load "/home/mbc/Downloads/ssql-fixed.scm"))
	(check-value  (:auth rc))
	)    
   (view-render "authtest" (the-environment)))
  ))

