;; /gnu/store/0w76khfspfy8qmcpjya41chj3bgfcy0k-guile-3.0.4/bin/guile
;; /gnu/store/jgl9d4axpavsv83z2f1z1himnkbsxxqj-guile-2.2.7/bin/guile
;; /usr/lib/x86_64-linux-gnu/guile/3.0/bin/guile

(use-modules (srfi srfi-1)
	     (dbi dbi)
	     (ice-9 match)
	     (web uri)
	     (ice-9 format)
	     (ice-9 match)
	      (web response)
	     (web request)(web client)
	      (ice-9 receive)
	      (json)(ice-9 textual-ports)
	      (ice-9 pretty-print)
	     (artanis utils)(artanis irregex)
	     (srfi srfi-19)   ;; date time
	     (ice-9 textual-ports)(ice-9 rdelim)(ice-9 pretty-print)
	     (artanis artanis)
	     (ice-9 string-fun) ;; string-replace-substring
	     (rnrs bytevectors))
;;	     (lnserver sys extra))
(getcwd)	    
(use-modules  (home mbc .cache guile ccache 3.0-LE-8-4.4 home mbc projects ln7 lnserver sys extra))


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



(define a (((plate_set_sys_name . PS-42) (plate_sys_name . PLT-63) (well_name . B02) (by_col . 10) (sample_sys_name . SPL-87) (accs_id . )) ((plate_set_sys_name . PS-42) (plate_sys_name . PLT-63) (well_name . A02) (by_col . 9) (sample_sys_name . SPL-73) (accs_id . )) ((plate_set_sys_name . PS-42) (plate_sys_name . PLT-63) (well_name . H01) (by_col . 8) (sample_sys_name . SPL-65) (accs_id . )) ((plate_set_sys_name . PS-42) (plate_sys_name . PLT-63) (well_name . G01) (by_col . 7) (sample_sys_name . SPL-59) (accs_id . )) ((plate_set_sys_name . PS-42) (plate_sys_name . PLT-63) (well_name . F01) (by_col . 6) (sample_sys_name . SPL-53) (accs_id . )) ((plate_set_sys_name . PS-42) (plate_sys_name . PLT-63) (well_name . E01) (by_col . 5) (sample_sys_name . SPL-51) (accs_id . )) ((plate_set_sys_name . PS-42) (plate_sys_name . PLT-63) (well_name . D01) (by_col . 4) (sample_sys_name . SPL-49) (accs_id . )) ((plate_set_sys_name . PS-42) (plate_sys_name . PLT-63) (well_name . C01) (by_col . 3) (sample_sys_name . SPL-43) (accs_id . )) ((plate_set_sys_name . PS-42) (plate_sys_name . PLT-63) (well_name . B01) (by_col . 2) (sample_sys_name . SPL-39) (accs_id . )) ((plate_set_sys_name . PS-42) (plate_sys_name . PLT-63) (well_name . A01) (by_col . 1) (sample_sys_name . SPL-16) (accs_id . )) ))
