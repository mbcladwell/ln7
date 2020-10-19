

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

create table if not exists Sessions (sid varchar(32)  ,data text  ,expires varchar(29)  ,client varchar(39)  ,valid integer  ,PRIMARY KEY (sid));
