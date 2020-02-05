# Hiring Project
This project is meant to gauge your skills, attention to detail, and creativity.  We are testing your full stack skills; TSQL, PHP, Javascript, HTML, CSS.  Also, your ability to work within predefined libraries and frameworks.

You can take as much time as you need, but the amount of time it takes will be considered.  We realize life can get in the way, so if you have extenuating circumstances for why the project is taking so long, just let us know.  The project ETA is about 1 - 3 weeks, depending on available time.

If you have any questions, concerns, clarifications, or issues, please do not hesitate to email us directly.

# Project Steps
1. Clone this project using Git.
2. Follow instructions in [Part 1](#part-1) and include final results in the [Part1-SQL folder](https://github.com/StrivvenMedia/HiringProject/tree/master/Part1-SQL).
3. Follow instructions in [Part 2]($part-2) and include the final results in the [Part2-App folder](https://github.com/StrivvenMedia/HiringProject/tree/master/Part2-App).
4.  When you are finished, push your final results to a public repo on github, and send us a link.

# Part 1
The first part of the project is to test your SQL skills.  All the links you will need are provided below and all files are in the [Part1-SQL Folder](https://github.com/StrivvenMedia/HiringProject/tree/master/Part1-SQL).

We have provided you with a [schemas.sql file](https://github.com/StrivvenMedia/HiringProject/blob/master/Part1-SQL/schemas.sql). This file will contain all the table schemas we will be asking questions about. You can create the tables in either (MySQL or MSSQL).

There is a file [questions.sql](https://github.com/StrivvenMedia/HiringProject/blob/master/Part1-SQL/questions.sql) that you will need to open and fill out.  It contains questions that need to be answered, using the schemas provided.  For example something like, please write a query that gets all the users with no email ordered by their first names descending.

IMPORTANT: It is ok/expected that you will change the Table Schemas. There will be a question that asks what you changed, and why.  


# Part 2
The next part involves creating a PHP application using the technologies and data links below.  

The application needs to include the following.
1. Create a functioning login page, and logout feature.
2. Using the [Assessment data](https://github.com/StrivvenMedia/HiringProject/blob/master/Part2-App/Assessment%20Data.xlsx) provided, allow the user to take an assessment. They should be allowed to take the assessment as many times as they want.
  NOTE: The assessment questions are scored with 1 to 5 points. 5 points for liking most and 1 point for liking least.
3. Store the results of only the last assessment taken.  (No need to keep the results of every time taking it)
4. Display the results for the user.


### Don't Forget
* be sure to put the database backup in with your project.  Or some type of exported schema.
* if we need to know a password to login, please remember to include that information in the `README.md` in your repository.
* __DO NOT__ put any sensitive information in this project.  It is public. We are not responsible.

### Assessment Data
* [Data File](https://github.com/StrivvenMedia/HiringProject/blob/master/Part2-App/Assessment%20Data.xlsx)

### Technologies Required
* [SlimPHP Framework 2 or 3](https://www.slimframework.com/)
* [JQuery](https://jquery.com/)
* [Bootstrap 3 or 4 for CSS](http://getbootstrap.com/docs/3.3/)
* MySQL, MSSQL, Flat Files, SQL Lite, etc..

### Other Technologies that might help
* [Composer for PHP](https://getcomposer.org/)
* [FontAwesome](https://fontawesome.com/)
* [underscore.js](http://underscorejs.org/)
