;; Controller test definition of lnserver
;; Please add your license header here.
;; This file is generated automatically by GNU Artanis.
(define-artanis-controller test) ; DO NOT REMOVE THIS LINE!!!

(get "/test/logtest" #:cookies '(names group)
  (lambda (rc)
  "<h1>This is test#logtest</h1><p>Find me in app/views/test/logtest.html.tpl</p>"
  ;; TODO: add controller method `logtest'
  ;; uncomment this line if you want to render view from template
  (let*((grp ((:cookies-ref rc "group" group)))
	)
    
   (view-render "logtest" (the-environment)))
  ))

(test-define sessiontest
  (lambda (rc)
  "<h1>This is test#sessiontest</h1><p>Find me in app/views/test/sessiontest.html.tpl</p>"
  ;; TODO: add controller method `sessiontest'
  ;; uncomment this line if you want to render view from template
   (view-render "sessiontest" (the-environment))
  ))

