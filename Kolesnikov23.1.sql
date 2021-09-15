--Автор: Максим Колесников
--Дата: 14.06.2021
--ТЕМА 23. Триггеры 

use sample_primer

--Использование инструкции MERGEcreate table bonus(pr_no char(4),bonus smallint default 100);insert into bonus (pr_no) values ('p1');/*Вставка новых строк данных в таблицу
bonus – инструкция MERGE (2)*/merge into bonus B	using (select project_no, budget from project) E		on (B.pr_no = E.project_no)	when matched then		update set B.bonus = E.budget * 0.1	when not matched then		insert (pr_no, bonus)			values (E.project_no, E.budget * 0.05);select * from projectselect * from bonus/*Применение инструкции OUTPUTс
инструкцией DELETE*/
declare @del_table table (emp_no int, emp_lname char(20))

delete employee
output deleted.emp_no, deleted.emp_lname into @del_table
where emp_no = 77777

select * from @del_table
----------------
select * from employee
insert employee values (77777, 'Anu', 'Aro', 'd2', null)

--I. Создание журнала аудита
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


--Тестирование
UPDATE project
SET budget = 150000
WHERE project_no = 'p2';

select * from audit_budget