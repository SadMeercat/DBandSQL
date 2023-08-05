    #Используя операторы языка SQL, создайте табличку “sales”. Заполните ее данными
create table if not exists sales(
id int Primary key not null,
order_date date,
count_product int
);

insert into sales (id,  order_date, count_product) values
  (1, "2022-01-01", 156),
  (2, "2022-01-02", 180),
  (3, "2022-01-03", 21),
  (4, "2022-01-04", 124),
  (5, "2022-01-05", 341);

    #Сгруппируйте значений количества в 3 сегмента — меньше 100, 100-300 и больше 300.
select id,
case TRUE
    when count_product < 100 then 'Маленький заказ'
    when count_product >= 100 and count_product <= 300 then 'Средний заказ'
    else 'Большой заказ'
end as order_size
from sales;

    #Создайте таблицу “orders”, заполните ее значениями. Покажите “полный” статус заказа, используя оператор CASE
create table if not exists orders(
id int primary key not null,
employee_id varchar(45),
amount float,
order_status varchar(45)
); 

insert into orders (id, employee_id, amount, order_status) values
(1, "e03", 15.00, "OPEN"),
(2, "e01", 25.50, "OPEN"),
(3, "e05", 100.70, "CLOSED"),
(4, "e02", 22.18, "OPEN"),
(5, "e04", 9.50, "CANCELLED");

select id,
case True
	when order_status = "OPEN" then "Order is in open state"
    when order_status = "CLOSED" then "Order is closed"
    when order_status = "CANCELLED" then "Order is cancelled"
end as full_order_status
from orders;

    #Чем NULL отличается от 0?
# Null - ничего (пустая ячейка), 0 - уже какое-либо значение (не пустая ячейка)
