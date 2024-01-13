-- 1.	Покажите все данные заказов покупателя (номер 13) и отсортируйте стоимость по возрастанию.
select * from chinook.invoice inner join chinook.customer on invoice.CustomerId = customer.CustomerId where invoice.CustomerId = 13 order by Total;
-- 2.	Посчитайте количество треков в каждом альбоме. В результате вывести ID альбома, имя альбома и кол-во треков. 
select chinook.album.AlbumID, Title, count(TrackId) as 'Количество треков' 
from chinook.album left join chinook.track on album.AlbumId = track.AlbumId group by AlbumId;
-- 3.	Покажите имя, фамилию, кол-во и стоимость покупок по каждому клиенту. Столбцы кол-во назвать quantity, стоимость - sum.
select FirstName, LastName, count(InvoiceId) as 'Quantity', sum(Total) as 'Sum' from chinook.customer join chinook.invoice on chinook.customer.CustomerId = chinook.invoice.CustomerId group by chinook.customer.CustomerId;
-- select FirstName, LastName, count(InvoiceId) as 'Quantity', sum(Total) as 'Sum' from chinook.customer join chinook.invoice on chinook.customer.CustomerId = chinook.invoice.CustomerId group by FirstName; 56 результатов - 3 съедаются из-за совпадения имён
-- 4.	Посчитайте общую сумму продаж в США в 1 квартале 2012 года. Присвойте любой псевдоним столбцу.
select BillingCountry, sum(Total) as 'Sold' from chinook.invoice where BillingCountry = 'USA' and InvoiceDate between date('2012-01-01') and date('2012-03-31');
-- 5.	Выполните запросы по очереди и ответьте на вопросы:
-- Вернут ли данные запросы одинаковый результат?  Ответы: Да или НЕТ. 
-- 1)	Если ДА. Объяснить почему.
-- 2)	Если НЕТ. Объяснить почему. Нет, так как второй запрос включает в себя вывод и тех сотрудников, которые не сопровождают клиентов
-- 3)	Какой запрос вернет больше строк? Второй

select * from chinook.customer left JOIN chinook.employee
ON chinook.customer.SupportRepId = chinook.employee.employeeId;

select * from chinook.customer right JOIN chinook.employee
ON chinook.customer.SupportRepId = chinook.employee.employeeId;

-- 6.	Выполните запросы по очереди и ответьте на вопросы:
-- Вернут ли данные запросы одинаковый результат? Ответы: Да или НЕТ. 
-- 1)	Если ДА. Объяснить почему.
-- 2)	Если НЕТ. Объяснить почему. Нет, так как первый подразумевает фильтрацию - вопрос выведёт строки, когда у закреплённого за клиентом сотрудника не будет имени. 
-- Во втором же запросе фильтрация не производится, несмотря на отсутствие совпадений
-- 3)	Какой запрос вернет больше строк ? Второй

select * from chinook.customer LEFT JOIN chinook.employee
ON chinook.customer.SupportRepId = chinook.employee.employeeId
where chinook.employee.FirstName is null;

select * from chinook.customer LEFT JOIN chinook.employee
ON chinook.customer.SupportRepId = chinook.employee.employeeId
and chinook.employee.FirstName is null;

-- 7.	Покажите количество и среднюю стоимость треков в каждом жанре. Вывести ID жанра, название жанра, количество и среднюю стоимость.
select chinook.genre.genreID, chinook.genre.Name, count(TrackId) as 'Количество песен жанра', round(avg(UnitPrice), 2) as 'Средняя стоимость' 
from chinook.genre left join chinook.track on chinook.genre.genreID = chinook.track.genreId group by chinook.genre.Name;
-- 8.	Покажите клиента, который потратил больше всего денег. Для сокращения количества символов в запросе, используйте псевдонимы. Для ограничения количества записей используйте оператор "limit".
-- select FirstName, LastName, sum(chinook.invoice.Total)  from chinook.customer left join chinook.invoice on chinook.customer.CustomerId = chinook.invoice.CustomerId group by chinook.customer.CustomerId limit 1;
select FirstName, LastName, sum(chinook.invoice.Total) as Sum
from chinook.customer 
join chinook.invoice on chinook.customer.CustomerId = chinook.invoice.CustomerId 
group by chinook.customer.CustomerId order by sum desc limit 1;
-- в группировку надёжнее добавлять все столбцы после Select
-- Сначала программа идёт в from, затем в join, потом - столбцы из Select. Полезно в контексте расставления alias для таблиц во 2-3 строках

select CustomerId, sum(TOtal) from chinook.invoice group by CustomerId; 
-- Extra (используется соединение 3х таблиц)
-- 9.  Покажите список названий альбомов, ID альбомов, количество треков и общую цену альбомов для исполнителя Audioslave.
select ArtistID from chinook.artist where Name = 'Audioslave';
select chinook.album.Title, chinook.album.AlbumId, count(chinook.track.TrackId) as 'Песен в альбоме', sum(chinook.track.UnitPrice) as 'Стоимость' from chinook.album
-- join chinook.track
-- on chinook.album.AlbumId = chinook.track.AlbumId
join chinook.artist on chinook.album.ArtistId = chinook.artist.ArtistId 
-- where chinook.artist.ArtistId = 8
join chinook.track on chinook.track.AlbumId = chinook.album.AlbumId
where chinook.artist.ArtistId = 8 group by Title;
select ar.Name, al.Title, t.albumId, count(t.TrackId) as 'Песен в альбоме', sum(t.UnitPrice) from chinook.album al
join chinook.artist ar on al.ArtistId = ar.ArtistId
join chinook.track t on t.AlbumId = al.AlbumId
where ar.Name = 'Audioslave' group by ar.Name, al.Title, AlbumId
