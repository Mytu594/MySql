--2(1)
select *
from student_course
where mark between 80 and 85
/*查询80分到85分的学生信息*/

--2(2)
select count(*)
from student
where mNo='100165' and sSex='女'
/*统计专业号为'100165'的女同学的人数*/

--2(3)
select distinct left(sName,1)
from student
/*查询所有学生的姓氏(去重复)*/
select distinct substring(sName,1,1)
from student

--2(4)
select sNo,sName
from student
where sName like '[陈李]%'
/*查询所有姓陈和李的同学学号和姓名*/

--2(5)
select ccNo as '开课编号',avg(mark) as '平均数'
from student_course
where sNo like '09165%'
group by ccNO
/*查询"09165"专业的开课编号以及课程平均分*/

--3(1)
select count(*) as '选课人数',avg(mark) as '平均分'
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
select sNo,avg(mark) as '平均分',max(mark) as '最高分',min(mark) as '最低分'
from student_course
group by sNo
order by avg(mark) desc

--3(5)
select top 3 sNo,mark
from student_course
where ccNo='0901120001'
order by Mark desc

/*(三)多表数据查询*/
--1(1)
select sNo,sName,sSex,mName
from student s
left join Major m on s.mNo=m.mNo

--1(2)
select sc.sNo AS '学号',sName AS '姓名',COUNT(*) AS '没有及格的门数'
from student_course sc,student s
where mark<60 AND s.sNo=sc.sNo
group by sc.sNo,sName

--1(3)
select left(s.sNo,7),count(*) as '人数'
from student s,major m
where m.mName='计算机科学与技术' and s.mNo=m.mNo
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

/*2、功能分析实验内容*/
--2(1)
select sName,sBirth
from student
where sSex=
	(select sSex
	from student
	where sName='刘卫平')
/*查询与'刘卫平'同性别同学的姓名和生日*/

--2(2)
select sNo,sName,sSex
from student
where student.sNo in
	(select sNo
	from student_course
	where ccNo in('0324091007','0324051013')
	)
/*查询选了'0324091007','0324051013'课程的学生的学号、姓名和性别*/

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
/*查询选了课程'0324091007','0312091006'的同学学号和姓名*/

--2(4)
select ccNo,mark
from student_course
where sNO='100212201' and mark>=any
	(select mark
	from student_course
	where sNo='100212208')
/*查询学号为'100212201'且成绩大于学号为'100212208'的学生的最高分的课程号及成绩*/

--2(5)
select sNo,sName,mName
from student as s,major as m
where s.mNO=m.mNO and s.sNO in
	(select sNO
	from student_course
	where mark<60)
/*查询成绩不及格同学的学号、姓名和专业*/

--2(6)
select sName
from student s
where not exists
	(select *
	from student_course sc,course_class cc,teacher t
	where sc.ccNo=cc.ccNo and cc.tNO=t.tNO and
		  sc.sNO=s.sNO and t.tName='李明')
/*查询没有选"李明"课程的学生姓名*/

/*3、语句填空实验内容*/
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
	where sc.ccno=cc.ccno and cc.cno=c.cno and c.cname in('计算机网络','金融学')
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

/*四、实验测验*/
/*（二）单表查询测验*/
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
where sNative='海南' and sNative='广东'

select *
from student 
where sNative='海南' or sNative='广东'

--3
select sname,ssex,sHeight,sWeight,sweight/(sheight/100*sheight/100) as 'BMI'
from student
where ('BMI'<=19 and ssex='女') and ('BMI'<=20 and ssex='男')

select sName,sSex,sHeight,sWeight,sWeight/(sHeight/100*sHeight/100) as'BMI'
from student
where ('BMI'<=19 and sSex='女')and('BMI'<=20 and sSex='男')
--4
select AVG(mark) as '平均分',MAX(mark) as '最高分',MIN(mark) as '最低分'
from student_course
group by ccNo
order by '平均分' desc

--5
select sNo,COUNT(*)
from student_course
where AVG(mark)>80
group by ccNO
Having(COUNT(*)>=2)

/*（三）多表查询测验*/
--1
select 	*
from student
where sNative=
	(select sNative
	from student 
	where sname='张凡')
	and 
	sBirth>
	(select sBirth 
	from student 
	where sName='张凡')

--2
select *
from student
where sBirth>(select MAX(sBirth)
	from student s inner join major m on s.mNO=m.mNO
	inner join department d on d.dNO=m.dNO
	WHERE dName='计算机系')

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
where student.sName='李晨' and course.cName='高等数学'
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
