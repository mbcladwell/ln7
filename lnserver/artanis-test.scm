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


    public void importPlateLayout(Object[][] _data, String _name, String _descr, String _control_location, int _n_controls, int _n_unknowns, int _format, int _n_edge){
	Object[][] data = _data;
	String name = _name;
	String descr = _descr;
	String control_location = _control_location;
	int n_controls = _n_controls;
	int n_unknowns = _n_unknowns;
	int format = _format;
	int n_edge = _n_edge;

	String sql_statement1="TRUNCATE TABLE import_plate_layout;";
	
	String sql_statement2_pre = "INSERT INTO import_plate_layout (well_by_col, well_type_id, replicates, target) VALUES ";
	for (int i = 1; i < data.length; i++) {
      sql_statement2_pre =
          sql_statement2_pre
	  + "("
	  + Integer.parseInt((String)data[i][0])
	  + ", "
	  + Integer.parseInt((String)data[i][1])
	  + ", 1, 1), ";
    }

	String sql_statement2 = sql_statement2_pre.substring(0, sql_statement2_pre.length() - 2) + ";";

	String sql_statement3 = "SELECT create_layout_records(?,?,?,?,?,?,?);";
    //LOGGER.info(insertSql);
    PreparedStatement insertPs;
    try {
	conn.setAutoCommit(false);
      insertPs = conn.prepareStatement(sql_statement1);
      insertPreparedStatement(insertPs);
      //insertPs.addBatch();
	
      insertPs = conn.prepareStatement(sql_statement2);
      insertPreparedStatement(insertPs);
      insertPs = conn.prepareStatement(sql_statement3);
      insertPs.setString(1, name);
      insertPs.setString(2, descr);
      insertPs.setString(3, control_location);
      insertPs.setInt(4, n_controls);
      insertPs.setInt(5, n_unknowns);
      insertPs.setInt(6, format);
      insertPs.setInt(7, n_edge);
      insertPreparedStatement(insertPs);
      //insertPs.addBatch();
      //insertPs.executeBatch();
      //insertPreparedStatement(insertPs);
      conn.commit();
    } catch (SQLException sqle) {
      LOGGER.warning("Failed to properly prepare  prepared statement: " + sqle);
      JOptionPane.showMessageDialog(
          dmf, "Problems parsing data file!.", "Error", JOptionPane.ERROR_MESSAGE);
      return;
    }

      (define a '((384 5 ) (383 5 ) (382 5 ) (381 5 ) (380 5 ) (379 5 ) (378 5 ) (377 5 ) (376 5 ) (375 5 ) (374 5 ) (373 5 ) (372 5 ) (371 5 ) (370 5 ) (369 5 ) (368 5 ) (367 1 ) (366 1 ) (365 1 ) (364 1 ) (363 1 ) (362 1 ) (361 1 ) (360 1 ) (359 1 ) (358 1 ) (357 1 ) (356 3 ) (355 1 ) (354 1 ) (353 5 ) (352 5 ) (351 1 ) (350 1 ) (349 1 ) (348 1 ) (347 1 ) (346 4 ) (345 1 ) (344 1 ) (343 1 ) (342 1 ) (341 1 ) (340 1 ) (339 1 ) (338 1 ) (337 5 ) (336 5 ) (335 1 ) (334 1 ) (333 1 ) (332 1 ) (331 1 ) (330 1 ) (329 1 ) (328 1 ) (327 1 ) (326 1 ) (325 1 ) (324 2 ) (323 1 ) (322 1 ) (321 5 ) (320 5 ) (319 1 ) (318 1 ) (317 1 ) (316 1 ) (315 1 ) (314 1 ) (313 1 ) (312 1 ) (311 1 ) (310 1 ) (309 1 ) (308 1 ) (307 1 ) (306 1 ) (305 5 ) (304 5 ) (303 1 ) (302 1 ) (301 1 ) (300 1 ) (299 1 ) (298 1 ) (297 1 ) (296 1 ) (295 1 ) (294 1 ) (293 1 ) (292 1 ) (291 1 ) (290 1 ) (289 5 ) (288 5 ) (287 1 ) (286 1 ) (285 1 ) (284 1 ) (283 1 ) (282 1 ) (281 1 ) (280 1 ) (279 1 ) (278 1 ) (277 1 ) (276 1 ) (275 1 ) (274 1 ) (273 5 ) (272 5 ) (271 1 ) (270 2 ) (269 1 ) (268 1 ) (267 1 ) (266 1 ) (265 1 ) (264 1 ) (263 1 ) (262 1 ) (261 1 ) (260 1 ) (259 1 ) (258 1 ) (257 5 ) (256 5 ) (255 1 ) (254 1 ) (253 1 ) (252 1 ) (251 1 ) (250 1 ) (249 1 ) (248 1 ) (247 1 ) (246 1 ) (245 1 ) (244 1 ) (243 1 ) (242 1 ) (241 5 ) (240 5 ) (239 1 ) (238 1 ) (237 1 ) (236 1 ) (235 1 ) (234 1 ) (233 1 ) (232 1 ) (231 1 ) (230 1 ) (229 1 ) (228 1 ) (227 1 ) (226 1 ) (225 5 ) (224 5 ) (223 1 ) (222 1 ) (221 1 ) (220 1 ) (219 1 ) (218 1 ) (217 1 ) (216 1 ) (215 1 ) (214 1 ) (213 1 ) (212 1 ) (211 1 ) (210 1 ) (209 5 ) (208 5 ) (207 1 ) (206 1 ) (205 1 ) (204 1 ) (203 1 ) (202 1 ) (201 1 ) (200 1 ) (199 1 ) (198 1 ) (197 1 ) (196 1 ) (195 1 ) (194 1 ) (193 5 ) (192 5 ) (191 1 ) (190 1 ) (189 1 ) (188 1 ) (187 1 ) (186 1 ) (185 1 ) (184 4 ) (183 1 ) (182 1 ) (181 1 ) (180 1 ) (179 1 ) (178 1 ) (177 5 ) (176 5 ) (175 1 ) (174 1 ) (173 1 ) (172 1 ) (171 1 ) (170 1 ) (169 1 ) (168 1 ) (167 1 ) (166 1 ) (165 1 ) (164 1 ) (163 1 ) (162 1 ) (161 5 ) (160 5 ) (159 1 ) (158 1 ) (157 1 ) (156 1 ) (155 1 ) (154 1 ) (153 1 ) (152 1 ) (151 1 ) (150 1 ) (149 1 ) (148 1 ) (147 1 ) (146 1 ) (145 5 ) (144 5 ) (143 1 ) (142 1 ) (141 1 ) (140 1 ) (139 1 ) (138 1 ) (137 1 ) (136 1 ) (135 1 ) (134 1 ) (133 1 ) (132 1 ) (131 1 ) (130 1 ) (129 5 ) (128 5 ) (127 1 ) (126 1 ) (125 2 ) (124 1 ) (123 1 ) (122 1 ) (121 1 ) (120 1 ) (119 1 ) (118 1 ) (117 1 ) (116 1 ) (115 1 ) (114 1 ) (113 5 ) (112 5 ) (111 1 ) (110 1 ) (109 1 ) (108 1 ) (107 1 ) (106 1 ) (105 1 ) (104 1 ) (103 1 ) (102 1 ) (101 1 ) (100 1 ) (99 1 ) (98 3 ) (97 5 ) (96 5 ) (95 1 ) (94 1 ) (93 1 ) (92 1 ) (91 1 ) (90 1 ) (89 1 ) (88 1 ) (87 1 ) (86 1 ) (85 1 ) (84 1 ) (83 1 ) (82 1 ) (81 5 ) (80 5 ) (79 1 ) (78 1 ) (77 1 ) (76 1 ) (75 1 ) (74 1 ) (73 1 ) (72 1 ) (71 1 ) (70 1 ) (69 1 ) (68 1 ) (67 1 ) (66 1 ) (65 5 ) (64 5 ) (63 1 ) (62 1 ) (61 1 ) (60 1 ) (59 1 ) (58 1 ) (57 1 ) (56 1 ) (55 2 ) (54 1 ) (53 1 ) (52 1 ) (51 1 ) (50 1 ) (49 5 ) (48 5 ) (47 1 ) (46 1 ) (45 1 ) (44 1 ) (43 1 ) (42 1 ) (41 1 ) (40 1 ) (39 1 ) (38 1 ) (37 1 ) (36 1 ) (35 1 ) (34 1 ) (33 5 ) (32 5 ) (31 1 ) (30 1 ) (29 1 ) (28 1 ) (27 1 ) (26 1 ) (25 1 ) (24 1 ) (23 1 ) (22 1 ) (21 1 ) (20 1 ) (19 1 ) (18 1 ) (17 5 ) (16 5 ) (15 5 ) (14 5 ) (13 5 ) (12 5 ) (11 5 ) (10 5 ) (9 5 ) (8 5 ) (7 5 ) (6 5 ) (5 5 ) (4 5 ) (3 5 ) (2 5 ) (1 5 )) )


 (define (prep-sql-suffix list sqlsuffix)
  ;;
  ;;input is (88\t90\r)
  (cond
   ((null? (cdr list))
    (string-append "(" (number->string (caar list)) ", " (number->string (cadr list))  ", 1, 1) ")
    sqlsuffix)
   ((cdr list)
    (string-append "(" (number->string (caar list)) ", " (number->string (cadr list))  ", 1, 1), ")
    (prep-sql-suffix (cdr list) sqlsuffix))
   (else #f)))

 (prep-sql-suffix a "")
