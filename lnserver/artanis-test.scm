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
 

(mytest)

(define a '((("project_sys_name" . "PRJ-1")) (("project_sys_name" . "PRJ-2")) (("project_sys_name" . "PRJ-3")) (("project_sys_name" . "PRJ-4")) (("project_sys_name" . "PRJ-5")) (("project_sys_name" . "PRJ-6")) (("project_sys_name" . "PRJ-7")) (("project_sys_name" . "PRJ-8")) (("project_sys_name" . "PRJ-9")) (("project_sys_name" . "PRJ-10")))
)

(result-ref a "project_sys_name")

(cdaar a)
(cdr a)


(define (extract-projects lst all-prj)
  (if (null? (cdr lst))
        (begin
	 (set! all-prj (cons (string-append "<option value=\"" (cdaar lst) "\">"(cdaar lst) "</option>") all-prj))
       all-prj)
       (begin
	 (set! all-prj (cons (string-append "<option value=\"" (cdaar lst) "\">"(cdaar lst) "</option>") all-prj))
	 (extract-projects (cdr lst) all-prj)) ))

(define all-projects '())
(extract-projects a all-projects)

(define c '())
(set! c (cons "2" c))
(pair? c)

 <option value="volvo">Volvo</option>

(substring "PRJ-10" 4)
