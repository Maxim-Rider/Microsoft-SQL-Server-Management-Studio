--����: 26.05.2021
--�����: ������ ����������
--���� 20. �������������

--�������� �������������
use sample_primer
go
create view v_clerk
as select emp_no, project_no, enter_date, job
from works_on
where job = 'Clerk';
go
select * from v_clerk;

--����� ������� ���� �������� ��� �������������
create view v_count (project_no, count_emp)
as select project_no, count(*)
from works_on
group by project_no
go

select * from v_count

--������������� �� ���� ������� �������������
create view v_project_p2
as select * --emp_no
from v_clerk
where project_no = 'p2';
go

select * from v_project_p2

--��������� ������������� - ALTER VIEW
alter view v_without_budget
as select project_no, project_name
from project
where project_no >= 'p3';
go

--���������� INSERT � ������������� (1)
create view v_dept
as select dept_no, dept_name
from department
go 
insert into v_dept values ('d4', 'Development');
go

delete from department where dept_no = 'd4'
--������� ������� -������������
alter table department
alter column location varchar(15) not null
--������� � �������� ���������
alter table department
alter column location varchar(25) null

select * from v_dept

--���������� WITH CHECK OPTION
create view v_2006_check
as select emp_no, project_no, enter_date
from works_on
where enter_date between '2006-01-01' and '2006-12-31'
with check option; 
go 
insert into v_2006_check values (22334, 'p2', '2007-01-15')

--���������� UPDATE � �������������
create view v_100000
as select project_no, budget
from project
where budget > 100000
with check option;
go
update v_100000
set budget = 93000
--set budget = 130000
where project_no = 'p3';

select * from v_100000

/*���������� � ��������������
� �������� ������ �������������� �������� ������������� �
�������������� �������� sys.objects
� ��� ������������� �������� �������� ���������� ����������
���� �������� � ������� ���� ������
� ��� ������ ������������� �������� �� ��������� v � �������
type �������� ���������� � ��������������
� ������������� �������� sys.views �������� ��������������
���������� � ������������ ��������������.
� �������� ������ �������� ����� ������������� ��������
������� with_check_option, ������� �����������, ������� ���
��� ����������� WITH CHECK OPTION.
� ������ ��� ������������� ������������� ����� ����������
����������� ��������� ��������� sp_helptext. */









