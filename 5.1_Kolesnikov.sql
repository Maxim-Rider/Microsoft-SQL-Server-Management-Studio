USE sample_primer

--���������� 5.1
-- ��������� ������� ���� ����� �� ������� works_on.
select * from works_on

-- ���������� 5.2
--��������� ������� ��������� ������� ���� ����������� � ���������� �����
--(clerk).select emp_no from works_onwhere job = 'Clerk'--���������� 5.3
--��������� ������� ��������� ������� ���� �����������, ������� �������� ���
--�������� p2 � ��� ��������� ����� ������, ��� 10 000.select emp_no from works_onwhere project_no = 'p2' and emp_no <= 10000--���������� 5.4
--��������� ������� ��������� ������� ���� �����������, ������� �� ���������� �
--������ ��� �������� � 2007 �.
--������ ��� ������, ��������� ��� ���������, �� ������������� ������� �
--(��������� - BETWEEN).select emp_no, enter_date from works_onwhere YEAR(enter_date) != 2007--���������� 5.5
--��������� ������� ��������� ������� ���� ����������� ������� p1 � ��������
--����������� (�. �. �������� � analyst � �������� � manager).select emp_no, job from works_onwhere project_no = 'p1' and job in ('analysist','manager')--���������� 5.6
--��������� ������� ���� ����������� ������� p2, ��� ��������� ��� �� ����������select emp_no, project_no, job from works_onwhere project_no = 'p2' and job is null--���������� 5.7--��������� ������� ��������� ������� � ������� �����������, ��� ����� ��������
--��� ����� tselect emp_no, emp_fname, emp_lname from  employeewhere emp_fname like '%[tt]%'--���������� 5.8
--��������� ������� ��������� ������� � ���� ���� �����������, � ������� ������
--����� ������� o ��� a (����� ����������) � ��������� ����� ������� es.
select emp_no, emp_fname, emp_lname from employee
WHERE emp_lname LIKE '_[oa]%es'

--���������� 5.9
--��������� ������� ��������, ��� ������� ������ 100000 ��� ������ 300000 .
--������ ��� ������, ��������� ��� ���������, �� ������������� ������� 
select project_name, budget from project
where budget < 100000 or budget > 300000

--���������� 5.10
--��������� ������� ������� � ���� �����������, � ������� �� � �������, �� � �����
--�� ����������� �� ����� x �� ����� y
select emp_fname, emp_lname from employee
WHERE emp_lname NOT LIKE '_[xy]%' and emp_fname NOT LIKE '_[xy]%' 
