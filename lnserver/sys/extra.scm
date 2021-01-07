(define-module (lnserver sys extra)
  #:export (get-rand-file-name
	    sid
	    nopwd-conn
	    ln-version
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
	    dropdown-contents-with-id
	    dropdown-contents-no-id
	    prep-ar-rows
	    whitechars
	    stripfix
	    htmlify
	    dehtmlify
	    addquotes
	    ))

(use-modules (artanis artanis)(artanis utils) (ice-9 local-eval) (srfi srfi-1)
             (artanis irregex)(dbi dbi) (ice-9 textual-ports)(ice-9 rdelim)
	     (rnrs bytevectors))

;; artanis config: /etc/artanis/artanis.conf
;; pgbouncer -d ./syncd/pgbouncer.ini
;; psql -U ln_admin -p 6432 -d pgbouncer -h 127.0.0.1
;; psql -U ln_admin -p 6432 -d lndb -h 127.0.0.1
;; guix environment --manifest=./environment.scm --pure
;; guile -s ./lnserver.scm

;; https://github.com/UMCUGenetics/guix-documentation/blob/master/for-bioinformaticians/guix-for-bioinformaticians.md

(define ln-version "0.1.0-042020")


;; (if (access? properties-filename R_OK)
;;     (let* ((props-file properties-filename)
;; 	   (my-port (open-input-file props-file))
;; 	   (ret #f)
;; 	   (holder '())
;; 	   (ret (read-line my-port))
;; 	   (dummy2 (while (not (eof-object? ret))
;; 		     (set! holder (cons (string-split ret #\=) holder))
;; 		     (set! ret (read-line my-port)))))
;;       (set! ln-properties holder)))


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

(define white-chars (char-set #\space #\tab #\newline #\return))
(define (stripfix x) (uri-decode (string-trim-both x white-chars) ))


;;

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

(define (dropdown-contents-with-id in out)
  ;;in: ((("id" . 7) ("name" . "8 controls col 12")) (("id" . 1) ("name" . "4 controls col 12")))
  ;;out starts as '()
  ;;provides integer as value of selection
   (if (null? (cdr in))
       (begin
	 (set! out (cons (string-append "<option value=\"" (number->string (cdaar in)) "\">"(cdadar in) "</option>") out))
       out)
       (begin
	 (set! out (cons (string-append "<option value=\"" (number->string (cdaar in)) "\">"  (cdadar in) "</option>") out))
	 (dropdown-contents-with-id (cdr in) out)) ))

(define (prep-ar-rows a)
  (fold (lambda (x prev)
          (let* (
                (assay-run-sys-name (result-ref x "assay_run_sys_name"))
		(assay-run-name (result-ref x "assay_run_name"))
		(descr (result-ref x "descr"))
		(assay-type-name (result-ref x "assay_type_name"))
		(sys-name (result-ref x "sys_name"))
		(lytid (substring sys-name 4))
		(name (result-ref x "name"))
		)
            (cons (string-append "<tr><th><a href=\"/assayrun/getid?id=" (number->string (cdr (car x))) "\">" assay-run-sys-name "</a></th><th>" assay-run-name "</th><th>" descr "</th><th>" assay-type-name "</th><th><a href=\"/layout/lytbyid?id=" lytid  "\">" sys-name "</a></th><th>" name "</th><tr>")
		  prev)))
        '() a))


(define (dropdown-contents-no-id in out)
  ;;in: ((("id" . 7) ("name" . "8 controls col 12")) (("id" . 1) ("name" . "4 controls col 12")))
  ;;out starts as '()
   (if (null? (cdr in))
       (begin
	 (set! out (cons (string-append "<option value=\"" (cdadar in) "\">"(cdadar in) "</option>") out))
       out)
       (begin
	 (set! out (cons (string-append "<option value=\"" (cdadar in) "\">"  (cdadar in) "</option>") out))
	 (dropdown-contents-with-id (cdr in) out)) ))

;; convert html to a manageable string for passing back and forth
;; from server; must not have characters like < > /

(define (string->blist x)
  ;; "a few words" -> (97 32 102 101 119 32 119 111 114 100 115)
  (bytevector->u8-list (string->utf8 x)))


(define (html-encode lst result)
  ;; (97 32 102 101 119 -> "97%2032%20102%20101%2011...."
  (if (null? (cdr lst))
      (let* ((result (string-append result (number->string (car lst)))))       
       result)
      (let* ((result (string-append result (number->string (car lst)) "+")))
	(html-encode (cdr lst) result))))
      

(define (htmlify x)
  (let*((a (string->blist x))
	(b (html-encode a "")))
	b))

(define (dehtmlify x)
(utf8->string (u8-list->bytevector (map string->number (string-split (uri-decode x) #\+)))))

(define (addquotes x)
  (string-append "\"" x "\""))


