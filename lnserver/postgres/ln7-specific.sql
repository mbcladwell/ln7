

DROP FUNCTION IF EXISTS get_all_sessions();

CREATE OR REPLACE FUNCTION get_all_sessions()
 RETURNS TABLE( id TEXT, updated TEXT, lnuser_name VARCHAR(250), usergroup VARCHAR(250)  ) AS
$BODY$
BEGIN

RETURN query 
select to_char(lnsession.ID, '9999999'), to_char(lnsession.updated, 'DD Mon YYYY HH12:MI:SS'), lnuser.lnuser_name, lnuser_groups.usergroup  from lnsession, lnuser, lnuser_groups where lnsession.lnuser_id=lnuser.id AND lnuser_groups.id=lnuser.usergroup_id;

END;
$BODY$
  LANGUAGE plpgsql VOLATILE;

SELECT * FROM get_all_sessions();


-- this is required if using the Artanis session manager
-- script does it wrong: create table if not exists Sessions (sid varchar(32)  ,data text  ,expires varchar(29)  ,client varchar(39)  ,valid integer  ,PRIMARY KEY (sid)) engine=InnoDB;

create table if not exists sessions (sid varchar(32)  ,data text  ,expires varchar(29)  ,client varchar(39)  ,valid integer  ,PRIMARY KEY (sid));
create table if not exists person (id SERIAL PRIMARY KEY, lnuser varchar(250), passwd varchar(250), salt varchar(250));

insert into person (lnuser, passwd, salt) VALUES ('ln_admin','1d52114553ae31b3','a39b69e5fd79854b'),('ln_user','ca6468f6ff4a82e6','e999f4c34635f943');



DROP TABLE IF EXISTS lnsession CASCADE;
DROP SEQUENCE IF EXISTS  lnsession_id_seq CASCADE;
DROP INDEX IF EXISTS lnsession_pkey CASCADE;

DROP TABLE IF EXISTS sessions CASCADE;
DROP SEQUENCE IF EXISTS  sessions_id_seq CASCADE;
DROP INDEX IF EXISTS sessions_pkey CASCADE;
CREATE TABLE sessions
(        
        sid varchar(32),
        data text,
        expires varchar(29),
        client varchar(39),
        valid integer,
        lnuser_id INTEGER,
        FOREIGN KEY (lnuser_id) REFERENCES lnuser(id));

INSERT INTO sessions (lnuser_id) VALUES (1);

