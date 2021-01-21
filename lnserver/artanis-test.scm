;; /gnu/store/0w76khfspfy8qmcpjya41chj3bgfcy0k-guile-3.0.4/bin/guile
;; /gnu/store/jgl9d4axpavsv83z2f1z1himnkbsxxqj-guile-2.2.7/bin/guile
;; /usr/lib/x86_64-linux-gnu/guile/3.0/bin/guile

(use-modules (srfi srfi-1)
	     (dbi dbi)
	     (ice-9 match)
	     (web uri)
	     (artanis utils)(artanis irregex)
	     (srfi srfi-19)   ;; date time
	     (ice-9 textual-ports)(ice-9 rdelim)(ice-9 pretty-print)
	     (artanis artanis)
	     (ice-9 string-fun) ;; string-replace-substring
	     (rnrs bytevectors)
	     (lnserver sys extra))
	    

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

(define a #f)


(eq? #t a)

ln-version


(define (get-salt)
(get-random-from-dev #:length 8 #:uppercase #f))

(define a  (get-salt))

(my-hmac "demo" a)

(supports-source-properties? my-hmac)


('demo','97f8647f1067346d','55ecb01c50cb1ae1', '','user')

(pretty-print (my-hmac "demo" a))


 public ComboItem[] getLayoutDestinationsForSourceID(int _source_id, int  _source_reps, int _target_reps) {
    ComboItem[] output = null;
    Array results = null;
    int source_id = _source_id;
    int source_reps = _source_reps;
    int target_reps = _target_reps;
    String replication = String.valueOf(source_reps) + "S" + String.valueOf(target_reps) + "T";
    //LOGGER.info(replication);
    ArrayList<ComboItem> combo_items = new ArrayList<ComboItem>();
    try {
      PreparedStatement pstmt =
          conn.prepareStatement(
        "select id, sys_name, name, descr FROM plate_layout_name, layout_source_dest WHERE layout_source_dest.src = ? AND layout_source_dest.dest = plate_layout_name.id AND plate_layout_name.descr=?;");
      				
