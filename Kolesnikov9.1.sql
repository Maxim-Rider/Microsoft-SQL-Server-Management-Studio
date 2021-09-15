--���� 9. SQL - INSERT, UPDATE, DELETE
--��������������� ����������� ������ (���������� INSERT, UPDATE, DELETE)
--����: 31.03.2021
--�����: ������ ����������

use sample_primer

select * from employee
--1 �������� ������
insert into employee values (15300, 'Kiro', 'Aro', null, null)

insert into employee (emp_no, emp_fname, emp_lname) values (15320, 'Irina', 'Novikova')

--2 �������� �������
create table dallas_dept (dept_no char(4) not null, dept_name char(20) not null)

select * from dallas_dept

--3 ���������� ��������� �������
insert into dallas_dept (dept_no, dept_name)
select dept_no, dept_name from department
where location = 'Dallas'

--4 ������� ������ �� ������ ���� (+ ����� �������� �������)
select top 10 CustomerID, CompanyName, City 
into customers
from WholeSale.dbo.Customers

select * from customers

--5 �������������� ������
update works_on
set job = 'Manager'
where emp_no = 18316
and project_no = 'p2'

select * from works_on

--6 ��� ������ ����������� �������
update works_on
set job = null
where emp_no in
	(select emp_no from employee
	where emp_lname = 'Jones')

select * from employee

--7 ��� ������ case
update project
set budget = case
	when budget >0 and budget < 100000 then budget*1.2
	when budget >=100000 and budget < 200000 then budget*1.1
    else budget*1.05
end



/*���������� 9.1
�������� ������ ��� ����� ���������� (���, �������, ��������� �����
���������� ����). ��� ��� �� ��������� � �����-���� �����.*/
select * from employee
insert into employee values (30001, 'Ekaterina', 'Frantseva', null, null)

/*���������� 9.2
�������� ����� ������� � ��������� � ��� �� ������� employee ���� �����������,
���������� � ������� d1, d2. �������� ��� ������, �� ������������ �������.
(Create, Insert Into | Select Into)*/
create table employee_d1_d2 (emp_no char(6) not null, emp_fname char(20) not null, emp_lname char(20) not null, dept_no char(4) not null, salary money not null)
insert into employee_d1_d2 (emp_no, emp_fname, emp_lname, dept_no, salary)
select emp_no, emp_fname, emp_lname, dept_no, salary from employee
where dept_no = 'd1' or dept_no = 'd2'

select * from employee_d1_d2

/*���������� 9.3
�������� ����� ������� ��� �����������, ������� ���������� � ������ ���
������ ��������� � 2008 �., � ��������� � ��� ��������������� ������ ��
������� employee.
���������� ��� ������, �� ������������ �������. (Create, Insert Into |Select
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

/*���������� 9.4
�������� ��������� ���� ���������� (Manager) � ������� p1 �� �����
(��������� ���������� ����).*/
update works_on
set job = 'Game Designer'
where job = 'Manager'
or project_no = 'p1'

select * from works_on

/*���������� 9.5
���������� ������ ��� ��������� �������� �������� �������� p3 � p1 ��
�������� NULL. (������ �� ����������)*/

update project 
set budget = null
where project_no in
	(select project_no from works_on
	where project_no = 'p1' or project_no = 'p3');

/*���������� 9.6
�������� ��������� ���������� � ��������� ������� 28559 �� ���������
(Manager) ��� ���� ��� ��������*/
select * from works_on

update works_on
set job = 'Manager'
where emp_no in
	(select emp_no from works_on
	where emp_no = 28559);

/*���������� 9.7
�������� �� 10% ������ �������, �������� �������� ����� ��������� �����
10102.*/
update project
set budget = budget * 1.1
where project_no in
	(select project_no from works_on
	where emp_no = 10102)

select * from project

/*���������� 9.8
�������� ������������ ������, � ������� �������� ��������� �� �������
James, �� �������� Sales.*/
update department
set dept_name = 'Sales'
where dept_no in
	(select dept_no from employee
	where emp_fname = 'James')

select * from department

/*���������� 9.9
�������� ���� ������ ������ ��� �������� ��� �����������, ������� ��������
��� �������� p1 � �������� � ������ Sales �� 12 ������� 2009 �.*/
update works_on
set enter_date = '2009-12-12'
where enter_date in
	(select enter_date from employee 
	where project_no = 'p1' or dept_no = 'Sales');

/*���������� 9.10
���������� ������ ��� �������� ���� �������, ������������� � ������
(Seattle).
(������ �� ����������)*/

delete from department
where location = 'Dallas'

/*���������� 9.11
���������� �������. ������ p3 ��������. ������� ��� ���������� �� ����
������� �� ���� ������. (������ �� ����������)*/

delete from project
where project_no = 'p3'

/*���������� 9.12
���������� ������. ������� ��� ���������� �� ������� works_on ��� ����
�����������, ������� �������� � �������, ������������� � ������� (Dallas).
(������ �� ����������)*/

delete from works_on inner join employee 
on works_on.emp_no = employee.emp_no inner join department 
on department.dept_no = employee.dept_no
where location = 'Dallas'

-- (�������� ���� ��� delete)
select * from works_on inner join employee 
on works_on.emp_no = employee.emp_no inner join department 
on department.dept_no = employee.dept_no
where location = 'Dallas'

