-- podstawowe rzeczy do uzupełnienia na poziomie room
with room as (
select r.*,
	case 
		when r.cov is null then 'brak przypisanego znacznika,'
	end uwaga1,
	case
		when loc_type is null then 'brak przypisania typu budynku,'
	end uwaga2,
	case 
		when r.door = '' or r.door is null then 'brak wpisanego door,'
		when r."floor" = '' or r."floor" is null then 'brak wpisanego floor,'
	end uwaga3
from rooms r
