set term ^;
create or alter trigger downgrade for weapon
active
before insert
as
	declare variable weapon_name varchar(100);	
	declare variable cntr integer;
	declare variable id_caliber_req integer;	
begin
	id_caliber_req = NULL;
	weapon_name = NULL;
	select first 1 id
	from caliber
	where caliber.diameter >
		(select diameter from caliber where id = new.id_caliber)
	order by diameter asc, length asc
	into :id_caliber_req;
	if (id_caliber_req is not NULL) then
		select name
		from weapon
		where id_caliber = :id_caliber_req and 
		      id_type = new.id_type and
		      id_manufacture = new.id_manufacture and
		      name = new.name
		into :weapon_name;
	if (weapon_name is not NULL) then
	begin
		execute procedure downgrade :weapon_name
		returning_values :cntr;
		new.name = :weapon_name || '_' || cast (new.id as varchar(100));
	end
end^

create or alter trigger copymounts for weapon
active
after insert
as
	declare variable weapon_name varchar(100);
	declare variable new_name varchar(100);
	declare variable cntr integer;
	declare variable id_caliber_req integer;	
begin
	id_caliber_req = NULL;
	weapon_name = NULL;
	select first 1 id
	from caliber
	where caliber.diameter >
		(select diameter from caliber where id = new.id_caliber)
	order by diameter asc, length asc
	into :id_caliber_req;
	if (id_caliber_req is not NULL) then
		select first 1 name
		from weapon
		where id_caliber = :id_caliber_req and 
		      id_type = new.id_type and
		      id_manufacture = new.id_manufacture and
		      new.name like name || '%'
		order by id
		into :weapon_name;
	if (weapon_name is not NULL) then
	begin
		select first 1 new.name from weapon into :new_name;
		execute procedure copymounts :weapon_name, :new_name
		returning_values :cntr;
	end
end^ 
set term ;^
