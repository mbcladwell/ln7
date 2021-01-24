;; Controller test definition of lnserver
;; Please add your license header here.
;; This file is generated automatically by GNU Artanis.
(define-artanis-controller test) ; DO NOT REMOVE THIS LINE!!!

(test-define add
  (lambda (rc)
  "<h1>This is test#add</h1><p>Find me in app/views/test/add.html.tpl</p>"
  ;; TODO: add controller method `add'
  ;; uncomment this line if you want to render view from template
  ;; (view-render "add" (the-environment))
  ))

(test-define remove
  (options #:cookies '(names prjid sid))
		 (lambda (rc)
		   (let* (
			  (dummy (:cookies-setattr! rc 'prjid #:path "/plateset"))
			  (dummy (:cookies-remove! rc "prjid"))
			  )
		     (view-render "remove" (the-environment))
		     )))

(test-define check
  (lambda (rc)
  "<h1>This is test#check</h1><p>Find me in app/views/test/check.html.tpl</p>"
  ;; TODO: add controller method `check'
  ;; uncomment this line if you want to render view from template
  ;; (view-render "check" (the-environment))
  ))

