select * from accessory;
select * from accessory_type;
select * from caliber;
select * from country;
select * from history;
select * from manufacture;
select * from mount;
select * from owner;
select * from shell;
select * from shell_type;
select * from weapon;
select * from weapon_instance;
select * from weapon_mount;
select * from weapon_type;

select name
from weapon
where name like 'AK%';

select name, price
from accessory
where price between '250' and '350';

select id, diameter, length
from caliber
where diameter in ('9', '5.45');

select id, name, price
from weapon
order by price, name;

select id, start_date, end_date
from history
order by start_date, end_date;

select MAX(price) as maximum, AVG(price) as average_price, MIN(price) as MINIMUM
from weapon;

select weapon.name as weapon, shell.name as shell
from weapon
join caliber on weapon.id_caliber = caliber.id
join shell on shell.id_caliber = caliber.id;

select manufacture.name as manufacture, country.name as country
from manufacture join country on manufacture.id_country = country.id;

select caliber.diameter as diameter, caliber.length as length, AVG(shell.price) as average_shell_price
from shell join caliber on shell.id_caliber = caliber.id
group by caliber.diameter, caliber.length
having caliber.diameter > '7';

select shell.name as shell, manufacture.name as manufacture
from shell 
join manufacture on shell.id_manufacture = manufacture.id
where manufacture.id_country = (
select id from country where name = 'Belgium'
);

insert into country (id, name)
	select max(id)+1, 'temp' from country;
insert into accessory_type (id, name)
	select max(id)+1, 'temp' from accessory_type;
insert into manufacture (id, name, id_country)
	select max(manufacture.id)+1, 'temp', country.id 
	from country, manufacture
	where country.name = 'temp'
	group by country.id;
insert into shell_type (id, name)
	select max(id)+1, 'temp' from shell_type;
insert into caliber (id, name, length, diameter)
	select max(id)+1, 'temp', '0', '0' from caliber;
insert into shell (id, id_caliber, name, id_manufacture, id_shell_type, price)
	select max(shell.id)+1, caliber.id, 'temp', manufacture.id, shell_type.id, '0'
	from shell, caliber, manufacture, shell_type
	where caliber.name ='temp' and manufacture.name = 'temp' and shell_type.name = 'temp'
	group by caliber.id, manufacture.id, shell_type.id;
insert into weapon_type (id, name)
	select max(id)+1, 'temp' from weapon_type;
insert into mount (id, name)
	select max(id)+1, 'temp' from mount;
insert into accessory (id, name, id_accessory_type, id_mount, id_manufacture, price)
	select max(accessory.id)+1, 'temp', accessory_type.id, mount.id, manufacture.id, '0'
	from accessory, accessory_type, mount, manufacture
	where accessory_type.name='temp' and mount.name='temp' and manufacture.name='temp'
	group by accessory_type.id, mount.id, manufacture.id;
insert into weapon (id, name, id_caliber, id_type, id_manufacture, price)
	select max(weapon.id)+1, 'temp', caliber.id, weapon_type.id, manufacture.id, '0'
	from weapon, caliber, weapon_type, manufacture
	where caliber.name='temp' and weapon_type.name='temp' and manufacture.name='temp'
	group by caliber.id, weapon_type.id, manufacture.id; 
insert into weapon_mount(id, id_weapon, id_mount, quantity)
	select max(weapon_mount.id)+1, weapon.id, mount.id, '1'
	from weapon_mount, weapon, mount
	where weapon.name = 'temp' and mount.name = 'temp'
	group by weapon.id, mount.id;
insert into owner(id, last_name, first_name, second_name)
	select max(id)+1, 'temp', 'temp', 'temp' from owner;
insert into weapon_instance (id, id_weapon, id_owner)
	select max(weapon_instance.id)+1, weapon.id, owner.id
	from weapon_instance, weapon, owner
	where owner.last_name='temp' and owner.first_name='temp' and owner.second_name = 'temp' and weapon.name='temp'
	group by weapon.id, owner.id;
insert into history (id, id_owner, id_weapon_instance, start_date, end_date)
	select max(history.id)+1, owner.id, weapon_instance.id, '2016-09-30', '2016-09-31'
	from history, owner, weapon_instance
	where owner.last_name='temp' and weapon_instance.code = 'temp'
	group by owner.id, weapon_instance.id;
insert into history (id, id_owner, id_weapon_instance, start_date, end_date)
	values ('100000', '100000', '100000', '29-SEP-16', '30-SEP-16');

update shell
set description='temporary description', price='300'
where name='temp';

delete from shell 
where id in
	(select id
	from shell,
	(select max(price) as maximum from shell) m
	where shell.price=m.maximum);

delete from country
where id not in
	(select country.id
	from country
	join manufacture on country.id = manufacture.id_country);	 

# big game gunners
select first 10 owner.last_name, count(w.id_owner)
from owner
join
	(select weapon_instance.id_owner as id_owner
	from caliber
	join weapon on caliber.id = weapon.id_caliber
	join weapon_instance on weapon_instance.id_weapon = weapon.id
	where caliber.diameter > 8) w
on w.id_owner = owner.id
group by owner.last_name, owner.first_name, owner.second_name
having count(w.id_owner)>4;

# delete unused calibers
delete from caliber
where id not in
	(select caliber.id as id
	from accessory join caliber on caliber.id=accessory.id_caliber)
and id not in
	(select caliber.id as id
	from shell join caliber on caliber.id=shell.id_caliber)
and id not in
	(select caliber.id as id
	from weapon join caliber on caliber.id = weapon.id_caliber);

select first 5 caliber.diameter, caliber.length
from caliber
join weapon on 

# calibers of the most owner-changable weapons
select first 5 caliber.diameter, caliber.length, avg(avg_wpn_period) as average_caliber_period
from caliber
join weapon on weapon.id_caliber = caliber.id
join
	(select weapon.id as id_weapon, avg(end_date - start_date) as avg_wpn_period
	from weapon
	join weapon_instance on weapon.id = weapon_instance.id_weapon
	join history on weapon_instance.id = history.id_weapon_instance
	group by id_weapon) wid
on wid.id_weapon = weapon.id
group by caliber.length, caliber.diameter
order by average_caliber_period asc;





