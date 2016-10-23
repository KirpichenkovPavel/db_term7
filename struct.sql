create generator id_weapon_type;
create generator id_weapon_mount;
create generator id_country;
create generator id_weapon;
create generator id_mount;
create generator id_caliber;
create generator id_manufacture;
create generator id_shell;
create generator id_accessory;
create generator id_accessory_type;
create generator id_shell_type;

create table Accessory_type(
id int not null primary key,
name varchar(100) unique);
commit;

create table Country(
id int not null primary key,
name varchar(100) unique);
commit;

create table Manufacture(
id int not null primary key,
name varchar(100) unique,
id_coutry int not null references Country);
commit;

create table Shell_type(
id int not null primary key,
name varchar(100) not null unique);
commit;

create table Weapon_type(
id int not null primary key,
name varchar(100) unique not null);
commit;

create table Mount(
id int not null primary key,
name varchar(100) unique not null);
commit;

create table Caliber(
id int not null primary key,
diameter decimal(10,2),
length decimal(10,2),
name varchar(100));
commit;

create table Shell(
id int not null primary key,
id_caliber int not null references Caliber,
name varchar(100) unique not null,
description varchar(1000),
id_manufacture int references Manufacture,
id_shell_type int not null references Shell_type,
price int);
commit;

create table Accessory(
id int not null primary key,
name varchar(100) unique not null,
id_accessory_type int not null references Accessory_type,
id_mount int not null references Mount,
id_manufacture int references Manufacture,
price int,
description varchar(1000),
id_caliber int references Caliber);
commit;

create table Weapon(
id int not null primary key,
name varchar(100) not null unique,
id_caliber int not null references Caliber,
id_type int not null references Weapon_type,
id_manufacture int references Manufacture,
description varchar(1000),
price int);
commit;

create table Weapon_mount(
id int not null primary key,
id_weapon int not null references Weapon,
id_mount int not null references Mount);
commit;
