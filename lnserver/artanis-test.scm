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
	    

(load "../../sys/extra.scm")

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

(define a #f)


(eq? #t a)

ln-version



(define a '((2 96 0.004 ) (2 95 0.2 ) (2 94 0.611 ) (2 93 0.633 ) (2 92 0.0304191944349324 ) (2 91 0.413638579585479 ) (2 90 0.276386615511721 ) (2 89 0.436560343612436 ) (2 88 0.221652143668975 ) (2 87 0.368845292531106 ) (2 86 0.39595564907588 ) (2 85 0.296420968580512 ) (2 84 0.402837993183001 ) (2 83 0.288142553388534 ) (2 82 0.402243824871786 ) (2 81 0.344443627282312 ) (2 80 0.662580748794217 ) (2 79 0.309382861013891 ) (2 78 0.267412366636968 ) (2 77 0.121968052736661 ) (2 76 0.42941348449024 ) (2 75 0.300148693313444 ) (2 74 0.179006743775054 )))


(define (process-ar-row lst results)
  (if (null? (cdr lst))
        (begin
	 (set! results  (string-append results "(" (object->string (caar lst)) ", " (object->string (cadar a)) ", "  (object->string (caddar a))   ")" ))
       results)
       (begin
	 (set! results (string-append results "(" (object->string (caar lst)) ", " (object->string (cadar a)) ", "  (object->string (caddar a))   ")," ))
	 (process-ar-row (cdr lst) results)) ))

(process-ar-row a "")


(object->string a)
