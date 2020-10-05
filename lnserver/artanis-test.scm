;; /gnu/store/0w76khfspfy8qmcpjya41chj3bgfcy0k-guile-3.0.4/bin/guile
;; /gnu/store/jgl9d4axpavsv83z2f1z1himnkbsxxqj-guile-2.2.7/bin/guile

(use-modules (srfi srfi-1)
	     (dbi dbi) 
	     (ice-9 textual-ports)(ice-9 rdelim)(ice-9 pretty-print))

(load "./sys/extra.scm")


(define ciccio (dbi-open "postgresql" "ln_admin:welcome:lndb:tcp:192.168.1.11:5432"))


(define (prep-session-rows a)
  (fold (lambda (x prev)
          (let ((id (get-c1 x))
		(updated (get-c2 x))
		(lnuser-name (result-ref x "lnuser_name"))
		(usergroup (result-ref x "usergroup")))
	      
	      (cons (string-append "<tr><th><a href=\"/hitlist/gethlbyid?id=" id  "\">" updated "</a></th><th>" lnuser-name "</th><th>" usergroup "</th><tr>")
		  prev)))
        '() a))




    (let* ((help-topic "session")
	   (ret #f)
	   (holder '())
	   (dummy (dbi-query ciccio  "select lnsession.id, lnsession.updated, lnuser.lnuser_name, lnuser_groups.usergroup  from lnsession, lnuser, lnuser_groups where lnsession.lnuser_id=lnuser.id AND lnuser_groups.id=lnuser.usergroup_id"  ))
	   (ret (dbi-get_row ciccio))
	   (dummy2 (while (not (equal? ret #f))     
		     (set! holder (cons ret holder))		   
		     (set! ret  (dbi-get_row ciccio))
		     (pretty-print ret)

		     ))
	   ;;(body (string-concatenate (prep-session-rows holder)))
	   )
      (pretty-print holder))
