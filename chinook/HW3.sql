-- 1.	Покажите длительность самой длинной песни. Столбец назвать sec.
select name, Milliseconds/1000 as sec from chinook.track order by Milliseconds desc limit 1;
-- 2.	Покажите название и длительность в секундах самой длинной песни применив округление по правилам математики. Столбец назвать sec.
select name, round(Milliseconds/1000) as sec from chinook.track order by Milliseconds desc limit 1;
-- 3.	Покажите все счёт-фактуры, стоимость которых ниже средней.
select * from chinook.invoice where total < (select avg(Total) from chinook.invoice) order by Total desc;
-- 4.	Покажите счёт-фактуру с высокой стоимостью.
select * from chinook.invoice order by Total desc limit 1;
-- 5.	Покажите города, в которых живут и сотрудники, и клиенты (используйте пример с урока № 4).
-- select distinct chinook.customer.city, chinook.employee.city from chinook.customer, chinook.employee;
select city from chinook.employee where city in (select city from chinook.customer);
-- 6.	Покажите имя, фамилию покупателя (номер 16), компанию и общую сумму его заказов. Столбец назовите sum.
select FirstName, LastName, Company, (select sum(Total) from chinook.invoice where CustomerId = chinook.customer.CustomerId) as sum from chinook.customer where CustomerID = 16;
-- select sum(Total) from chinook.invoice where CustomerId = 16;
-- Extra
-- 7.	Покажите, сколько раз покупали треки группы Queen.  Количество покупок необходимо посчитать по каждому треку. Вывести название, ИД трека и количество купленных треков группы Queen. Столбец назовите total.
select * from chinook.artist order by name desc;
select * from chinook.album where ArtistId = 51;
select * from chinook.track where AlbumId in(36, 185, 186);
-- select TrackId, Name, (select count(TrackId) from chinook.invoiceline where (TrackId between 419 and 435) or (TrackId between 2254 and 2281)) as Total from chinook.track where (TrackId between 419 and 435) or (TrackId between 2254 and 2281) group by TrackId;
select TrackId, Name, (select count(TrackId) from chinook.invoiceline where TrackId = chinook.track.TrackId) as Total from chinook.track where (TrackId between 419 and 435) or (TrackId between 2254 and 2281);
-- select sum(Quantity) from chinook.invoiceline where TrackId between 419 and 435;
-- 8.	Посчитайте количество треков в каждом альбоме. В результате вывести имя альбома и кол-во треков.
select Title, (select count(TrackId) from chinook.track where chinook.track.AlbumId = chinook.album.AlbumId) as Quantity from chinook.album;