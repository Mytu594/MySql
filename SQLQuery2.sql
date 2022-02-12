--2(1)
select *
from student_course
where mark between 80 and 85
/*��ѯ80�ֵ�85�ֵ�ѧ����Ϣ*/

--2(2)
select count(*)
from student
where mNo='100165' and sSex='Ů'
/*ͳ��רҵ��Ϊ'100165'��Ůͬѧ������*/

--2(3)
select distinct left(sName,1)
from student
/*��ѯ����ѧ��������(ȥ�ظ�)*/
select distinct substring(sName,1,1)
from student

--2(4)
select sNo,sName
from student
where sName like '[����]%'
/*��ѯ�����ճº����ͬѧѧ�ź�����*/

--2(5)
select ccNo as '���α��',avg(mark) as 'ƽ����'
from student_course
where sNo like '09165%'
group by ccNO
/*��ѯ"09165"רҵ�Ŀ��α���Լ��γ�ƽ����*/

--3(1)
select count(*) as 'ѡ������',avg(mark) as 'ƽ����'
from student_course
where sNo like '0916502%'
group by ccNo
having count(*)>5

--3(2)
select sNo,sName,sSex,sBirth
from student
where sBirth>'1993/12/31'

--3(3)
select sNo,sName
from student
where sName like '___'

--3(4)
select sNo,avg(mark) as 'ƽ����',max(mark) as '��߷�',min(mark) as '��ͷ�'
from student_course
group by sNo
order by avg(mark) desc

--3(5)
select top 3 sNo,mark
from student_course
where ccNo='0901120001'
order by Mark desc

/*(��)������ݲ�ѯ*/
--1(1)
select sNo,sName,sSex,mName
from student s
left join Major m on s.mNo=m.mNo

--1(2)
select sc.sNo AS 'ѧ��',sName AS '����',COUNT(*) AS 'û�м��������'
from student_course sc,student s
where mark<60 AND s.sNo=sc.sNo
group by sc.sNo,sName

--1(3)
select left(s.sNo,7),count(*) as '����'
from student s,major m
where m.mName='�������ѧ�뼼��' and s.mNo=m.mNo
group by left(s.sNo,7)

--1(4)
select s.sNo,sName,mark
from student s,student_course sc
where s.sNo=sc.sNo and ccNo='0324091007' and mark>=(
	select avg(mark)
	from student_course
	where ccNo='0324091007'
)

--1(5)
select count(distinct cNo)
from course_class cc,student_course sc
where cc.ccNO=sc.ccNO

--1(6)
select sNo,sName
from student s
where not exists(
	(select *
	from course_class cc
	where not exists(
	select *
	from student_course sc
	where s.sNo=sc.sNo AND sc.ccNo=cc.ccNo)))

/*2�����ܷ���ʵ������*/
--2(1)
select sName,sBirth
from student
where sSex=
	(select sSex
	from student
	where sName='����ƽ')
/*��ѯ��'����ƽ'ͬ�Ա�ͬѧ������������*/

--2(2)
select sNo,sName,sSex
from student
where student.sNo in
	(select sNo
	from student_course
	where ccNo in('0324091007','0324051013')
	)
/*��ѯѡ��'0324091007','0324051013'�γ̵�ѧ����ѧ�š��������Ա�*/

--2(3)
select sNo,sName
from student s
where exists
	(select *
	from student_course sc
	where sc.sNo=s.sNo and ccNo='0324091007')
	and exists
	(select *
	from student_course sc
	where sc.sNO=s.sNO and ccNO='0312091006')
/*��ѯѡ�˿γ�'0324091007','0312091006'��ͬѧѧ�ź�����*/

--2(4)
select ccNo,mark
from student_course
where sNO='100212201' and mark>=any
	(select mark
	from student_course
	where sNo='100212208')
/*��ѯѧ��Ϊ'100212201'�ҳɼ�����ѧ��Ϊ'100212208'��ѧ������߷ֵĿγ̺ż��ɼ�*/

--2(5)
select sNo,sName,mName
from student as s,major as m
where s.mNO=m.mNO and s.sNO in
	(select sNO
	from student_course
	where mark<60)
/*��ѯ�ɼ�������ͬѧ��ѧ�š�������רҵ*/

--2(6)
select sName
from student s
where not exists
	(select *
	from student_course sc,course_class cc,teacher t
	where sc.ccNo=cc.ccNo and cc.tNO=t.tNO and
		  sc.sNO=s.sNO and t.tName='����')
/*��ѯû��ѡ"����"�γ̵�ѧ������*/

/*3��������ʵ������*/
--3(1)
select distinct s.sno,sname,mname
from student s,major m,student_course sc
where s.mno=m.mno and s.sno=sc.sno and mark<60

select distinct s.sno,sname,mname
from student s,major m,student_course sc
where s.mno=m.mno and s.sno=sc.sno and mark<60

--3(2)
select sc1.sno,sc1.mark,sc2.mark
from student_course sc1,student_course sc2
where sc1.ccno='2009010101' and sc1.ccNO=sc2.ccNo and sc1.mark>sc2.mark

--3(3)
select s.sno,s.sname
from student s
where sno in(
	select sc.sno
	from student_course sc,course_class cc,course c
	where sc.ccno=cc.ccno and cc.cno=c.cno and c.cname in('���������','����ѧ')
	group by sno
	having (count(*)=2))

--3(4)
select s.sname,avg(sc1.mark)
from student s,student_course sc1
where s.sno=sc1.sno and s.sno in(
	select sno
	from student_course sc2
	where mark<60
	group by sno
	having count(*)>=2)
group by s.sname

--3(5)
select sno,sname
from student s
where sno in(
	select sno
	from student_course sc
	right join course_class cc on sc.ccno=cc.ccno
	group by sno
	having count(*)=(_____)

--3(6)
select cname,tname
from course c,teacher t,course_class cc
where c.cno=cc.cno and cc.tno=t.tno and ccno=(
	select ____ ccno
	from student_course
	group by ccno
	order by ____ DESC)

/*�ġ�ʵ�����*/
/*�����������ѯ����*/
--1
select sNO
from student_course
where mark<60
group by sNO

select sNO
from student_course
where mark<60
group by sNO
--2
select *
from student
where sNative='����' and sNative='�㶫'

select *
from student 
where sNative='����' or sNative='�㶫'

--3
select sname,ssex,sHeight,sWeight,sweight/(sheight/100*sheight/100) as 'BMI'
from student
where ('BMI'<=19 and ssex='Ů') and ('BMI'<=20 and ssex='��')

select sName,sSex,sHeight,sWeight,sWeight/(sHeight/100*sHeight/100) as'BMI'
from student
where ('BMI'<=19 and sSex='Ů')and('BMI'<=20 and sSex='��')
--4
select AVG(mark) as 'ƽ����',MAX(mark) as '��߷�',MIN(mark) as '��ͷ�'
from student_course
group by ccNo
order by 'ƽ����' desc

--5
select sNo,COUNT(*)
from student_course
where AVG(mark)>80
group by ccNO
Having(COUNT(*)>=2)

/*����������ѯ����*/
--1
select 	*
from student
where sNative=
	(select sNative
	from student 
	where sname='�ŷ�')
	and 
	sBirth>
	(select sBirth 
	from student 
	where sName='�ŷ�')

--2
select *
from student
where sBirth>(select MAX(sBirth)
	from student s inner join major m on s.mNO=m.mNO
	inner join department d on d.dNO=m.dNO
	WHERE dName='�����ϵ')

--3
select sName,s.sNO,c.cNO,MARK
from student_course SC, student s,course c, course_class cc
where sc.sNO=s.sNO and c.cNO=cc.ccNO and cc.ccNO=SC.ccNO
order by Mark asc

--4
select student.sNo , MARK,sName
from student,course,student_course
where student.sno=course.cNO and student_course.Mark<60
(select student_course.Mark from course,student,student_course
where student.sName='�' and course.cName='�ߵ���ѧ'
and student.sNO=student_course.sNO
and course.cNO=student_course.ccno )

--5
select student.sNO,student.sName
from
(
select sNO,count(ccNO) as num 
from student_course
where ccNO IN(
select ccNO from student join student_course on student.sNO=student_course.SNO
and sName='090120206')
group by sNO
)t2
join(select count(ccNO) num from student join student_course 
on student.sNO=student_course.sNO and sName='090120206')
t1 on t2.NUM=t1.NUM
join student on student.sNO=t2.sNO
