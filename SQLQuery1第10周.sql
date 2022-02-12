--��1������һ������ѧ����ѧ�ż�����Ź��ε�ƽ���ɼ�����ͼV_STU_AVG��
CREATE VIEW V_STU_AVG(sNO,AVGMARK)
AS 
	SELECT SNO,AVG(MARK)
	FROM student_course
	GROUP BY sNO
	
--��2�����Զ���ͼV_STU_AVGִ������������䡣
UPDATE V_STU_AVG
SET AVGMARK=85
WHERE sNO='081220102'
DELETE
FROM V_STU_AVG
WHERE sNO='081220102'
--����ͼ���� 'V_STU_AVG' �ĸ��»����ʧ�ܣ�������������������

--��3����һ��������ʦ��š���ʦ�������Ա�����յ�060606�������н�ʦ����ͼ��
--�����Ա�����յ�060606�������н�ʦ����ͼ��
CREATE VIEW V_TEACHER1
AS
	SELECT TNO,TNAME,TSEX,DNO
	FROM teacher
	WHERE DNO='100002' AND TSEX='Ů'
with check option

--��4��ִ������������䣬���Զ���ͼV_TEACHER1����DML������
INSERT INTO V_TEACHER1
VALUES('090901','������','Ů','100002')
insert into V_TEACHER1
values('090902','��¸�','��','100002')
delete
from V_TEACHER1
where tNO='090901'
--��ͼ���еĲ���������ʧ�ܣ�ԭ����Ŀ����ͼ����Ŀ����ͼ����Խ��ĳһ��ͼָ���� WITH CHECK OPTION�����ò�����һ������������ֲ����� CHECK OPTION Լ����

--��5��ʹ��T-SQL����޸���ͼ
alter view v_teacher1
as
	select tno,tname,tsex,trank,dno
	from teacher
	where dNo='100002' and tSex='Ů'
	
select * 
from v_teacher1

--��6��ִ������������䣬�ٴγ��Զ���ͼteacher1_view����DML������
insert into v_teacher1
values('090901','������','Ů','��ʦ','100002')
insert into v_teacher1
values('090902','��¸�','��','��ʦ','100002')

--��7��ʹ��T-SQL ���ɾ����ͼ
DROP VIEW V_TEACHER1
/*����*/
--��1��ʹ��SQL���ΪstuManage���ݿ��student_course��ġ�mark���ֶδ���һ���Ǿۼ�����������ΪIX_SC_MARK��
create index ix_sc_mark on student_course(mark)

--Ϊstudent��ġ�sName���͡�sSex���ֶδ���һ������Ψһ����������ΪIX_STUDENT_NAMESEX��
create unique index ix_student_namesex on student(sname,ssex)

--��3��ʹ��ϵͳ�洢����SP_HELPINDEX�鿴student_course���ϵ�������Ϣ��
sp_helpindex student_course

--��4��ʹ��ϵͳ�洢����SP_RENAME������IX_SC_MARK����ΪIX_S_C_MARK��
sp_rename 'student_course.IX_SC_MARK','IX_S_C_MARK','INDEX'
--ע��: ���Ķ���������һ���ֶ����ܻ��ƻ��ű��ʹ洢���̡�

--��5��ʹ��DROP INDEXɾ������IX_S_C_MARK��
drop index student_ourse.ix_s_c_mark

--����student���д�����������
create index ix_stu_sname on student(sname)
create index ix_stu_ssex on student(ssex)
create index ix_stu_sweight on student(sweight)

--�ڲ鿴�����ѯ����ִ�мƻ�����˼����ִ�мƻ���
select *
from student
where sNO='091650105'
go
select *
from student
where sName='������'

select *
from student
where sSex='Ů'
go
select COUNT(*),ssex
from student
group by sSex
 --�ٴ�����stu2������Ӵ�������
 select *
 into stu2
 from student
 
 --
 insert into stu2
 select * from stu2
 
 insert into stu2(sNO,sName,mNO,sSex)
 values('1112223333','С�컨','100164','Ů')
 
 --���ڱ�stu2�д�����������
 create index ix_sname_stu2 on stu2(sname)

--�۲鿴��������ִ�мƻ�����˼��
select *
from stu2
where sName='������'

select *
from stu2
where sName='С�컨'
