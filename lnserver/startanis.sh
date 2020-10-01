#!/gnu/store/jgl9d4axpavsv83z2f1z1himnkbsxxqj-guile-2.2.7/bin/guile
!#
(use-modules (artanis artanis))
(add-to-load-path "/home/mbc/projects/ln7/lnserver")
art work -c conf/artanis.conf
(get "/project/getall" (lambda (rc) (rc-path rc)))
(run)
