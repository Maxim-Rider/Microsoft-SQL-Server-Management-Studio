--18/03/2021
--����� ������: ������ ����������
--����: ��������� ����������.

use sample_primer

--1 (������������ ������������)
select *
from department inner join employee on
department.dept_no = employee.dept_no

--2 old style (���������� ������������)
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


--���������� 8.1
--�������� ��������� ���������� ������ project � works_on, ��������:
--� ������������ ����������;
select *
from project inner join works_on on
project.project_no = works_on.project_no

--� ��������� ������������.
select *
from project, works_on
where project.project_no = works_on.project_no

--���������� 8.2
--������� ������� ���������� ���������� ��� ���������� � ������� n ������?

--����� ���� ������� ������ �������.

--���������� 8.3
--��������� ������� ���������� ������ ���������� � ��������� ��� ���� �����������,
--���������� ��� �������� Gemini.
select emp_no, job, project.project_name
from works_on inner join project on
works_on.project_no = project.project_no
where project_name = 'Gemini'

--���������� 8.4
--��������� ������� ���� � ������� ���� �����������, ���������� � ������
--Research ��� Accounting.
select emp_fname, emp_lname, dept_name
from department join employee on 
department.dept_no = employee.dept_no
where dept_name in ('Research', 'Accounting') 

--���������� 8.5
--��������� ������� ���� ��� ������ ������ ��� ���� ������� (clerk), ���������� �
--������ d1.
select enter_date, dept_no, job
from employee e join works_on w on
e.emp_no = w.emp_no
where job = 'clerk' AND dept_no = 'd1'

--���������� 8.6
--��������� ������� ���� �������� (� ������ ����������� � ��������), ��� ��������
--�������� ���� ��� ������ ����������� � ���������� ����� (clerk).
select p.project_no, project_name, budget, count(*) as 'clerks'
from project p JOIN works_on w
on p.project_no = w.project_no
where job = 'clerk'
group by w.job, p.project_no, project_name, budget
having count(*) >= 2

--���������� 8.7
--��������� ������� ���� � ������� �����������, ������� ����� ��������� ��������
--(manager) � �������� ��� �������� Mercury.
select emp_fname, emp_lname
from employee
where emp_no in (
	select emp_no
	from works_on w join project p
	on w.project_no = p.project_no
	where job = 'manager'
	and p.project_name = 'Mercury');

--���������� 8.8
--��������� ������� ���� � ������� ���� �����������, ������� ������ �������� ���
--�������� ������������, �� ������� ����, ��� � ����� ������ �����������.
select emp_fname, emp_lname, enter_date
from works_on w join employee e on 
w.emp_no = e.emp_no
group by enter_date, emp_fname, emp_lname, enter_date
having count(*) > 1

--���������� 8.9
--��������� ������� ��������� ������� �����������, ������� ����� � ��� �� ������, ���
--��������� �� �����. (����������� ����������� ������� employee_ enh ���� ������ sample.)
select emp_no
from employee_enh
where emp_no in (
	select emp_no
	from employee_enh e join department d
	on e.emp_no = d.location
	group by e.emp_no);
	--� ���������� 

	--where emp_no = d.location);


--���������� 8.10
--��������� ������� ���� ����������� (� ������ �����������), ���������� � ������
--���������� Marketing � ����������� � ���������� ������� Apollo. �������� ��� ������������
--�������, ���������:
--� �������� ����������;
select *
from department d join employee e
on d.dept_no = e.dept_no
where d.dept_name = 'marketing';
--� ��������� ���������.
select *
from employee 
where dept_no in (
	select dept_no 
	from department
	where dept_name = 'marketing');
