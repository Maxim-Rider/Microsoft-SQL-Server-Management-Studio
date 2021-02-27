USE sample_primer;
SELECT dept_no, dept_name
FROM department;

SELECT * 
from department;

SELECT DISTINCT location
FROM department;

SELECT dept_name, dept_no
FROM department
WHERE location = 'Dallas';

SELECT emp_lname, emp_fname
FROM employee
WHERE emp_no >= 15000;

SELECT * FROM project
WHERE project_name = 'Gemini';

SELECT * FROM works_on
WHERE emp_no = 10102;

SELECT * FROM works_on
WHERE enter_date = '2007-10-15' --ÝÒÎ ÏÐÀÂÈËÜÍÛÉ ÔÎÐÌÀÒ
--WHERE enter_date = '2007/10/15' --ÝÒÎ ÏÐÀÂÈËÜÍÛÉ ÔÎÐÌÀÒ
--WHERE enter_date = '2007.10/15' --ÝÒÎ ÍÅÏÐÀÂÈËÜÍÛÉ ÔÎÐÌÀÒ
--WHERE enter_date = '10-15-2007' --ÝÒÎ ÍÅÏÐÀÂÈËÜÍÛÉ ÔÎÐÌÀÒ

select *, YEAR(enter_date) as year_enter from works_on

select *, YEAR(enter_date) as year_enter 
from works_on
where YEAR(enter_date) = 2006

select project_name
from project
where budget*0.51 > 60000;

select project_no, emp_no
from works_on
where project_no = 'p1'
or project_no = 'p2';

select emp_no, emp_fname, emp_lname
from employee
where emp_no = 25348 AND emp_lname = 'Smith'
or emp_fname = 'Matthew' and dept_no = 'd1';

select emp_no, emp_lname
from employee
where not dept_no = 'd2';

select emp_no, emp_fname, emp_lname
from employee
where emp_no in (29346, 28559, 25348);

select emp_no, emp_fname, emp_lname, dept_no
from employee
where emp_no not in (10102, 9031);

select project_name, budget
from project
where budget between 95000 and 120000;

select project_name, budget
from project
where budget >= 95000 and budget <= 120000;

select project_name, budget
from project
where budget < 100000 or budget > 150000;

select project_name, budget
from project
where budget not between 100000 and 150000;

--------------------------------------------------
select emp_no, project_no 
from works_on
where project_no = 'p2'
and job is null;

select project_no, job
from works_on
where job <> null; -- íå ðàáîòàåò

select project_no, job
from works_on
where job is null;

select emp_no, isnull(job, 'Job unknown') as task
from works_on
where project_no = 'p1';

select emp_no, project_no, job,
isnull(job, 'Job unknown') as task
from works_on;

select emp_fname, emp_lname, emp_no
from employee
where emp_lname like 'j%';

select emp_fname, emp_lname, emp_no
from employee
where emp_fname like '_a%';

select *
from department
where location like '[C-F]%';

select emp_no, emp_fname, emp_lname
from employee
where emp_lname like '[^J-O]%'
and emp_fname like '[^EZ]%';

select *
from works_on
where enter_date like '2007%';

select *
from works_on
where enter_date like '%-01-%';

select *
from works_on
where enter_date like '%[0][1-5]';

select project_no, project_name
from project
where project_name like '%[_]%';

select project_no, project_name
from project
where project_name like '%[_]%' escape '!';

select project_no, project_name
from project
where project_name like '%[_]%' escape '/';

-- ÌÎÈ ÏÐÈÌÅÐÛ --
--#1--
SELECT DISTINCT project_name
FROM project;

--#2--
SELECT * FROM project
WHERE project_name = 'Apollo';

--#3--
select *, YEAR(enter_date) as year_enter 
from works_on
where emp_no = 2581 and YEAR(enter_date) = 2007

--#4--
select *
from project
where budget*0.90 > 80000;

--#5--
select emp_no, emp_fname, emp_lname
from employee
where emp_no = 2581 AND emp_lname = 'Bertoni'
or emp_fname = 'Elke' and dept_no = 'd2';

--#6--
select emp_no, project_no 
from works_on
where project_no = 'p1'
and job is null;

--#7--
select emp_no, isnull(job, 'Job unknown') as task
from works_on
where project_no = 'p2';

--#8--
select emp_fname, emp_lname, emp_no
from employee
where emp_lname like 's%';

--#9--
select emp_no, emp_fname, emp_lname
from employee
where emp_lname like '[^B-E]%'
and emp_fname like '[^EJ]%';

--#10--
select emp_no, project_no, isnull(job, 'Job unknown') as task
from works_on
where enter_date like '2006%';
