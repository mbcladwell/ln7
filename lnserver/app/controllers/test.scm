;; Controller test definition of lnserver
;; Please add your license header here.
;; This file is generated automatically by GNU Artanis.
(define-artanis-controller test) ; DO NOT REMOVE THIS LINE!!!
(use-modules (web uri))

(define (get-redirect-uri dest)
  (string->uri (string-append "http://3.13.182.53:3000" dest)))


(test-define page1
  (lambda (rc)
   (view-render "page1" (the-environment))
  ))

;; (post "/test/page1action"
;; 		 (lambda (rc)
;; 		     (redirect-to rc (get-redirect-uri "/test/page2"))
;; 		     ))

(post "/test/page1action"
		 (lambda (rc)
		     (redirect-to rc  "/test/page2")
		     ))

(test-define page2
  (lambda (rc)
   (view-render "page2" (the-environment))
  ))

