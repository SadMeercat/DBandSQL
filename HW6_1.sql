#Создайте таблицу users_old, аналогичную таблице users. Создайте процедуру, с помощью которой можно переместить любого (одного) 
#пользователя из таблицы users в таблицу users_old. (использование транзакции с выбором commit или rollback – обязательно).

drop procedure if exists transfer;



delimiter //
create procedure transfer(id_user int)
begin
start transaction;
create table if not exists users_old(
	id SERIAL PRIMARY KEY, -- SERIAL = BIGINT UNSIGNED NOT NULL AUTO_INCREMENT UNIQUE
    firstname VARCHAR(50),
    lastname VARCHAR(50) COMMENT 'Фамилия',
    email VARCHAR(120) UNIQUE
);

insert into users_old select * from users where id = id_user;

delete from users where id = id_user;
commit;
end //
delimiter ;

call transfer(1);

#Создайте хранимую функцию hello(), которая будет возвращать приветствие, в зависимости от текущего времени суток. 
#С 6:00 до 12:00 функция должна возвращать фразу "Доброе утро", с 12:00 до 18:00 функция должна возвращать фразу "Добрый день", 
#с 18:00 до 00:00 — "Добрый вечер", с 00:00 до 6:00 — "Доброй ночи".

drop function if exists hello;

delimiter //

create function hello()
returns varchar(255)
begin
    declare greeting varchar(255);
    declare curr_time time;
    set curr_time = curtime();

    if hour(curr_time) >= 18 then
        set greeting = 'Добрый вечер';
    elseif hour(curr_time) >= 12 and hour(curr_time) < 18 then
        set greeting = 'Добрый день';
    elseif hour(curr_time) >= 6 and hour(curr_time) < 12 then
        set greeting = 'Доброе утро';
    else
        set greeting = 'Доброй ночи';
    end if;
    
    return greeting;
end //

delimiter ;

select hello();

#(по желанию)* Создайте таблицу logs типа Archive. Пусть при каждом создании записи в таблицах users, communities и messages в таблицу logs 
#помещается время и дата создания записи, название таблицы, идентификатор первичного ключа.
drop table if exists logs;
create table logs (
	log_id int auto_increment primary key,
    table_name varchar(255),
    primary_key_id int,
    created_at datetime default current_timestamp
) engine = archive;

drop trigger if exists usr_log;
drop trigger if exists comm_log;
drop trigger if exists mess_log;

delimiter //

create trigger usr_log after insert on users for each row
begin
	insert into logs (table_name, primary_key_id) values
		('users', new.id);
end //

create trigger comm_log after insert on communities for each row
begin
	insert into logs (table_name, primary_key_id) values
		('communities', new.id);
end //

create trigger mess_log after insert on messages for each row
begin
	insert into logs (table_name, primary_key_id) values
		('messages', new.id);
end //

delimiter ;

insert into users values (11, 'test','test','test')
