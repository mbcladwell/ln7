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
