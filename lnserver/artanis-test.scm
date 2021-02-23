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

(define a "60%2B116%2B114%2B62%2B60%2B116%2B100%2B62%2B65%2B82%2B45%2B50%2B60%2B47%2B116%2B100%2B62%2B60%2B116%2B100%2B62%2B97%2B115%2B115%2B97%2B121%2B95%2B114%2B117%2B110%2B50%2B60%2B47%2B116%2B100%2B62%2B60%2B116%2B100%2B62%2B80%2B83%2B45%2B50%2B32%2B76%2B89%2B84%2B45%2B49%2B59%2B57%2B54%2B59%2B52%2B105%2B110%2B49%2B50%2B60%2B47%2B116%2B100%2B62%2B60%2B116%2B100%2B62%2B69%2B76%2B73%2B83%2B65%2B60%2B47%2B116%2B100%2B62%2B60%2B116%2B100%2B62%2B60%2B97%2B32%2B104%2B114%2B101%2B102%2B61%2B34%2B47%2B108%2B97%2B121%2B111%2B117%2B116%2B47%2B108%2B121%2B116%2B98%2B121%2B105%2B100%2B63%2B105%2B100%2B61%2B49%2B34%2B62%2B76%2B89%2B84%2B45%2B49%2B60%2B47%2B97%2B62%2B60%2B47%2B116%2B100%2B62%2B60%2B116%2B100%2B62%2B52%2B32%2B99%2B111%2B110%2B116%2B114%2B111%2B108%2B115%2B32%2B99%2B111%2B108%2B32%2B49%2B50%2B60%2B47%2B116%2B100%2B62%2B60%2B116%2B114%2B62 ")

(define (dehtmlify x)
  (utf8->string (u8-list->bytevector (map string->number (string-split (stripfix a) #\+)))))

(dehtmlify a)


(define white-chars (char-set #\space #\tab #\newline #\return))
(define (stripfix x) (uri-decode (string-trim-both x white-chars)))

(utf8->string (u8-list->bytevector (map string->number (string-split  (uri-decode (string-trim-both x white-chars)) #\space))))
(utf8->string (u8-list->bytevector (map string->number (string-split (stripfix x) #\space))))



(uri-decode "60%252B116%252B114" #:encoding="utf-8" #:decode-plus-to-space? #t)




(define x "60+116+114+62+60+116+100+62+65+82+45+49+60+47+116+100+62+60+116+100+62+97+115+115+97+121+95+114+117+110+49+60+47+116+100+62+60+116+100+62+80+83+45+49+32+76+89+84+45+49+59+57+54+59+52+105+110+49+50+60+47+116+100+62+60+116+100+62+69+76+73+83+65+60+47+116+100+62+60+116+100+62+60+97+32+104+114+101+102+61+34+47+108+97+121+111+117+116+47+108+121+116+98+121+105+100+63+105+100+61+49+34+62+76+89+84+45+49+60+47+97+62+60+47+116+100+62+60+116+100+62+52+32+99+111+110+116+114+111+108+115+32+99+111+108+32+49+50+60+47+116+100+62+60+116+114+62 ")
