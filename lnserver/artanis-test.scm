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

 (case reps
	 ('("1") (set! q2 "q2")(set! q3 "q3")(set! q4 "q4") (pretty-print '(q2 q3 q4)))
	 ('("2") (set! q2 "q2")(set! q3 "q1")(set! q4 "q2") (pretty-print '(q2 q3 q4)))
	 ('("4") (set! q2 "q1")(set! q3 "q1")(set! q4 "q1") (pretty-print '(q2 q3 q4))))

(cond
 ((equal? reps "1") ((set! q2 "q2")(set! q3 "q3")(set! q4 "q4")  ))
 ((equal? reps "2") ((set! q2 "q2")(set! q3 "q1")(set! q4 "q2")  ))
 ((equal? reps "4") ((set! q2 "q1")(set! q3 "q1")(set! q4 "q1")  ))))


(cond
 ((equal? reps "1") (let* ((q2 "q2")(q3 "q3")(q4 "q4")) #f  ))
 ((equal? reps "2") (let* ((q2 "q2")(q3 "q1")(q4 "q2")) #f  ))
 ((equal? reps "4") (let* ((q2 "q1")(q3 "q1")(q4 "q1")) #f  )))


 (let* ((help-topic "target")
			 (prj-name "PRJ-10")
			 (id (substring prj-name 4))
			 (tlytname "tlytname")
			 (desc "desc")
			 (reps "2")
			 (q1 "t1")
			 (q2 (cond ((equal? reps "1") "t2")
				   ((equal? reps "2") "t1")
				   ((equal? reps "4") "t1")))
			 (q3 (cond ((equal? reps "1") "t3")
				   ((equal? reps "2") "t1")
				   ((equal? reps "4") "t1")))
			 (q4 (cond ((equal? reps "1") "t4")
				   ((equal? reps "2") "t2")
				   ((equal? reps "4") "t1")))
			 (sql (string-append "select new_target_layout_name(" id ", '" tlytname "', '" desc "', '" reps "', '" q1 "', '" q2 "', '" q3 "', '" q4 "')")))
		    (pretty-print sql))
