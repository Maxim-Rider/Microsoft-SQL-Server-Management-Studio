--Максим Колесников
--Education Database


--1) Создание базы данных.
Create database Education
On (name=education_dat,
	Filename = 'E:\SQLDatabases\education.mdf',
	Size = 5,
	Maxsize = 100,
	Filegrowth = 5)
Log on
	(Name = education_log,
	Filename = 'E:\SQLDatabases\education.ldf',
	Size = 10,
	Maxsize = 100,
	Filegrowth = 10);

--2) Создание таблицы Students.
Use Education
Create table Students
(idcode char(11) not null primary key,
student_name varchar(50) not null,
city varchar(50) not null,
address varchar(50) not null);

--drop table Students

--3) Создание таблицы Training.
Create table Training 
(idcode char(11) not null primary key,
specialty varchar(50) not null,
group_name varchar(10) not null,
status varchar(50) not null,
arrival_date date not null,
finish_date date null,
comment varchar(50) null,
check (status in ('active', 'finish', 'dismissed')));

--drop table Training

--4) Создание таблицы Groups.
Create table Groups 
(group_name varchar(10) not null primary key,
group_code int identity(10000, 1) not null,
language varchar(50) not null,
location varchar(50) not null,
training_time varchar(50) not null,
form_master varchar(50) null,
check (language in ('russian', 'estonian')));

--drop table Groups

--5) Создание таблицы Specialty.
Create table Specialty
(specialty varchar(50) not null primary key,
module_code char(4) not null,
location varchar(50) not null);

--drop table Specialty

--6) Создание таблицы Department.
Create table Department 
(department varchar(50) not null primary key,
department_code char(10) not null,
education varchar(50) not null,
education_form varchar(50) not null,
head varchar(50) not null,
mail varchar(50) not null);

--drop table Department

--7) Заполнение таблицы Students.
select * from Students
Insert Students (idcode, student_name, city, address) values ('50103273728','Maksim Kolesnikov', 'Narva', 'Kangelaste 19-81')
Insert Students (idcode, student_name, city, address) values ('50103275812','Igor Sokolov', 'Narva', 'Kangelaste 17-25')
Insert Students (idcode, student_name, city, address) values ('50103274824','Artem Goncharov', 'Narva', 'Daumani 19-45')
Insert Students (idcode, student_name, city, address) values ('50103279572','Alina Begunova', 'Narva', 'Daumani 25-75')
Insert Students (idcode, student_name, city, address) values ('50103275154','Viktor Pavlov', 'Narva', 'Kreenholm 10-21')
Insert Students (idcode, student_name, city, address) values ('50103279091','Alex Pavlenko', 'Narva', 'Kreenholm 19-34')
Insert Students (idcode, student_name, city, address) values ('50103272512','Zahar Obramovich', 'Narva', 'Kulgu 20-43')
Insert Students (idcode, student_name, city, address) values ('50103278081','Petr Petrovich', 'Narva', 'Kulgu 22-43')
Insert Students (idcode, student_name, city, address) values ('50103272451','Ivan Petrovich', 'Narva', 'Kulgu 23-43')
Insert Students (idcode, student_name, city, address) values ('50103275482','Sergei Ivanov', 'Narva', 'Kangelaste 23-43')
Insert Students (idcode, student_name, city, address) values ('50103270512','Juri Sergeevich', 'Narva', 'Daumani 23-43')
Insert Students (idcode, student_name, city, address) values ('50103279052','Artem Sergeevich', 'Sillamae', 'Daumani 22-43')
Insert Students (idcode, student_name, city, address) values ('50103275106','Artem Sidorov', 'Sillamae', 'Daumani 67-16')
Insert Students (idcode, student_name, city, address) values ('50103279006','Viktor Ivanov', 'Sillamae', 'Daumani 50-90')
Insert Students (idcode, student_name, city, address) values ('50103279950','Artur Petrenko', 'Sillamae', 'Daumani 40-90')



--8) Заполнение таблицы Groups.
select * from groups
Insert Groups (group_name, language, location, training_time) values ('SPTVR19', 'russian', 'Sillamae', '4 years')
Insert Groups (group_name, language, location, training_time) values ('JPTVR19', 'estonian', 'Jõhvi', '4 years')
Insert Groups (group_name, language, location, training_time) values ('SPTV17', 'russian', 'Sillamae', '3 years')
Insert Groups (group_name, language, location, training_time) values ('SPME17', 'russian', 'Sillamae', '3 years')
Insert Groups (group_name, language, location, training_time) values ('SPME19', 'russian', 'Sillamae', '3 years')
update groups set form_master = 'Andrei Izmalkov' where group_name = 'SPTVR19'




--9) Заполнение таблицы Department.
select * from department
Insert Department (department, department_code, education, education_form, head, mail) values ('IT', '154347' , 'Main', 'Statical', 'Natella Mihhailova', 'natella.mihhailova@ivkhk.ee')
Insert Department (department, department_code, education, education_form, head, mail) values ('Metal', '543267' , 'Main', 'Statical', 'Jelena Kruglova', 'jelena.kruglova@ivkhk.ee')


--10) Заполнение таблицы Specialty.
select * from specialty
Insert Specialty (specialty, module_code, location) values ('IT academy', '4357', 'Sillamae')
Insert Specialty (specialty, module_code, location) values ('Junior Software Developer', '2463', 'Sillamae')
Insert Specialty (specialty, module_code, location) values ('Metalworking', '5275', 'Sillamae')



--11) Заполнение таблицы Training.
-- *Примечание: 
--arrival_date - это дата поступления.
--finish_date - это дата окончания обучения.

select * from training
Insert Training (idcode, specialty, group_name, status, arrival_date, finish_date, comment) values ('50103273728', 'IT academy', 'SPTVR19', 'active', '2019-09-01', null, null)
Insert Training (idcode, specialty, group_name, status, arrival_date, finish_date, comment) values ('50103275812', 'IT academy', 'SPTVR19', 'active', '2019-09-01', null, null)
Insert Training (idcode, specialty, group_name, status, arrival_date, finish_date, comment) values ('50103274824', 'IT academy', 'SPTVR19', 'active', '2019-09-01', null, null)
Insert Training (idcode, specialty, group_name, status, arrival_date, finish_date, comment) values ('50103279572', 'IT academy', 'JPTVR19', 'active', '2019-09-01', null, null)
Insert Training (idcode, specialty, group_name, status, arrival_date, finish_date, comment) values ('50103275154', 'IT academy', 'JPTVR19', 'active', '2019-09-01', null, null)
Insert Training (idcode, specialty, group_name, status, arrival_date, finish_date, comment) values ('50103279091', 'Junior Software Developer', 'SPTV17', 'finish', '2017-09-01', '2020-07-30', 'Graduated successfully')
Insert Training (idcode, specialty, group_name, status, arrival_date, finish_date, comment) values ('50103272512', 'Junior Software Developer', 'SPTV17', 'finish', '2017-09-01', '2020-07-30', 'Graduated successfully')
Insert Training (idcode, specialty, group_name, status, arrival_date, finish_date, comment) values ('50103278081', 'Metalworking', 'SPME17', 'finish', '2017-09-01', '2020-07-30', 'Graduated successfully')
Insert Training (idcode, specialty, group_name, status, arrival_date, finish_date, comment) values ('50103272451', 'Metalworking', 'SPME17', 'finish', '2017-09-01', '2020-07-30', 'Graduated successfully')
Insert Training (idcode, specialty, group_name, status, arrival_date, finish_date, comment) values ('50103275482', 'Metalworking', 'SPME19', 'active', '2019-09-01', null, null)
Insert Training (idcode, specialty, group_name, status, arrival_date, finish_date, comment) values ('50103270512', 'Metalworking', 'SPME19', 'active', '2019-09-01', null, null)
Insert Training (idcode, specialty, group_name, status, arrival_date, finish_date, comment) values ('50103279052', 'Metalworking', 'SPME17', 'dismissed', '2017-09-01', '2019-04-25', 'Dismissed for academic failure')
Insert Training (idcode, specialty, group_name, status, arrival_date, finish_date, comment) values ('50103275106', 'Metalworking', 'SPME17', 'dismissed', '2017-09-01', '2019-03-19', 'Dismissed for academic failure')
Insert Training (idcode, specialty, group_name, status, arrival_date, finish_date, comment) values ('50103279006', 'Junior Software Developer', 'SPTV17', 'dismissed', '2017-09-01', '2018-01-20', 'Dismissed for academic failure')
Insert Training (idcode, specialty, group_name, status, arrival_date, finish_date, comment) values ('50103279950', 'Junior Software Developer', 'SPTV17', 'dismissed', '2017-09-01', '2018-05-08', 'Dismissed for academic failure')




-------------------------
select * from Students
select * from groups
select * from department
select * from specialty
select * from training

--1. Запрос – вывод списка учащихся, обучающихся в конкретной группе (критерий по группе)
select * from students
where idcode in (select idcode from training
				where group_name = 'SPTVR19' and status = 'active')

select * from students
where idcode in (select idcode from training
				where group_name = 'JPTVR19' and status = 'active')

select * from students
where idcode in (select idcode from training
				where group_name = 'SPME19' and status = 'active')


--2. Подсчет количества учащихся, обучающихся в каждой группе
select count(idcode) as StudentsCount, group_name from training
where status = 'active'
group by group_name



--3. Сколько учащихся закончило обучение по каждой специальности
select count(idcode) as Number_of_Graduates, specialty from training
where status = 'finish'
group by specialty


--4. Сколько учащихся учится в текущее время  по каждой специальности
select count(idcode) as Studying_at_Current_Time, specialty from training
where status = 'active'
group by specialty


--5. Сколько учащихся было отчислено ежегодно по каждой специальности
select count(idcode) as Dismissed_Students, specialty, year(finish_date) as year from training
where status = 'dismissed'
group by specialty, year(finish_date)


