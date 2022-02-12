 --1
 SELECT  tname  as '姓名',tSex  as '性别',trank,
	case trank
		when '教授' then '高级职称'
		when '讲师' then '中级职称'
	else
		'初级职称'
	end
from teacher


--2
Update student_course set normalmark=60
go
WHILE (SELECT  avg(normalmark) FROM student_course)<80
BEGIN
UPDATE student_course
SET normalmark = normalmark *1.08
if (SELECT MAX(normalmark) FROM student_course)>95      
    break
END

--3
select * into sc_copy from student_course
alter table sc_copy
add midexam float

begin 
	update sc_copy set ExamMark=-1
end
go 
create trigger tr_mark on SC_copy
after update
as 
declare @sno char(10) ,@ccno varchar(20)
select @sno=sno,@ccno=ccno from deleted
begin 
	if UPDATE(exammark)
	begin
		if(select midexam from SC_copy
			where sno=@sno and ccno=@ccno)>0
			begin
				update SC_copy
				set Mark=normalmark*0.2+midexam*0.2+exammark*0.6
				where sno=@sno and @ccno=ccno
			end
		else
			begin	
				update Sc_copy
				set Mark=normalmark*0.2+exammark*0.8
				where sno=@sno and ccno=@ccno
			end
		end
	end
go

select * into sc_copy from student_course
alter table sc_copy
add midmark int
go
update sc_copy set midmark=-1
go
create trigger trig_student_course
on sc_copy
for insert,update
as
begin
declare @nMark int,@eMark int,@mMark int
declare @sno varchar(10),@ccno char(10)
select @nMark=normalMark,@eMark=examMark,@mMark=midMark,@sno=sno,@ccno=ccno
from sc_copy
if @mMark>0
update sc_copy
set mark=@nMark*0.2+@mMark*0.2+@eMark*0.6
where sno=@sno and ccno=@ccno
else
    update sc_copy
    set mark=@nMark*0.2+@eMark*0.8
where sno=@sno and ccno=@ccno
end

--3(2)
go
create trigger trg on student
for update
as
if UPDATE(mNO)
	begin
		declare @sno varchar(10),@mno char(6),@ccno varchar(20)
		select @sno=student.sNO,@mno=inserted.mno
		from student,inserted
		where student.sno=inserted.sNO
		
		select distinct @ccno=ccno
		from student s,student_course sc
		where s.sNO=sc.sNO and mno=@mno
		group by ccNO
		having count(*)=(select COUNT(*)
							from student
							where mNO=@mno)-1
		insert into sc_copy(sNO,ccNO)
		values(@sno,@ccno)
	end
go


--3(3)
go 
create procedure class_proc(@class_id varchar(10),@ccno char(10))
as
begin
	insert into student_course(sNO,ccNO)
	select sno,@ccno
	from student
	where LEFT(sno,7)=@class_id
end
go

exec class_proc @class_id='0812201',@ccno='2009010101'
select * from student_course 
where LEFT(sno,7)='0812201'


--4
create proc show
(@sno char(9),
@snocount int output,
@avgMark float output,
@sumcredit int output)
as
begin
	select @snocount=count(*),@avgMark=avg(mark),@sumcredit=SUM(credit)
	from student_course sc,course_class cc,student s
	where sc.ccno=cc.ccno and sc.sno=@sno
	group by s.sNO,sName 
end

--5
declare @ccount int
declare @aMark float
declare @credits int
exec show '081710106',@ccount output,@aMark output,@credits output
select '081710106' as '学号', @ccount as '选课门数',
@aMark as '平均分',@credits as '所选学分'


