create database EXAM;
use EXAM;

--创建学生信息表
create table Students(
sNo char(4) primary key,   --学号
sName varchar(30),         --姓名
sSex char(2),              --性别
sPwd varchar(6),           --密码
Classroom varchar(7)       --班级
);

--创建管理员信息表
create table Administrators(
aNo char(4) primary key,   --管理员编号
aName varchar(30),         --姓名
aPwd varchar(6)            --密码
);

--创建教师信息表
create table Teachers(
tNo char(4) primary key,   --教师编号
tName varchar(30),         --姓名
tClass varchar(15),        --所授课程
tPwd varchar(6),           --密码
tDept varchar(15),         --所在部门
tSex varchar(2),           --性别
tEmail varchar(20),        --Email
);

--创建试卷信息表
create table Exams(
examNo varchar(3) primary key,   --试卷编号
examName varchar(30),            --试卷名称
examCnt varchar(700),            --试卷内容
Score int,                       --成绩
StartTime Datetime,              --开始时间
StopTime Datetime,               --结束时间
sNo char(4),                     --学号（外键）
tNo char(4),                     --教师编号（外键）
foreign key(sNo) references Students(sNo),
foreign key(tNo) references Teachers(tNo)
);

--创建题目信息表
create table  Questions(
qNo varchar(5) primary key,   --题目编号 
qStem varchar(300),           --题干
qPoint varchar(5),            --分值
qAnswer varchar(50),          --正确答案
qCnt varchar(300),            --题目内容
qType varchar(10),            --题型
examNo varchar(3),            --试卷编号（外键）
kNo varchar(4),               --知识点编号（外键）
foreign key(examNo) references Exams(examNo),
foreign key(kNo) references Knowledge(kNo)
);

--创建科目信息表
create table Subjects(
subNo varchar(3) primary key,   --科目编号
subName  varchar(30),           --科目名称
kNo varchar(4),                 --知识点编号（外键）
foreign key(kNo) references Knowledge(kNo)
);


--创建知识点信息表
create table Knowledge(
kNo varchar(4) primary key,   --知识点编号
kCnt varchar(700),            --知识点内容
);

--创建出卷规则信息表
create table Rules(
ruleNO char(4) primary key,   --规则编号 
ruleName varchar(20),         --规则名称
ruleType varchar(10),         --题型
ruleNum int,                  --题量
ruleLevel varchar(10),        --难度
ruleRange varchar(20)         --知识点范围
);

--创建管理信息表
create table Manage(
mNo varchar(5) primary key,   --管理编号
aNo char(4),                  --管理员编号（外键）
sNo char(4),                  --学号（外键）
tNo char(4),                  --教师编号（外键）
foreign key(aNo) references Administrators(aNo),
foreign key(sNo) references Students(sNo),
foreign key(tNo) references Teachers(tNo)
);

--创建批阅信息表
create table Checks(
cNo varchar(5) primary key,   --批阅编号
cMethod varchar(8),           --批阅方式
examNo varchar(3),            --试卷编号（外键）
tNo char(4),                  --教师编号（外键）
foreign key(examNo) references Exams(examNo),
foreign key(tNo) references Teachers(tNo)
);

--创建出卷信息表
create table Rollout(
rollNo varchar(5) primary key,   --出卷编号
rollTime Datetime,               --出卷时间
examNo varchar(3),               --试卷编号（外键）
tNo char(4),                  --教师编号（外键）
foreign key(examNo) references Exams(examNo),
foreign key(tNo) references Teachers(tNo)
);

--插入学生信息
insert into Students
	values('0001','张三','男','123456','A1801');
insert into Students
	values('0002','李四','女','234567','A1802');
insert into Students
	values('0003','王五','男','345678','A1803');

--插入管理员信息
insert into Administrators
	values('1001','林一','000000');
insert into Administrators
	values('1002','卓二','111111');
insert into Administrators
	values('1003','褥三','222222');

--插入教师信息
insert into Teachers
	values('2001','张六','数据结构','456789','互联网院','男','123456789@qq.com');
insert into Teachers
	values('2002','白七','商务英语','567891','外文院','女','234567891@qq.com');
insert into Teachers
	values('2003','安八','视觉艺术','678912','创教院','女','345678912@qq.com');

--插入试卷信息
insert into Exams
	values('E01','数据结构','1.第一题:What is your name? ','90','2019-12-25 08:00:00','2019-12-25 010:00:00','0003','2003');
insert into Exams
	values('E02','商务英语','1. 算法必须具备输入、输出和[ ]
A. 计算方法　　　　　　　　　B. 排序方法
C．解决问题的有限运算步骤　　D. 程序设计方法','92','2019-12-24 08:00:00','2019-12-24 010:00:00','0001','2001');
insert into Exams
	values('E03','视觉艺术','1.第一题: 蒙娜丽莎的作者是?','88','2019-12-26 08:00:00','2019-12-26 010:00:00','0002','2001');


--插入题目信息
insert into Questions
	values('Q0001','1.What is your name? ','5分','A','A.Lihua  B.HanLeilei','选择题','E01','K001');
insert into Questions
	values('Q0002','1.算法必须具备输入、输出和[ ] ','3分','C','A. 计算方法　B. 排序方法  C．解决问题的有限运算步骤 D. 程序设计方法','选择题','E02','K002');
insert into Questions
	values('Q0003','1.蒙娜丽莎的作者是? ','10分','达芬奇','___','填空题','E03','K003');

--插入科目信息
insert into Subjects
	values('301','数据结构','K001');
insert into Subjects
	values('302','商务英语','K002');
insert into Subjects
	values('303','视觉艺术','K003');

--插入知识点信息
insert into Knowledge
	values('K001','算法（Algorithm）');
insert into Knowledge
	values('K002','The discussion about name');
insert into Knowledge
	values('K003','文艺复兴时的画家');

--插入出卷规则信息
insert into Rules
	values('R001','一','选择题','10','中等','数据结构');
insert into Rules
	values('R002','二','填空题','15','简单','商务英语上册');
insert into Rules
	values('R003','三','简答题','2','难','数据库');

--插入管理信息
insert into Manage
	values('M001','1001','0001','2001');
insert into Manage
	values('M002','1002','0002','2002');
insert into Manage
	values('M003','1003','0003','2003');

--插入批阅信息
insert into Checks
	values('C0001','自动评分','E01','2001');
insert into Checks
	values('C002','手工批阅','E02','2002');
insert into Checks
	values('C003','手工批阅','E03','2003');

--插入批阅信息
insert into Rollout
	values('Rool1','2019-11-11 20:00:00','E01','2001');
insert into Rollout
	values('Rool2','2019-12-11 10:00:00','E02','2002');
insert into Rollout
	values('Rool3','2019-12-12 03:00:00','E03','2003');














