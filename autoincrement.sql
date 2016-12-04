set term ^;
create or alter trigger trig_id_country for Country
active
before insert
as
begin
	if (new.id is NULL) then
	new.id = gen_id(gen_id_country, 1);
end^
set term ;^