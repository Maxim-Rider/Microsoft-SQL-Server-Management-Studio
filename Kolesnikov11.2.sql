--11.2 Пример последовательного проектирования базы данных по интернет-учебнику (SQL DDL создание и редактирование объектов)
--Максим Колесников

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

-- обновление поля ID
ALTER TABLE Employees ALTER COLUMN ID_emp int NOT NULL

-- обновление поля Name_emp
ALTER TABLE Employees ALTER COLUMN Name_emp nvarchar(30) NOT NULL

--заполнение таблицы
INSERT Employees(ID_emp,Position,Department,Name_emp) VALUES
(1000,N'Директор',N'Администрация',N'Иванов И.И.'),
(1001,N'Программист',N'ИТ',N'Петров П.П.'),
(1002,N'Бухгалтер',N'Бухгалтерия',N'Сидоров С.С.'),
(1003,N'Старший программист',N'ИТ',N'Андреев А.А.')

--удаление таблицы
DROP TABLE Employees

--создание новой таблицы
CREATE TABLE Employees(
  ID_emp int NOT NULL,
  Name_emp nvarchar(30) NOT NULL,
  Birthday date,
  Email nvarchar(30),
  Position nvarchar(30),
  Department nvarchar(30)
)

--обновление поля
ALTER TABLE Employees ALTER COLUMN Name_emp nvarchar(50)

ALTER TABLE Employees ADD CONSTRAINT PK_Employees PRIMARY KEY(ID_emp)

--опять удалим
DROP TABLE Employees

--создаём новую и со всеми интересностями
CREATE TABLE Employees(
  ID_emp int NOT NULL,
  Name_emp nvarchar(30) NOT NULL,
  Birthday date,
  Email nvarchar(30),
  Position nvarchar(30),
  Department nvarchar(30),
  CONSTRAINT PK_Employees PRIMARY KEY(ID_emp) -- описываем PK после всех полей, как ограничение
)

INSERT Employees(ID_emp,Position,Department,Name_emp) VALUES
(1000,N'Директор',N'Администрация',N'Иванов И.И.'),
(1001,N'Программист',N'ИТ',N'Петров П.П.'),
(1002,N'Бухгалтер',N'Бухгалтерия',N'Сидоров С.С.'),
(1003,N'Старший программист',N'ИТ',N'Андреев А.А.')

--удаление ограничения
ALTER TABLE Employees DROP CONSTRAINT PK_Employees

--временная таблица
CREATE TABLE #Temp(
  ID_emp int,
  Name_emp nvarchar(30)
)

--удаляем её
DROP TABLE #Temp

--создаём её уже с данными из другой таблицы
SELECT ID_emp,Name_emp
INTO #Temp
FROM Employees

--2 таблицы справочники «Должности» и «Отделы», первую назовем Positions, а вторую соответственно Departments:

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

-- заполняем поле Name таблицы Positions, уникальными значениями из поля Position таблицы Employees
INSERT Positions(Name_pos)
SELECT DISTINCT Position
FROM Employees
WHERE Position IS NOT NULL -- отбрасываем записи у которых позиция не указана

--То же самое проделаем для таблицы Departments:
INSERT Departments(Name_dep)
SELECT DISTINCT Department
FROM Employees
WHERE Department IS NOT NULL

SELECT * FROM Positions
SELECT * FROM Departments

-- добавляем поле для ID должности
ALTER TABLE Employees ADD PositionID int
-- добавляем поле для ID отдела
ALTER TABLE Employees ADD DepartmentID int

--Так же добавить в таблицу сразу несколько полей можно одной командой, перечислив поля через запятую:
ALTER TABLE Employees ADD PositionID int, DepartmentID int

--Теперь пропишем ссылки (ссылочные ограничения — FOREIGN KEY) для этих полей, для того чтобы пользователь
--не имел возможности записать в данные поля, значения, отсутствующие среди значений ID находящихся в справочниках.
ALTER TABLE Employees ADD CONSTRAINT FK_Employees_PositionID
FOREIGN KEY(PositionID) REFERENCES Positions(ID_pos)

ALTER TABLE Employees ADD CONSTRAINT FK_Employees_DepartmentID
FOREIGN KEY(DepartmentID) REFERENCES Departments(ID_dep)

-- теперь обновим поля PositionID и DepartmentID значениями ID из справочников.
UPDATE e
SET
  PositionID=(SELECT ID_pos FROM Positions WHERE Name_pos=e.Position),
  DepartmentID=(SELECT ID_dep FROM Departments WHERE Name_dep=e.Department)
FROM Employees e
--Посмотрим, что получилось, выполнив запрос:
SELECT * FROM Employees

--поля PositionID и DepartmentID заполнены соответствующие должностям и отделам идентификаторами надобности 
--в полях Position и Department в таблице Employees теперь нет, можно удалить эти поля:
ALTER TABLE Employees DROP COLUMN Position,Department

--Теперь таблица у нас приобрела следующий вид:
SELECT * FROM Employees

--Т.е. мы в итоге избавились от хранения избыточной информации. 
--Теперь, по номерам должности и отдела можем однозначно определить их названия, используя значения в таблицах-справочниках:
SELECT e.ID_emp,e.Name_emp,p.Name_pos PositionName,d.Name_dep DepartmentName
FROM Employees e
LEFT JOIN Departments d ON d.ID_dep=e.DepartmentID
LEFT JOIN Positions p ON p.ID_pos=e.PositionID

--таблица может ссылаться сама на себя, т.е. можно создать рекурсивную ссылку.
--Для примера добавим в нашу таблицу с сотрудниками еще одно поле ManagerID, которое будет указывать на сотрудника,
--которому подчиняется данный сотрудник. Создадим поле:
ALTER TABLE Employees ADD ManagerID int

--Теперь создадим FOREIGN KEY на таблицу Employees:
ALTER TABLE Employees ADD CONSTRAINT FK_Employees_ManagerID
FOREIGN KEY (ManagerID) REFERENCES Employees(ID_emp)

--пересоздадим таблицу с указанием опции ON DELETE CASCADE для FK_Employees_DepartmentID:
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
(1000,N'Иванов И.И.','19550219',101,1000,NULL),
(1001,N'Петров П.П.','19831203',102,1010,1003),
(1002,N'Сидоров С.С.','19760607',103,1020,1000),
(1003,N'Андреев А.А.','19820417',104,1030,1000)

DELETE Departments WHERE ID_dep=3

SELECT * FROM Employees

--
UPDATE Departments
SET
  ID_dep=30
WHERE ID_dep=3

-- даем разрешение на добавление/изменение IDENTITY значения
SET IDENTITY_INSERT Departments ON

INSERT Departments(ID_dep,Name_dep) VALUES(3,N'ИТ')

-- запрещаем добавление/изменение IDENTITY значения
SET IDENTITY_INSERT Departments OFF

--Полностью очистим таблицу Employees при помощи команды TRUNCATE TABLE:
TRUNCATE TABLE Employees

--
INSERT Employees (ID_emp,Name_emp,Birthday,PositionID,DepartmentID,ManagerID)VALUES
(1000,N'Иванов И.И.','19550219',101,1000,NULL),
(1001,N'Петров П.П.','19831203',102,1010,1003),
(1002,N'Сидоров С.С.','19760607',103,1020,1000),
(1003,N'Андреев А.А.','19820417',104,1030,1000)


--
UPDATE Employees SET Email='i.ivanov@test.tt' WHERE ID_emp=1000
UPDATE Employees SET Email='p.petrov@test.tt' WHERE ID_emp=1001
UPDATE Employees SET Email='s.sidorov@test.tt' WHERE ID_emp=1002
UPDATE Employees SET Email='a.andreev@test.tt' WHERE ID_emp=1003

--А теперь можно наложить на это поле ограничение-уникальности:
ALTER TABLE Employees ADD CONSTRAINT UQ_Employees_Email UNIQUE(Email)

--Давайте добавим в таблицу Employees новое поле «Дата приема» и назовем его HireDate и
--скажем что значение по умолчанию у данного поля будет текущая дата:
ALTER TABLE Employees ADD HireDate date NOT NULL DEFAULT SYSDATETIME()

--Или если столбец HireDate уже существует, то можно использовать следующий синтаксис:
ALTER TABLE Employees ADD DEFAULT SYSDATETIME() FOR HireDate

--с именем ограничения
ALTER TABLE Employees ADD CONSTRAINT DF_Employees_HireDate DEFAULT SYSDATETIME() FOR HireDate

--
INSERT Employees(ID_emp,Name_emp,Email)VALUES(1004,N'Сергеев С.С.','s.sergeev@test.tt')

SELECT * FROM Employees

--При помощи данного ограничения скажем, что табельные номера должны иметь значение от 1000 до 1999:
ALTER TABLE Employees ADD CONSTRAINT CK_Employees_ID CHECK(ID_emp BETWEEN 1000 AND 1999)

--проверка работы ограничения
INSERT Employees(ID_emp,Email) VALUES(2000,'test@test.tt')

--А теперь изменим вставляемое значение на 1500 и убедимся, что запись вставится:
INSERT Employees(ID_emp,Email) VALUES(1500,'test@test.tt')

--Можно так же создать ограничения UNIQUE и CHECK без указания имени:
ALTER TABLE Employees ADD UNIQUE(Email)
ALTER TABLE Employees ADD CHECK(ID_emp BETWEEN 1000 AND 1999)

--все эти ограничения можно создать сразу же при создании таблицы, если ее еще нет. Удалим таблицу:
DROP TABLE Employees

--И пересоздадим ее со всеми созданными ограничениями одной командой CREATE TABLE:
CREATE TABLE Employees(
  ID_emp int NOT NULL,
  Name_emp nvarchar(30),
  Birthday date,
  Email nvarchar(30),
  PositionID int,
  DepartmentID int,
  HireDate date NOT NULL DEFAULT SYSDATETIME(), -- для DEFAULT я сделаю исключение
CONSTRAINT PK_Employees PRIMARY KEY (ID_emp),
CONSTRAINT FK_Employees_DepartmentID FOREIGN KEY(DepartmentID) REFERENCES Departments(ID_dep),
CONSTRAINT FK_Employees_PositionID FOREIGN KEY(PositionID) REFERENCES Positions(ID_pos),
CONSTRAINT UQ_Employees_Email UNIQUE (Email),
CONSTRAINT CK_Employees_ID CHECK (ID_emp BETWEEN 1000 AND 1999)
)

INSERT Employees (ID_emp,Name_emp,Birthday,Email,PositionID,DepartmentID)VALUES
(1000,N'Иванов И.И.','19550219','i.ivanov@test.tt',101,1000),
(1001,N'Петров П.П.','19831203','p.petrov@test.tt',102,1010),
(1002,N'Сидоров С.С.','19760607','s.sidorov@test.tt',103,1020),
(1003,N'Андреев А.А.','19820417','a.andreev@test.tt',104,1030)

--Для примера сделаем индекс ограничения PK_Employees некластерным, а индекс ограничения UQ_Employees_Email кластерным.
--Первым делом удалим данные ограничения:
ALTER TABLE Employees DROP CONSTRAINT PK_Employees
ALTER TABLE Employees DROP CONSTRAINT UQ_Employees_Email

--А теперь создадим их с опциями CLUSTERED и NONCLUSTERED:
ALTER TABLE Employees ADD CONSTRAINT PK_Employees PRIMARY KEY NONCLUSTERED (ID_emp)
ALTER TABLE Employees ADD CONSTRAINT UQ_Employees_Email UNIQUE CLUSTERED (Email)

SELECT * FROM Employees

--Индексы по полю или полям можно создавать следующей командой:
CREATE INDEX IDX_Employees_Name ON Employees(Name_emp)

CREATE UNIQUE NONCLUSTERED INDEX UQ_Employees_EmailDesc ON Employees(Email DESC)

--Удалить индекс можно следующей командой:
DROP INDEX IDX_Employees_Name ON Employees

--Для примера снова удалим таблицу:
DROP TABLE Employees

--И пересоздадим ее со всеми созданными ограничениями и индексами одной командой CREATE TABLE:
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
(1000,N'Иванов И.И.','19550219','i.ivanov@test.tt',101,1000,NULL),
(1001,N'Петров П.П.','19831203','p.petrov@test.tt',102,1010,1003),
(1002,N'Сидоров С.С.','19760607','s.sidorov@test.tt',103,1020,1000),
(1003,N'Андреев А.А.','19820417','a.andreev@test.tt',104,1030,1000)

select * from Employees

--Узнал, как обновлять поля, как делать для них новые функции и как работать с ними.