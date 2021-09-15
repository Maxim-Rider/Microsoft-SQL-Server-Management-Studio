--�����: ������ ����������
--����: 19.05.2021

--���������� 19.1
use sample_primer
--�������� ������� employee_30 ��� ������ SQL-�������, �� ��������� �������
--���������� �. employee.
drop table employee_30
Create table employee_30 (
emp_no int not null,
emp_fname varchar(50) null,
emp_lname varchar(50) null,
dept_no char(10) null,
salary money null
)

--�������� ����� 1 ��� ������� 30 ����� � ������� employee_30. ��������
--������� emp_no ������ ���� ����������������� �� 1 �� 30 (���������
--���� WHILE).
DECLARE @id int 
SET @id = (select count(*) from employee_30)

WHILE @id < 30
	BEGIN
	insert into employee_30(emp_no) values (@id + 1)
	SET @id = (select count(*) from employee_30)
      IF @id > 30
      BREAK
   ELSE
      CONTINUE
END
--
select * from employee_30

--���� ������� �������� emp_lname, emp_fname � dept_no ��������������, �
--������ ������ ������������� ���������� �������� (�������� ����������
--���� ����� ��������� ����������).
DECLARE @value int, @emp_no int 
SET @emp_no = (select count(*) from employee_30)

WHILE @emp_no < 60
	BEGIN
	insert into employee_30(emp_no, emp_fname, emp_lname, dept_no) values (@emp_no +1,'Max','Kolesnikov','3')
	SET @emp_no = (select count(*) from employee_30)
      IF @emp_no > 60
      BREAK
   ELSE
      CONTINUE
END
--
select * from employee_30
--��� ���������� ������ ������ � ������� �������� ��������� �� ����� (���
--������ � �����������), ��������� ������� CAST ��� CONVERT
DECLARE @value2 int, @emp_no2 int 
SET @emp_no2 = (select count(*) from employee_30)

WHILE @emp_no2 < 90
	BEGIN
	insert into employee_30(emp_no, emp_fname, emp_lname, dept_no) values (@emp_no2 +1,'Max','Kolesnikov','3')
	SET @emp_no2 = (select count(*) from employee_30)
      IF @emp_no2 > 90
      BREAK
   ELSE
      CONTINUE
	  print '��� ������: ' + cast(@emp_no2 as char(12)) +'.' + '������ �������� ��������� ��������:' + cast(@value2 as char(12))
END
------
select * from employee_30

--���������� 19.2
/*���������� � �������� ����� �� ���������� 19.1 ����� �������, �����
������������ ��������� ����� �������� ��� ������� emp_no, ���������
������� RAND(). ������������ ����� � ��������� �� 2-� �������� �� 4-�
�������� �����.*/
DECLARE @id int 
DECLARE @Random INT;
DECLARE @Upper INT;
DECLARE @Lower INT;
SET @Lower = 10 
SET @Upper = 9999
SET @Random = 1
SET @id = (select count(*) from employee_30)


WHILE @id < 120
	BEGIN
	SET @id = (select count(*) from employee_30)
	SET @Random = ROUND(((@Upper - @Lower -1) * RAND() + @Lower), 0)
	insert into employee_30(emp_no) values (@Random)
      IF @id > 120
      BREAK
   ELSE
      CONTINUE
END
--
select * from employee_30

/*
���� ������� �������� emp_lname, emp_fname � dept_no ��������������, �
������ ������ ������������� ���������� �������� (�������� ������� ����
� ��������� INSERT).
*/
DECLARE @id int;
DECLARE @Random INT;
DECLARE @Upper INT;
DECLARE @Lower INT;
SET @Lower = 10 
SET @Upper = 9999
SET @Random = 1
SET @id = (select count(*) from employee_30)

WHILE @id < 150
	BEGIN
	SET @id = (select count(*) from employee_30)
	SET @Random = ROUND(((@Upper - @Lower -1) * RAND() + @Lower), 0)
	insert into employee_30(emp_no, emp_fname, emp_lname, dept_no) values (@Random, 'Max','Kolesnikov','3')
      IF @id > 150
      BREAK
   ELSE
      CONTINUE
END
--
select * from employee_30
/*
���������� 19.3
��� ��������� ����� �����, ���� �����������, ��� ����� �������������
�������� �����-�� �����. �� �������� ���� �� ����� ��������� ���������.
�������� ����� �� ���������� 19.2 ����� �������, ����� ������������
��������� ������������� �������� ��� ������� emp_no, ���������
������� RAND()
��� ������������ ������������� �����, ��������� �������� ����������
����� (�������� �� 200 �� 270).
*/
DECLARE @id int 
DECLARE @Random INT;
DECLARE @Upper INT;
DECLARE @Lower INT;
SET @Lower = 200
SET @Upper = 270
SET @Random = 1
SET @id = (select count(*) from employee_30)


WHILE @id < 180
	BEGIN
	SET @id = (select count(*) from employee_30)
	SET @Random = ROUND(((@Upper - @Lower -1) * RAND() + @Lower), 0)
	insert into employee_30(emp_no) values (@Random + 1)
      IF @id > 180
      BREAK
   ELSE
      CONTINUE
END
--
select * from employee_30
/*���� ������� �������� emp_lname, emp_fname � dept_no ��������������, �
������ ������ ������������� ���������� �������� (�������� ������� ����
� ��������� INSERT).*/
DECLARE @id int;
DECLARE @Random INT;
DECLARE @Upper INT;
DECLARE @Lower INT;
SET @Lower = 200
SET @Upper = 270
SET @Random = 1
SET @id = (select count(*) from employee_30)

WHILE @id < 210
	BEGIN
	SET @id = (select count(*) from employee_30)
	SET @Random = ROUND(((@Upper - @Lower -1) * RAND() + @Lower), 0)
	insert into employee_30(emp_no, emp_fname, emp_lname, dept_no) values (@Random, 'Max','Kolesnikov','3')
      IF @id > 210
      BREAK
   ELSE
      CONTINUE
END
--
select * from employee_30
