--�����������ݿ����

--�������ݿ�
Create database BLDisk;
GO
--����BLDisk���ݿ�
USE BLDisk;

--�����û���Ϣ��
Create table UserInfo(
	UserID varchar(30) not null,
	UserName varchar(30) default '������û��ǳ�',  --�û��ǳ�
	UserPass varchar(50) not null, --�û�����
	UserHead varchar(180) default 'defaultHead.jpg',  --�û�ͷ��,Ϊ��ʱΪĬ��ͷ��
	UserLevel int default 1,  --���ŵȼ��仯���洢Ҳ����Ӧ�Ľ���
	UserMemorySize varchar(36) default '1073741824',--�û�Ĭ��1G�ڴ�
	UserUsedSize varchar(36) default '0', --�û������ڴ�
	IsAdmin int default '0',--0��ʾ���ǹ���Ա,1��ʾΪ����Ա��2��ʾΪ��������Ա
	UserMail varchar(36), --�û�����
	CTime datetime not null, --ע��ʱ��
	PrivatePass varchar(50), --˽�ܿռ�����
	PrivateStatus int default 0, --�Ƿ���˽�ܿռ�
	Constraint UserID_PK Primary Key(UserID)
)
GO

--ɾ����
--drop table UserInfo;

--�洢Ŀ¼��
Create table FileInfo(
	UserID varchar(30) not null,   --�û�ID�����
	UserFileName varchar(30) not null,   --�ļ�/�ļ�����
	FilePath text not null, --�ļ��ϴ���Ŀ¼
	CreateTime datetime not null, --�ļ�������ʱ��
	ModifyTime datetime, --���һ���ļ��޸�ʱ��
	DownNum int,  --�����ش���
	Constraint UserID_FK Foreign Key(UserID) References UserInfo(UserID) --����UserIDΪ���
)
GO
--ɾ����
--drop table FileInfo;

--��������Ŀ¼��
Create table ShareFile(
	UserID varchar(30) not null,   --�û�ID�����
	FilePath text not null, --�ļ��ϴ���Ŀ¼
	SharePass varchar(30), --�������룬���û��Ļ�����ʾ����
	ShareLevel int not null, --�������ͣ��������ѹ���˽�ܹ���
	ShareName varchar(60) not null, --�����ļ�������
	ShareTime datetime not null, --�����ʱ��
	ShareDeadline datetime, -- �������÷�����Чʱ��
	Constraint UserID_ShareFile_FK Foreign Key(UserID) References UserInfo(UserID) --����UserIDΪ���
);
GO
--ɾ����
--drop table ShareFile;


--����/����/������־��
Create table UpdateLog(
	UserID varchar(30) not null,   --�û�ID�����
	UserDO varchar(80) not null,  --�û����Ĳ���
	DOTime datetime not null, --������ʱ��
	Constraint UserID_UpdateLog_FK Foreign Key(UserID) References UserInfo(UserID) --����UserIDΪ���
);
GO
--ɾ����
--drop table UpdateLog;


--���ѱ�
Create table FriendInfo(
	UserID varchar(30) not null,   --�û�ID�����
	FriendType varchar(30) default '�ҵĺ���',  --��������
	FriendID varchar(30) not null, --����ID
	AddTime datetime not null, --���ʱ��
	Constraint UserID_FriendInfo_FK Foreign Key(UserID) References UserInfo(UserID) --����UserIDΪ���
	Constraint FK_FrinedID foreign key(FriendID) references UserInfo(UserID)	--����FrinedIDΪ���
);
GO
--ɾ����
--drop table FriendInfo;

alter table FriendInfo
	add Constraint FK_FrinedID foreign key(FriendID) references UserInfo(UserID)


select * from FriendInfo
select * from UserInfo
select * from FileInfo
select * from ChatList
delete from UpdateLog

delete from ChatList
delete from UpdateLog
delete from FriendInfo
delete from FileInfo
delete from UserInfo