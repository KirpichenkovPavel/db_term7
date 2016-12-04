set term ^;
create or alter trigger mountcontrol for weapon_mount
active
before insert
as
	declare variable id_weapon_mount integer;
begin
	for select id
	from weapon_mount
	where id_weapon = new.id_weapon and id_mount = new.id_mount
	into id_weapon_mount
	do
		exception mount_exists;	
end^
set term ;^