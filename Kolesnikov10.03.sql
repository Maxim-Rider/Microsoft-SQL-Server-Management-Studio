-- 10/09/2021
-- Автор: Максим Колесников
-- Тема 7. SQL - Subquery (подчинённые запросы)
-- Оператор IN, операторы ANY и ALL, функция EXISTS

use sample_primer
select * from department
select * from employee

--1
select * from employee
where dept_no = 
	(select dept_no
	from department
	where dept_name = 'Research');

--2
select * from employee
where dept_no IN
	(select dept_no
	from department
	where location = 'Dallas');

--3
select * from employee
where emp_no in 
	(select emp_no	from works_on
	where project_no =
		(select project_no from project
		where project_name = 'Apollo'));

--4
select * from works_on
where enter_date > ANY
(select enter_date from works_on)
--select * from works_on
order by enter_date;