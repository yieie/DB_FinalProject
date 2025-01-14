CREATE TABLE WORK_SHOP
(
  WSID INT AUTO_INCREMENT PRIMARY KEY,
  WSDate DATE NOT NULL,
  WSTime TIME NOT NULL,
  WSTopic VARCHAR(50) NOT NULL
  -- PRIMARY KEY (WSID)
);

CREATE TABLE ADMIN
(
  AdminID VARCHAR(50) NOT NULL,
  AdminPasswd VARCHAR(50) NOT NULL,
  AdminName VARCHAR(50) NOT NULL,
  AdminEmail VARCHAR(50) NOT NULL,
  AdminPhone VARCHAR(50) NOT NULL,
  PRIMARY KEY (AdminID)
);

CREATE TABLE ANN
(
  AnnID INT AUTO_INCREMENT PRIMARY KEY,
  AnnInfo VARCHAR(1000) NOT NULL,
  AnnTime DATETIME NOT NULL,
  AdminID VARCHAR(50) NOT NULL,
  -- PRIMARY KEY (AnnID),
  FOREIGN KEY (AdminID) REFERENCES ADMIN(AdminID)
);

CREATE TABLE LECTURER
(
  LectName VARCHAR(50) NOT NULL,
  LectTitle VARCHAR(50) NOT NULL,
  LectPhone VARCHAR(50) NOT NULL,
  LectEmail VARCHAR(50) NOT NULL,
  LectAddress VARCHAR(50) NOT NULL,
  WSID INT NOT NULL,
  PRIMARY KEY (LectName, WSID),
  FOREIGN KEY (WSID) REFERENCES WORK_SHOP(WSID)
);

CREATE TABLE TEACHER_JUDGE
(
  TJEmail VARCHAR(50) NOT NULL,
  TJPassword VARCHAR(50) NOT NULL,
  TJName VARCHAR(50) NOT NULL,
  TJSex CHAR(1) NOT NULL,
  TJPhone VARCHAR(50) NOT NULL,
  PRIMARY KEY (TJEmail)
);

CREATE TABLE TEACHER
(
  TrJobType VARCHAR(50),
  TrDepartment VARCHAR(50),
  TrOrganization VARCHAR(50),
  TJEmail VARCHAR(50) NOT NULL,
  PRIMARY KEY (TJEmail),
  FOREIGN KEY (TJEmail) REFERENCES TEACHER_JUDGE(TJEmail)
);

CREATE TABLE JUDGE
(
  JudgeTitle VARCHAR(50),
  TJEmail VARCHAR(50) NOT NULL,
  PRIMARY KEY (TJEmail),
  FOREIGN KEY (TJEmail) REFERENCES TEACHER_JUDGE(TJEmail)
);

CREATE TABLE HOLD
(
  AdminID VARCHAR(50) NOT NULL,
  WSID INT NOT NULL,
  PRIMARY KEY (AdminID, WSID),
  FOREIGN KEY (AdminID) REFERENCES ADMIN(AdminID),
  FOREIGN KEY (WSID) REFERENCES WORK_SHOP(WSID)
);

CREATE TABLE MODIFY
(
  ModifyTime DATETIME NOT NULL,
  AdminID VARCHAR(50) NOT NULL,
  AnnID INT NOT NULL,
  PRIMARY KEY (AdminID, AnnID),
  FOREIGN KEY (AdminID) REFERENCES ADMIN(AdminID),
  FOREIGN KEY (AnnID) REFERENCES ANN(AnnID)
);

CREATE TABLE ANN_AnnPoster
(
  AnnPoster VARCHAR(200) NOT NULL,
  AnnID INT NOT NULL,
  PRIMARY KEY (AnnPoster, AnnID),
  FOREIGN KEY (AnnID) REFERENCES ANN(AnnID)
);

CREATE TABLE ANN_AnnFile
(
  AnnFileURL VARCHAR(200) NOT NULL,
  AnnFileName VARCHAR(200) NOT NULL,
  -- AnnFileType VARCHAR(50) NOT NULL,
  AnnID INT NOT NULL,
  PRIMARY KEY (AnnFileURL, AnnID),
  FOREIGN KEY (AnnID) REFERENCES ANN(AnnID)
);

CREATE TABLE TEAM
(
  TeamID VARCHAR(50) NOT NULL,
  TeamName VARCHAR(50) NOT NULL,
  TeamRank VARCHAR(50),
  TeamType VARCHAR(50) NOT NULL,
  Consent VARCHAR(50),
  Affidavit VARCHAR(50),
  TeamState VARCHAR(50) NOT NULL,
  TeacherEmail VARCHAR(50),
  PRIMARY KEY (TeamID),
  FOREIGN KEY (TeacherEmail) REFERENCES TEACHER(TJEmail)
);

CREATE TABLE STUDENT
(
  StuID VARCHAR(50) NOT NULL,
  StuPasswd VARCHAR(50) NOT NULL,
  StuName VARCHAR(50) NOT NULL,
  StuSex VARCHAR(50) NOT NULL,
  StuPhone VARCHAR(50) NOT NULL,
  StuEmail VARCHAR(50) NOT NULL,
  StuDepartment VARCHAR(50) NOT NULL,
  StuGrade VARCHAR(50) NOT NULL,
  StuIDCard VARCHAR(50),
  IsLeader BOOLEAN DEFAULT NULL,
  TeamID VARCHAR(50) DEFAULT NULL,
  PRIMARY KEY (StuID),
  FOREIGN KEY (TeamID) REFERENCES TEAM(TeamID)
);

CREATE TABLE WORK
(
  WorkID VARCHAR(50) NOT NULL,
  WorkName VARCHAR(50) NOT NULL,
  WorkSummary VARCHAR(300) NOT NULL,
  WorkSDGs VARCHAR(50),
  WorkPoster VARCHAR(200),
  WorkYTURL VARCHAR(200),
  WorkGithub VARCHAR(200),
  WorkYear YEAR NOT NULL,
  WorkIntro VARCHAR(200),
  TeamID VARCHAR(50) NOT NULL,
  PRIMARY KEY (WorkID),
  FOREIGN KEY (TeamID) REFERENCES TEAM(TeamID)
);

CREATE TABLE SCORE
(
  Rate1 INT,
  Rate2 INT,
  Rate3 INT,
  Rate4 INT,
  TeamID VARCHAR(50) NOT NULL,
  JudgeEmail VARCHAR(50) NOT NULL,
  PRIMARY KEY (TeamID, JudgeEmail),
  FOREIGN KEY (TeamID) REFERENCES TEAM(TeamID),
  FOREIGN KEY (JudgeEmail) REFERENCES JUDGE(TJEmail)
);

CREATE TABLE ATTEND
(
  StuID VARCHAR(50) NOT NULL,
  WSID INT NOT NULL,
  PRIMARY KEY (StuID, WSID),
  FOREIGN KEY (StuID) REFERENCES STUDENT(StuID),
  FOREIGN KEY (WSID) REFERENCES WORK_SHOP(WSID)
);