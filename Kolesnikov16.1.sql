--�����: ������ ����������
--����: 12.05.2021
--���� 16. �������������� ���� ������ � �� �������
--���� 17. ������� ��� ��������� ����� ������ - ���� � �����. ������� ��� ��������������� ���
use sample_primer

create table MyUniqueTable (UniqueColumn uniqueidentifier default newid(), Characters varchar(10))
go
insert into MyUniqueTable(Characters) values ('abc')
insert into MyUniqueTable values (newid(), 'def')
go