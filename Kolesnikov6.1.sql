USE sample_primer
--���������� 6.11 --������������ ��� ������ �� �� ���������������. 
select location, COUNT(location) AS QuantityDepartments from department
group by location

--���������� 6.12. ��������� ������� ����� ������������� DISTINCT � GROUP BY.

-- Distinct ��������� ����������, Group by ��������� ���������� � ��������� ������.

--���������� 6.13 ��� ����������� GROUP BY ������������ �������� NULL? ������� �� ��� ���������
--������� ��������� ���� ��������?

--Null �������� ������� ������������ � ��������� ������. ���� ������� ����������� �������� null ��������, �� ��� null �������� ��������� ������� � ���������� � ���� ������.
-
--���������� 6.14 ��������� ������� ����� ����������� ��������� COUNT(*) � COUNT(column).

--COUNT(expression) - ������� �������� (�������/��������) � ���������� ��� �� NULL ��������� ��������� COUNT(*) - ������� ��� ������ (�� ����� NULL ��� ���).

--���������� 6.15 ��������� ������� ����������� ���������� ������ ����������.
SELECT MAX(emp_no) as emp_no FROM employee

--���������� 6.16 (a, b, c)
--a. ������� ����������� �������� � ������ ������
select dept_no, count(dept_no) as QuantityEmployees from employee
group by dept_no
--b. ������� ����������� �������� ��� ������ ��������
select project_no, count(emp_no) as QuantityEmployees from works_on
group by project_no
--c. ������� ����� �������� ������ �� �����������
select job, count(job) as QuantityJobs from works_on
where job is not null
group by job


--���������� 6.17 ��������� ������� ����������, ���������� ������, ��� ����� ������������.
SELECT job FROM works_on
WHERE job IS NOT NULL
GROUP BY job
HAVING COUNT(*) > 2