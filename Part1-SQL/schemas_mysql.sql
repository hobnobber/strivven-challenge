USE testing

;

CREATE TABLE emails (
  id int AUTO_INCREMENT PRIMARY KEY,
  email varchar(500) NULL,
  `primary` int NULL,
  date datetime NULL
)

;

CREATE TABLE usage_log (
	id int AUTO_INCREMENT PRIMARY KEY,
	sessionId int NULL,
	login datetime NULL,
	logout datetime NULL
)

;

CREATE TABLE user_admin (
	id int AUTO_INCREMENT PRIMARY KEY,
	userId int NOT NULL
)

;

CREATE TABLE users (
	id int AUTO_INCREMENT PRIMARY KEY,
	fName varchar(500) NULL,
	lName varchar(500) NULL,
	age bigint NULL,
	date datetime NULL
)

;
