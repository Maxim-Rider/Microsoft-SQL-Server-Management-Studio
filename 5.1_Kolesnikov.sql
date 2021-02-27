USE sample_primer

--Упражнение 5.1
-- Выполните выборку всех строк из таблицы works_on.
select * from works_on

-- Упражнение 5.2
--Выполните выборку табельных номеров всех сотрудников с должностью клерк
--(clerk).select emp_no from works_onwhere job = 'Clerk'--Упражнение 5.3
--Выполните выборку табельных номеров всех сотрудников, которые работают над
--проектом p2 и чей табельный номер меньше, чем 10 000.select emp_no from works_onwhere project_no = 'p2' and emp_no <= 10000--Упражнение 5.4
--Выполните выборку табельных номеров всех сотрудников, которые не приступили к
--работе над проектом в 2007 г.
--Решите эту задачу, используя два различных, но эквивалентных запроса с
--(подсказка - BETWEEN).select emp_no, enter_date from works_onwhere YEAR(enter_date) != 2007--Упражнение 5.5
--Выполните выборку табельных номеров всех сотрудников проекта p1 с ведущими
--должностями (т. е. аналитик — analyst и менеджер — manager).select emp_no, job from works_onwhere project_no = 'p1' and job in ('analysist','manager')--Упражнение 5.6
--Выполните выборку всех сотрудников проекта p2, чья должность еще не определенаselect emp_no, project_no, job from works_onwhere project_no = 'p2' and job is null--Упражнение 5.7--Выполните выборку табельных номеров и фамилий сотрудников, чьи имена содержат
--две буквы tselect emp_no, emp_fname, emp_lname from  employeewhere emp_fname like '%[tt]%'--Упражнение 5.8
--Выполните выборку табельных номеров и имен всех сотрудников, у которых вторая
--буква фамилии o или a (буквы английские) и последние буквы фамилии es.
select emp_no, emp_fname, emp_lname from employee
WHERE emp_lname LIKE '_[oa]%es'

--Упражнение 5.9
--Выполните выборку проектов, чьи бюджеты меньше 100000 или больше 300000 .
--Решите эту задачу, используя два различных, но эквивалентных запроса 
select project_name, budget from project
where budget < 100000 or budget > 300000

--Упражнение 5.10
--Выполните выборку фамилий и имен сотрудников, у которых ни в фамилии, ни в имени
--не встречается ни буква x ни буква y
select emp_fname, emp_lname from employee
WHERE emp_lname NOT LIKE '_[xy]%' and emp_fname NOT LIKE '_[xy]%' 
