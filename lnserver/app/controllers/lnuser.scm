;; Controller user definition of postest
;; Please add your license header here.
;; This file is generated automatically by GNU Artanis.
;;(use-modules (artanis artanis)(artanis utils) (ice-9 local-eval) (srfi srfi-1)
           ;;  (artanis irregex)(dbi dbi) (ice-9 textual-ports)(ice-9 rdelim))
(define-artanis-controller lnuser) ; DO NOT REMOVE THIS LINE!!!

;;(define (default-hmac passwd salt)
;;  (substring (string->sha-256 (string-append passwd salt)) 0 16))


(post "/add" #:conn #t #:from-post 'qstr
  (lambda (rc)
  "<h1>This is user#add</h1><p>Find me in app/views/lnuser/add.html.tpl</p>"
  ;; TODO: add controller method `add'
  ;; uncomment this line if you want to render view from template
  (let*((salt (get-random-from-dev #:length 8 #:uppercase #f))
	(qstr (:from-post rc 'get))
	(pre-pwd (car (assoc-ref qstr  "passwd")))
	(name (car (assoc-ref qstr "lnuser")))
	(pwd  (default-hmac pre-pwd salt))
	(sql (string-append "insert into person (lnuser, passwd, salt ) VALUES ('" name "', '" pwd "', '" salt "')"))
	(dummy (:conn rc sql)))
   (view-render "add" (the-environment)) )
  ))

(lnuser-define entry
  (lambda (rc)
  "<h1>This is user#add</h1><p>Find me in app/views/lnuser/entry.html.tpl</p>"
  ;; TODO: add controller method `add'
  ;; uncomment this line if you want to render view from template
   (view-render "entry" (the-environment))
  ))

