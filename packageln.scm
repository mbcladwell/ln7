;; tar -cvf /home/mbc/projects/guix/*
;; guix hash -f nix-base32 ./limsnucleus.tar 
;; guix package --install-from-file=packageln.scm
;; #bzip2 -dk /var/log/guix/drvs/aw/a2pmaxl38isglzbar3rba0z55s5g0p-LIMSNucleus-0.2.drv.bz2

;; https://www.draketo.de/proj/with-guise-and-guile/guile-projects-with-autotools.html


(use-modules (guix packages)
             (guix download)
             (guix build-system gnu)
             (guix licenses))

(package
  (name "LIMSNucleus")
  (version "0.2")
  (source (origin
            (method url-fetch)
            (uri  "file://localhost/home/mbc/temp/package/limsnucleus.tar")
            (sha256
             (base32
              "0i7dmsf9h8zbmr981hghq037l04nn4r9jnqw3nm0qk4k5dig77ma"))
	    ))
  (build-system gnu-build-system)
  (synopsis "LIMS*Nucleus with web interface")
  (description
   "LIMS*Nucleus with web interface.")
  (home-page "http://labsolns.com/software/")
  (license gpl3+))

































