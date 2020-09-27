;; Controller sessions definition of lnserver
;; Please add your license header here.
;; This file is generated automatically by GNU Artanis.
(define-artanis-controller sessions) ; DO NOT REMOVE THIS LINE!!!

(use-modules (artanis utils)(artanis irregex)(srfi srfi-1)(dbi dbi) (lnserver sys extra))

(sessions-define get
  (lambda (rc)
  "<h1>This is sessions#get</h1><p>Find me in app/views/sessions/get.html.tpl</p>"
  ;; TODO: add controller method `get'
  ;; uncomment this line if you want to render view from template
  ;; (view-render "get" (the-environment))
  ))

