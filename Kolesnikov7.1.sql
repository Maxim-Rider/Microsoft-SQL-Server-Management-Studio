use sample_primer

select dept_no, count(emp_no) as emp_count from employee
group by dept_no

--���������� 6.18
--a) � ����� ������� ������������ ���������� �����������

select top 1 dept_no, count(emp_no) as emp_count from employee 
group by dept_no
order by count(emp_no) desc



--b) � ����� ������� ����������� ���������� �����������
select top 2 dept_no, count(emp_no) as emp_count from employee 
group by dept_no
order by count(emp_no) asc

--���������� 6.19
--� ����� ������� ��������� ������ � ����������� ����������� �����������
select top 2 location, dept_no from department
group by location, dept_no
order by location asc


--���������� 6.20
--�������� ������ ���������� � �����������, ��� ������ �����������:
--a) � ������ (Seattle)
select * from employee
where dept_no IN
	(select dept_no
	from department
	where location = 'Seattle');

--b) � ������� (Dallas)
select * from employee
where dept_no IN
	(select dept_no
	from department
	where location = 'Dallas');

--���������� 6.21
--��������� ������� ������� � ���� �����������, ������� ���������� � ������ ���
--���������:
--a) 4 ������ 2007�.
select emp_fname, emp_lname, enter_date from employee, works_on
where enter_date = '2007-01-04'

--b) � ������ ��� ������� 2008�.
select emp_fname, emp_lname, enter_date from employee, works_on
where year(enter_date) = '2008' 
and 
month(enter_date) = '01' or month(enter_date)= '02'

--���������� 6.22
--�������� ������ ���������� � �����������, ������� ��� ����� ��������� ����� (clerk),
--��� �������� � ������ d3.

select * from employee
where emp_no IN
	(select emp_no from works_on
	where job = 'Clerk' or dept_no = 'd3')



--���������� 6.23
--���������, ������ ��������� ������ ������������.
--a) ��������� ��������� �������
--b) ������������� ����� ��� �������������� �������


--������� �������� ��������, ��� ������� �������� ���������� � ���������� Clerk
SELECT project_name
FROM project
WHERE project_no in
(SELECT project_no FROM works_on WHERE Job = 'Clerk')