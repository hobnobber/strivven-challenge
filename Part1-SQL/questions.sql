-- Here are some questions to answer
-- Keep the questions in the file, and just put the answers below the questions.

/*
  About the DATA
  There are 4 tables
  here is a list with descriptions

  IMPORTANT: YOU MAY CHANGE THE TABLE STRUCTURES IF YOU WOULD LIKE.
      THE LAST QUESTION WILL ASK ABOUT ALL YOUR CHANGES.

  - users
     - just a list of user data
  - emails
     - holds users emails.
     - There is a one to many relationship with the users table. Each user can have many emails
     - One email is marked as the primary email for the user
  - usage_log
     - holds the users session dates and times.
     - contains the login and logout times of every user session.
     - So every time a user logs in, it creates a new entry in this table
  - users_admin
     - only holds a user id
     - if a user's id is in this table, then they are an admin
*/

-- EXAMPLE
-- Write a statement that will return all the users
--  with the last name 'Johnson'
SELECT *
  FROM users
  WHERE lName = 'Johnson';


-- QUESTION 1
-- write a statement that returns all the users data
--   including their primary email, if they have one
--   and if they are an admin or not

SELECT DISTINCT users.*, emails.email,
  CASE WHEN user_admin.id IS NOT NULL
    THEN true
    ELSE false
  END AS admin
  FROM users
  LEFT JOIN emails
  ON users.id = emails.userId and emails.`primary` = true
  LEFT JOIN user_admin
  ON users.id = user_admin.userId
  ORDER BY users.id;

/*
TEST RESULTS:
id, fName,   lName,    age, date,                email,               admin
1,  John,    Doe,      30,  2020-02-18 15:00:00, john@doe.com,        1
2,  Steve,   Wilbanks, 65,  2020-02-18 16:00:00, NULL,                1
3,  Heather, Valdez,   44,  2020-02-18 17:00:00, NULL,                0
4,  Hazel,   Byers,    71,  2020-02-18 18:00:00, hazelb831@yahoo.com, 0
*/

-- QUESTION 2
-- write a statement that returns all user data
--   including their primary email
--   and if they are an admin or not
--   but only users with emails

SELECT users.*, emails.email,
  CASE WHEN user_admin.id IS NOT NULL
    THEN true
    ELSE false
  END AS admin
  FROM users
  JOIN emails
  ON users.id = emails.userId and emails.`primary` = true
  LEFT JOIN user_admin
  ON users.id = user_admin.userId
  ORDER BY users.id;

/*
TEST RESULTS:
id, fName, lName, age, date,                email,               admin
1,  John,  Doe,   30,  2020-02-18 15:00:00, john@doe.com,        1
4,  Hazel, Byers, 71,  2020-02-18 18:00:00, hazelb831@yahoo.com, 0
*/

-- QUESTION 3
-- write a statement that returns all user data
--   that do not have an email
--   and are not admins

SELECT users.*
  FROM users
  LEFT JOIN emails
  ON users.id = emails.userId
  LEFT JOIN user_admin
  ON users.id = user_admin.userId
  WHERE emails.userId IS NULL and user_admin.userId IS NULL
  ORDER BY users.id;

/*
TEST RESULTS: 
id, fName,   lName,  age, date
3,  Heather, Valdez, 44,  2020-02-18 17:00:00
*/

-- QUESTION 4
-- write a statement that returns all the users data
--    only users with last name that contains a letter 'B'
--    and also return the number of emails those users have

SELECT users.*, count(emails.id) as emailcount
  FROM users
  LEFT JOIN emails
  ON users.id = emails.userId
  WHERE users.lName LIKE '%b%'
  GROUP BY users.id
  ORDER BY users.id;

/*
TEST RESULTS:
id, fName, lName,    age, date,                emailcount
2,  Steve, Wilbanks, 65,  2020-02-18 16:00:00, 0
4,  Hazel, Byers,    71,  2020-02-18 18:00:00, 1
*/

-- QUESTION 5
-- write a statement that returns all the users data
--    only users that have more than one email
--    and are admins

SELECT DISTINCT users.*
  FROM users, emails, user_admin
  WHERE users.id = emails.userId and users.id = user_admin.userId
  ORDER BY users.id;

/*
TEST RESULTS:
id, fName, lName, age, date
1,  John,  Doe,   30,  2020-02-18 15:00:00
*/

-- QUESTION 6
-- write a statement that returns all user data
--   with the total amount of time the users have spent on the site
--   in the past 21 days, in minutes

SELECT users.*,
  count(usage_log.id) as logincount,
  time_format(sum(abs(timediff(logout, login))),'%H:%i:%s') as total21days
  FROM users, usage_log
  WHERE users.id = usage_log.userId 
    AND logout BETWEEN NOW() - INTERVAL 21 DAY AND NOW()
  GROUP BY users.id
  ORDER BY users.id;

/*
TEST RESULTS:
id, fName,   lName,  age, date,                logincount, total21days
1,  John,    Doe,    30,  2020-02-18 15:00:00, 1,          00:20:15
3,  Heather, Valdez, 44,  2020-02-18 17:00:00, 1,          00:30:00
4,  Hazel,   Byers,  71,  2020-02-18 18:00:00, 1,          00:01:00
*/

-- QUESTION 7
-- Write a statement that returns all user data
--   with the total amount of time spent on the site
--   and with the total number of logins
--   beginning of time

SELECT users.*,
  time_format(sum(abs(timediff(logout, login))),'%H:%i:%s') as totaltime,
  count(usage_log.id) as logincount
  FROM users, usage_log
  WHERE users.id = usage_log.userId
  GROUP BY users.id
  ORDER BY users.id;

/*
TEST RESULTS:
id, fName,   lName,  age, date,                totaltime, logincount
1,  John,    Doe,    30,  2020-02-18 15:00:00, 01:20:15,  2
3,  Heather, Valdez, 44,  2020-02-18 17:00:00, 00:30:00,  1
4,  Hazel,   Byers,  71,  2020-02-18 18:00:00, 00:01:00,  1
*/

-- QUESTION 8
-- given the table structure provided.
-- How would you did/would you change/improve our schema? Any Why?
-- Please list all changes that were made and a justification for the change.

/*
Assumptions I made:

1. Emails/Email is actually "email address(es)" but not an email with a to/from/subject/etc
2. "returns all user data" in questions means all data in the users table and not to include all users data across all tables
3. QUESTION 2 says if they include an email and I am assuming that also means the email has to be marked as primary.
   You would likely want to make the system to require that if the user only has one email then it would be set to primary as true.
4. users.date field represents the date the users account was created and after that does not change
5. QUESTION 6 does not indicate if you want users with no minutes.  I assuming you only want to show users who logged in the last 21 days.
6. QUESTION 7 does not indicate if you want users who never logged in.  I am assuming you want a list of useres that have at least one login.
*/

/*
Changes I made to schemas and reasons:

1. Changes to make SQL commands work with MySQL:
   a) removing brackets
   b) removed dbo reference
   c) change primary key fields flags to "AUTO_INCREMENT PRIMARY KEY"
   d) removed GO command and replaced with semicolons
   REASON: Need to run this on MySQL instead of MSSQL for my hosting/testing
2. Added drop table commands to top of sql file
   REASON: So that I could rerun the SQL file without errors of existing tables
3. Data Type changes:
   a) Changed field 'primary' in table 'emails' into a boolean type
   REASON: since there is only one primary email per user then we need only a boolean and results in less disk space used
   b) Changed field 'age' in table ' users' into a smallint unsigned
   REASON: Maybe if we are lucky users get to an age of 256 which would surpass an unsigned tinyint data type so I went with 
           an unsigned smallint which means the max age range is 0 to 65,535.  We do not need a bigint here which would support an age
           up to 2^63-1, approx 9,223,372,037,000,000,000
           so reducing this field from bigint to an unsigned smallint will save 4 times the disk space space (8 bytes to 2 bytes)
4. Added 'userId' field to both tables 'emails' and 'usage_log' and not allowing nulls
   REASON: one to many relationship requires that the 'user.id' field needs a field to relate to
           This is similar to the existing 'userId' field in table 'user_admin'
5. Removed 'sessionId' field from table 'usage_log'
   REASON: redundant field of 'usage_log.id'
6. Changed some fields from allowing null to not allowing null:
   a) 'email' field in 'emails' to not be NULL
   REASON: there is no reason to add an email record if the email address is blank
           also when making email a unique index this field should not allow nulls
   a) 'primary' field in 'emails' to not be NULL
   REASON: when an email is added it should default to false unless specified as primary
   b) 'date' field in 'emails' to not be NULL
   REASON: when an email is added then the date and time of the change should always be recorded in the 'date' field
   c) 'login' field in 'usage_log' to not be NULL
   REASON: when the user logs in and the session is created then the date and time of the login should be recorded in the 'login' field
   d) 'date' field in 'users' to not be NULL
   REASON: when a user is added then the date and time of the change should always be recorded in the 'date' field
7. Non-Primary Indexes:
   a) added index 'userix' using field 'userId' in table 'emails'
   REASON: quicker searching for emails for a specific user
   b) added unique index 'emailix' using field 'email' in table 'emails'
   REASON: quicker searching for an email and also, by making unqiue, to not allow a user to use an email already assigned to a different user
   c) added index 'userprimary' using fields 'userId' and 'primary' in table 'emails'
   REASON: quicker search for the primary email for a user
   d) added index 'userix' using field 'userId' in table 'usage_log'
   REASON: quicker searching for a specific users sessions data
   e) added index 'userlogin' using field 'userId' and 'login' in table 'usage_log'
   REASON: quicker searching for a specific users session based on login date
   f) added index 'userlogout' using field 'userId' and 'logout' in table 'usage_log'
   REASON: quicker searching for a specific users session based on logout date
   d) added index 'userix' using field 'userId' in table 'user_admin'
   REASON: quicker searching searching for an admin user
   e) added index 'dateix' using field 'date' in table 'users'
   REASON: quicker searching of users created in specific date ranges
8. Added Test Data (insert statements)
   REASON: Test the "answer" sql statements are returning correct values 
*/


-- Some fun with SQL:

-- Total System Usage:

SELECT time_format(sum(abs(timediff(logout, login))),'%H:%i:%s') as totaltime,
  count(distinct usage_log.id) as logincount,
  count(distinct users.id) as usercount,
  count(distinct emails.id) as emailcount
  FROM users
  LEFT JOIN usage_log
  ON users.id = usage_log.userId
  LEFT JOIN emails
  ON users.id = emails.userId;
 
/*
TEST RESULTS:
totaltime, logincount, usercount, emailcount
01:51:15,  4,          4,         3
*/
