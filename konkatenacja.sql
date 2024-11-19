select 
       null as room_id, -- ID
       null as room_status, -- Status
       null as room_geometry, -- Geometria
       -- Kolumna notice zawiera listę informacji
       'address_id;locality;removal_reason;person;id;type;location_category;status;region_name;region_code;province;county;commune;locality_name;locality_part;street;property' as "notice"
union all
select  
       r.room_identifier as room_id,
       r.room_status as room_status, 
       room_geometry, 
       -- Konkatenacja informacji z tabel źródłowych do kolumny notice
       coalesce(rsf.address_id, 'NULL') || ';' ||
       coalesce(rsf.locality, 'NULL') || ';' ||
       coalesce(r.removal_reason, 'NULL') || ';' ||
       coalesce(r.person, 'NULL') || ';' ||
       coalesce(rsf.id, 'NULL') || ';' ||
       coalesce(rsf.type, 'NULL') || ';' || 
       coalesce(rsf.location_category, 'NULL') || ';' || 
       coalesce(rsf.status, 'NULL') || ';' || 
       coalesce(rsf.region_name, 'NULL') || ';' || 
       coalesce(rsf.region_code, 'NULL') || ';' || 
       coalesce(rsf.province, 'NULL') || ';' || 
       coalesce(rsf.county, 'NULL') || ';' ||  
       coalesce(rsf.commune, 'NULL') || ';' ||  
       coalesce(rsf.locality_name, 'NULL') || ';' ||  
       coalesce(rsf.locality_part, 'NULL') || ';' || 
       coalesce(rsf.street, 'NULL') || ';' || 
       coalesce(rsf.property, 'NULL') as "notice"
from source_data.rooms r
left join m.updated_room_status rsf on r.identifier = rsf.id 
where r.room_status = 'R' and r.additional_info is null;
