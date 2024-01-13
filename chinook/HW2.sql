-- 1.	Покажите фамилии и имя клиентов, у которых имя Mарк.
select LastName, FirstName from chinook.customer where FirstName = 'Mark';

-- 2.	Покажите название и размер треков в Мегабайтах, применив округление до 2 знаков и отсортировав по убыванию. Столбец назовите MB.
select name, round(bytes/1024/1024, 2) as MB from chinook.track order by bytes desc;

-- 3.	Покажите возраст сотрудников, на момент оформления на работу. Вывести фамилию, имя, возраст. дату оформления и день рождения. Столбец назовите age.
select LastName, FirstName, floor(datediff(HireDate, BirthDate)/365) as Age, date(HireDate), date(BirthDate) from chinook.employee;
-- select LastName, FirstName, timestampdiff(Year, BirthDate, HireDate) as Age, date(HireDate), date(BirthDate) from chinook.employee;

-- 4.	Покажите покупателей-американцев без факса.
select LastName, FirstName, Country, Fax from chinook.customer where Country = 'USA' and Fax is NULL;

-- 5.	Покажите почтовые адреса клиентов из домена gmail.com.
select LastName, FirstName, Email from chinook.customer where email like "%gmail.com";

-- 6.	Покажите в алфавитном порядке все уникальные должности в компании.
select distinct Title from chinook.employee;

-- 7.	Покажите самую короткую песню.
select `Name`, Milliseconds from chinook.track order by Milliseconds limit 1;
-- select `Name`, min(Milliseconds) from chinook.track;

-- 8.	Покажите название и длительность в секундах самой короткой песни. Столбец назвать sec.
select `Name`, Milliseconds/1000 as sec from chinook.track order by Milliseconds limit 1;

-- 9.	Покажите средний возраст сотрудников, работающих в компании.
select floor((avg(datediff(CURDATE(), Birthdate))/365)) as AvgAge from chinook.employee;
-- select floor((avg(timestampdiff(Year, Birthdate, Now())))) as AvgAge from chinook.employee;
-- 10.	Проведите аналитическую работу: узнайте фамилию, имя и компанию покупателя (номер 5). Сколько заказов он сделал и на какую сумму. Покажите 2 запроса Вашей работы.
select LastName, FirstName, Company from chinook.customer where CustomerId = '5';

select CustomerId, count(Total), sum(Total) from chinook.invoice where CustomerID = '5';
-- select LastName, FirstName, Company, chinook.invoice.CustomerId, count(Total), sum(Total) from chinook.invoice 
-- left join chinook.customer on customer.CustomerID = invoice.CustomerID where invoice.CustomerID = '5';

-- 11.	Напишите запрос, определяющий количество треков, где ID плейлиста > 15.
-- Назовите столбцы соответственно их расположения. 
select PlaylistId as `CONDITION`, count(TrackID) as RESULT from chinook.playlisttrack group by PlaylistId having PlaylistId > 15;
-- select PlaylistId as `CONDITION`, count(TrackID) as RESULT from chinook.playlisttrack where PlaylistId > 15 group by PlaylistId;

-- 12.	Найти все ID счет-фактур, в которых количество треков больше или равно 6 и меньше или равно 9
select * from chinook.invoiceline;
select InvoiceId, sum(Quantity) from chinook.invoiceline group by InvoiceId having count(InvoiceID) >= 6 and count(InvoiceID) <= 9;
-- select InvoiceId, sum(Quantity) from chinook.invoiceline group by InvoiceId having sum(Quantity) >= 6 and sum(Quantity) <= 9;