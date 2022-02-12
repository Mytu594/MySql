create database EXAM;
use EXAM;

--����ѧ����Ϣ��
create table Students(
sNo char(4) primary key,   --ѧ��
sName varchar(30),         --����
sSex char(2),              --�Ա�
sPwd varchar(6),           --����
Classroom varchar(7)       --�༶
);

--��������Ա��Ϣ��
create table Administrators(
aNo char(4) primary key,   --����Ա���
aName varchar(30),         --����
aPwd varchar(6)            --����
);

--������ʦ��Ϣ��
create table Teachers(
tNo char(4) primary key,   --��ʦ���
tName varchar(30),         --����
tClass varchar(15),        --���ڿγ�
tPwd varchar(6),           --����
tDept varchar(15),         --���ڲ���
tSex varchar(2),           --�Ա�
tEmail varchar(20),        --Email
);

--�����Ծ���Ϣ��
create table Exams(
examNo varchar(3) primary key,   --�Ծ���
examName varchar(30),            --�Ծ�����
examCnt varchar(700),            --�Ծ�����
Score int,                       --�ɼ�
StartTime Datetime,              --��ʼʱ��
StopTime Datetime,               --����ʱ��
sNo char(4),                     --ѧ�ţ������
tNo char(4),                     --��ʦ��ţ������
foreign key(sNo) references Students(sNo),
foreign key(tNo) references Teachers(tNo)
);

--������Ŀ��Ϣ��
create table  Questions(
qNo varchar(5) primary key,   --��Ŀ��� 
qStem varchar(300),           --���
qPoint varchar(5),            --��ֵ
qAnswer varchar(50),          --��ȷ��
qCnt varchar(300),            --��Ŀ����
qType varchar(10),            --����
examNo varchar(3),            --�Ծ��ţ������
kNo varchar(4),               --֪ʶ���ţ������
foreign key(examNo) references Exams(examNo),
foreign key(kNo) references Knowledge(kNo)
);

--������Ŀ��Ϣ��
create table Subjects(
subNo varchar(3) primary key,   --��Ŀ���
subName  varchar(30),           --��Ŀ����
kNo varchar(4),                 --֪ʶ���ţ������
foreign key(kNo) references Knowledge(kNo)
);


--����֪ʶ����Ϣ��
create table Knowledge(
kNo varchar(4) primary key,   --֪ʶ����
kCnt varchar(700),            --֪ʶ������
);

--�������������Ϣ��
create table Rules(
ruleNO char(4) primary key,   --������ 
ruleName varchar(20),         --��������
ruleType varchar(10),         --����
ruleNum int,                  --����
ruleLevel varchar(10),        --�Ѷ�
ruleRange varchar(20)         --֪ʶ�㷶Χ
);

--����������Ϣ��
create table Manage(
mNo varchar(5) primary key,   --������
aNo char(4),                  --����Ա��ţ������
sNo char(4),                  --ѧ�ţ������
tNo char(4),                  --��ʦ��ţ������
foreign key(aNo) references Administrators(aNo),
foreign key(sNo) references Students(sNo),
foreign key(tNo) references Teachers(tNo)
);

--����������Ϣ��
create table Checks(
cNo varchar(5) primary key,   --���ı��
cMethod varchar(8),           --���ķ�ʽ
examNo varchar(3),            --�Ծ��ţ������
tNo char(4),                  --��ʦ��ţ������
foreign key(examNo) references Exams(examNo),
foreign key(tNo) references Teachers(tNo)
);

--����������Ϣ��
create table Rollout(
rollNo varchar(5) primary key,   --������
rollTime Datetime,               --����ʱ��
examNo varchar(3),               --�Ծ��ţ������
tNo char(4),                  --��ʦ��ţ������
foreign key(examNo) references Exams(examNo),
foreign key(tNo) references Teachers(tNo)
);

--����ѧ����Ϣ
insert into Students
	values('0001','����','��','123456','A1801');
insert into Students
	values('0002','����','Ů','234567','A1802');
insert into Students
	values('0003','����','��','345678','A1803');

--�������Ա��Ϣ
insert into Administrators
	values('1001','��һ','000000');
insert into Administrators
	values('1002','׿��','111111');
insert into Administrators
	values('1003','����','222222');

--�����ʦ��Ϣ
insert into Teachers
	values('2001','����','���ݽṹ','456789','������Ժ','��','123456789@qq.com');
insert into Teachers
	values('2002','����','����Ӣ��','567891','����Ժ','Ů','234567891@qq.com');
insert into Teachers
	values('2003','����','�Ӿ�����','678912','����Ժ','Ů','345678912@qq.com');

--�����Ծ���Ϣ
insert into Exams
	values('E01','���ݽṹ','1.��һ��:What is your name? ','90','2019-12-25 08:00:00','2019-12-25 010:00:00','0003','2003');
insert into Exams
	values('E02','����Ӣ��','1. �㷨����߱����롢�����[ ]
A. ���㷽��������������������B. ���򷽷�
C�����������������㲽�衡��D. ������Ʒ���','92','2019-12-24 08:00:00','2019-12-24 010:00:00','0001','2001');
insert into Exams
	values('E03','�Ӿ�����','1.��һ��: ������ɯ��������?','88','2019-12-26 08:00:00','2019-12-26 010:00:00','0002','2001');


--������Ŀ��Ϣ
insert into Questions
	values('Q0001','1.What is your name? ','5��','A','A.Lihua  B.HanLeilei','ѡ����','E01','K001');
insert into Questions
	values('Q0002','1.�㷨����߱����롢�����[ ] ','3��','C','A. ���㷽����B. ���򷽷�  C�����������������㲽�� D. ������Ʒ���','ѡ����','E02','K002');
insert into Questions
	values('Q0003','1.������ɯ��������? ','10��','�����','___','�����','E03','K003');

--�����Ŀ��Ϣ
insert into Subjects
	values('301','���ݽṹ','K001');
insert into Subjects
	values('302','����Ӣ��','K002');
insert into Subjects
	values('303','�Ӿ�����','K003');

--����֪ʶ����Ϣ
insert into Knowledge
	values('K001','�㷨��Algorithm��');
insert into Knowledge
	values('K002','The discussion about name');
insert into Knowledge
	values('K003','���ո���ʱ�Ļ���');

--������������Ϣ
insert into Rules
	values('R001','һ','ѡ����','10','�е�','���ݽṹ');
insert into Rules
	values('R002','��','�����','15','��','����Ӣ���ϲ�');
insert into Rules
	values('R003','��','�����','2','��','���ݿ�');

--���������Ϣ
insert into Manage
	values('M001','1001','0001','2001');
insert into Manage
	values('M002','1002','0002','2002');
insert into Manage
	values('M003','1003','0003','2003');

--����������Ϣ
insert into Checks
	values('C0001','�Զ�����','E01','2001');
insert into Checks
	values('C002','�ֹ�����','E02','2002');
insert into Checks
	values('C003','�ֹ�����','E03','2003');

--����������Ϣ
insert into Rollout
	values('Rool1','2019-11-11 20:00:00','E01','2001');
insert into Rollout
	values('Rool2','2019-12-11 10:00:00','E02','2002');
insert into Rollout
	values('Rool3','2019-12-12 03:00:00','E03','2003');














