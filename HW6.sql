#Создайте функцию, которая принимает кол-во сек и формат их в кол-во дней часов. Пример: 123456 ->'1 days 10 hours 17 minutes 36 seconds '

delimiter $$
create procedure sec_to_date(sec int)
begin
	declare days int default 0;
  declare hours int default 0;
	declare min int default 0;
    
    while sec >= 60 do
		set min = sec / 60;
        set sec = sec % 60;
	end while;
    
    while min >= 60 do
		set hours = min / 60;
        set min = min % 60;
	end while;
    
    while hours >= 24 do
		set days = hours / 24;
        set hours = hours % 24;
	end while;
    
select days, hours, min, sec;

end$$
delimiter ;

call sec_to_date(123456);

#Выведите только четные числа от 1 до 10. Пример: 2,4,6,8,10

delimiter $$
create procedure num()
begin
	declare n int default 0;
    drop table if exists numbers;
    create table numbers (num int);
    
    while n < 10 do 
	set n = n + 2;
    insert into numbers value (n);
    end while;
    
    select * from numbers;
    
select days, hours, min, sec;

end$$
delimiter ;

call num();
