;; Controller utilities definition of lnserver
;; Please add your license header here.
;; This file is generated automatically by GNU Artanis.
(define-artanis-controller utilities) ; DO NOT REMOVE THIS LINE!!!

(use-modules (artanis utils)(artanis irregex)(srfi srfi-1)(dbi dbi) (lnserver sys extra))

(define (process-item x) (string-append "<tr><th>"(car x) "</th><th>" (cadr x) "</th></tr>"))


(define (get-key cust-id email )
  (string->md5 (string-append cust-id email "lnsDFoKytr")))

(define (validate-key cust_id cust_email cust_key)
  (equal? (get-key cust_id cust_email) cust_key))



(post "/registeraction"  #:from-post 'qstr #:conn #t
		  (lambda (rc)
		    (let* ((help-topic "register")
			   (sql "select cust_id from config where id=1")
			   (emptyreg? (equal? "" (cdaar (DB-get-all-rows (:conn rc sql)))))
			   (cust-id (stripfix (:from-post rc 'get-vals "custid")))
			   (cust-key (stripfix (:from-post rc 'get-vals "custkey")))
			   (email (stripfix (:from-post rc 'get-vals "email")))
			   (validkey? (validate-key cust-id email cust-key))
			   (sql2 (string-append "UPDATE config SET cust_id='" cust-id "', cust_key= '" cust-key "', cust_email='" email "' WHERE id=1"))
			   (dummy (if (and emptyreg? validkey?) (:conn rc sql2) #f))
 			   (sql3 "select cust_id, cust_key, cust_email from config where id=1")
			   (holder (car (DB-get-all-rows (:conn rc sql3))))
			   (vcust (assoc-ref holder "cust_id"))
			   (vkey (assoc-ref holder "cust_key"))
			   (vemail (assoc-ref holder "cust_email"))
			   )			    		      	      		 
			 (view-render "isreg" (the-environment)))
			 ))
			
		
		      
  


(utilities-define register
		  (lambda (rc)
		    (let* (
			   (help-topic "register"))			    
		    (view-render "register" (the-environment)))
  ))

(utilities-define login
		  (lambda (rc)
		    (let* ((version ln-version)
			   ;;(connection nopwd-conn)
			   (help-topic "login")	)		    
		    (view-render "login" (the-environment)))
  ))

(utilities-define validate
		  (options #:conn #t)
		  (lambda (rc) 
		    (let* ((user (get-from-qstr rc "name"))
			   (pword (get-from-qstr rc "password"))
			   (help-topic "login")
			   (sql  (string-append "select id, password from lnuser where lnuser_name ='" user "'" ))
			   (ret (DB-get-all-rows (:conn rc sql))))
                      (if (result-ref ret "password")
			  (if (string=? pword (result-ref ret "password"))
			      (let* ((userid (get-c1 ret))	   
				      (dummy (DB-get-all-rows (:conn rc (string-append "INSERT INTO lnsession(lnuser_id) VALUES('" userid "')"))))
				      (dummy2 (DB-get-all-rows (:conn rc  "select id from lnsession order by id DESC LIMIT 1")))
				      ;;(sid-candidate (get-c1 (dbi-get_row (:conn rc)))
				      )
				 (begin
				  ;; (set! sid sid-candidate)
				 (redirect-to rc "project/getall" )))
			       (view-render "login" (the-environment)))))))

(utilities-define help
		  (lambda (rc)
		    (let* ((topic (get-from-qstr rc "topic")))
		    (redirect-to rc  (string-append "../software/" topic "/index.html") ))))

