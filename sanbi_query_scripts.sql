/*show unique values in column*/
select distinct "ADM1_EN" from zaf_provinces;
/*rename column*/
alter table zaf_provinces rename column "ADM1_EN" to adm1_en;

/*create views of layers*/
create view vw_major_rivers2018 as select * from rivers2018 where "order" > 3;

create view vw_major_dws_dams_50k as select * from dws_dams_50k where "Area_M2" > 17000000;
create view vw_midscale_dws_dams_50k as select * from dws_dams_50k where "Dam_Class" = 'Major' OR "Dam_Class" = 'Minor';


create view vw_major_zaf_roads as select * from zaf_roads where "highway" = 'motorway' OR "highway" = 'highway' OR "highway"='trunk';
create view vw_midscale_zaf_roads as select * from zaf_roads where "highway" = 'primary' OR "highway" = 'trunk' OR "highway" = 'trunk_link' OR "highway" = 'motorway' OR "highway" = 'highway' OR "highway" = 'motorway_link';

create view vw_place_name_largest_scale as select * from place_names where "fclass" != 'national_capital' AND "fclass" != 'city';
create view vw_place_name_larger_scale as select * from place_names where "fclass" = 'national_capital' OR "fclass" = 'city' OR "fclass" = 'town' OR "fclass" = 'village' OR "fclass" = 'hamlet';
create view vw_place_name_medium_scale as select * from place_names where "fclass" = 'national_capital' OR "fclass" = 'city';
create view vw_place_name_smallest_scale as select * from place_names where "fclass" =  'national_capital' OR "name" =  'Johannesburg' OR "name" =  'Bloemfontein' OR "name" =  'Upington' OR "name" =  'Gqeberha' OR "name" = 'Durban' OR "name" = 'Kimberley' OR "name" = 'Polokwane';

/*other index creation: create index index_name on table_name("column_name);"*/
create index idx_area_m2 on dws_dams_50k("Area_M2");

/*spatial index creation: create index index_name_geom on table_name USING GIST ("column_name");*/
create index idx_dws_dams_50k_geom on dws_dams_50k USING GIST ("geom");

/*remove index: drop index index_name*/
drop index idx_cba_2019;

/*explain output of command: explain analyze select * from table_name where condition1 or condition2;
(can also use condition1 and condition2)*/
EXPLAIN ANALYZE select * from vw_place_name_largest_scale where "fclass" != 'national_capital' AND "fclass" != 'city';

/*indexes on columns used for filtering layers*/
create index idx_sensfeat on critical_biodiversity_areas_2019("sensfeat");
create index idx_area_m2 on dws_dams_50k("Area_M2");
create index idx_dam_class on dws_dams_50k("Dam_Class");
create index idx_biome_18 on ecosystems("biome_18");
create index idx_fclass on place_names("fclass");
create index idx_site_type on protected_areas_2022("site_type");
create index idx_order on rivers2018("order");
create index idx_highway on zaf_roads("highway");

/*drop un-needed columns: alter table table_name drop column column_name1, drop column column_name2, etc;*/
alter table critical_biodiversity_areas_2019 
	drop column "sensitivit", 
	drop column "theme", 
	drop column "develop", 
	drop column "sub_cat", 
	drop column "area";

alter table dws_dams_50k 
	drop column "OBJECTID",
	drop column "P_Catch_No",
	drop column "Quat_No",
	drop column "Dam_Alias",
	drop column "Riv_Name",
	drop column "Mapsheet50",
	drop column "Uniq_ID",
	drop column "Year_OfPUB",
	drop column "Hectares",
	drop column "Shape__Are",
	drop column "Shape__Len";

alter table ecosystems 
	drop column "objectid", 
	drop column "name_18", 
	drop column "mapcode18", 
	drop column "biomeid_18", 
	drop column "bioregion_", 
	drop column "brgnid_18", 
	drop column "subtypnm_1", 
	drop column"mcdsubtype", 
	drop column "polygon_so",
	drop column "change_ver",
	drop column "change_ref",
	drop column "contributo",
	drop column "contribu_1", 
	drop column "cnsrv_trgt", 
	drop column "featuresou", 
	drop column "coastalfea", 
	drop column "primaryrea", 
	drop column "crossrealm", 
	drop column "crossrea_1", 
	drop column "vm_poly_id", 
	drop column "estuaryexc", 
	drop column "coastalpol", 
	drop column "shape_leng", 
	drop column "shape_area", 
	drop column "estuary_id", 
	drop column "nba2018_pl", 
	drop column "nba2018_rl";

alter table erf 
	drop column "ogc_fid",
	drop column "gid", 
	drop column "comments", 
	drop column "tag_just", 
	drop column "year", 
	drop column "value", 
	drop column "name";

alter table farm_portion 
	drop column "ogc_fid",
	drop column "gid", 
	drop column "comments", 
	drop column "tag_just", 
	drop column "year", 
	drop column "value", 
	drop column "name";

alter table holding 
	drop column "ogc_fid", 
	drop column "gid", 
	drop column "comments",
	drop column "tag_just",
	drop column "year",
	drop column "value";

alter table parent_farm 
	drop column "ogc_fid", 
	drop column "gid", 
	drop column "comments", 
	drop column "tag_just",
	drop column "year",
	drop column "value";

alter table place_names 
	drop column "osm_id", 
	drop column "code", 
	drop column "population";

alter table protected_areas_2022 
	drop column "wdpaid", 
	drop column "cur_nme", 
	drop column "wmcm_type", 
	drop column"maj_type", 
	drop column "d_dclar", 
	drop column "legal_stat", 
	drop column "gis_area", 
	drop column "proc_doc";

alter table rivers2018 
	drop column "ogc_fid", 
	drop column "objectid", 
	drop column "fnode", 
	drop column "tnode", 
	drop column "reachcode", 
	drop column "unit_id", 
	drop column "reachnum", 
	drop column "mainstem", 
	drop column "lev1_ecoregion", 
	drop column "lev2_ecoregion", 
	drop column "flow", 
	drop column "geozone", 
	drop column "gzlump", 
	drop column "rivtype", 
	drop column "pes1999", 
	drop column "rivcon", 
	drop column "ffrid", 
	drop column "ffr_region", 
	drop column "ffr_flagshp", 
	drop column "pes_2018", 
	drop column "nba2018_ets", 
	drop column "nba2018_epl", 
	drop column "ffrid_2018", 
	drop column "frfag_2018";

alter table zaf_boundary 
	drop column "Shape_Leng", 
	drop column "Shape_Area", 
	drop column "ADM0_EN", 
	drop column "ADM0_PCODE", 
	drop column "ADM0_REF", 
	drop column "ADM0ALT1EN", 
	drop column "ADM0ALT2EN", 
	drop column "date", 
	drop column "validOn", 
	drop column "validTo";

alter table zaf_provinces 
	drop column "Shape_Leng", 
	drop column "Shape_Area", 
	drop column "ADM1_PCODE", 
	drop column "ADM1_REF", 
	drop column "ADM1ALT1EN", 
	drop column "ADM1ALT2EN", 
	drop column "ADM0_EN", 
	drop column "ADM0_PCODE", 
	drop column "date", 
	drop column "validOn", 
	drop column "validTo", 
	drop column "ADM1_ID", 
	drop column "auxiliary_storage_labeling_positionx", 
	drop column "auxiliary_storage_labeling_positiony";

alter table zaf_public_places 
	drop column "ogc_fid", 
	drop column "gid", 
	drop column "comments", 
	drop column "tag_just", 
	drop column "year", 
	drop column "value";

alter table zaf_roads 
	drop column "osm_id", 
	drop column "surface", 
	drop column "oneway", 
	drop column "smoothness", 
	drop column "lanes", 
	drop column "source", 
	drop column "bridge", 
	drop column "width", 
	drop column "layer";

/*list all columns in table: SELECT * FROM information_schema.columns WHERE table_schema = 'schema' AND table_name   = 'table_name';*/
SELECT * FROM information_schema.columns WHERE table_schema = 'public' AND table_name   = 'dws_dams_50k';

/*simplify geometry of complex layers: 
create view view_name as select column_name1 as column_name1, st_simplify("geometry_column", factor) as geometry_column,
column_name2 as column_name2 from table_name where condition1 OR condition2 OR condition3 OR etc;
(Can also use AND in conditions)*/
create view vw_testing as select fid as fid, st_simplify("geom", 0.1) as geom, "name" as "name", highway as highway from zaf_roads
where "highway" = 'motorway' OR "highway" = 'highway' OR "highway"='trunk';

drop table if exists major_rivers2018;
/* creating tables for different zoom levels*/
/*rivers*/
select fid as fid, st_simplify("geom", 0.5) as geom, 
"order" as "order", "name" as "name"
into major_rivers2018
from rivers2018 where "order" > 3;

/*dams*/

/*create view vw_major_dws_dams_50k as select fid as fid, st_simplify("geom", 0.5) as geom, 
"Dam_Name" as "Dam_Name", "Dam_Class" as "Dam_Class", "Area_M2" as "Area_M2"
from dws_dams_50k where "Area_M2" > 17000000;*/
select fid as fid, st_simplify("geom", 0.5) as geom, 
"Dam_Name" as "Dam_Name", "Dam_Class" as "Dam_Class", "Area_M2" as "Area_M2"
into major_dws_dams_50k
from dws_dams_50k where "Area_M2" > 17000000;
/*rename columns*/
alter table major_dws_dams_50k rename column "Dam_Name" to dam_name;
alter table major_dws_dams_50k rename column "Dam_Class" to dam_class;
alter table major_dws_dams_50k rename column "Area_M2" to area_m2;

/*create view vw_midscale_dws_dams_50k as select fid as fid, st_simplify("geom", 0.1) as geom,
"Dam_Name" as "Dam_Name", "Dam_Class" as "Dam_Class", "Area_M2" as "Area_M2" 
from dws_dams_50k where "Dam_Class" = 'Major' OR "Dam_Class" = 'Minor';*/
select fid as fid, st_simplify("geom", 0.5) as geom, 
"Dam_Name" as "Dam_Name", "Dam_Class" as "Dam_Class", "Area_M2" as "Area_M2"
into midscale_dws_dams_50k
from dws_dams_50k where "Dam_Class" = 'Major' OR "Dam_Class" = 'Minor';
/*rename columns*/
alter table midscale_dws_dams_50k rename column "Dam_Name" to dam_name;
alter table midscale_dws_dams_50k rename column "Dam_Class" to dam_class;
alter table midscale_dws_dams_50k rename column "Area_M2" to area_m2;

/*rename columns*/
alter table dws_dams_50k rename column "Dam_Name" to dam_name;
alter table dws_dams_50k rename column "Dam_Class" to dam_class;
alter table dws_dams_50k rename column "Area_M2" to area_m2;

/*roads*/
/*create view vw_major_zaf_roads as select fid as fid, st_simplify("geom", 0.5) as geom, "name" as "name", highway as highway from zaf_roads
where "highway" = 'motorway' OR "highway" = 'highway' OR "highway"='trunk';*/
Made zaf_highway for this layer

/*create view vw_midscale_zaf_roads as select fid as fid, st_simplify("geom", 0.1) as geom, "name" as "name", highway as highway
from zaf_roads where "highway" = 'primary' OR "highway" = 'trunk' OR "highway" = 'trunk_link' OR "highway" = 'motorway' 
OR "highway" = 'highway' OR "highway" = 'motorway_link';*/
select fid as fid, st_simplify("geom", 0.1) as geom, 
"name" as "name", highway as highway
into midscale_zaf_roads
from zaf_roads where "highway" = 'primary' OR "highway" = 'trunk' 
OR "highway" = 'trunk_link' OR "highway" = 'motorway' 
OR "highway" = 'highway' OR "highway" = 'motorway_link';

/*borders*/

/*create view vw_zaf_boundary_small_scale as select fid as fid, st_simplify("geom", 0.1) as geom from zaf_boundary;*/
select fid as fid, st_simplify("geom", 0.1) as geom
into zaf_boundary_small_scale
from zaf_boundary;

/*create view vw_zaf_provinces_small_scale as select fid as fid, st_simplify("geom", 0.5) as geom, 
"adm1_en" as "adm1_en" from zaf_provinces;*/
select fid as fid, st_simplify("geom", 0.1) as geom, adm1_en as adm1_en
into zaf_provinces_small_scale
from zaf_provinces;

/*place names*/

/*create view vw_place_name_largest_scale as select * from place_names 
where "fclass" != 'national_capital' AND "fclass" != 'city';*/
select fid as fid, geom as geom, fclass as fclass, name as "name"
into place_name_largest_scale
from place_names where "fclass" != 'national_capital' AND "fclass" != 'city';

/*create view vw_place_name_larger_scale as select * from place_names 
where "fclass" = 'national_capital' OR "fclass" = 'city' OR "fclass" = 'town' 
OR "fclass" = 'village' OR "fclass" = 'hamlet';*/
select fid as fid, geom as geom, fclass as fclass, "name" as "name"
into place_name_larger_scale
from place_names where "fclass" = 'national_capital' OR 
"fclass" = 'city' OR "fclass" = 'town' 
OR "fclass" = 'village' OR "fclass" = 'hamlet';

/*create view vw_place_name_medium_scale as select * from place_names 
where "fclass" = 'national_capital' OR "fclass" = 'city';*/
select fid as fid, geom as geom, fclass as fclass, "name" as "name"
into place_name_midscale
from place_names where "fclass" = 'national_capital' OR "fclass" = 'city';

/*create view vw_place_name_smallest_scale as select * from place_names 
where "fclass" =  'national_capital' OR "name" =  'Johannesburg' OR 
"name" =  'Bloemfontein' OR "name" =  'Upington' OR "name" =  'Gqeberha' 
OR "name" = 'Durban' OR "name" = 'Kimberley' OR "name" = 'Polokwane';*/
select fid as fid, geom as geom, fclass as fclass, "name" as "name"
into place_name_smallest_scale
from place_names where "fclass" =  'national_capital' OR "name" =  'Johannesburg' OR 
"name" =  'Bloemfontein' OR "name" =  'Upington' OR "name" =  'Gqeberha' 
OR "name" = 'Durban' OR "name" = 'Kimberley' OR "name" = 'Polokwane';

/*critical_biodiversity_areas_2019*/
select fid as fid, st_simplify("geom", 0.5) as geom, sensfeat as sensfeat
into critical_biodiversity_areas_2019_small_scale
from critical_biodiversity_areas_2019;

select fid as fid, st_simplify("geom", 0.1) as geom, sensfeat as sensfeat
into critical_biodiversity_areas_2019_midscale
from critical_biodiversity_areas_2019;

/*ecosystems*/
select fid as fid, st_simplify("geom", 0.5) as geom, biome_18 as biome_18
into ecosystems_small_scale
from ecosystems;

select fid as fid, st_simplify("geom", 0.1) as geom, biome_18 as biome_18
into ecosystems_midscale
from ecosystems;

/*protected_areas_2022*/
select fid as fid, st_simplify("geom", 0.5) as geom, site_type as site_type
into protected_areas_2022_small_scale
from protected_areas_2022;

select fid as fid, st_simplify("geom", 0.1) as geom, site_type as site_type
into protected_areas_2022_midscale
from protected_areas_2022;

/*zaf_public_places*/
select fid as fid, st_simplify("geom", 0.1) as geom, tag_value as tag_value
into zaf_public_places_midscale
from zaf_public_places;

/* catch all required roads for small scale*/
update zaf_roads set name = 'none' where (highway = 'motorway' OR highway = 'highway' OR highway='trunk') and name is null;

/* merge roads into single lines*/
WITH edges_merged as (SELECT name, 
                highway,
                ST_LineMerge(ST_Union(f.geom)) as singlegeom
            FROM zaf_roads As f
            GROUP BY 1,2
            HAVING highway = 'motorway' OR highway = 'highway' OR highway='trunk'
    ),

edges_intersections as( SELECT a.name, a.highway, st_union(st_intersection(a.singlegeom, b.singlegeom)) as geom
                FROM edges_merged a
                JOIN edges_merged b
                ON ST_crosses(a.singlegeom, b.singlegeom) or st_touches(a.singlegeom, b.singlegeom)
                group by 1,2)

select l.name as lname, l.highway as lhighway
    ,(st_dump(st_split(l.singlegeom, p.geom))).geom
into zaf_highways 
FROM edges_merged as l
JOIN edges_intersections as p
ON l.name = p.name;

alter table zaf_highways add column fid serial Not null;
select * from zaf_roads;

/* making bbox*/
SELECT ST_AsMVTGeom(geom,ST_MakeBox2D(ST_Point(0, 0), ST_Point(4096, 4096))) AS 
geometry, fid FROM public.zaf_roads WHERE geom && ST_MakeBox2D(ST_Point(0, 0), ST_Point(4096, 4096));
SELECT ST_AsMVTGeom(geom,ST_MakeBox2D(ST_Point(0, 0), ST_Point(4096, 4096))) AS 
geometry, fid FROM public.midscale_zaf_roads WHERE geom && ST_MakeBox2D(ST_Point(0, 0), ST_Point(4096, 4096));
SELECT ST_AsMVTGeom(geom,ST_MakeBox2D(ST_Point(0, 0), ST_Point(4096, 4096))) AS 
geometry, fid FROM public.zaf_highways WHERE geom && ST_MakeBox2D(ST_Point(0, 0), ST_Point(4096, 4096));

SELECT ST_AsMVTGeom(geom,ST_MakeBox2D(ST_Point(0, 0), ST_Point(4096, 4096))) AS 
geometry, fid FROM public.major_dws_dams_50k WHERE geom && ST_MakeBox2D(ST_Point(0, 0), ST_Point(4096, 4096));
SELECT ST_AsMVTGeom(geom,ST_MakeBox2D(ST_Point(0, 0), ST_Point(4096, 4096))) AS 
geometry, fid FROM public.midscale_dws_dams_50k WHERE geom && ST_MakeBox2D(ST_Point(0, 0), ST_Point(4096, 4096));
SELECT ST_AsMVTGeom(geom,ST_MakeBox2D(ST_Point(0, 0), ST_Point(4096, 4096))) AS 
geometry, fid FROM public.dws_dams_50k WHERE geom && ST_MakeBox2D(ST_Point(0, 0), ST_Point(4096, 4096));

SELECT ST_AsMVTGeom(geom,ST_MakeBox2D(ST_Point(0, 0), ST_Point(4096, 4096))) AS 
geometry, fid FROM public.major_rivers2018 WHERE geom && ST_MakeBox2D(ST_Point(0, 0), ST_Point(4096, 4096));
SELECT ST_AsMVTGeom(geom,ST_MakeBox2D(ST_Point(0, 0), ST_Point(4096, 4096))) AS 
geometry, fid FROM public.rivers2018 WHERE geom && ST_MakeBox2D(ST_Point(0, 0), ST_Point(4096, 4096));

SELECT ST_AsMVTGeom(geom,ST_MakeBox2D(ST_Point(0, 0), ST_Point(4096, 4096))) AS 
geometry, fid FROM public.zaf_boundary_small_scale WHERE geom && ST_MakeBox2D(ST_Point(0, 0), ST_Point(4096, 4096));
SELECT ST_AsMVTGeom(geom,ST_MakeBox2D(ST_Point(0, 0), ST_Point(4096, 4096))) AS 
geometry, fid FROM public.zaf_boundary WHERE geom && ST_MakeBox2D(ST_Point(0, 0), ST_Point(4096, 4096));

SELECT ST_AsMVTGeom(geom,ST_MakeBox2D(ST_Point(0, 0), ST_Point(4096, 4096))) AS 
geometry, fid FROM public.zaf_provinces_small_scale WHERE geom && ST_MakeBox2D(ST_Point(0, 0), ST_Point(4096, 4096));
SELECT ST_AsMVTGeom(geom,ST_MakeBox2D(ST_Point(0, 0), ST_Point(4096, 4096))) AS 
geometry, fid FROM public.zaf_provinces WHERE geom && ST_MakeBox2D(ST_Point(0, 0), ST_Point(4096, 4096));

SELECT ST_AsMVTGeom(geom,ST_MakeBox2D(ST_Point(0, 0), ST_Point(4096, 4096))) AS 
geometry, fid FROM public.place_name_largest_scale WHERE geom && ST_MakeBox2D(ST_Point(0, 0), ST_Point(4096, 4096));
SELECT ST_AsMVTGeom(geom,ST_MakeBox2D(ST_Point(0, 0), ST_Point(4096, 4096))) AS 
geometry, fid FROM public.place_name_larger_scale WHERE geom && ST_MakeBox2D(ST_Point(0, 0), ST_Point(4096, 4096));
SELECT ST_AsMVTGeom(geom,ST_MakeBox2D(ST_Point(0, 0), ST_Point(4096, 4096))) AS 
geometry, fid FROM public.place_name_midscale WHERE geom && ST_MakeBox2D(ST_Point(0, 0), ST_Point(4096, 4096));
SELECT ST_AsMVTGeom(geom,ST_MakeBox2D(ST_Point(0, 0), ST_Point(4096, 4096))) AS 
geometry, fid FROM public.place_name_smallest_scale WHERE geom && ST_MakeBox2D(ST_Point(0, 0), ST_Point(4096, 4096));

SELECT ST_AsMVTGeom(geom,ST_MakeBox2D(ST_Point(0, 0), ST_Point(4096, 4096))) AS 
geometry, fid FROM public.critical_biodiversity_areas_2019 WHERE geom && ST_MakeBox2D(ST_Point(0, 0), ST_Point(4096, 4096));
SELECT ST_AsMVTGeom(geom,ST_MakeBox2D(ST_Point(0, 0), ST_Point(4096, 4096))) AS 
geometry, fid FROM public.critical_biodiversity_areas_2019_midscale WHERE geom && ST_MakeBox2D(ST_Point(0, 0), ST_Point(4096, 4096));
SELECT ST_AsMVTGeom(geom,ST_MakeBox2D(ST_Point(0, 0), ST_Point(4096, 4096))) AS 
geometry, fid FROM public.critical_biodiversity_areas_2019_small_scale WHERE geom && ST_MakeBox2D(ST_Point(0, 0), ST_Point(4096, 4096));

SELECT ST_AsMVTGeom(geom,ST_MakeBox2D(ST_Point(0, 0), ST_Point(4096, 4096))) AS 
geometry, fid FROM public.ecosystems_small_scale WHERE geom && ST_MakeBox2D(ST_Point(0, 0), ST_Point(4096, 4096));
SELECT ST_AsMVTGeom(geom,ST_MakeBox2D(ST_Point(0, 0), ST_Point(4096, 4096))) AS 
geometry, fid FROM public.ecosystems_midscale WHERE geom && ST_MakeBox2D(ST_Point(0, 0), ST_Point(4096, 4096));
SELECT ST_AsMVTGeom(geom,ST_MakeBox2D(ST_Point(0, 0), ST_Point(4096, 4096))) AS 
geometry, fid FROM public.ecosystems WHERE geom && ST_MakeBox2D(ST_Point(0, 0), ST_Point(4096, 4096));

SELECT ST_AsMVTGeom(geom,ST_MakeBox2D(ST_Point(0, 0), ST_Point(4096, 4096))) AS 
geometry, fid FROM public.protected_areas_2022_small_scale WHERE geom && ST_MakeBox2D(ST_Point(0, 0), ST_Point(4096, 4096));
SELECT ST_AsMVTGeom(geom,ST_MakeBox2D(ST_Point(0, 0), ST_Point(4096, 4096))) AS 
geometry, fid FROM public.protected_areas_2022_midscale WHERE geom && ST_MakeBox2D(ST_Point(0, 0), ST_Point(4096, 4096));
SELECT ST_AsMVTGeom(geom,ST_MakeBox2D(ST_Point(0, 0), ST_Point(4096, 4096))) AS 
geometry, fid FROM public.protected_areas_2022 WHERE geom && ST_MakeBox2D(ST_Point(0, 0), ST_Point(4096, 4096));

SELECT ST_AsMVTGeom(geom,ST_MakeBox2D(ST_Point(0, 0), ST_Point(4096, 4096))) AS 
geometry, fid FROM public.zaf_public_places_midscale WHERE geom && ST_MakeBox2D(ST_Point(0, 0), ST_Point(4096, 4096));
SELECT ST_AsMVTGeom(geom,ST_MakeBox2D(ST_Point(0, 0), ST_Point(4096, 4096))) AS 
geometry, fid FROM public.zaf_public_places WHERE geom && ST_MakeBox2D(ST_Point(0, 0), ST_Point(4096, 4096));

SELECT ST_AsMVTGeom(geom,ST_MakeBox2D(ST_Point(0, 0), ST_Point(4096, 4096))) AS 
geometry, fid FROM public.parent_farm WHERE geom && ST_MakeBox2D(ST_Point(0, 0), ST_Point(4096, 4096));

SELECT ST_AsMVTGeom(geom,ST_MakeBox2D(ST_Point(0, 0), ST_Point(4096, 4096))) AS 
geometry, fid FROM public.farm_portion WHERE geom && ST_MakeBox2D(ST_Point(0, 0), ST_Point(4096, 4096));

SELECT ST_AsMVTGeom(geom,ST_MakeBox2D(ST_Point(0, 0), ST_Point(4096, 4096))) AS 
geometry, fid FROM public.holding WHERE geom && ST_MakeBox2D(ST_Point(0, 0), ST_Point(4096, 4096));

SELECT ST_AsMVTGeom(geom,ST_MakeBox2D(ST_Point(0, 0), ST_Point(4096, 4096))) AS 
geometry, fid FROM public.erf WHERE geom && ST_MakeBox2D(ST_Point(0, 0), ST_Point(4096, 4096));