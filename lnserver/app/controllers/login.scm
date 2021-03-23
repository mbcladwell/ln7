;; Controller login definition of postest
;; Please add your license header here.
;; This file is generated automatically by GNU Artanis.

(define-artanis-controller login) ; DO NOT REMOVE THIS LINE!!!

(use-modules (lnserver sys extra)(artanis cookie))

;;(use-modules (artanis artanis)(artanis utils)(artanis irregex)
;;	     ((rnrs) #:select (define-record-type))	     
;;	     (srfi srfi-1)(dbi dbi) 
;;	     (ice-9 textual-ports)(ice-9 rdelim)(rnrs bytevectors)
;;	     (web uri)(ice-9 pretty-print))

(get "/login"
	       #:cookies '(names prjid sid )
  (lambda (rc)
    (let* ((login-failed (if (params rc "login_failed") (params rc "login_failed") ""))
	   (help-topic "login")
	  ;; (dummy (:cookies-remove! rc 'prjid ))
	 ;;  (dummy (:cookies-remove! rc 'sid))
	   (dest (params rc "destination"))
	   (destinationq (addquotes (if dest dest "project/getall")))
	 )
    (view-render "login" (the-environment))
  )))



(define (get-id-for-name name rows)
  (if (and  (null? (cdr rows))  (string=?  (cdadar rows) name))
      (number->string (cdaar rows))
      (if (string=?  (cdadar rows) name)
	   (number->string (cdaar rows))
	   (get-id-for-name name (cdr rows)))))


;; (define (get-group-for-name name rows)
;;   (if (and  (null? (cdr rows))  (string=?   (cdadar rows) name))
;;        (cdr (caddar rows))
;;       (if (string=?   (cdadar rows) name)
;; 	   (cdr (caddar rows))
;; 	   (get-group-for-name name (cdr rows)))))

(post "/auth"
      #:auth `(table person "lnuser" "passwd" "salt" ,my-hmac)
      #:session #t
      #:conn #t
      #:cookies '(names prjid sid )
      #:from-post 'qstr
      (lambda (rc)	
	 (if (:session rc 'check)
	     (let* (
		    (dest (uri-decode (:from-post rc 'get-vals "destination")))
		    ;; (dest (params rc "destination"))
		    (requested-url  (if dest dest "/project/getall")))
	       (redirect-to rc requested-url))
	     ;; requested url, sid, userid must be available at top level
	     (let* ((sid (:auth rc))		    
		    (userid (if sid (let* (
					   (sql "select id, lnuser, usergroup from person")
					   (ret  (DB-get-all-rows (:conn rc sql)))  ;;this is in artanis/artanis/db.scm
					   (name (:from-post rc 'get-vals "lnuser"))
					   (userid (get-id-for-name name ret))
					   (dummy (:cookies-set! rc 'prjid "prjid" "1"))
					   ;;(dummy (:cookies-set! rc 'sid "sid" sid))
					   (sql2 (string-append "INSERT INTO sess_person ( sid, person_id) VALUES ('" sid "', " userid ")"))
					   (dummy (:conn rc sql2))
					   )
				      userid)
				#f))
		    (requested-url (if sid (let* (
						  (dest  (uri-decode (:from-post rc 'get-vals "destination")))				  			      
						  )
					     (if dest dest "/project/getall"))
				       "/login?login_failed=Login_Failed!"))
		    )
	       (redirect-to rc requested-url)))))
	     ;;  (view-render "test" (the-environment))))))

  

;; (get "/login/setuserid"
;;       #:conn #t
;;       (lambda (rc)	
;; 	     (let* (
;; 		    (dest (uri-decode (params rc "dest")))
;; 		    (sid (uri-decode (params rc "sid")))
;; 		    (userid (uri-decode (params rc "userid")))
;; 		    (sql (string-append "UPDATE sessions SET person_id=" userid " WHERE sid='" sid "'"))
;; 		    (dummy (:conn rc sql))
;; 		    )
;; 	       (redirect-to rc dest))))
;;	       (view-render "test" (the-environment)))))



(login-define wauth
	      (options  #:session #t
			#:with-auth "/login")
		;;	#:auth `(table person "lnuser" "passwd" "salt" ,my-hmac))      
	      (lambda (rc)
		(let* (
		       (check (:session rc 'check))
		       (results "empty"))
		       ;;(results (:auth rc)))	 	  
		  (view-render "test" (the-environment))
		  )))

(login-define sess
	      (options  #:session #t
			#:with-auth "/login")
		;;	#:auth `(table person "lnuser" "passwd" "salt" ,my-hmac))      
	      (lambda (rc)
		(let* (
		       (check (:session rc 'check))
		       (results "empty"))
		       ;;(results (:auth rc)))	 	  
		  (view-render "test" (the-environment))
		  )))

(get "/find" #:session #t (lambda (rc)
                             (if (:session rc 'check)
                                 "YES"
                               "NO!")))
