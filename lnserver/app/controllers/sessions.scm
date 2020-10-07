;; Controller sessions definition of lnserver
;; Please add your license header here.
;; This file is generated automatically by GNU Artanis.
(define-artanis-controller sessions) ; DO NOT REMOVE THIS LINE!!!

(use-modules (artanis utils)(artanis irregex)(srfi srfi-1)(srfi srfi-19)(dbi dbi) (lnserver sys extra)
	     (ice-9 pretty-print))

(sessions-define get
  (lambda (rc)
  "<h1>This is sessions#get</h1><p>Find me in app/views/sessions/get.html.tpl</p>"
  ;; TODO: add controller method `get'
  ;; uncomment this line if you want to render view from template
  ;; (view-render "get" (the-environment))
  ))


(define (prep-session-rows a)
  (fold (lambda (x prev)
          (let ((id (result-ref x "id"))
		(updated (result-ref x "updated"))
		(lnuser-name (result-ref x "lnuser_name"))
		(usergroup (result-ref x "usergroup")))
	      
	      (cons (string-append "<tr><th>" id  "</th><th>" updated  "</th><th>" lnuser-name "</th><th>" usergroup "</th><tr>")
		  prev)))
        '() a))





(sessions-define getall
		 (lambda (rc)
		   (let* ((help-topic "session")
			  (ret #f)
			  (holder '())
			  (dummy (dbi-query ciccio  "select * from get_all_sessions()"  ))
			  (ret (dbi-get_row ciccio))
			  (dummy2 (while (not (equal? ret #f))
				    ;;(pretty-print ret)
				    (set! holder (cons ret holder))		   
				    (set! ret  (dbi-get_row ciccio))))
			  (body (string-concatenate (prep-session-rows holder)))
			  )
		     (view-render "getall" (the-environment))
		     )))
