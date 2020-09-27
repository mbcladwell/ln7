(define-module (lnserver sys extra)
  #:export (get-rand-file-name
	    ciccio
	    ln-properties
	    sid
	    nopwd-conn
	    ln-version
	    properties-filename
	    prep-ar-rows
	    process-pg-row-element
	    process-list-of-rows
	    get-c1
	    get-c2
	    get-c3
	    get-c4
	    get-c5
	    get-c6
	    get-c7
	    get-c8
	    get-c9
	    get-c10
	    get-c11
	    get-c12
	    get-c13
	    get-c14
	    get-c15
	    get-c16
	    get-c17
	    ))

(use-modules (artanis artanis)(artanis utils) (ice-9 local-eval) (srfi srfi-1)
             (artanis irregex)(dbi dbi) (ice-9 textual-ports)(ice-9 rdelim)
	     )

;; artanis config: /etc/artanis/artanis.conf
;; pgbouncer -d ./syncd/pgbouncer.ini
;; psql -U ln_admin -p 6432 -d pgbouncer -h 127.0.0.1
;; psql -U ln_admin -p 6432 -d lndb -h 127.0.0.1
;; guix environment --manifest=./environment.scm --pure
;; guile -s ./lnserver.scm

;; https://github.com/UMCUGenetics/guix-documentation/blob/master/for-bioinformaticians/guix-for-bioinformaticians.md

(define ln-version "0.1.0-042020")

;; default for elephant-sql
(define ln-properties '(("sslmode" #f)
			("init" #f)
			("dbname" "klohymim")
			("port" "5432")
			("host" "raja.db.elephantsql.com")
			("source" "test")
			("connuser" "klohymim")
			("connpassword" "hwc3v4_rbkT-1EL2KI-JBaqFq0thCXM_")
			("user" "ln_admin")
			("password" "welcome")
			("help-url-prefix" "127.0.0.1/software/")))


(define properties-filename (string-append (getcwd) "/limsnucleus.properties"))

;; (define properties-filename (string-append (getcwd) "/home/projects/ln4/lnserver/limsnucleus.properties"))


(if (access? properties-filename R_OK)
    (let* ((props-file properties-filename)
	   (my-port (open-input-file props-file))
	   (ret #f)
	   (holder '())
	   (ret (read-line my-port))
	   (dummy2 (while (not (eof-object? ret))
		     (set! holder (cons (string-split ret #\=) holder))
		     (set! ret (read-line my-port)))))
      (set! ln-properties holder)))


;; (define ciccio (dbi-open "postgresql" "ln_admin:welcome:lndb:socket:192.168.1.11:5432"))

(define ciccio (dbi-open "postgresql" (string-append 
				       (car (assoc-ref ln-properties "connuser")) ":"
				       (car (assoc-ref ln-properties "connpassword")) ":"
				       (car (assoc-ref ln-properties "dbname")) ":socket:"
				       (car (assoc-ref ln-properties "host")) ":"
				       (car (assoc-ref ln-properties "port")))))

;; for display on login page
(define nopwd-conn  (string-append  
		     (car (assoc-ref ln-properties "connuser")) ":"
		     (car (assoc-ref ln-properties "dbname")) ":socket:"
		     (car (assoc-ref ln-properties "host")) ":"
		     (car (assoc-ref ln-properties "port"))))

;; session id
(define sid "0")

(define browse-history '())

(define (get-rand-file-name pre suff)
  (string-append "tmp/" pre "-" (number->string (random 10000000000000000000000)) "." suff))

;; artanis result-ref only works with strings
;; get a numeric by column and convert to string
(define (get-c1 x) (number->string (cdar x)))
(define (get-c2 x) (number->string (cdar (cdr x))))
(define (get-c3 x) (number->string (cdar (cddr x))))
(define (get-c4 x) (number->string (cdar (cdddr x))))
(define (get-c5 x) (number->string (cdar (cddddr x))))
(define (get-c6 x) (number->string (cdar (cdr (cddddr x)))))
(define (get-c7 x) (number->string (cdar (cddr (cddddr x)))))
(define (get-c8 x) (number->string (cdar (cdddr (cddddr x)))))
(define (get-c9 x) (number->string (cdar (cddddr (cddddr x)))))
(define (get-c10 x) (number->string (cdar (cdr (cddddr (cddddr x))))))
(define (get-c11 x) (number->string (cdar (cddr (cddddr (cddddr x))))))
(define (get-c12 x) (number->string (cdar (cdddr (cddddr (cddddr x))))))
(define (get-c13 x) (number->string (cdar (cddddr (cddddr (cddddr x))))))
(define (get-c14 x) (number->string (cdar (cdr (cddddr (cddddr (cddddr x)))))))
(define (get-c15 x) (number->string (cdar (cddr (cddddr (cddddr (cddddr x)))))))
(define (get-c16 x) (number->string (cdar (cdddr (cddddr (cddddr (cddddr x)))))))
(define (get-c17 x) (number->string (cdar (cddddr (cddddr (cddddr (cddddr x)))))))


;; (define a '( ("b" . "itemb")("c" . "itemc")("d" . "itemd")("e" . "iteme") ))
;; (assoc-ref ln-properties "password" )
;;

;;goal:
;;"select bulk_target_upload('{{"1","DYSF","8291", ""},
;;                             {"2", "DsSF",  "8292", ""},
;;                             {"3", "DYdF",  "8293", ""},
;;                             {"4", "DYSt",  ""}}')" 



(define (prep-ar-rows a)
  (fold (lambda (x prev)
          (let (
                (assay-run-sys-name (result-ref x "assay_run_sys_name"))
		(assay-run-name (result-ref x "assay_run_name"))
		(descr (result-ref x "descr"))
		(assay-type-name (result-ref x "assay_type_name"))
		(sys-name (result-ref x "sys_name"))
		(name (result-ref x "name"))
		)
            (cons (string-append "<tr><th><a href=\"/assayrun/getid?id=" (number->string (cdr (car x))) "\">" assay-run-sys-name "</a></th><th>" assay-run-name "</th><th>" descr "</th><th>" assay-type-name "</th><th>" sys-name "</th><th>" name "</th><tr>")
		  prev)))
        '() a))

;; these two methods help create a Postgres array
;; for Postgres
(define (process-pg-row-element x)
             (string-append  "\"" x "\", ") )

	    
;; for Postgres
(define (process-list-of-rows x)
  (let* ((step1 (string-concatenate (map process-pg-row-element x) ))
	 (step2  (xsubstring step1 0 (- (string-length step1) 2))) ;;trim the final comma
	 )
   (string-append "{" step2 "},")
))


