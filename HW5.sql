#1. Создайте представление, в которое попадет информация о пользователях (имя, фамилия,
#город и пол), которые не старше 20 лет.
  
create view users20 as select b.firstname, b.lastname, a.hometown, a.gender 
from profiles a 
join users b on a.user_id = b.id 
where year(current_date()) - year(a.birthday) <= 20;

#2. Найдите кол-во, отправленных сообщений каждым пользователем и выведите
#ранжированный список пользователей, указав имя и фамилию пользователя, количество
#отправленных сообщений и место в рейтинге (первое место у пользователя с максимальным
#количеством сообщений) . (используйте DENSE_RANK)

create view ranked_mess as select b.firstname, b.lastname, count(a.from_user_id) as count_mess 
from messages a join users b on a.from_user_id = b.id group by a.from_user_id order by count_mess desc;

select *, dense_rank() over (order by count_mess desc) as dense from ranked_mess;

#3. Выберите все сообщения, отсортируйте сообщения по возрастанию даты отправления
#(created_at) и найдите разницу дат отправления между соседними сообщениями, получившегося
#списка. (используйте LEAD или LAG)

select *, 
lead(created_at, 1, 0) over (partition by timestampdiff(second, created_at, created_at)) as lead_at,
lag(created_at,1,0) over (partition by timestampdiff(second, created_at,created_at)) as lag_at from messages 
order by timestampdiff(second, created_at, now()) desc;
