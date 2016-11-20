set term ^;
create procedure downgrade
	( WeaponName varchar(100) )
returns
	( CopiedShells integer)
as
	declare variable scount integer;
	declare variable id_caliber integer;
	declare variable id_caliber_prev integer;
	declare variable name varchar(100);
	declare variable description varchar(1000);
	declare variable id_manufacture integer;
	declare variable id_shell_type integer;
	declare variable price integer;
begin
	scount = 0;
	id_caliber = NULL;
	select caliber.id
	from weapon
	join caliber on weapon.id_caliber = caliber.id
	where weapon.name = :WeaponName
	into :id_caliber;
	if ( id_caliber is not NULL) then
	begin
		id_caliber_prev = NULL;		
		select first 1 id
		from caliber
		where caliber.diameter <
			(select diameter from caliber where id = :id_caliber)
		order by diameter desc, length desc
		into :id_caliber_prev;
		if ( id_caliber_prev is not NULL) then
		begin
			for select name, description, id_manufacture, id_shell_type, price
				from shell
				where id_caliber = :id_caliber
				into :name, :description, :id_manufacture, :id_shell_type, :price
			do begin				
				insert into shell (id, name, id_caliber, description, id_manufacture, id_shell_type, price)
				select max(shell.id)+1, :name, :id_caliber_prev, :description, :id_manufacture, :id_shell_type, :price
				from shell;
				scount = scount + 1;
			end
			CopiedShells = scount;				
		end
		else CopiedShells = -2;
	end
	else
		CopiedShells = -1;
end^
set term ;^










