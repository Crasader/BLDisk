--北理网盘数据库设计

--创建数据库
Create database BLDisk;
GO
--进入BLDisk数据库
USE BLDisk;

--创建用户信息表
Create table UserInfo(
	UserID varchar(30) not null,
	UserName varchar(30) default '请更换用户昵称',  --用户昵称
	UserPass varchar(50) not null, --用户密码
	UserHead varchar(180) default 'defaultHead.jpg',  --用户头像,为空时为默认头像
	UserLevel int default 1,  --随着等级变化，存储也有相应的奖励
	UserMemorySize varchar(36) default '1073741824',--用户默认1G内存
	UserUsedSize varchar(36) default '0', --用户已用内存
	IsAdmin int default '0',--0表示不是管理员,1表示为管理员，2表示为超级管理员
	UserMail varchar(36), --用户邮箱
	CTime datetime not null, --注册时间
	PrivatePass varchar(50), --私密空间密码
	PrivateStatus int default 0, --是否开启私密空间
	Constraint UserID_PK Primary Key(UserID)
)
GO

--删除表
--drop table UserInfo;

--存储目录表
Create table FileInfo(
	UserID varchar(30) not null,   --用户ID，外键
	UserFileName varchar(30) not null,   --文件/文件夹名
	FilePath text not null, --文件上传的目录
	CreateTime datetime not null, --文件创建的时间
	ModifyTime datetime, --最后一次文件修改时间
	DownNum int,  --被下载次数
	Constraint UserID_FK Foreign Key(UserID) References UserInfo(UserID) --设置UserID为外键
)
GO
--删除表
--drop table FileInfo;

--创建分享目录表
Create table ShareFile(
	UserID varchar(30) not null,   --用户ID，外键
	FilePath text not null, --文件上传的目录
	SharePass varchar(30), --分享密码，如果没设的话，表示共享
	ShareLevel int not null, --分享类型，共享，好友共享，私密共享
	ShareName varchar(60) not null, --分享文件的名字
	ShareTime datetime not null, --分享的时间
	ShareDeadline datetime, -- 可以设置分享有效时间
	Constraint UserID_ShareFile_FK Foreign Key(UserID) References UserInfo(UserID) --设置UserID为外键
);
GO
--删除表
--drop table ShareFile;


--插入/更新/插入日志表
Create table UpdateLog(
	UserID varchar(30) not null,   --用户ID，外键
	UserDO varchar(80) not null,  --用户做的操作
	DOTime datetime not null, --操作的时间
	Constraint UserID_UpdateLog_FK Foreign Key(UserID) References UserInfo(UserID) --设置UserID为外键
);
GO
--删除表
--drop table UpdateLog;


--好友表
Create table FriendInfo(
	UserID varchar(30) not null,   --用户ID，外键
	FriendType varchar(30) default '我的好友',  --好友类型
	FriendID varchar(30) not null, --好友ID
	AddTime datetime not null, --添加时间
	Constraint UserID_FriendInfo_FK Foreign Key(UserID) References UserInfo(UserID) --设置UserID为外键
	Constraint FK_FrinedID foreign key(FriendID) references UserInfo(UserID)	--设置FrinedID为外键
);
GO
--删除表
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