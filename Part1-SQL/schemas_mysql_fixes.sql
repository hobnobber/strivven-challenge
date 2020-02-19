# USE testing;

DROP TABLE IF EXISTS emails;
DROP TABLE IF EXISTS usage_log;
DROP TABLE IF EXISTS user_admin;
DROP TABLE IF EXISTS users;

CREATE TABLE emails (
  id int AUTO_INCREMENT PRIMARY KEY,
  userId int NOT NULL,
  email varchar(500) NOT NULL,
  `primary` boolean NOT NULL,
  date datetime NOT NULL
);

ALTER TABLE emails ADD INDEX userix (userId);
ALTER TABLE emails ADD UNIQUE emailix (email);
ALTER TABLE emails ADD INDEX userprimary (userId, `primary`);

CREATE TABLE usage_log (
	id int AUTO_INCREMENT PRIMARY KEY,
    userId int NOT NULL,
	login datetime NOT NULL,
	logout datetime NULL
);

ALTER TABLE usage_log ADD INDEX userix (userId);
ALTER TABLE usage_log ADD INDEX userlogin (userId, login);
ALTER TABLE usage_log ADD INDEX userlogout (userId, logout);

CREATE TABLE user_admin (
	id int AUTO_INCREMENT PRIMARY KEY,
	userId int NOT NULL
);

ALTER TABLE user_admin ADD INDEX userix (userId);

CREATE TABLE users (
	id int AUTO_INCREMENT PRIMARY KEY,
	fName varchar(500) NULL,
	lName varchar(500) NULL,
	age smallint unsigned NULL,
	date datetime NOT NULL
);

ALTER TABLE users ADD INDEX dateix (date);

# Below Is Test Data

# id = 1 ; admin with primary email and alternate email ; usage 20 minutes 15 seconds recently and 30+ days ago for 1 hour : total time 1:20:15
INSERT INTO users (id, fName, lName, age, date) VALUES (1, 'John', 'Doe', 30, '2020-02-18 15:00:00');
INSERT INTO user_admin (id, userId) VALUES (1, 1);
INSERT INTO emails (id, userId, email, `primary`, date) VALUES (1, 1, "john@doe.com", true, '2020-02-18 15:00:00');
INSERT INTO emails (id, userId, email, `primary`, date) VALUES (2, 1, "johndoe7771@google.com", false, '2020-02-18 15:15:12');
INSERT INTO usage_log (id, userId, login, logout) VALUES (1, 1, '2020-01-01 15:00:00', '2020-01-01 16:00:00');
INSERT INTO usage_log (id, userId, login, logout) VALUES (2, 1, '2020-02-18 15:00:00', '2020-02-18 15:20:15');

# id = 2 ; admin without email ; no usage
INSERT INTO users (id, fName, lName, age, date) VALUES (2, 'Steve', 'Wilbanks', 65, '2020-02-18 16:00:00');
INSERT INTO user_admin (id, userId) VALUES (2, 2);

# id = 3; user without email; usage 30 minutes
INSERT INTO users (id, fName, lName, age, date) VALUES (3, 'Heather', 'Valdez', 44, '2020-02-18 17:00:00');
INSERT INTO usage_log (id, userId, login, logout) VALUES (3, 3, '2020-02-18 17:00:00', '2020-02-18 17:30:00');

# id = 4; user with email ; usage 1 minute
INSERT INTO users (id, fName, lName, age, date) VALUES (4, 'Hazel', 'Byers', 71, '2020-02-18 18:00:00');
INSERT INTO emails (id, userId, email, `primary`, date) VALUES (3, 4, "hazelb831@yahoo.com", true, '2020-02-18 18:00:00');
INSERT INTO usage_log (id, userId, login, logout) VALUES (4, 4, '2020-02-18 18:00:00', '2020-02-18 18:01:00');

# total usage is 1:00:00 + 20:15 + 30:00 + 1:00 = 1:51:15
