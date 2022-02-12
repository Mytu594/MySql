/*(一)DML测验*/
--1
INSERT INTO student (sNo,sName ,mNo, sSex,sNative,sBirth,sHeight,sWeight) 
VALUES ('091940101','张大庆','061201','男','湖南长沙', '1990-08-12',171,65)
GO
INSERT INTO student (sNo,sName ,mNo, sSex,sNative,sBirth,sHeight,sWeight)
VALUES ('091940102','李美丽','061201','女','北京', '1991-04-12',166,53)
GO
INSERT INTO student (sNo,sName ,mNo, sSex,sNative,sBirth,sHeight,sWeight)
VALUES ('091940103','王天祝','061201','男','广东佛山', '1990-05-26',173,68)
GO
INSERT INTO student (sNo,sName ,mNo, sSex,sNative,sBirth,sHeight,sWeight) 
VALUES('091940114','蔡大炮','061211','男','广东阳江', '1991-08-26',167,61)
GO
--2
UPDATE student SET sEntime='2018/9/1'

UPDATE student_course SET mark=mark+5 WHERE mark<60

--3
UPDATE student SET sNative='湖南衡阳' WHERE sName='张大庆'

UPDATE student SET sNative='湖南衡阳' WHERE  

--4
DELETE FROM student_course WHERE mark =40

DELETE FROM student WHERE sName='蔡大炮'

DELETE FROM major WHERE mName='软件工程'

--5(1)
update teacher set tRank='副教授' where tName='陈潇潇'
/*
--5(2)
insert info course 

--5(3)
insert info student_course
insert info student_course*/

/*（一）DML 测验*/
--1
INSERT INTO student(sNo,sName,mNo,sSex,sNative,sBirth,sHeight,sWeight)
VALUES('10154050101', '李明帝', '061201', '男', '湖南常德', '1995-08-12',171,65)
GO
/*原因:将截断字符串或二进制数据。学号数超过存储范围*/
INSERT INTO student(sNo,sName,mNo,sSex,sNative,sBirth,sHeight,sWeight)
VALUES('101940102', '张强生', '060606', '男', '河北邯郸', '1994-08-12',166,55)
/*原因:INSERT 语句与FOREIGN KEY 约束"FK_student_major"冲突。该冲突发生于数据库"stuManage2"，表"dbo.major", column 'mNO'。*/

insert into student(sNo,sName,mNo,sSex,sNative,sBirth,sHeight,sWeight)
values('101540501', '李明帝', '061201', '男', '湖南常德', '1995-08-12',171,65)
go
insert into student(sNo,sName,mNo,sSex,sNative,sBirth,sHeight,sWeight)
values('101940102', '张强生', '061201', '男', '河北邯郸', '1994-08-12',166,55)
go

--2
update student set sHeight=sHeight+5 
update student set sWeight=sWeight-1 where sSex='女'

--3
update teacher set tName='李波',tRank='讲师',tSex='男',tDegree='博士' where tName='陈潇潇'
		

/*（三）多表查询测验*/
--1、查询出跟“张凡”同一个藉贯，且年龄比她大的学生。
select *
from student
where sNative=(
	select sNative
	from student
	where sname='张凡'
	)
	and
	(GETDATE()-sbirth)>(
	select(GETDATE()-sbirth) as '年龄'
	from student
	where sName='张凡'
	)


--2、求其他系中比计算机系所有学生年龄都小的学生。
select *
from department,student
where dName!='计算机系' and year(getdate())-year(sbirth)<(
	select min(year(getdate())-year(sbirth)) as '最小年龄'
	from department,student
	where dName='计算机系'
)

--3、查询每一个学生的课程选修情况（包括没选课的），要求显示学号，姓名，开课编号及成绩，优先显示没选课的同学信息。
select s.sNo,sName,ccNO,Mark
from student s,student_course sc
where s.sNO=sc.sNO
group by s.sNO,sName,ccNO,Mark
order by mark asc

--4、查询出高等数学课程的成绩高于刘晨成绩的学生学号和成绩。
select sNO,Mark
from student_course sc,course c,course_class cc
where cc.ccNO=sc.ccNO and c.cNO=cc.cNO and c.cName='高等数学' and sc.Mark>(
	select Mark
	from student s,student_course sc,course c,course_class cc
	where s.sName='刘晨' and s.sNO=sc.ccNO and sc.ccNO=cc.ccNO and c.cName='高等数学' and c.cNO=cc.cNO
	)

--5、求至少选修了学号为“090120206”的学生所选修全部课程的学生学号和姓名。
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