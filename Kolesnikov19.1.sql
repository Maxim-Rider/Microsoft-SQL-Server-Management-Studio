--Автор: Максим Колесников
--Дата: 19.05.2021

--Упражнение 19.1
use sample_primer
--Создайте таблицу employee_30 при помощи SQL-запроса, по структуре таблица
--аналогична т. employee.
drop table employee_30
Create table employee_30 (
emp_no int not null,
emp_fname varchar(50) null,
emp_lname varchar(50) null,
dept_no char(10) null,
salary money null
)

--Создайте пакет 1 для вставки 30 строк в таблицу employee_30. Значения
--столбца emp_no должны быть последовательными от 1 до 30 (примените
--цикл WHILE).
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

--Всем ячейкам столбцов emp_lname, emp_fname и dept_no соответственно, в
--каждой строке присваиваются одинаковые значения (значения предложите
--сами через локальные переменные).
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
--При добавлении каждой строки в таблицу выведите сообщение на экран (код
--строки и комментарий), примените функции CAST или CONVERT
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
	  print 'Код строки: ' + cast(@emp_no2 as char(12)) +'.' + 'Строка получила следующие значения:' + cast(@value2 as char(12))
END
------
select * from employee_30

--Упражнение 19.2
/*Скопируйте и измените пакет из упражнения 19.1 таким образом, чтобы
генерировать случайные целые значения для столбца emp_no, используя
функцию RAND(). Генерируются числа в интервале от 2-х значного до 4-х
значного числа.*/
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
Всем ячейкам столбцов emp_lname, emp_fname и dept_no соответственно, в
каждой строке присваиваются одинаковые значения (значения укажите сами
в операторе INSERT).
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
Упражнение 19.3
При генерации новых чисел, есть вероятность, что будет сгенерировано
повторно какое-то число. Но ключевое поле не может содержать дубликаты.
Измените пакет из упражнения 19.2 таким образом, чтобы генерировать
случайные повторяющиеся значения для столбца emp_no, используя
функцию RAND()
Для демонстрации повторяющихся чисел, уменьшите диапазон выбираемых
чисел (например от 200 до 270).
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
/*Всем ячейкам столбцов emp_lname, emp_fname и dept_no соответственно, в
каждой строке присваиваются одинаковые значения (значения укажите сами
в операторе INSERT).*/
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
