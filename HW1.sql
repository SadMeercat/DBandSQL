#Выведите название, производителя и цену для товаров, количество которых превышает 2
SELECT Manufacturer, Model, Price FROM gbhomeworks.phones where Count > 2;

#Выведите весь ассортимент товаров марки “Samsung”
SELECT * From gbhomeworks.phones where Manufacturer = "Samsung";
