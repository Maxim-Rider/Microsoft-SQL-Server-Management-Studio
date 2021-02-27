USE sample_primer
--Упражнение 6.11 --Сгруппируйте все отделы по их местонахождению. 
select location, COUNT(location) AS QuantityDepartments from department
group by location

--Упражнение 6.12. Объясните разницу между предложениями DISTINCT и GROUP BY.

-- Distinct исключает повторения, Group by исключает повторения и сортирует список.

--Упражнение 6.13 Как предложение GROUP BY обрабатывает значения NULL? Подобна ли эта обработка
--обычной обработке этих значений?

--Null значения столбца группируются в отдельную группу. Если столбец группировки содержит null значения, то все null значений считаются равными и помещаются в одну группу.
-
--Упражнение 6.14 Объясните разницу между агрегатными функциями COUNT(*) и COUNT(column).

--COUNT(expression) - ожидает аргумент (столбец/выражеие) и показывает все не NULL вхождения аргумента COUNT(*) - сичтает все строки (не важно NULL или нет).

--Упражнение 6.15 Выполните выборку наибольшего табельного номера сотрудника.
SELECT MAX(emp_no) as emp_no FROM employee

--Упражнение 6.16 (a, b, c)
--a. Сколько сотрудников работает в каждом отделе
select dept_no, count(dept_no) as QuantityEmployees from employee
group by dept_no
--b. Сколько сотрудников работает над каждым проектом
select project_no, count(emp_no) as QuantityEmployees from works_on
group by project_no
--c. Сколько задач выполнил каждый из сотрудников
select job, count(job) as QuantityJobs from works_on
where job is not null
group by job


--Упражнение 6.17 Выполните выборку должностей, занимаемых больше, чем двумя сотрудниками.
SELECT job FROM works_on
WHERE job IS NOT NULL
GROUP BY job
HAVING COUNT(*) > 2