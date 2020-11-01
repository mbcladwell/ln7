;; Controller test definition of lnserver
;; Please add your license header here.
;; This file is generated automatically by GNU Artanis.
(define-artanis-controller test) ; DO NOT REMOVE THIS LINE!!!
;;(use-modules (artanis cookie))
(get "/test/logtest" #:cookies '(names group)
  (lambda (rc)
  "<h1>This is test#logtest</h1><p>Find me in app/views/test/logtest.html.tpl</p>"
  ;; TODO: add controller method `logtest'
  ;; uncomment this line if you want to render view from template
  (let*((grp (rc-cookie rc))
	(sid "sidintestscm")
	)
    
   (view-render "logtest" (the-environment)))
  ))


;; can't have sessions and cookies in the same method
(get "/sessiontest"
   ;;  #:session #t
     #:cookies '(names sid)     
  (lambda (rc)
  "<h1>This is test#sessiontest</h1><p>Find me in app/views/test/sessiontest.html.tpl</p>"
  ;; TODO: add controller method `sessiontest'
  ;; uncomment this line if you want to render view from template
  (let* (
;;	 (dummy  (:session rc 'spawn))
	 	 (check-value (:cookies-set! rc 'sid "sid" "sometext"))
;;	 (check-value "manual")
	 )
   (view-render "sessiontest" (the-environment) ))
  ))

