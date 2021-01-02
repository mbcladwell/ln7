;; /gnu/store/0w76khfspfy8qmcpjya41chj3bgfcy0k-guile-3.0.4/bin/guile
;; /gnu/store/jgl9d4axpavsv83z2f1z1himnkbsxxqj-guile-2.2.7/bin/guile
;; /usr/lib/x86_64-linux-gnu/guile/3.0/bin/guile

(use-modules (srfi srfi-1)
	     (dbi dbi)
	     (ice-9 match)
	     (web uri)
	     (srfi srfi-19)   ;; date time
	     (ice-9 textual-ports)(ice-9 rdelim)(ice-9 pretty-print)
	     (artanis artanis))

(load "./sys/extra.scm")


(define ciccio (dbi-open "postgresql" "ln_admin:welcome:lndb:tcp:192.168.1.11:5432"))

(define a '(("project_name" . "MyTestProj9") ("descr" . "description 9")))

(cdar a)

(define a "well	type
1	5
2	5
3	5
4	5
5	5
6	5
7	5
8	5
9	5
10	5
11	5
12	5
13	5
14	5
15	5
16	5
17	5
18	1
19	1
20	1
21	1
22	1
23	1
24	1
25	1
26	1
27	1
28	1
29	1
30	1
31	1
32	5
33	5
34	1
35	1
36	1
37	1
38	1
39	1
40	1
41	1
42	1
43	1
44	1
45	1
46	1
47	1
48	5
49	5
50	1
51	1
52	1
53	1
54	1
55	2
56	1
57	1
58	1
59	1
60	1")


(define b (map list (cdr (string-split a #\newline))))

(map list a)

(map string-split b #\tab)

(cdr (string-split "1\t5" #\tab))

(define holder '())

(define (get-types lst)
  (if (null? (cdr lst))
      (set! holder (cons (cdr (string-split (caar lst) #\tab)) holder))
      (let ((c (set! holder (cons (cdr (string-split (caar lst) #\tab)) holder))))
	(get-types (cdr lst)))))

(get-types b)

(define f (apply append holder))

(car f)

(define counter 0)

(define (count what list counter)
   (if (null? (cdr list))
       ((if (equal? what  (car list)) (set! counter (+ counter 1)))
	 (return counter))
       ((if (equal? what (car list)) (set! counter (+ counter 1)))
	(count what (cdr list) counter))))
   


 
(count "5" f 0)

(car f)
(pretty-print f)

