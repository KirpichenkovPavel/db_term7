insert into country (id, name)
values ('1', 'Russia')
returning id, name;
insert into country (id, name)
values ('2', 'USA')
returning id, name;
insert into country (id, name)
values ('3', 'Germany')
returning id, name;
insert into country (id, name)
values ('4', 'UK')
returning id, name;
insert into country (id, name)
values ('5', 'Belgium')
returning id, name;

insert into shell_type(id, name)
values ('1', 'basic')
returning id, name;
insert into shell_type(id, name)
values ('2', 'armor-piercieng')
returning id, name;
insert into shell_type(id, name)
values ('3', 'incendiary')
returning id, name;
insert into shell_type(id, name)
values ('4', 'tracer')
returning id, name;
insert into shell_type(id, name)
values ('5', 'miscellaneous')
returning id, name;

insert into accessory_type (id, name)
values ('1', 'scope')
returning id, name;
insert into accessory_type (id, name)
values ('2', 'grip')
returning id, name;
insert into accessory_type (id, name)
values ('3', 'grenade launcher')
returning id, name;
insert into accessory_type (id, name)
values ('4', 'shotgun')
returning id, name;
insert into accessory_type (id, name)
values ('5', 'laser sight')
returning id, name;
insert into accessory_type (id, name)
values ('6', 'miscellaneous')
returning id, name;

insert into weapon_type (id, name)
values ('1', 'assault rifle')
returning id, name;
insert into weapon_type (id, name)
values ('2', 'pistol')
returning id, name;
insert into weapon_type (id, name)
values ('3', 'machine gun')
returning id, name;
insert into weapon_type (id, name)
values ('4', 'submachine gun')
returning id, name;
insert into weapon_type (id, name)
values ('5', 'shotgun')
returning id, name;
insert into weapon_type (id, name)
values ('6', 'miscellaneous')
returning id, name;

insert into manufacture (id, name, id_country)
select '1', 'Kalashnikov Concern (Izhmash)', country.id from country where name = 'Russia';
insert into manufacture (id, name, id_country)
select '2', 'Fabrique Nationale d''Herstal', country.id from country where name = 'Belgium';
insert into manufacture (id, name, id_country)
select '3', 'Colt''s Manufacturing Company', country.id from country where name = 'USA';
insert into manufacture (id, name, id_country)
select '4', 'BAE Systems', country.id from country where name = 'UK';
insert into manufacture (id, name, id_country)
select '5', 'Heckler & Koch', country.id from country where name='Germany';
insert into manufacture (id, name, id_country)
select '5', 'C-More Systems', country.id from country where name='USA';

insert into mount (id, name)
values ('1' ,'Warsaw Pact mounting dovetail')
returning id, name;
insert into mount
values ('2' ,'Picatinny rail')
returning id, name;
insert into mount
values ('3' ,'Weawer rail')
returning id, name;

insert into caliber (id, diameter, length, name)
values ('1', '5.45', '39', NULL)
returning id, diameter, length, name;
insert into caliber (id, diameter, length, name)
values ('2', '7.62', '39', NULL)
returning id, diameter, length, name;
insert into caliber (id, diameter, length, name)
values ('3', '7.62', '51', NULL)
returning id, diameter, length, name;
insert into caliber (id, diameter, length, name)
values ('4', '9', '19', NULL)
returning id, diameter, length, name;
insert into caliber (id, diameter, length, name)
values ('5', '9', '18', NULL)
returning id, diameter, length, name;
insert into caliber (id, diameter, length, name)
values ('6', '40', '46', NULL)
returning id, diameter, length, name;
insert into caliber (id, diameter, length, name)
values ('7', '12', '76', NULL)
returning id, diameter, length, name;
insert into caliber (id, diameter, length, name)
values ('8', '5.56', '45', NULL)
returning id, diameter, length, name;

insert into shell (id, id_caliber, name, description, id_manufacture, id_shell_type)
values ('1', '1', '5.45x39 b', 'sample 5.45', '1', '1')
returning name; 
insert into shell (id, id_caliber, name, description, id_manufacture, id_shell_type)
values ('2', '2', '7.62x39 ap', 'sample 7.62', '1', '2')
returning name; 
insert into shell (id, id_caliber, name, description, id_manufacture, id_shell_type)
values ('3', '3', '7.62x51 ap', 'sample 7.62', '2', '2')
returning name; 
insert into shell (id, id_caliber, name, description, id_manufacture, id_shell_type)
values ('4', '4', '9x19 b', 'sample 9x19', '5', '1')
returning name; 
insert into shell (id, id_caliber, name, description, id_manufacture, id_shell_type)
values ('5', '5', '9x18 b', 'sample 9x18', '1', '1')
returning name; 
insert into shell (id, id_caliber, name, description, id_manufacture, id_shell_type)
values ('6', '5', '9x18 tr', 'sample 9x18 tr', '1', '4')
returning name;

insert into accessory (id, name, id_accessory_type, id_mount, id_manufacture, price, description, id_caliber)
values ('1', 'PSO-1', '1', '1', '1', '200', 'PSO-1 optical scope', NULL)
returning name;
insert into accessory (id, name, id_accessory_type, id_mount, id_manufacture, price, description, id_caliber)
values ('2', 'M26 MASS', '5', '2', '1', '350', 'under-barrel shotgun', 7)
returning name;
insert into accessory (id, name, id_accessory_type, id_mount, id_manufacture, price, description, id_caliber)
values ('3', 'M203', '3', '2', '3', '400', 'under-barrel granade launcher', 6)
returning name;

insert into weapon (id, name, id_caliber, id_type, id_manufacture, description, price)
values ('1', 'AK-74', '1', '1', '1', 'Kalashnikov automatic rifle model 1974', 1000)
returning name;
insert into weapon (id, name, id_caliber, id_type, id_manufacture, description, price)
values ('2', 'PM', '5', '2', '1', 'Makarov pistol', 200)
returning name;
insert into weapon (id, name, id_caliber, id_type, id_manufacture, description, price)
values ('3', 'MP-5', '4', '3', '5', 'Heckler & Koch MP5', NULL)
returning name;
insert into weapon (id, name, id_caliber, id_type, id_manufacture, description, price)
values ('4', 'SCAR-L', '8', '1', '2', 'Special combat assault rifle', NULL)
returning name;








