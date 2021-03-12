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

(define (get-key cust-id email )
  (string->md5 (string-append cust-id email "lnsDFoKytr")))

(define (validate-key cust_id cust_email cust_key)
  (equal? (get-key cust_id cust_email) cust_key))

(get-key "jf8d9slkdow09ieieurie" "info@labsolns.com")

"e118bd1efb4b4f5367cf99976267c5ad"

(validate-key "jf8d9slkdow09ieieurie" "info@labsolns.com" "e118bd1efb4b4f5367cf99976267c5ad")

UPDATE config SET cust_id='jf8d9slkdow09ieieurie', cust_email='info@labsolns.com', cust_key='e118bd1efb4b4f5367cf99976267c5ad' WHERE id=1;

UPDATE config SET cust_id='', cust_email='', cust_key='' WHERE id=1;

(car '(1 1 -64.6179 1 1))
(cadr '(1 1 -64.6179 1 1))
(caddr '(1 1 -64.6179 1 1))
(cadddr '(1 1 -64.6179 1 1))
(car (cddddr '(1 1 -64.6179 1 1)))



(car '("a" "b" "c" "d" "e"))
(cadr '(1 1 -64.6179 1 1))
(caddr '(1 1 -64.6179 1 1))
(cadddr '(1 1 -64.6179 1 1))
(car (cddddr '(1 1 -64.6179 1 1)))


(define numplates "11")

(> (string->number numplates) 10)
