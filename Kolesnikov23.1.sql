--�����: ������ ����������
--����: 14.06.2021
--���� 23. �������� 

use sample_primer

--������������� ���������� MERGE
bonus � ���������� MERGE (2)
����������� DELETE*/
declare @del_table table (emp_no int, emp_lname char(20))

delete employee
output deleted.emp_no, deleted.emp_lname into @del_table
where emp_no = 77777

select * from @del_table
----------------
select * from employee
insert employee values (77777, 'Anu', 'Aro', 'd2', null)

--I. �������� ������� ������
go 
create table audit_budget (project_no char(4) null,
	user_name char(16) null,
	date datetime null,
	budget_old float null,
	budget_new float null);
go
create trigger modify_budget
	on project after update
	as if update(budget)
begin
declare @budget_old float
declare @budget_new float
declare @project_number char(4)
select @budget_old = (select budget from deleted)
select @budget_new (select budget from inserted)
select @project_number (select project_no from deleted)

insert into audit_budget values
(@project_number, user_name(), getdate(), @budget_old, @budget_new)
end


--������������
UPDATE project
SET budget = 150000
WHERE project_no = 'p2';

select * from audit_budget