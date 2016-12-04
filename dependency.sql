set term ^;
create trigger delete_check for Country
active
before delete
as
declare variable id_country integer;
begin		
	for select id_country
	from Manufacture
	into :id_country
	do begin
		if (old.id = :id_country) then
			exception dependent_field;
	end
end^

create trigger update_check for Country
active
before update
as
declare variable id_country integer;
begin
	for select id_country
	from Manufacture
	into :id_country
	do begin
		if (old.id = :id_country) then
			exception dependent_field;
	end
end^
set term ;^