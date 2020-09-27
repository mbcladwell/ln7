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
              "0xg41qs3cb2ydlhby0vyzp93bdsqjdidljw1iw6mkj982dc5bb7g"))
	    ))
  (build-system gnu-build-system)
  (inputs '(("artanis", artanis)("artanis", utils) ("ice-9", local-eval) ("srfi", srfi-1)
             ))
  (synopsis "LIMS*Nucleus with web interface")
  (description
   "LIMS*Nucleus with web interface.")
  (home-page "http://labsolns.com/software/")
  (license gpl3+))
