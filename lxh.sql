CREATE PROCEDURE show_course_Mark1
(@cno CHAR(6),
@stuCount int output,
@avgMark FLOAT OUTPUT,
@ratioPass FLOAT OUTPUT)
AS
BEGIN
DECLARE @passCount INT
SELECT @stuCount=COUNT(*),@avgMark=AVG(mark)
FROM student_course sc,course_class cc
WHERE sc.ccNo=cc.ccNo AND cc.cNo=@cno
SELECT @passCount=COUNT(*)
FROM student_course sc,course_class cc
WHERE sc.ccNo=cc.ccNo AND cc.cNo=@cno AND mark>=60
SET @ratioPass=convert(FLOAT,@passCount)/@stuCount
END

BEGIN
DECLARE @stuCount INT
DECLARE @avgMark FLOAT
DECLARE @patiopass FLOAT
EXEC show_course_Mark1 '010101',@stuCount output,@avgMark output,@patiopass output
SELECT '010101' AS '�γ̺�', @stuCount AS '����',
@avgMark AS 'ƽ����',@patiopass AS '������'
END

EXEC sp_helptext 'list_student_department'

CREATE TRIGGER trig1
ON course
FOR INSERT,UPDATE,DELETE
AS
--'��ʾINSERTED������'
SELECT 'INSERTED��' AS 'INSERTED��', INSERTED.*
FROM INSERTED
-- '��ʾDELETED������'
SELECT 'DELETED��' AS'DELETED��', DELETED.*
FROM DELETED

INSERT INTO course
VALUES('090009','���ݿ�����뿪��','010101')
GO
UPDATE course
SET cpNo='020101'
WHERE cNo='090009'
GO
DELETE course
WHERE cNo='090009'

SELECT s.sNo,sName,COUNT(*) AS 'courseCOUNT',SUM(credit) AS 'sumCredit'
INTO stu_credit
FROM student s,student_course sc,course_class cc
WHERE s.sNo=sc.sNo AND sc.ccNo=cc.ccNo
GROUP BY s.sNo,sName

CREATE TRIGGER trig01_student_course
ON student_course
FOR INSERT
AS
BEGIN
DECLARE @sno VARCHAR(10)
DECLARE @ccno CHAR(10)
DECLARE @credit INT
SELECT @sno=sNo,@ccno=ccNo FROM INSERTED
SELECT @credit=credit
FROM course_class WHERE ccNo=@ccno
UPDATE stu_credit
SET courseCOUNT=courseCOUNT+1,sumcredit=sumcredit+@credit
WHERE sNo=@sno
END

--�Ȳ鿴��������ѧ����Ϣ
SELECT *
FROM stu_credit
WHERE sNo='081220101'
GO
--������ݣ�������ִ��
INSERT INTO student_course(sNo,ccNo)
VALUES('081220101','0312091006')
GO
--�ٴβ鿴������Ϣ
SELECT *
FROM stu_credit
WHERE sNo='081220101'

ALTER TABLE course_class
ADD validity BIT DEFAULT(1)
GO
UPDATE course_class SET validity=1
GO

CREATE TRIGGER trig01_course_class
ON course_class
INSTEAD OF DELETE
AS
BEGIN
DECLARE @ccno CHAR(10)
SELECT @ccno=ccNo FROM INSERTED
UPDATE course_class
SET validity=0
WHERE ccNo=@ccno
DELETE
FROM student_course
WHERE ccNo=@ccno
END

SELECT cc.ccNo,validity,sNo,mark
FROM course_class cc LEFT JOIN student_course sc
ON cc.ccNo=sc.ccNo WHERE cc.ccNo='2010020201'
GO

DELETE FROM course_class
WHERE ccNo='2010020201'
GO

SELECT cc.ccNo,validity,sNo,mark
FROM course_class cc LEFT JOIN student_course sc
ON cc.ccNo=sc.ccNo WHERE cc.ccNo='2010020201'


--4
CREATE TRIGGER trig02_student_course
ON student_course
FOR UPDATE
AS 
BEGIN 
	DECLARE @nMark float,@eMark Float
	declare @sno varchar(10),@ccno char(10)
	select @nMark=normalmark,@eMark=ExamMark,@sno=sNo,@ccno=ccno
	from student_course
	update student_course
	set Mark=CONVERT(int,@nmark*0.2+@emark*0.8)
	where sNO=@sno and ccNO=@ccno
end


select *
from student_course
where sNO='081220101' and ccNO='0312091006'
go

update student_course set NormalMark=80,ExamMark=90
where sNO='081220101' and ccNO='0312091006'
go

select *
from student_course
where sNO='081220101' and ccNO='0312091006'


--2
--(1)����
create procedure show_course_Mark
(@cno char(6),
@stuCount int output,
@avgMark float output,
@radioPass float output)
as 
begin
	declare @passCount int
	select @stuCount=COUNT(*),@avgMark=AVG(mark)
	from student_course sc,course_class cc
	where sc.ccNO=cc.ccNO and cc.cNO=@cno
	select @passCount=COUNT(*)
	FROM student_course SC,course_class CC
	WHERE SC.ccNO=CC.ccNO AND CC.cNO=@cno AND Mark>=60
	SET @radioPass=(froat,@passCount)/@stuCount
end

--11111
 SELECT  tname  as '����',tSex  as '�Ա�',trank,
	case trank
		when '����' then '�߼�ְ��'
		when '��ʦ' then '�м�ְ��'
	else
		'����ְ��'
	end
from teacher
--����ְͬ�Ƶ���ʦ��ְ�Ƶȼ������ڹ����߼�ְ�ƣ���ʦ�����м�ְ�ƣ�����Ϊ����ְ��

--2222
Update student_course set normalmark=60
go
WHILE (SELECT  avg(normalmark) FROM student_course)<80
BEGIN
UPDATE student_course
SET normalmark = normalmark *1.08
if (SELECT MAX(normalmark) FROM student_course)>95      
    break
END



