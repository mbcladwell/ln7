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

(define a #f)


(eq? #t a)

ln-version


(define (get-salt)
(get-random-from-dev #:length 8 #:uppercase #f))

(define a  (get-salt))

(my-hmac "demo" a)

(supports-source-properties? my-hmac)


('demo','97f8647f1067346d','55ecb01c50cb1ae1', '','user')

(define a '(((id . 193) (sample_sys_name . SPL-193) (project_id . 0) (accs_id . )) ((id . 204) (sample_sys_name . SPL-204) (project_id . 0) (accs_id . )) ((id . 216) (sample_sys_name . SPL-216) (project_id . 0) (accs_id . )) ((id . 217) (sample_sys_name . SPL-217) (project_id . 0) (accs_id . )) ((id . 221) (sample_sys_name . SPL-221) (project_id . 0) (accs_id . )) ((id . 244) (sample_sys_name . SPL-244) (project_id . 0) (accs_id . )) ((id . 251) (sample_sys_name . SPL-251) (project_id . 0) (accs_id . )) ((id . 252) (sample_sys_name . SPL-252) (project_id . 0) (accs_id . )) ((id . 256) (sample_sys_name . SPL-256) (project_id . 0) (accs_id . )) ((id . 269) (sample_sys_name . SPL-269) (project_id . 0) (accs_id . ))))
