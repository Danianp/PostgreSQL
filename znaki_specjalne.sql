--Znaki specjalne w locality name
select  
    rsf.locality_name id,
    string_agg(distinct  match.special_character, ',') as special_character
from  rsf
left join lateral (
    select unnest(regexp_matches(rsf.locality_name, '[^a-zA-Z0-9 \[\]ąćęłńóśźżĄĆĘŁŃÓŚŹŻ.,_"\-/]', 'g')) as special_character
) as match ON true
where rsf.locality_name ~ '[^a-zA-Z0-9 \[\]ąćęłńóśźżĄĆĘŁŃÓŚŹŻ.,_"\-/]' and locality_name not ilike '%Brücknera%' and locality_name not ilike '%Ampere''a%'
group by rsf.locality_name;
