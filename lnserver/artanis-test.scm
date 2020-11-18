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
 




(define a '(((id . 1) (target_sys_name . TRG-1) (target_name . Target1)) ((id . 2) (target_sys_name . TRG-2) (target_name . Target2)) ((id . 3) (target_sys_name . TRG-3) (target_name . Target3)) ((id . 4) (target_sys_name . TRG-4) (target_name . Target4)) ((id . 5) (target_sys_name . TRG-5) (target_name . muCD71)) ((id . 6) (target_sys_name . TRG-6) (target_name . huCD71)) ((id . 7) (target_sys_name . TRG-7) (target_name . cynoCD71)) ((id . 8) (target_sys_name . TRG-8) (target_name . BSA)) ((id . 9) (target_sys_name . TRG-9) (target_name . Lysozyme)) ((id . 10) (target_sys_name . TRG-10) (target_name . GAPDH)) ((id . 11) (target_sys_name . TRG-11) (target_name . ICAM4)) ((id . 12) (target_sys_name . TRG-12) (target_name . IL21R)) ((id . 13) (target_sys_name . TRG-13) (target_name . uiuiu)) ((id . 14) (target_sys_name . TRG-14) (target_name . hytgfr))))


(define (extract-targets lst all-trgs)
  (if (null? (cdr lst))
        (begin
	 (set! all-trgs (cons (string-append "<option value=\"" (object->string (cdaar lst)) "\">" (string-append (object->string (cdadar lst)) " " (object->string (cdar (cddar lst)))) "</option>") all-trgs))
       all-trgs)
       (begin
	 (set! all-trgs (cons (string-append "<option value=\"" (object->string (cdaar lst)) "\">"(string-append (object->string (cdadar lst)) " " (object->string (cdar (cddar lst)))) "</option>") all-trgs))
	 (extract-targets (cdr lst) all-trgs)) ))

(define all-targets '())
(extract-targets a all-targets)


(cdaar a) ;;1
(object->string (cdadar a)) ;;trg1
(object->string (cdar (cddar a))) ;;

(string-append (object->string (cdadar a)) " " (object->string (cdar (cddar a))))
