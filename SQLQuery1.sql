/*(һ)DML����*/
--1
INSERT INTO student (sNo,sName ,mNo, sSex,sNative,sBirth,sHeight,sWeight) 
VALUES ('091940101','�Ŵ���','061201','��','���ϳ�ɳ', '1990-08-12',171,65)
GO
INSERT INTO student (sNo,sName ,mNo, sSex,sNative,sBirth,sHeight,sWeight)
VALUES ('091940102','������','061201','Ů','����', '1991-04-12',166,53)
GO
INSERT INTO student (sNo,sName ,mNo, sSex,sNative,sBirth,sHeight,sWeight)
VALUES ('091940103','����ף','061201','��','�㶫��ɽ', '1990-05-26',173,68)
GO
INSERT INTO student (sNo,sName ,mNo, sSex,sNative,sBirth,sHeight,sWeight) 
VALUES('091940114','�̴���','061211','��','�㶫����', '1991-08-26',167,61)
GO
--2
UPDATE student SET sEntime='2018/9/1'

UPDATE student_course SET mark=mark+5 WHERE mark<60

--3
UPDATE student SET sNative='���Ϻ���' WHERE sName='�Ŵ���'

UPDATE student SET sNative='���Ϻ���' WHERE  

--4
DELETE FROM student_course WHERE mark =40

DELETE FROM student WHERE sName='�̴���'

DELETE FROM major WHERE mName='�������'

--5(1)
update teacher set tRank='������' where tName='������'
/*
--5(2)
insert info course 

--5(3)
insert info student_course
insert info student_course*/

/*��һ��DML ����*/
--1
INSERT INTO student(sNo,sName,mNo,sSex,sNative,sBirth,sHeight,sWeight)
VALUES('10154050101', '������', '061201', '��', '���ϳ���', '1995-08-12',171,65)
GO
/*ԭ��:���ض��ַ�������������ݡ�ѧ���������洢��Χ*/
INSERT INTO student(sNo,sName,mNo,sSex,sNative,sBirth,sHeight,sWeight)
VALUES('101940102', '��ǿ��', '060606', '��', '�ӱ�����', '1994-08-12',166,55)
/*ԭ��:INSERT �����FOREIGN KEY Լ��"FK_student_major"��ͻ���ó�ͻ���������ݿ�"stuManage2"����"dbo.major", column 'mNO'��*/

insert into student(sNo,sName,mNo,sSex,sNative,sBirth,sHeight,sWeight)
values('101540501', '������', '061201', '��', '���ϳ���', '1995-08-12',171,65)
go
insert into student(sNo,sName,mNo,sSex,sNative,sBirth,sHeight,sWeight)
values('101940102', '��ǿ��', '061201', '��', '�ӱ�����', '1994-08-12',166,55)
go

--2
update student set sHeight=sHeight+5 
update student set sWeight=sWeight-1 where sSex='Ů'

--3
update teacher set tName='�',tRank='��ʦ',tSex='��',tDegree='��ʿ' where tName='������'
		

/*����������ѯ����*/
--1����ѯ�������ŷ���ͬһ����ᣬ������������ѧ����
select *
from student
where sNative=(
	select sNative
	from student
	where sname='�ŷ�'
	)
	and
	(GETDATE()-sbirth)>(
	select(GETDATE()-sbirth) as '����'
	from student
	where sName='�ŷ�'
	)


--2��������ϵ�бȼ����ϵ����ѧ�����䶼С��ѧ����
select *
from department,student
where dName!='�����ϵ' and year(getdate())-year(sbirth)<(
	select min(year(getdate())-year(sbirth)) as '��С����'
	from department,student
	where dName='�����ϵ'
)

--3����ѯÿһ��ѧ���Ŀγ�ѡ�����������ûѡ�εģ���Ҫ����ʾѧ�ţ����������α�ż��ɼ���������ʾûѡ�ε�ͬѧ��Ϣ��
select s.sNo,sName,ccNO,Mark
from student s,student_course sc
where s.sNO=sc.sNO
group by s.sNO,sName,ccNO,Mark
order by mark asc

--4����ѯ���ߵ���ѧ�γ̵ĳɼ����������ɼ���ѧ��ѧ�źͳɼ���
select sNO,Mark
from student_course sc,course c,course_class cc
where cc.ccNO=sc.ccNO and c.cNO=cc.cNO and c.cName='�ߵ���ѧ' and sc.Mark>(
	select Mark
	from student s,student_course sc,course c,course_class cc
	where s.sName='����' and s.sNO=sc.ccNO and sc.ccNO=cc.ccNO and c.cName='�ߵ���ѧ' and c.cNO=cc.cNO
	)

--5��������ѡ����ѧ��Ϊ��090120206����ѧ����ѡ��ȫ���γ̵�ѧ��ѧ�ź�������
select distinct s.sNo,sName
from student s,student_course sc
where not exists
(
	select *
	from student_course a
	where a.sNO='090120206' and not exists
	(
		select *
		from student_course b
		where b.ccNO=a.ccNO and
		a.sNo=sc.sNO
	)
)