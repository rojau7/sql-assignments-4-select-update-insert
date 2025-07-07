USE ASSIGNMENT

CREATE TABLE STUDENTS(StudentID INT PRIMARY key,[NAME] VARCHAR(MAX), SURNAME VARCHAR(MAX),
BIRTHDATE DATE,GENDER CHAR(1),CLASS VARCHAR(50), [POINT] INT)

CREATE TABLE BORROWS(borrowID INT PRIMARY KEY, studentID INT, bookID INT, takenDate DATE,broughtDate DATE)

CREATE TABLE BOOKS (bookID INT PRIMARY KEY,[name] VARCHAR(MAX) ,[pagecount] INT ,[point] INT ,authorID INT ,typeID INT)

CREATE TABLE TYPES(typeID INT PRIMARY KEY, [name] VARCHAR(MAX))

--Example 1:  List all the records in the student chart

SELECT*FROM STUDENTS

--Example 2: List the name surname and class of the student in the student table

SELECT [NAME],SURNAME,CLASS FROM STUDENTS

--Example 3: List the gender Female (F) records in the student table

SELECT*FROM STUDENTS WHERE GENDER = 'F'

--Example 4 : List the names of each class in the way of being seen once in the student table

SELECT DISTINCT CLASS FROM STUDENTS

--Example 5: List the students with Female gender and the class 10Math in the student table

SELECT*FROM STUDENTS
WHERE GENDER = 'F' AND CLASS = '10Math'

--Example 6: List the names, surnames and classes of the students in the class 10Math or 10Sci in the student table

SELECT [NAME],SURNAME, CLASS FROM STUDENTS
WHERE CLASS = '10thMath' or CLASS = '10sci'

--Example 7: List the students name surname and school number in the student table

SELECT [NAME], SURNAME, StudentID FROM STUDENTS

--Example 8: List the students name and surname by combining them as name surname in the student table

SELECT [NAME] + ' ' + SURNAME AS FullName FROM STUDENTS

--Example 9: List the students with the names starting with “A” letter in the student table

SELECT*FROM STUDENTS WHERE NAME LIKE 'A%'

--Example 10: List the book names and pages count with number of pages between 50 and 200 in the book table

SELECT NAME,PAGECOUNT FROM BOOKS
WHERE pagecount BETWEEN 50 AND 200

--Example 11: List the students with names Emma Sophia and Robert in the student table

SELECT NAME FROM STUDENTS
WHERE NAME IN ('EMMA SOPHIA', 'ROBERT')

--Example 12: List the students with names starting with A D and K in the student table

SELECT*FROM STUDENTS WHERE NAME LIKE 'A%' OR NAME LIKE 'D%' OR NAME LIKE 'K%'

--Example 13: List the names surnames classes and genders of males in 9Math or females in 9His in the student table

SELECT NAME,SURNAME, CLASS,GENDER FROM STUDENTS
WHERE (GENDER = 'M' AND CLASS = '9Math') OR (GENDER = 'F' AND CLASS = '9His')

--Example 14: List the males whose classes are 10Math or 10Bio

SELECT*FROM STUDENTS WHERE GENDER = 'M' AND (CLASS = '10Math' or CLASS = '10Bio')

--Example 15: List the students with birth year 1989 in the student table

SELECT*FROM STUDENTS WHERE YEAR(BIRTHDATE) = 1989

--Example 16: List the female students with student numbers between 30 and 50

SELECT*FROM STUDENTS WHERE GENDER = 'F' AND  StudentID BETWEEN 30 AND 50

--Example 17: List the students according to their names

SELECT*FROM STUDENTS ORDER BY NAME DESC

--Example 18: List the students by names for those with same names. List them by their surnames

SELECT NAME, SURNAME,CLASS, GENDER,STUDENTID FROM STUDENTS
WHERE NAME IN(
    SELECT NAME FROM STUDENTS
    GROUP BY NAME
    HAVING COUNT(*)>1
)
ORDER BY NAME, SURNAME

--Example 19: List the students in 10Math by decreasing school numbers

SELECT*FROM STUDENTS
WHERE CLASS = '10Math'
ORDER BY StudentID DESC

--Example 20: List the first 10 records in the student chart

SELECT TOP 10* FROM STUDENTS

--Example 21: List the first 10 records name surname and date of birth information in the student table

SELECT TOP 10 NAME,SURNAME,BIRTHDATE FROM STUDENTS


--Example 22: List the book with the most pagenumber

SELECT TOP 1 NAME, PAGECOUNT FROM BOOKS 
ORDER BY pagecount DESC

--Example 23: List the youngest student in the student table

SELECT top 1 * from students 
order by BIRTHDATE DESC


--Example 24: List the oldest student in the 10Math class

SELECT TOP 1* FROM STUDENTS
Where CLASS = '10Math'
Order by BIRTHDATE ASC

--Example 25: List the books with the second letter N

SELECT*FROM BOOKS
where name like '_N%'

--Example 26: List the students by grouping according to their classes

SELECT*from students 
order by CLASS

--Example 27: List the students to be different in each questioning randomly

SELECT*FROM STUDENTS
ORDER BY NEWID()

--Example 28: Pick a random student from student table

SELECT TOP 1* FROM STUDENTS
ORDER BY NEWID()


--Example 29: Bring some random student’s name , surname and number from class 10Math

SELECT TOP 3 NAME, SURNAME, STUDENTID FROM STUDENTS
WHERE CLASS = '10Math'
ORDER BY NEWID()

--Example 30: Add the writer named Smith Allen to the authors table

INSERT INTO AUTHORS VALUES (101,'SMITH', 'ALLEN')
SELECT*FROM AUTHORS

--Example 31: Add the genre of  biography to the genre table

INSERT INTO TYPES VALUES (5,'BIOGRAPHY')

/*Example 32: Add 10Math Class male named Thomas Nelson , 9Bio class female named Sally Allen and 
11His Class female named Linda Sandra in one question*/

INSERT INTO STUDENTS (StudentID, name, surname, birthdate, gender, class, point)
VALUES
(1, 'THOMAS', 'NELSON', NULL, 'M', '10Math', NULL),
(2, 'SALLY', 'ALLEN', NULL, 'F', '9Bio', NULL),
(3, 'LINDA', 'SANDRA', NULL, 'F', '11His', NULL);

SELECT*from STUDENTS

--Example 33: Add a random student in the students chart to the writers chart as an authors

INSERT INTO AUTHORS (AuthorID,name, surname)
SELECT 105, name, surname
from (
    select top 1 name, surname
    from students 
    order by NEWID()
) as randomstudents


Example 34: Add students with student numbers between 10 and 30 as authors

WITH FilterStudents AS (
    SELECT ROW_NUMBER() OVER (ORDER BY STUDENTID) + 200 AS AuthorID, Name, Surname 
    FROM STUDENTS
    WHERE StudentID BETWEEN 10 AND 30
)
SELECT * FROM FilterStudents;

/*Example 35: Add the writer named Cindy Brown and make him write his writer number (Note: The last
increased rate in automatic enhancing is hold in @@IDENTITY factor)*/

INSERT INTO AUTHORS(AUTHORID,NAME,SURNAME)
VALUES(201,'CINDY','BROWN')

SELECT @@IDENTITY AS NEWWRITENUMBER


--Example 36: Change the class of the student whose school number is 3 from 10Bio to 10His

UPDATE STUDENTS
SET CLASS = '10His'
WHERE studentID = 3 and class = '10Bio'

--Example 37: Transfer all the students in 9Math Class to 10Math Class

UPDATE STUDENTS
set class = '10Math'
WHERE CLASS = '9Math'

--Example 38: Increase all of the students’ score by 5 points

update STUDENTS
SET POINT = POINT+5

--Example 39: Delete the author #25

DELETE FROM AUTHORS 
WHERE AUTHORID = 25


--Example 40: List the students whose birth dates are null

SELECT*FROM STUDENTS
WHERE BIRTHDATE IS NULL


--Example 41: List the name ,surname and the dates of received books of the student

SELECT S.NAME,S.SURNAME,B.takenDate
FROM STUDENTS S 
INNER JOIN BORROWS B 
ON S.STUDENTID = B.STUDENTID 
