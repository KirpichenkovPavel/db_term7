create table Owner(
id int not null primary key,
last_name varchar(100),
first_name varchar(100),
second_name varchar(100));

create table Weapon_instance (
id int not null primary key,
id_weapon int not null references Weapon,
id_owner int references Owner,
code varchar(100) unique);

create table History(
id int not null primary key,
id_owner int not null references Owner,
id_weapon_instance int not null references Weapon_instance,
start_date date,
end_date date);
