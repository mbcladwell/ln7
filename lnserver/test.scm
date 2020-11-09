(use-modules (srfi srfi-1)     
	      (ice-9 textual-ports)(ice-9 rdelim))

(define file (open-input-file "/home/mbc/controls8scatteredNoEdge384.txt"))
(display (read-line file))

(define contents (call-with-input-file "/home/mbc/controls8scatteredNoEdge384.txt" get-string-all))

(define a  (map list  (string-split contents #\newline)))

(define (extract-tab x) (string-split (car x) #\tab))
(define data (cdr (map extract-tab a))

(string-split (caar a) #\tab)

(with-input-from-file "/home/mbc/controls8scatteredNoEdge384.txt" read-line)


(define (get-group-for-name name rows)
  (if (and  (null? (cdr rows))  (string=?  (object->string (cdadar rows)) name))
      (object->string (cdr (caddar rows)))
      (if (string=?  (object->string (cdadar rows)) name)
	   (object->string (cdr (caddar rows)))
	   (get-group-for-name name (cdr rows)))))


(define a '(((id . 1) (lnuser . ln_admin) (usergroup . admin)) ((id . 2) (lnuser . ln_user) (usergroup . user))))



(get-group-for-name "ln_admin" a)

(object->string (cdr (caddar a)))
