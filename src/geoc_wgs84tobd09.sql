CREATE OR REPLACE FUNCTION "public"."geoc_wgs84tobd09"("geom" "public"."geometry")
  RETURNS "public"."geometry" AS $BODY$
DECLARE
BEGIN
-- IF st_srid(geom) != '4490' THEN
--         RETURN null;
-- end if;
-- IF st_srid(geom) != '4326' THEN
--         RETURN null;
-- end if;
case ST_GeometryType(geom)
  when 'ST_LineString' then 
		return geoc_wgs84tobd09_line(geom);
	when 'ST_MultiLineString' then 
		return geoc_wgs84tobd09_multiline(geom);
	when 'ST_Point' then 
		return geoc_wgs84tobd09_point(geom);
	when 'ST_MultiPoint' then 
		return geoc_wgs84tobd09_multipoint(geom);
	when 'ST_Polygon' then 
		return geoc_wgs84tobd09_polygon(geom);
	when 'ST_MultiPolygon' then
		return geoc_wgs84tobd09_multipolygon(geom); 
	ELSE
    	RETURN null;
END CASE;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100