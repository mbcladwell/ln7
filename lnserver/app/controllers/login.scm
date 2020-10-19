;; Controller login definition of lnserver
;; Please add your license header here.
;; This file is generated automatically by GNU Artanis.
(define-artanis-controller login) ; DO NOT REMOVE THIS LINE!!!

(login-define "auth" 
  (lambda (rc)  #:session 'spawn
  "<h1>This is login#auth</h1><p>Find me in app/views/login/auth.html.tpl</p>"
  (let*((sid (:session rc 'check-and-spawn))
	)
    #f
    )
  
   (view-render "auth" (the-environment))
  ))



(post "/auth/sign_in" #:auth      `(table PEOPLE "USERNAME" "PASSWORD" "SALT",SALTER)
      #:cookies   '(names sess)
      #:session   #t
      #:from-post 'qstr-safe
      (lambda (rc)
	(cond
	 [(:session rc 'check) (redirect-to rc "/")]
	 [(:auth    rc)        (:session rc 'spawn)
          (:cookies-set!
           rc
           'sess
           "account"
           (uri-decode (:from-post rc 'get "USERNAME")))
          (redirect-to rc "/")]
	 [else                   "Go to fail page."])))
