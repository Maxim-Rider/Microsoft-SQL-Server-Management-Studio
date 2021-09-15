--Дата: 26.05.2021
--Автор: Максим Колесников
--ТЕМА 20. Представления

--Создание представления
use sample_primer
go
create view v_clerk
as select emp_no, project_no, enter_date, job
from works_on
where job = 'Clerk';
go
select * from v_clerk;

--Явное задание имен столбцов для представления
create view v_count (project_no, count_emp)
as select project_no, count(*)
from works_on
group by project_no
go

select * from v_count

--Представление на базе другого представления
create view v_project_p2
as select * --emp_no
from v_clerk
where project_no = 'p2';
go

select * from v_project_p2

--Изменение представления - ALTER VIEW
alter view v_without_budget
as select project_no, project_name
from project
where project_no >= 'p3';
go

--Инструкция INSERT и представление (1)
create view v_dept
as select dept_no, dept_name
from department
go 
insert into v_dept values ('d4', 'Development');
go

delete from department where dept_no = 'd4'
--Пробный вариант -тестирование
alter table department
alter column location varchar(15) not null
--Вернули в исходное состояние
alter table department
alter column location varchar(25) null

select * from v_dept

--Применение WITH CHECK OPTION
create view v_2006_check
as select emp_no, project_no, enter_date
from works_on
where enter_date between '2006-01-01' and '2006-12-31'
with check option; 
go 
insert into v_2006_check values (22334, 'p2', '2007-01-15')

--Инструкция UPDATE и представление
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

/*Информация о представлениях
• Наиболее важным представлением каталога применительно к
представлениям является sys.objects
• Это представление каталога содержит информацию касательно
всех объектов в текущей базе данных
• Все строки представления каталога со значением v в столбце
type содержат информацию о представлениях
• Представление каталога sys.views содержит дополнительную
информацию о существующих представлениях.
• Наиболее важным столбцом этого представления является
столбец with_check_option, который информирует, указано или
нет предложение WITH CHECK OPTION.
• Запрос для определенного представления можно отобразить
посредством системной процедуры sp_helptext. */









