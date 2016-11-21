set term ^;
create procedure copymounts
	( OldWeaponName varchar(100), NewWeaponName varchar(100) )
returns
	( CopiedMounts integer)
as
	declare variable mcount integer;
	declare variable id_weapon_old integer;
	declare variable id_weapon_new integer;
	declare variable id_mount integer; 
	declare variable quantity integer;
begin
	mcount = 0;
	select id from weapon where name = :NewWeaponName
	into :id_weapon_new;
	select id from weapon where name = :OldWeaponName
	into :id_weapon_old;
	if ( id_weapon_old is not NULL AND id_weapon_new is not NULL ) then
	begin
		for select id_mount, quantity 
			from weapon_mount
			where id_weapon = :id_weapon_old
			into :id_mount, :quantity
		do
		begin
			insert into weapon_mount
			select max(id) + 1, :id_weapon_new, :id_mount, :quantity
			from weapon_mount;
			mcount = mcount + 1;		
		end
		CopiedMounts = mcount;		
	end
	else
		CopiedMounts = -1;
end^
set term ;^