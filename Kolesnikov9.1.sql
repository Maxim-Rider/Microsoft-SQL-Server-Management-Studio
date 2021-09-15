--ТЕМА 9. SQL - INSERT, UPDATE, DELETE
--Модифицирование содержимого таблиц (Инструкции INSERT, UPDATE, DELETE)
--Дата: 31.03.2021
--Автор: Максим Колесников

use sample_primer

select * from employee
--1 создание строки
insert into employee values (15300, 'Kiro', 'Aro', null, null)

insert into employee (emp_no, emp_fname, emp_lname) values (15320, 'Irina', 'Novikova')

--2 создание таблицы
create table dallas_dept (dept_no char(4) not null, dept_name char(20) not null)

select * from dallas_dept

--3 заполнение созданной таблицы
insert into dallas_dept (dept_no, dept_name)
select dept_no, dept_name from department
where location = 'Dallas'

--4 перенос данных из другой базы (+ сразу создание таблицы)
select top 10 CustomerID, CompanyName, City 
into customers
from WholeSale.dbo.Customers

select * from customers

--5 редактирование данных
update works_on
set job = 'Manager'
where emp_no = 18316
and project_no = 'p2'

select * from works_on

--6 при помощи подчинённого запроса
update works_on
set job = null
where emp_no in
	(select emp_no from employee
	where emp_lname = 'Jones')

select * from employee

--7 при помощи case
update project
set budget = case
	when budget >0 and budget < 100000 then budget*1.2
	when budget >=100000 and budget < 200000 then budget*1.1
    else budget*1.05
end



/*Упражнение 9.1
Вставьте данные для новой сотрудницы (имя, фамилию, табельный номер
предложите сами). Она еще не назначена в какой-либо отдел.*/
select * from employee
insert into employee values (30001, 'Ekaterina', 'Frantseva', null, null)

/*Упражнение 9.2
Создайте новую таблицу и загрузите в нее из таблицы employee всех сотрудников,
работающих в отделах d1, d2. Создайте два разных, но равнозначных решения.
(Create, Insert Into | Select Into)*/
create table employee_d1_d2 (emp_no char(6) not null, emp_fname char(20) not null, emp_lname char(20) not null, dept_no char(4) not null, salary money not null)
insert into employee_d1_d2 (emp_no, emp_fname, emp_lname, dept_no, salary)
select emp_no, emp_fname, emp_lname, dept_no, salary from employee
where dept_no = 'd1' or dept_no = 'd2'

select * from employee_d1_d2

/*Упражнение 9.3
Создайте новую таблицу для сотрудников, которые приступили к работе над
своими проектами в 2008 г., и загрузите в нее соответствующие строки из
таблицы employee.
Предложите два разных, но равнозначных решения. (Create, Insert Into |Select
Into)*/
create table employee_2008_works_on (emp_no char(6) not null, emp_fname char(20) not null, emp_lname char(20) not null, dept_no char(4) not null, salary money not null)
insert into employee_2008_works_on (emp_no, emp_fname, emp_lname, dept_no, salary)
select employee.emp_no, emp_fname, emp_lname, dept_no, salary from employee
join works_on on employee.emp_no = works_on.emp_no
where year(enter_date) = '2008'

---
select * from employee_2008_works_on
select * from works_on
---
delete from employee_2008_works_on
---

/*Упражнение 9.4
Измените должности всех менеджеров (Manager) в проекте p1 на новую
(должность предложите сами).*/
update works_on
set job = 'Game Designer'
where job = 'Manager'
or project_no = 'p1'

select * from works_on

/*Упражнение 9.5
Предложите запрос для изменения значения бюджетов проектов p3 и p1 на
значение NULL. (Запрос не выполняйте)*/

update project 
set budget = null
where project_no in
	(select project_no from works_on
	where project_no = 'p1' or project_no = 'p3');

/*Упражнение 9.6
Измените должность сотрудника с табельным номером 28559 на менеджера
(Manager) для всех его проектов*/
select * from works_on

update works_on
set job = 'Manager'
where emp_no in
	(select emp_no from works_on
	where emp_no = 28559);

/*Упражнение 9.7
Повысьте на 10% бюджет проекта, менеджер которого имеет табельный номер
10102.*/
update project
set budget = budget * 1.1
where project_no in
	(select project_no from works_on
	where emp_no = 10102)

select * from project

/*Упражнение 9.8
Измените наименование отдела, в котором работает сотрудник по фамилии
James, на название Sales.*/
update department
set dept_name = 'Sales'
where dept_no in
	(select dept_no from employee
	where emp_fname = 'James')

select * from department

/*Упражнение 9.9
Измените дату начала работы над проектом для сотрудников, которые работают
над проектом p1 и числятся в отделе Sales на 12 декабря 2009 г.*/
update works_on
set enter_date = '2009-12-12'
where enter_date in
	(select enter_date from employee 
	where project_no = 'p1' or dept_no = 'Sales');

/*Упражнение 9.10
Предложите запрос для удаления всех отделов, расположенные в Сиэтле
(Seattle).
(Запрос не выполняйте)*/

delete from department
where location = 'Dallas'

/*Упражнение 9.11
Предложите запросы. Проект p3 выполнен. Удалите всю информацию об этом
проекте из базы данных. (Запрос не выполняйте)*/

delete from project
where project_no = 'p3'

/*Упражнение 9.12
Предложите запрос. Удалите всю информацию из таблицы works_on для всех
сотрудников, которые работают в отделах, расположенных в Далласе (Dallas).
(Запрос не выполняйте)*/

delete from works_on inner join employee 
on works_on.emp_no = employee.emp_no inner join department 
on department.dept_no = employee.dept_no
where location = 'Dallas'

-- (проверка кода без delete)
select * from works_on inner join employee 
on works_on.emp_no = employee.emp_no inner join department 
on department.dept_no = employee.dept_no
where location = 'Dallas'

