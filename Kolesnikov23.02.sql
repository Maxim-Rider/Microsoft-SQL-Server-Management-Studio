Use sample_primer

SELECT *
into employee_enh
from employee

SELECT * from employee_enh

SELECT domicile from employee_enh
union all
select location from department

--пересечение
SELECT domicile from employee_enh
intersect
select location from department

--оператор except - разность
select emp_no from employee
where dept_no = 'd3'
except
select emp_no from works_on
where enter_date > '2007-01-12'


-- применение поискового выражения case
select *, 
	case
		when budget > 0 and budget <100000 then 1
		when budget >= 100000 and budget <200000 then 2
		when budget >= 200000 and budget <300000 then 3
		else 4
	end budget_weight
from project

--применение поискового выражения case с вложенными запросами
select *,
	case
		when budget < (select avg(budget) from project)
		then 'below average'
		when budget > (select avg(budget) from project)
		then 'above average'
		when budget = (select avg(budget) from project)
		then 'on average'
	end budget_category
from project

-- простое выражение case - пример (премия)
select *, 
	case dept_no
		when 'd2' then '50%'
		when 'd3' then '80%'
		else '25%'
	end bonus_percent,
	salary/100 * 
		case dept_no
		when 'd2' then 50
		when 'd3' then 80
		else 25
	end bonus_
from employee

--решение задачи при помощи добавления case - выражения
select *
from employee
order by
case 
	 when salary >= 1500 then 1 else 0 end,
	 emp_lname