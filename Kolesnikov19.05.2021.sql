--�����: ������ ����������
--����: 19.05.2021
--���� 19. ����������� ���������� ����� Transact-SQL

use sample_primer
--���������� IF
/*
�������� ELSE �������� ��� ����������: PRINT � SELECT. ������� ��� ���������� ����
���������� �� ���������� ��������� � ���� ����� ��������� ������� BEGIN � END.
(���������� PRINT �������� ����������� ����������� � ���������� ������������
������������� ���������)
The number of employees in the project p1 is four or more
(� ������� p1 ������������� ������ ��� ������ �����������)
*/
if (select count(*)
	from works_on
	where project_no = 'p1'
	group by project_no ) > 3
	print 'The number of employees in the project p1 is 4 or more'
else 
	begin 
		print 'The followng employees work the project p1'
		select emp_fname, emp_lname
		from employee e, works_on w
		where e.emp_no = w.emp_no
		and project_no = 'p1'
	end

--���������� WHILE
/*
� ������� ������� ���� �������� ������������� �� 10% �� ��� ���, ���� �����
����� �������� �� �������� $500 000.
�� ���������� ����� �����������, ���� ���� ����� ����� �������� �����
������ $500 000, ���� ������ ������ ������ �� �������� �������� $240 000
*/
update project set budget = budget*0.5

while (select sum(budget)
		from project) < 500000
	begin
	    update project set budget = budget*1.1
		print '������ ������� �� 10 ���������'
		if (select max(budget)
		from project) > 240000
		begin
		print '������ ��������� 240 000'
		break
		end
		else continue
	end

--������ ������������� ���������� (1)
declare @vLastName varchar(50), @vFirstName varchar(50)
set @vLastName = '%Bertoni'
select @vFirstName = emp_fname
from employee
where emp_lname like @vLastName
print 'Nimi Bertoni on ' +@vFirstName 

--������ ���������� ��������� ���������� (IF)
declare @avg_budget money, @extra_budget money, @project_no char(3)
	set @extra_budget = 25000
	set @project_no = 'p2'
	select @avg_budget = avg(budget) from project
	print 'Average ���� ��������' + cast(@avg_budget as char(10))

	if (select budget
		from project
		where project_no = @project_no) < @avg_budget
	begin
	update project
		set budget = budget + @extra_budget
			where project_no = @project_no
	print 'Budget for ' + @project_no +  'increased by' + cast(@extra_budget as char(12))
end
else print 'Budget for ' +@project_no+ 'unchanged' 


--������ ���������� ��������� ���������� (WHILE)
-- P��������� ������ ����� ����� ��������� ��� � ������ ���������� ������:
CREATE TABLE #Accounts ( CreatedAt DATE, Balance MONEY)

DECLARE @rate FLOAT = 0.065, @period INT = 5,
@sum MONEY = 10000, @date DATE = GETDATE()
WHILE @period > 0
	BEGIN
		INSERT INTO #Accounts VALUES(@date, @sum)
		print '�������� ' + cast(@date as char(12)) + '� �����' + cast(@sum as char(12))
		SET @period = @period - 1
		SET @date = DATEADD(year, 1, @date)
		SET @sum = @sum + @sum * @rate
	END
GO
SELECT * FROM #Accounts

--���������� � ��������� @@ERROR
declare @error int
update employee
	set dept_no = 'd4'
	where emp_no = 2581
set @error = @@error
if @error <> 0
begin
	print 'Error = ' +cast(@error as nvarchar(8))
	print '��������� ����������� ������.'
end

--
INSERT INTO employee VALUES (13,'Anu','Ressi','d2')
========================
GO
DELETE FROM employee
WHERE emp_no = 13

PRINT N'Error = ' + CAST(@@ERROR AS NVARCHAR(8))

PRINT N'Rows Deleted = ' + CAST(@@ROWCOUNT AS
NVARCHAR(8))

--
GO
DECLARE @ErrorVar INT;
DECLARE @RowCountVar INT;
DELETE FROM employee
WHERE emp_no = 13;
-- Save @@ERROR and @@ROWCOUNT while they are both
-- still valid.
SELECT @ErrorVar = @@ERROR,
@RowCountVar = @@ROWCOUNT;
IF (@ErrorVar <> 0)
PRINT N'Error = ' + CAST(@ErrorVar AS NVARCHAR(8));
PRINT N'Rows Deleted = ' + CAST(@RowCountVar AS
NVARCHAR(8));
--
BEGIN TRY
SELECT 1/0 -- Generate divide-by-zero error.
END TRY
BEGIN CATCH
-- Execute the error retrieval routine.
SELECT
ERROR_NUMBER() AS ErrorNumber,
ERROR_SEVERITY() AS ErrorSeverity,
ERROR_STATE() as ErrorState,
ERROR_LINE() as ErrorLine,
ERROR_MESSAGE() as ErrorMessage
END CATCH
--
CREATE TABLE Accounts (FirstName NVARCHAR NOT NULL,
Age INT NOT NULL)
==================================================
GO
BEGIN TRY
INSERT INTO Accounts VALUES (NULL, NULL)
PRINT '������ ������� ���������!'
END TRY
BEGIN CATCH
PRINT 'Error ' + CONVERT(VARCHAR,
ERROR_NUMBER()) + ':' + ERROR_MESSAGE()
END CATCH


select rand()
select rand(125)
select 20*rand()
select convert(int, 20*rand())

select rand((datepart(mm, getdate()) * 100000)
+ (datepart(ss, getdate()) * 1000 )
+ datepart(ms, getdate()))

-- ������� ������ rand()
declare @counter smallint
set @counter = 1
while @counter < 5
	begin
		select rand() Random_Number
		set @counter = @counter + 1
	end


