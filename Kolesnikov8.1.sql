--18/03/2021
--Автор работы: Максим Колесников
--Тема: операторы соединения.

use sample_primer

--1 (естественное произведение)
select *
from department inner join employee on
department.dept_no = employee.dept_no

--2 old style (декартовое произведение)
select *
from department, employee
where department.dept_no = employee.dept_no

--3
select *, project.project_no
from works_on inner join project on
works_on.project_no = project.project_no
where project_name = 'Gemini'

--4
select *
from works_on join employee on
works_on.emp_no = employee.emp_no
join department on employee.dept_no=department.dept_no
and location = 'Seattle'
and job = 'analyst'

--5
select employee_enh.*, location
from employee_enh join department
on domicile = location

--5.1
select employee_enh.*, location
from employee_enh left join department
on domicile = location

--6 (teta connection)
select emp_fname, emp_lname, domicile, location
from employee_enh join department
on domicile < location

--7
select t1.dept_no, t1.dept_name, t1.location
from department t1 join department t2
on t1.location = t2.location
where t1.dept_no <> t2.dept_no;


--Упражнение 8.1
--Создайте следующие соединения таблиц project и works_on, выполнив:
--• естественное соединение;
select *
from project inner join works_on on
project.project_no = works_on.project_no

--• декартово произведение.
select *
from project, works_on
where project.project_no = works_on.project_no

--Упражнение 8.2
--Сколько условий соединения необходимо для соединения в запросе n таблиц?

--Может быть сколько угодно условий.

--Упражнение 8.3
--Выполните выборку табельного номера сотрудника и должности для всех сотрудников,
--работающих над проектом Gemini.
select emp_no, job, project.project_name
from works_on inner join project on
works_on.project_no = project.project_no
where project_name = 'Gemini'

--Упражнение 8.4
--Выполните выборку имен и фамилий всех сотрудников, работающих в отделе
--Research или Accounting.
select emp_fname, emp_lname, dept_name
from department join employee on 
department.dept_no = employee.dept_no
where dept_name in ('Research', 'Accounting') 

--Упражнение 8.5
--Выполните выборку всех дат начала работы для всех клерков (clerk), работающих в
--отделе d1.
select enter_date, dept_no, job
from employee e join works_on w on
e.emp_no = w.emp_no
where job = 'clerk' AND dept_no = 'd1'

--Упражнение 8.6
--Выполните выборку всех проектов (с полной информацией о проектах), над которыми
--работают двое или больше сотрудников с должностью клерк (clerk).
select p.project_no, project_name, budget, count(*) as 'clerks'
from project p JOIN works_on w
on p.project_no = w.project_no
where job = 'clerk'
group by w.job, p.project_no, project_name, budget
having count(*) >= 2

--Упражнение 8.7
--Выполните выборку имен и фамилий сотрудников, которые имеют должность менеджер
--(manager) и работают над проектом Mercury.
select emp_fname, emp_lname
from employee
where emp_no in (
	select emp_no
	from works_on w join project p
	on w.project_no = p.project_no
	where job = 'manager'
	and p.project_name = 'Mercury');

--Упражнение 8.8
--Выполните выборку имен и фамилий всех сотрудников, которые начали работать над
--проектом одновременно, по крайней мере, еще с одним другим сотрудником.
select emp_fname, emp_lname, enter_date
from works_on w join employee e on 
w.emp_no = e.emp_no
group by enter_date, emp_fname, emp_lname, enter_date
having count(*) > 1

--Упражнение 8.9
--Выполните выборку табельных номеров сотрудников, которые живут в том же городе, где
--находится их отдел. (Используйте расширенную таблицу employee_ enh базы данных sample.)
select emp_no
from employee_enh
where emp_no in (
	select emp_no
	from employee_enh e join department d
	on e.emp_no = d.location
	group by e.emp_no);
	--в разработке 

	--where emp_no = d.location);


--Упражнение 8.10
--Выполните выборку всех сотрудников (с полной информацией), работающих в отделе
--маркетинга Marketing и участвующих в разработке проекта Apollo. Создайте два равнозначных
--запроса, используя:
--• оператор соединения;
select *
from department d join employee e
on d.dept_no = e.dept_no
where d.dept_name = 'marketing';
--• связанный подзапрос.
select *
from employee 
where dept_no in (
	select dept_no 
	from department
	where dept_name = 'marketing');
