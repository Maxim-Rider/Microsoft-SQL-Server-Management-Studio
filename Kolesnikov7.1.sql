use sample_primer

select dept_no, count(emp_no) as emp_count from employee
group by dept_no

--Упражнение 6.18
--a) В каких отделах максимальное количество сотрудников

select top 1 dept_no, count(emp_no) as emp_count from employee 
group by dept_no
order by count(emp_no) desc



--b) В каких отделах минимальное количество сотрудников
select top 2 dept_no, count(emp_no) as emp_count from employee 
group by dept_no
order by count(emp_no) asc

--Упражнение 6.19
--В каких городах находятся отделы с минимальным количеством сотрудников
select top 2 location, dept_no from department
group by location, dept_no
order by location asc


--Упражнение 6.20
--Получите полную информацию о сотрудниках, чьи отделы расположены:
--a) в Сиэтле (Seattle)
select * from employee
where dept_no IN
	(select dept_no
	from department
	where location = 'Seattle');

--b) в Далласе (Dallas)
select * from employee
where dept_no IN
	(select dept_no
	from department
	where location = 'Dallas');

--Упражнение 6.21
--Выполните выборку фамилий и имен сотрудников, которые приступили к работе над
--проектами:
--a) 4 января 2007г.
select emp_fname, emp_lname, enter_date from employee, works_on
where enter_date = '2007-01-04'

--b) в январе или феврале 2008г.
select emp_fname, emp_lname, enter_date from employee, works_on
where year(enter_date) = '2008' 
and 
month(enter_date) = '01' or month(enter_date)= '02'

--Упражнение 6.22
--Получите полную информацию о сотрудниках, которые или имели должность клерк (clerk),
--или работают в отделе d3.

select * from employee
where emp_no IN
	(select emp_no from works_on
	where job = 'Clerk' or dept_no = 'd3')



--Упражнение 6.23
--Объясните, почему следующий запрос неправильный.
--a) Исправьте синтаксис запроса
--b) Сформулируйте текст для нижеследующего запроса


--Выбрать названия проектов, над которым работают сотрудники с должностью Clerk
SELECT project_name
FROM project
WHERE project_no in
(SELECT project_no FROM works_on WHERE Job = 'Clerk')