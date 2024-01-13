-- HW5
-- 1.	Используя запрос, установи нашу базу данных как БД по умолчанию.
use testdb;
-- 2.	Используя запрос, посмотри какие таблицы содержит БД testdb.
show tables;
-- 3.	Отобразите данные таблицы department;
select * from department;
-- 4.	Ситуация:
-- Наша компания активно растет и теперь у нас в структуре появляется 2 отдела: отдел сопровождения и отдел планирования и продаж. Добавьте в таблицу новые отделы следующими по списку. Описание отделов придумайте самостоятельно.
INSERT INTO department (department, description_dep)
VALUES ('Отдел сопровождения', 'Мониторинг реализованных сделок'), ('Отдел планирования и продаж', 'Составление планов и их реализация');
-- 5.	Ситуация:
-- В компании поменялась «штатка». От отдела кадров поступил запрос на изменение описания отдела аналитики и наименования подразделения администрация. Необходимо изменить описание на: системный и бизнес анализ, название на: проектный офис.
UPDATE department SET department = 'Проектный офис' where id = 2;
UPDATE department SET description_dep = 'Системный и бизнес-анализ' where id = 4;
-- 6.	Покажите описание отдела тестирования.
select description_dep from department where department = 'Отдел тестирования';
select description_dep from department where id = 3;
-- 7.	А теперь представьте, что ID отделов Вы не видите. Попробуйте найти описание отдела тестирования еще раз. Используйте оператор like.
select description_dep from department where department like '%тестировани%';
-- 8.	Отобразите данные всех сотрудников.
select * from employee;
-- 9.	 На совещании руководителей и заместителей ИТ-компании решили оптимизировать количество отделов в компании. Отдел «проектный офис» решили упразднить распределив всех руководителей подразделений в соответствующие отделы, сохранив при этом им должности. Внесите соответствующие изменения в таблицы. 
-- Важно: id отделов в таблице department не изменять.
UPDATE employee SET department = 1 where position = 'Руководитель разработки';
UPDATE employee SET department = 4 where position = 'Руководитель аналитики';
DELETE FROM department where id = 2;
-- 10.	Посчитайте количество сотрудников отдела разработки.
select count(*) as 'Штат отдела разработки' from employee where department = 1;
-- 11.	В компанию взяли 2 новеньких сотрудников в отдел сопровождения на должности инженер сопровождения. ФИО: Матрешкин Олег Геннадьевич и Широкова Мария Валерьевна. Обогатите данными соответствующую таблицу. 
INSERT INTO employee (LastName, FirstName, MiddleName, Position, department)
values ('Матрешкин', 'Олег', 'Геннадьевич', 'Инженер сопровождения', 5), ('Широкова', 'Мария', 'Валерьевна', 'Инженер сопровождения', 5);
-- P.S. При добавлении данных, не указывайте и не вставляйте данные в столбец ServiceId.

-- 12.	Сотрудники Алексеев Алексей с должностью аналитик и Исаев Илья уволились. Внесите изменения в таблицу используя один запрос.
DELETE FROM employee where ServiceId in (12, 3);
-- 13.	 Покажите количество сотрудников в каждом отделе. Используйте данные из одной таблицы employee.
select department, count(*) from employee group by department;
-- 14.	Покажите ФИО сотрудников и наименования отделов, в которых они работают. (Решить с помощью JOIN).
select LastName, FirstName, MiddleName, department.department from employee join department on department.id = employee.department;
-- 15.	Покажите отделы, в которых количество сотрудников больше 2. (Решить с помощью JOIN).
select department.department, count(ServiceID) from department join employee on department.id = employee.department group by department having count(ServiceID) > 2 ;
-- 16.	Выполните левостороннее соединение двух таблиц. Выполните правостороннее соединение двух таблиц. Объясните разницу между 2мя запросами.
select * from department left join employee on department.id = employee.department;
select * from department right join employee on department.id = employee.department;
-- В случае с left join в выдаче на одну строку больше, так как учтены все строки, находящиеся в таблице Department. Так как в 6-ом отделе сотрудников нет, то запрос с right join 13-ую строку не отображает
-- 17.	Покажите отделы, должности и количество работников в каждом отделе, у которых руководящая должность. (Решить с помощью JOIN).
select department.department, position, count(ServiceID) as 'Количество работников в должности'
from employee 
join department on department.id = employee.department
group by employee.department, position having department in (1, 4);
select department.department, position, count(ServiceID) as 'Количество работников в должности'
from employee 
join department on department.id = employee.department
group by employee.department, position having count(ServiceID);
select department.department, position, count(ServiceID) as 'Количество работников в должности'
from employee 
join department on department.id = employee.department
group by employee.department, position having department in (1, 4);
select department.department, count(ServiceID) as 'Количество работников в должности'
from employee
join department on department.id = employee.department
group by employee.department having department in (1, 4);
select department.department, position, (select * from employee group by department)
from employee 
join department on department.id = employee.department
group by employee.department, position having position like '%руководитель%';
select department.department, position, count(ServiceID) as 'Количество работников в должности'
from employee 
join department on department.id = employee.department
group by employee.department, position having position like '%руководитель%'; 
-- 18.	У нас в отделе тестирования хорошие новости! Алёна стала руководителем тестирования и обещала устроить пир. Прежде чем ты отправишься праздновать,  нужно внести изменения в БД. Сделай это)
UPDATE employee SET position = 'Руководитель отдела тестирования' where ServiceId = 7;
-- 19.	Выполни еще раз запрос № 17 и запиши в комментарии общее количество руководителей.
select department.department, position, (select department, count(*) from employee group by department)
from employee 
join department on department.id = employee.department
group by employee.department, position having department in (1, 3, 4);
-- Количество руководителей: 3