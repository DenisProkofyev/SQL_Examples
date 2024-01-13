-- 1.	Покажите содержимое таблицы исполнителей (артистов)
select * from chinook.artist;

-- 2.	Покажите фамилии и имена клиентов из города Лондон
select FirstName, LastName from chinook.customer where City = 'London';

-- 3.	Покажите продажи за 2012 год, со стоимостью продаж более 4 долларов
select * from chinook.invoice where InvoiceDate > '2011-12-31' and Total > 4;

-- 4.	Покажите дату продажи, адрес продажи, город в которую совершена продажа и стоимость покупки не равную 17.91. Присвоить названия столбцам InvoiceDate – ДатаПродажи, BillingAddress – АдресПродажи и BillingCity - ГородПродажи
select InvoiceDate as ДатаПродажи, BillingAddress as АдресПродажи, BillingCity as ГородПродажи, Total from chinook.invoice where Total <> '17.91';

-- 5.	Покажите фамилии и имена сотрудников компании, нанятых в 2003 году из города Калгари
select LastName, FirstName from chinook.employee where HireDate between '2003-01-01' and '2003-12-31' and City = 'Calgary';

-- 6.	Покажите канадские города, в которые были сделаны продажи в августе?
select * from chinook.invoice where BillingCountry = 'Canada' and InvoiceDate like '%-08-%';

-- 7.	Покажите Фамилии и имена работников, нанятых в октябре?
select LastName, FirstName from chinook.employee where HireDate like '%-10-%';

-- 8.	Покажите фамилии и имена сотрудников, занимающих должность менеджера по продажам и ИТ менеджера. Решите задание двумя способами: 
-- 1)	используя оператор IN
select LastName, FirstName from chinook.employee where Title in ('Sales Manager', 'IT Manager');
-- 2)	используя логические операции
select LastName, FirstName from chinook.employee where Title = 'Sales Manager' or Title = 'IT Manager';