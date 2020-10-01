A simple GNU Guile project template.

This is the first version of the web interface derived from the ../ln directory
Coding began February 2020

# ln7
Guile/Artanis admin tool

I will use Guix pack to create the admin tool for ln

Also change assay to archive in example data

Remove admin classes from java client

(use-modules (artanis artanis))
(init-server)
(run #:use-db? #t #:dbd 'postgresql #:db-username "ln_admin"
     #:db-name "lndb" #:db-passwd "welcome" #:port 8080)
