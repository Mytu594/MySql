--（1）创建一个包括学生的学号及其各门功课的平均成绩的视图V_STU_AVG。
CREATE VIEW V_STU_AVG(sNO,AVGMARK)
AS 
	SELECT SNO,AVG(MARK)
	FROM student_course
	GROUP BY sNO
	
--（2）尝试对视图V_STU_AVG执行下面两条语句。
UPDATE V_STU_AVG
SET AVGMARK=85
WHERE sNO='081220102'
DELETE
FROM V_STU_AVG
WHERE sNO='081220102'
--对视图或函数 'V_STU_AVG' 的更新或插入失败，因其包含派生域或常量域。

--（3）创一个包括教师编号、教师姓名、性别和生日的060606部门所有教师的视图。
--姓名性别和生日的060606部门所有教师的视图。
CREATE VIEW V_TEACHER1
AS
	SELECT TNO,TNAME,TSEX,DNO
	FROM teacher
	WHERE DNO='100002' AND TSEX='女'
with check option

--（4）执行下面两条语句，尝试对视图V_TEACHER1进行DML操作。
INSERT INTO V_TEACHER1
VALUES('090901','郭云丽','女','100002')
insert into V_TEACHER1
values('090902','李德刚','男','100002')
delete
from V_TEACHER1
where tNO='090901'
--试图进行的插入或更新已失败，原因是目标视图或者目标视图所跨越的某一视图指定了 WITH CHECK OPTION，而该操作的一个或多个结果行又不符合 CHECK OPTION 约束。

--（5）使用T-SQL语句修改视图
alter view v_teacher1
as
	select tno,tname,tsex,trank,dno
	from teacher
	where dNo='100002' and tSex='女'
	
select * 
from v_teacher1

--（6）执行下面两条语句，再次尝试对视图teacher1_view进行DML操作。
insert into v_teacher1
values('090901','郭丽云','女','讲师','100002')
insert into v_teacher1
values('090902','李德刚','男','讲师','100002')

--（7）使用T-SQL 语句删除视图
DROP VIEW V_TEACHER1
/*索引*/
--（1）使用SQL语句为stuManage数据库的student_course表的“mark”字段创建一个非聚集索引，命名为IX_SC_MARK。
create index ix_sc_mark on student_course(mark)

--为student表的“sName”和“sSex”字段创建一个复合唯一索引，命名为IX_STUDENT_NAMESEX。
create unique index ix_student_namesex on student(sname,ssex)

--（3）使用系统存储过程SP_HELPINDEX查看student_course表上的索引信息。
sp_helpindex student_course

--（4）使用系统存储过程SP_RENAME将索引IX_SC_MARK更名为IX_S_C_MARK。
sp_rename 'student_course.IX_SC_MARK','IX_S_C_MARK','INDEX'
--注意: 更改对象名的任一部分都可能会破坏脚本和存储过程。

--（5）使用DROP INDEX删除索引IX_S_C_MARK。
drop index student_ourse.ix_s_c_mark

--①在student表中创建如下索引
create index ix_stu_sname on student(sname)
create index ix_stu_ssex on student(ssex)
create index ix_stu_sweight on student(sweight)

--②查看下面查询语句的执行计划，并思考其执行计划。
select *
from student
where sNO='091650105'
go
select *
from student
where sName='李艳丽'

select *
from student
where sSex='女'
go
select COUNT(*),ssex
from student
group by sSex
 --①创建表stu2，并添加大量数据
 select *
 into stu2
 from student
 
 --
 insert into stu2
 select * from stu2
 
 insert into stu2(sNO,sName,mNO,sSex)
 values('1112223333','小红花','100164','女')
 
 --②在表stu2中创建如下索引
 create index ix_sname_stu2 on stu2(sname)

--③查看下面语句的执行计划，并思考
select *
from stu2
where sName='李艳丽'

select *
from stu2
where sName='小红花'
