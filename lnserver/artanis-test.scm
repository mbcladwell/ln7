;; /gnu/store/0w76khfspfy8qmcpjya41chj3bgfcy0k-guile-3.0.4/bin/guile
;; /gnu/store/jgl9d4axpavsv83z2f1z1himnkbsxxqj-guile-2.2.7/bin/guile

(use-modules (srfi srfi-1)
	     (dbi dbi) 
	     (ice-9 textual-ports)(ice-9 rdelim)(ice-9 pretty-print)
	     (artanis artanis)(artanis util))

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



(use-modules (artanis artanis)(artanis utils))

(get-random-from-dev #:length 8 #:uppercase #f)

(define (default-hmac passwd salt)
  (string->sha-256 (string-append passwd salt)))




(define a '((("id" . 1) ("lnuser" . "ln_admin")) (("id" . 2) ("lnuser" . "ln_user"))(("id" . 3) ("lnuser" . "bozo"))))


(define anoq '(((id . 1) (lnuser . ln_admin)) ((id . 2) (lnuser . ln_user))((id . 3) (lnuser . bozo))))



((("id" . 1) ("lnuser" . "ln_admin")) (("id" . 2) ("lnuser" . "ln_user")))

(object->string anoq)


(define (get-id-for-name name rows)
  (if (and  (null? (cdr rows))  (string=?  (cdadar rows) name))
      (number->string (cdaar rows))
      (if (string=?  (cdadar rows) name)
	   (number->string (cdaar rows))
	   (get-id-for-name name (cdr rows)))))


(get-id-for-name "bozo" a)
(cdr a)
(cdadar a)

(cdaar a)


(define b (cdr a))
(string=? (cdadar b) "ln_user")
(cdaar b)


(define anoq '(((id . 1) (lnuser . ln_admin)) ((id . 2) (lnuser . ln_user))((id . 3) (lnuser . bozo))))


(define (get-id-for-name name rows)
  (if (and  (null? (cdr rows))  (string=?  (object->string (cdadar rows)) name))
      (number->string (cdaar rows))
      (if (string=?  (object->string (cdadar rows)) name)
	   (number->string (cdaar rows))
	   (get-id-for-name name (cdr rows)))))

(get-id-for-name "ln_admin" anoq)

;; Sat, 31 Oct 2020 13:41:27 GMT

(current-time)
(define a (current-time))

(define b (car (mktime (car (strptime  "%a, %d %b %Y %H:%M:%S %Z" "Sat, 31 Oct 2020 13:41:27 GMT")) "GMT")))

(- b a)

(use-modules (srfi srfi-19))
(- (time-second (current-time)) b)


       (if (< (- 22 20) 0) #t #f )
