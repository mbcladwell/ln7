;; /gnu/store/0w76khfspfy8qmcpjya41chj3bgfcy0k-guile-3.0.4/bin/guile
;; /gnu/store/jgl9d4axpavsv83z2f1z1himnkbsxxqj-guile-2.2.7/bin/guile
;; /usr/lib/x86_64-linux-gnu/guile/3.0/bin/guile

(use-modules (srfi srfi-1)
	     (dbi dbi)
	     (ice-9 match)
	     (web uri)
	     (artanis utils)(artanis irregex)
	     (srfi srfi-19)   ;; date time
	     (ice-9 textual-ports)(ice-9 rdelim)(ice-9 pretty-print)
	     (artanis artanis)
	     (ice-9 string-fun) ;; string-replace-substring
	     (rnrs bytevectors))
;;	     (lnserver sys extra))
	    

(define ciccio (dbi-open "postgresql" "ln_admin:welcome:lndb:tcp:192.168.1.11:5432"))

DROP TABLE IF EXISTS config CASCADE;
create table config
        (id SERIAL,
	 help_url_prefix VARCHAR(250),
	version VARCHAR(20),		 
	cust_id VARCHAR(250),
	cust_key varchar(250),
	cust_email VARCHAR(250));

INSERT INTO config(help_url_prefix, version) VALUES ('labsolns.com/software/','0.1.0-042020');


INSERT INTO config(help_url_prefix, version, cust_id, cust_key, cust_email) VALUES ('labsolns.com/software/','0.1.0-042020','16fjkhwF2rkdbwogqLdHZG4fb87jUxtJBU','c1f400d8992fbe8b1fec6c54cccf14a3', 'info@labsolns.com');

(get-key "16fjkhwF2rkdbwogqLdHZG4fb87jUxtJBU" "info@labsolns.com")

(validate-key "16fjkhwF2rkdbwogqLdHZG4fb87jUxtJBU" "info@labsolns.com" "c1f400d8992fbe8b1fec6c54cccf14a3")

(define a "project	target	description	accession
1	DYSF		8291
1	FKRP	descFKRP	79147
1	LAMA2		3908
1	TGFB2	descTGFB2	7042
1	FSHMD1B		2490
1	SYNE1	descSYNE1	23345
1	PROM1		8842
1	NGF		4803
1	SMCHD1		23347
1	SELENON		57190
1	HNRNPA1		3178
1	DES		1674
1	GNE		10020
1	SEPTIN9		10801
1	FST		10468
1	CAPN2		824
1	WWP1		11059
1	NEB		4703
1	LITAF		9516
1	GPC1		2817
2	FKTN		2218
2	HNRNPDL		9987
2	POMT2		29954
2	SPP1		6696
2	PABPN1		8106
2	EP300		2033
2	LGMD1H		100529230
2	TGM2		7052
2	BVES		11149")


(define (ghty x)
  (string-split (car x) #\t))

(define b (map list (cdr (string-split a #\newline))))
(define c (map ghty b))



(define (process-test lst results)
  ;; make a list of strings from objects
  (if (null? (cdr lst))
        (begin
	 (set! results  (cons   (string-split (caar lst)  #\tab) results))
       results)
       (begin
	 (set! results (cons (string-split (caar lst)  #\tab)  results))
	 (process-test (cdr lst) results )) ))

(process-test b '())

(pretty-print b)

 (string-split (caar b) #\tab)

(define (process-trg-row1 lst results)
  ;; make a list of strings from objects
  (if (null? (cdr lst))
        (begin
	 (set! results  (cons   (map object->string (car lst)) results))
       results)
       (begin
	 (set! results (cons  (map object->string (car lst)) results))
	 (process-trg-row1 (cdr lst) results )) ))


(define (process-trg-row2 lst results)
  ;; results is a string like "'{"2" "3" "4"}'" note the single quotes
  (if (null? (cdr lst))
      (begin
	(cond
	 ((= (length (car lst)) 3) (set! results  (string-append results "{\"" (caar lst) "\" \"" (cadar lst) "\" \"\"  \""  (caddar lst)   "\"}," )))
	  ((= (length (car lst)) 4)(set! results  (string-append results "{\"" (caar lst) "\" \""  (cadar lst)  "\" \""    (caddar lst)   "\" \""   (car (cdddar lst))   "\"}," )))
	 )
       results)
       (begin
	 (cond
	 ((= (length (car lst)) 3) (set! results  (string-append results "{\"" (caar lst) "\" \"" (cadar lst) "\" \"\"  \""  (caddar lst)   "\"}," )))
	  ((= (length (car lst)) 4)(set! results  (string-append results "{\"" (caar lst) "\" \""  (cadar lst)  "\" \""    (caddar lst)   "\" \""   (car (cdddar lst))   "\"}," ))))
	 (process-trg-row2 (cdr lst) results)) ))


(define a "id%0D%0ASPL-292%0D%0ASPL-285%0D%0ASPL-284%0D%0ASPL-283%0D%0ASPL-282%0D%0ASPL-281%0D%0A%0D%0A")

(define b (uri-decode a))
(define c (map list (cdr (string-split b #\newline))))

(define white-chars (char-set #\space #\tab #\newline #\return))


(define (ghty x)
  (string-trim-both (car x) white-chars))

(define c (map list (cdr (string-split b #\newline))))


(define g (map (lambda (x)(string-trim-both (car x) white-chars)) c))

(if (equal? (substring  (car g) 0 4) "SPL-") #f #t)


(define (no-empty lst results)
  ;; make a list of strings from objects
  (if (null? (cdr lst))
      (begin
	(if (= (string-length (car lst)) 0 ) #f
	 (set! results  (cons  (car lst) results)))
       results)
       (begin
	(if (= (string-length (car lst)) 0 ) #f
	 (set! results  (cons  (car lst) results)))
	 (no-empty (cdr lst) results )) ))

(define h (no-empty g '()))


(define (make-pg-hl lst results b )
  ;; if b is false must remove SPL-
 (if (null? (cdr lst))
      (begin
	(if b (set! results  (string-append  "{" (car lst) "}," results))
	    (set! results  (string-append  "{" (substring (car lst)  4 (string-length (car lst))) "}," results)) )
       results)
       (begin
	(if b (set! results  (string-append  "{" (car lst) "}," results))
	    (set! results  (string-append  "{" (substring (car lst)  4 (string-length (car lst))) "}," results)))
	 (make-pg-hl (cdr lst) results b))))

(make-pg-hl h "" #f)

(substring (car g) 4 (string-length (car g)) )

(define b  (process-trg-row1 a '()))
(define c (process-trg-row2 a ""))
(string-append "sdql_skjdf(" c ")")


