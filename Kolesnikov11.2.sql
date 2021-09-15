--11.2 ������ ����������������� �������������� ���� ������ �� ��������-�������� (SQL DDL �������� � �������������� ��������)
--������ ����������

CREATE DATABASE Test_Kolesnikov
use Test_Kolesnikov

CREATE TABLE Employees(
  ID_emp int,
  Name_emp nvarchar(30),
  Birthday date,
  Email nvarchar(30),
  Position nvarchar(30),
  Department nvarchar(30)
)

-- ���������� ���� ID
ALTER TABLE Employees ALTER COLUMN ID_emp int NOT NULL

-- ���������� ���� Name_emp
ALTER TABLE Employees ALTER COLUMN Name_emp nvarchar(30) NOT NULL

--���������� �������
INSERT Employees(ID_emp,Position,Department,Name_emp) VALUES
(1000,N'��������',N'�������������',N'������ �.�.'),
(1001,N'�����������',N'��',N'������ �.�.'),
(1002,N'���������',N'�����������',N'������� �.�.'),
(1003,N'������� �����������',N'��',N'������� �.�.')

--�������� �������
DROP TABLE Employees

--�������� ����� �������
CREATE TABLE Employees(
  ID_emp int NOT NULL,
  Name_emp nvarchar(30) NOT NULL,
  Birthday date,
  Email nvarchar(30),
  Position nvarchar(30),
  Department nvarchar(30)
)

--���������� ����
ALTER TABLE Employees ALTER COLUMN Name_emp nvarchar(50)

ALTER TABLE Employees ADD CONSTRAINT PK_Employees PRIMARY KEY(ID_emp)

--����� ������
DROP TABLE Employees

--������ ����� � �� ����� ��������������
CREATE TABLE Employees(
  ID_emp int NOT NULL,
  Name_emp nvarchar(30) NOT NULL,
  Birthday date,
  Email nvarchar(30),
  Position nvarchar(30),
  Department nvarchar(30),
  CONSTRAINT PK_Employees PRIMARY KEY(ID_emp) -- ��������� PK ����� ���� �����, ��� �����������
)

INSERT Employees(ID_emp,Position,Department,Name_emp) VALUES
(1000,N'��������',N'�������������',N'������ �.�.'),
(1001,N'�����������',N'��',N'������ �.�.'),
(1002,N'���������',N'�����������',N'������� �.�.'),
(1003,N'������� �����������',N'��',N'������� �.�.')

--�������� �����������
ALTER TABLE Employees DROP CONSTRAINT PK_Employees

--��������� �������
CREATE TABLE #Temp(
  ID_emp int,
  Name_emp nvarchar(30)
)

--������� �
DROP TABLE #Temp

--������ � ��� � ������� �� ������ �������
SELECT ID_emp,Name_emp
INTO #Temp
FROM Employees

--2 ������� ����������� ���������� � ��������, ������ ������� Positions, � ������ �������������� Departments:

CREATE TABLE Positions(
  ID_pos int IDENTITY(100,1) NOT NULL CONSTRAINT PK_Positions PRIMARY KEY,
  Name_pos nvarchar(30) NOT NULL
)

CREATE TABLE Departments(
  ID_dep int IDENTITY(1000,10) NOT NULL CONSTRAINT PK_Departments PRIMARY KEY,
  Name_dep nvarchar(30) NOT NULL
)

drop table positions
drop table Departments

-- ��������� ���� Name ������� Positions, ����������� ���������� �� ���� Position ������� Employees
INSERT Positions(Name_pos)
SELECT DISTINCT Position
FROM Employees
WHERE Position IS NOT NULL -- ����������� ������ � ������� ������� �� �������

--�� �� ����� ��������� ��� ������� Departments:
INSERT Departments(Name_dep)
SELECT DISTINCT Department
FROM Employees
WHERE Department IS NOT NULL

SELECT * FROM Positions
SELECT * FROM Departments

-- ��������� ���� ��� ID ���������
ALTER TABLE Employees ADD PositionID int
-- ��������� ���� ��� ID ������
ALTER TABLE Employees ADD DepartmentID int

--��� �� �������� � ������� ����� ��������� ����� ����� ����� ��������, ���������� ���� ����� �������:
ALTER TABLE Employees ADD PositionID int, DepartmentID int

--������ �������� ������ (��������� ����������� � FOREIGN KEY) ��� ���� �����, ��� ���� ����� ������������
--�� ���� ����������� �������� � ������ ����, ��������, ������������� ����� �������� ID ����������� � ������������.
ALTER TABLE Employees ADD CONSTRAINT FK_Employees_PositionID
FOREIGN KEY(PositionID) REFERENCES Positions(ID_pos)

ALTER TABLE Employees ADD CONSTRAINT FK_Employees_DepartmentID
FOREIGN KEY(DepartmentID) REFERENCES Departments(ID_dep)

-- ������ ������� ���� PositionID � DepartmentID ���������� ID �� ������������.
UPDATE e
SET
  PositionID=(SELECT ID_pos FROM Positions WHERE Name_pos=e.Position),
  DepartmentID=(SELECT ID_dep FROM Departments WHERE Name_dep=e.Department)
FROM Employees e
--���������, ��� ����������, �������� ������:
SELECT * FROM Employees

--���� PositionID � DepartmentID ��������� ��������������� ���������� � ������� ���������������� ���������� 
--� ����� Position � Department � ������� Employees ������ ���, ����� ������� ��� ����:
ALTER TABLE Employees DROP COLUMN Position,Department

--������ ������� � ��� ��������� ��������� ���:
SELECT * FROM Employees

--�.�. �� � ����� ���������� �� �������� ���������� ����������. 
--������, �� ������� ��������� � ������ ����� ���������� ���������� �� ��������, ��������� �������� � ��������-������������:
SELECT e.ID_emp,e.Name_emp,p.Name_pos PositionName,d.Name_dep DepartmentName
FROM Employees e
LEFT JOIN Departments d ON d.ID_dep=e.DepartmentID
LEFT JOIN Positions p ON p.ID_pos=e.PositionID

--������� ����� ��������� ���� �� ����, �.�. ����� ������� ����������� ������.
--��� ������� ������� � ���� ������� � ������������ ��� ���� ���� ManagerID, ������� ����� ��������� �� ����������,
--�������� ����������� ������ ���������. �������� ����:
ALTER TABLE Employees ADD ManagerID int

--������ �������� FOREIGN KEY �� ������� Employees:
ALTER TABLE Employees ADD CONSTRAINT FK_Employees_ManagerID
FOREIGN KEY (ManagerID) REFERENCES Employees(ID_emp)

--������������ ������� � ��������� ����� ON DELETE CASCADE ��� FK_Employees_DepartmentID:
DROP TABLE Employees

CREATE TABLE Employees(
  ID_emp int NOT NULL,
  Name_emp nvarchar(30),
  Birthday date,
  Email nvarchar(30),
  PositionID int,
  DepartmentID int,
  ManagerID int,
CONSTRAINT PK_Employees PRIMARY KEY (ID_emp),
CONSTRAINT FK_Employees_DepartmentID FOREIGN KEY(DepartmentID) REFERENCES Departments(ID_dep)
ON DELETE CASCADE,
CONSTRAINT FK_Employees_PositionID FOREIGN KEY(PositionID) REFERENCES Positions(ID_pos),
CONSTRAINT FK_Employees_ManagerID FOREIGN KEY (ManagerID) REFERENCES Employees(ID_emp)
)

INSERT Employees (ID_emp,Name_emp,Birthday,PositionID,DepartmentID,ManagerID)VALUES
(1000,N'������ �.�.','19550219',101,1000,NULL),
(1001,N'������ �.�.','19831203',102,1010,1003),
(1002,N'������� �.�.','19760607',103,1020,1000),
(1003,N'������� �.�.','19820417',104,1030,1000)

DELETE Departments WHERE ID_dep=3

SELECT * FROM Employees

--
UPDATE Departments
SET
  ID_dep=30
WHERE ID_dep=3

-- ���� ���������� �� ����������/��������� IDENTITY ��������
SET IDENTITY_INSERT Departments ON

INSERT Departments(ID_dep,Name_dep) VALUES(3,N'��')

-- ��������� ����������/��������� IDENTITY ��������
SET IDENTITY_INSERT Departments OFF

--��������� ������� ������� Employees ��� ������ ������� TRUNCATE TABLE:
TRUNCATE TABLE Employees

--
INSERT Employees (ID_emp,Name_emp,Birthday,PositionID,DepartmentID,ManagerID)VALUES
(1000,N'������ �.�.','19550219',101,1000,NULL),
(1001,N'������ �.�.','19831203',102,1010,1003),
(1002,N'������� �.�.','19760607',103,1020,1000),
(1003,N'������� �.�.','19820417',104,1030,1000)


--
UPDATE Employees SET Email='i.ivanov@test.tt' WHERE ID_emp=1000
UPDATE Employees SET Email='p.petrov@test.tt' WHERE ID_emp=1001
UPDATE Employees SET Email='s.sidorov@test.tt' WHERE ID_emp=1002
UPDATE Employees SET Email='a.andreev@test.tt' WHERE ID_emp=1003

--� ������ ����� �������� �� ��� ���� �����������-������������:
ALTER TABLE Employees ADD CONSTRAINT UQ_Employees_Email UNIQUE(Email)

--������� ������� � ������� Employees ����� ���� ����� ������ � ������� ��� HireDate �
--������ ��� �������� �� ��������� � ������� ���� ����� ������� ����:
ALTER TABLE Employees ADD HireDate date NOT NULL DEFAULT SYSDATETIME()

--��� ���� ������� HireDate ��� ����������, �� ����� ������������ ��������� ���������:
ALTER TABLE Employees ADD DEFAULT SYSDATETIME() FOR HireDate

--� ������ �����������
ALTER TABLE Employees ADD CONSTRAINT DF_Employees_HireDate DEFAULT SYSDATETIME() FOR HireDate

--
INSERT Employees(ID_emp,Name_emp,Email)VALUES(1004,N'������� �.�.','s.sergeev@test.tt')

SELECT * FROM Employees

--��� ������ ������� ����������� ������, ��� ��������� ������ ������ ����� �������� �� 1000 �� 1999:
ALTER TABLE Employees ADD CONSTRAINT CK_Employees_ID CHECK(ID_emp BETWEEN 1000 AND 1999)

--�������� ������ �����������
INSERT Employees(ID_emp,Email) VALUES(2000,'test@test.tt')

--� ������ ������� ����������� �������� �� 1500 � ��������, ��� ������ ���������:
INSERT Employees(ID_emp,Email) VALUES(1500,'test@test.tt')

--����� ��� �� ������� ����������� UNIQUE � CHECK ��� �������� �����:
ALTER TABLE Employees ADD UNIQUE(Email)
ALTER TABLE Employees ADD CHECK(ID_emp BETWEEN 1000 AND 1999)

--��� ��� ����������� ����� ������� ����� �� ��� �������� �������, ���� �� ��� ���. ������ �������:
DROP TABLE Employees

--� ������������ �� �� ����� ���������� ������������� ����� �������� CREATE TABLE:
CREATE TABLE Employees(
  ID_emp int NOT NULL,
  Name_emp nvarchar(30),
  Birthday date,
  Email nvarchar(30),
  PositionID int,
  DepartmentID int,
  HireDate date NOT NULL DEFAULT SYSDATETIME(), -- ��� DEFAULT � ������ ����������
CONSTRAINT PK_Employees PRIMARY KEY (ID_emp),
CONSTRAINT FK_Employees_DepartmentID FOREIGN KEY(DepartmentID) REFERENCES Departments(ID_dep),
CONSTRAINT FK_Employees_PositionID FOREIGN KEY(PositionID) REFERENCES Positions(ID_pos),
CONSTRAINT UQ_Employees_Email UNIQUE (Email),
CONSTRAINT CK_Employees_ID CHECK (ID_emp BETWEEN 1000 AND 1999)
)

INSERT Employees (ID_emp,Name_emp,Birthday,Email,PositionID,DepartmentID)VALUES
(1000,N'������ �.�.','19550219','i.ivanov@test.tt',101,1000),
(1001,N'������ �.�.','19831203','p.petrov@test.tt',102,1010),
(1002,N'������� �.�.','19760607','s.sidorov@test.tt',103,1020),
(1003,N'������� �.�.','19820417','a.andreev@test.tt',104,1030)

--��� ������� ������� ������ ����������� PK_Employees ������������, � ������ ����������� UQ_Employees_Email ����������.
--������ ����� ������ ������ �����������:
ALTER TABLE Employees DROP CONSTRAINT PK_Employees
ALTER TABLE Employees DROP CONSTRAINT UQ_Employees_Email

--� ������ �������� �� � ������� CLUSTERED � NONCLUSTERED:
ALTER TABLE Employees ADD CONSTRAINT PK_Employees PRIMARY KEY NONCLUSTERED (ID_emp)
ALTER TABLE Employees ADD CONSTRAINT UQ_Employees_Email UNIQUE CLUSTERED (Email)

SELECT * FROM Employees

--������� �� ���� ��� ����� ����� ��������� ��������� ��������:
CREATE INDEX IDX_Employees_Name ON Employees(Name_emp)

CREATE UNIQUE NONCLUSTERED INDEX UQ_Employees_EmailDesc ON Employees(Email DESC)

--������� ������ ����� ��������� ��������:
DROP INDEX IDX_Employees_Name ON Employees

--��� ������� ����� ������ �������:
DROP TABLE Employees

--� ������������ �� �� ����� ���������� ������������� � ��������� ����� �������� CREATE TABLE:
CREATE TABLE Employees(
  ID_emp int NOT NULL,
  Name_emp nvarchar(30),
  Birthday date,
  Email nvarchar(30),
  PositionID int,
  DepartmentID int,
  HireDate date NOT NULL CONSTRAINT DF_Employees_HireDate DEFAULT SYSDATETIME(),
  ManagerID int,
CONSTRAINT PK_Employees PRIMARY KEY (ID_emp),
CONSTRAINT FK_Employees_DepartmentID FOREIGN KEY(DepartmentID) REFERENCES Departments(ID_dep),
CONSTRAINT FK_Employees_PositionID FOREIGN KEY(PositionID) REFERENCES Positions(ID_pos),
CONSTRAINT FK_Employees_ManagerID FOREIGN KEY (ManagerID) REFERENCES Employees(ID_emp),
CONSTRAINT UQ_Employees_Email UNIQUE(Email),
CONSTRAINT CK_Employees_ID CHECK(ID_emp BETWEEN 1000 AND 1999),
INDEX IDX_Employees_Name(Name_emp)
)

INSERT Employees (ID_emp,Name_emp,Birthday,Email,PositionID,DepartmentID,ManagerID)VALUES
(1000,N'������ �.�.','19550219','i.ivanov@test.tt',101,1000,NULL),
(1001,N'������ �.�.','19831203','p.petrov@test.tt',102,1010,1003),
(1002,N'������� �.�.','19760607','s.sidorov@test.tt',103,1020,1000),
(1003,N'������� �.�.','19820417','a.andreev@test.tt',104,1030,1000)

select * from Employees

--�����, ��� ��������� ����, ��� ������ ��� ��� ����� ������� � ��� �������� � ����.