

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
