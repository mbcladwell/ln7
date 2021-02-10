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

(define a '((1	SEPTIN9		10801
) (1	FST		10468
) (1	CAPN2		824
) (1	WWP1		11059
) (1	NEB		4703
) (1	LITAF		9516
) (1	GPC1		2817
) (2	FKTN		2218
)))


(define holder '())

(define (my-last lst holder)
  (if (null? (cdr lst))
      (cons (map list (car lst)) holder)
      (my-last (cdr lst) holder)))


(my-last a)

(string-trim-both (map list (car a)) cs)
(string-split a #\t)

(map object->string (car a))



(define (process-trg-row1 lst results)
  ;; make a list of strings from objects
  (if (null? (cdr lst))
        (begin
	 (set! results  (cons   (map object->string (car lst)) results))
       results)
       (begin
	 (set! results (cons  (map object->string (car lst)) results))
	 (process-trg-row1 (cdr lst) results )) ))

(define b  (process-trg-row1 a '()))


(length (car b))

(define (process-trg-row2 lst results)
  ;; results is a string like "'{"2" "3" "4"}'" note the single quotes
  (if (null? (cdr lst))
      (begin
	(cond
	 ((= (length (car lst)) 3) (set! results  (string-append results "{\"" (caar lst) "\" " (cadar lst) "\" \""  (caddar lst)   "\"}," )))
	  ((= (length (car lst)) 4)(set! results  (string-append results "{" (caar lst) ", " (cadar lst) ", "  (caddar lst)   "}," )))
	 )
       (string-append "'" (substring results 0 (- (string-length results) 1)) "'"))
       (begin
	 (cond
	 ((= (length (car lst)) 3) (set! results  (string-append results "{" (caar lst) ", " (cadar lst) ", "  (caddar lst)   "}," )))
	  ((= (length (car lst)) 4)(set! results  (string-append results "{" (caar lst) ", " (cadar lst) ", "  (caddar lst)   "}," ))))	 
	 (process-trg-row2 (cdr lst) results)) ))

(pretty-print (process-trg-row2 b ""))


(- (string-length "jfksjdfkj,") 1)

(string-append "'" (substring "jfksjdfkj," 0 (- (string-length "jfksjdfkj,") 1)) "'")

(= (length (caddar b)) 3)

(string-append "{\""  "sometext" "\"}")
