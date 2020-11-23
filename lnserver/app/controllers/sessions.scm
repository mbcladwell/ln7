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
          (let* ((id (result-ref x "sid"))
		(lnuser-name (result-ref x "lnuser"))
		(usergroup (result-ref x "usergroup"))
		(expires (result-ref x "expires"))
		(expires-seconds (car (mktime (car (strptime  "%a, %d %b %Y %H:%M:%S %Z" expires)))))
		(now (time-second (current-time)))
		(expired? (if (> (- now expires-seconds) 0) #t #f ))
		(expire-text (if expired? expires (string-append "<font style=\"color:red\">" expires "</font>" ))))      
	      (cons (string-append "<tr><th>" id  "</th><th>" lnuser-name "</th><th>" usergroup "</th><th>" expire-text  "</th><tr>")
		    prev)
	      ))
        '() a))




;; person_id must be populated
(sessions-define getall
		 (options #:conn #t)
		 (lambda (rc)
		   (let* ((help-topic "session")
			  (sql  "select * from get_all_sessions()")
			  (holder (DB-get-all-rows (:conn rc sql)))
			  (body (string-concatenate (prep-session-rows holder)))
			  )
		     (view-render "getall" (the-environment))
		     )))



