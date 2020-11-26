;; /gnu/store/0w76khfspfy8qmcpjya41chj3bgfcy0k-guile-3.0.4/bin/guile
;; /gnu/store/jgl9d4axpavsv83z2f1z1himnkbsxxqj-guile-2.2.7/bin/guile
;; /usr/lib/x86_64-linux-gnu/guile/3.0/bin/guile

(use-modules (srfi srfi-1)
	     (dbi dbi) 
	     (ice-9 textual-ports)(ice-9 rdelim)(ice-9 pretty-print)
	     (artanis artanis))

(load "./sys/extra.scm")


(define ciccio (dbi-open "postgresql" "ln_admin:welcome:lndb:tcp:192.168.1.11:5432"))

(define (mytest)
  (let* ((help-topic "session")
	 (ret #f)
	 (holder '())
	 (sql "select target.id, target.target_sys_name, target.descr, target_layout_name.project_id, target.target_name, target_layout.quad, target_layout_name_sys_name, target_layout_name_name, target_layout_name_desc, target_layout_name.reps from target_layout_name, target_layout, target WHERE target_layout.target_layout_name_id=target_layout_name.id AND target_layout.target_id=target.id AND target_layout_name.id='1'")
	 (dummy (dbi-query ciccio  sql ))
	 (ret (dbi-get_row ciccio))
	 (dummy2 (while (not (equal? ret #f))
		   ;;(pretty-print ret)
		   (set! holder (cons ret holder))		   
		   (set! ret  (dbi-get_row ciccio))))
	  (trg-lyt-sys-name (result-ref holder "target_layout_name_sys_name"))
	;; (body (string-concatenate (prep-session-rows holder)))
	 )
 ;;   (pretty-print trg-lyt-sys-name)))
    (pretty-print (car holder))))
 


(define reps "2")
(define q1 "")
(define q2 "")
(define q3 "")
(define q4 "")

(use-modules (ice-9 match)(srfi srfi-1))

(define a '((plateset-id 1) (plateset-id 2) (buttons group) (imp data) (exp selected)))
(define b '(plateset-id 1))

(define c '((plateset-id 1) (plateset-id 2)))

 (match  b (('plateset-id x) x))

(match a
    (((plateset-id x) ...)   x))

(match a
  ((('(plateset-id) x) ...)   x))


 (delete #f (map (match-lambda (('plateset-id x) x)(_ #f))  a))
((match-lambda (('plateset-id x) x)(_ #f))  (car a))

((match-lambda (('hello (who)) who)) '(hello (world)))
⇒ world
