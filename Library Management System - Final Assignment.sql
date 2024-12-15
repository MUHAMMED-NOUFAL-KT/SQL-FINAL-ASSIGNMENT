create database Library;
use library;

Create table Branch (Branch_No Int Primary key,
Manager_id int,
Branch_address varchar(50),
Contact_no int);

create table Employee (Emp_id int primary key,
Emp_Name varchar(25),
Position varchar(25),
Salary int,
Branch_No int,
foreign key (Branch_No) references Branch(Branch_No));

create table Books (ISBN int PRIMARY key,
Book_Title varchar(50),
Category varchar(50),
Rental_Price int,
Status char(1) check (status in ('Y','N')));

create table Customer (Customer_Id int primary key,
Customer_name varchar(50),
Customer_address varchar(50),
Reg_date date);

create table IssueStatus (Issue_Id int auto_increment primary key,
Issued_cust int,
Issued_book_name varchar(50),
Issue_date date,
Isbn_Book int,
foreign key (Issued_cust) references Customer(Customer_Id),
foreign key (Isbn_Book) references Books(ISBN));

create table Return_Status (Return_Id int primary key,
Return_cust varchar(25),
Return_Book_Name varchar(30),
Return_Date date,
Isbn_Book2 int,
foreign key (Isbn_Book2) references Books(ISBN));

insert into Branch (Branch_No,Manager_id,Branch_address,Contact_no)
values (1,5,'Palakkad',5676),
(2,8,'Malappuram',5121),
(3,10,'Kozhikkode',1489),
(4,6,'Thrissur',5123),
(5,3,'Kollam',5127);

select * from Branch;

insert into Employee (Emp_id,Emp_Name,Position,Salary,Branch_No)
values (15,'Noufal','Manager',65000,5),
(22,'Noushad','Book keeper',25000,2),
(31,'Salam','Manager',70000,1),
(25,'Shoukath','Clerk',35000,3),
(33,'Sinsiya','Manager',75000,2),
(75,'Sharanya','Manager',60000,3),
(66,'Shajahan','Clerk',44000,3),
(50,'Shahana','Manager',65000,3),
(55,'Jasim','Book keeper',30000,5),
(10,'Sanoop','Clerk',44000,4);

select * from employee;

insert into Books (ISBN,Book_Title,Category,Rental_Price,Status)
values (2555,'Indian History','Drama',30,'Y'),
(3111,'Kathuri','Poem',20,'N'),
(6555,'Keralam through History','Novel',35,'Y'),
(7556,'Shakunthalam History','Poem',30,'Y'),
(8967,'Mr.Bean','Comic',23,'N'),
(7566,'Avathar','Fantasy',35,'N'),
(9554,'Indian Railway History','Novel',40,'Y'),
(7557,'Shankar Das','Novel',15,'Y'),
(8898,'Mayavi','Comic',28,'N'),
(7568,'Dream World','Fantacy',35,'Y');

select * from Books;

insert into Customer (Customer_Id,Customer_name,Customer_address,Reg_date)
values (1,'Anwar','Eranamkulam','2021-12-25'),
(2,'Sanoop','Palakkad','2024-11-11'),
(3,'Sufaid','Thrissur','2020-05-05'),
(4,'Navas','Malappuram','2005-11-15'),
(5,'Arun','Kozhikkode','2024-11-10'),
(6,'Musthafa','Palakkad','2020-10-10'),
(7,'Nadhira','Kollam','2023-10-24'),
(8,'Anoop','Kottayam','2024-01-01'),
(9,'Praveen','Malappuram','2023-05-10'),
(10,'Safwan','Palakkad','2024-10-10');

select * from Customer;

insert into IssueStatus (Issue_Id,Issued_cust,Issued_book_name,Issue_date,Isbn_Book)
values (101,6,'Mr.Bean','2023-06-01',8967),
(121,1,'Mayavi','2023-12-01',8898),
(155,4,'Indian History','2023-12-31',2555),
(175,2,'Shankar Das','2023-10-25',7557),
(123,9,'Avathar','2023-06-25',7566),
(456,8,'Kasthuri','2023-06-11',3111),
(875,7,'Dream World','2023-05-08',7568),
(750,5,'Shakunthalam History','2023-12-12',7556);

select * from IssueStatus;

insert into Return_Status (Return_Id,Return_cust,Return_Book_Name,Return_Date,Isbn_Book2)
values (250,'Praveen','Shankar Das','2024-10-24',7557),
(255,'Anoop','Avathar','2024-11-02',7566),
(301,'Safwan','Mr.Bean','2024-03-25',8967),
(375,'Sufaid','Mayavi','2024-03-03',8898),
(444,'Navas','Kasthuri','2024-04-01',3111),
(475,'Musthafa','Indian Railway History','2024-05-05',9554),
(350,'Anwar','Dream World','2024-11-11',7568);

select * from Return_Status;

update employee set Branch_No =3 where emp_id=5;
update employee set Branch_No =3 where emp_id=10;

##1. Retrieve the book title, category, and rental price of all available books.
select Book_Title,Category,Rental_Price from Books Where Status ='Y';

##2.List the employee names and their respective salaries in descending order of salary.
select Emp_Name,Salary from Employee order by Salary DESC;

##3.Retrieve the book titles and the corresponding customers who have issued those books.
select Issued_book_name, Customer_name from IssueStatus as I
inner join Customer As C on I.Issued_cust = C.Customer_Id;

##4.Display the total count of books in each category.
select category,count(*) as Book_Count from Books group by category;

 ##5. Retrieve the employee names and their positions for the employees whose salaries are above Rs.50,000.
 select Emp_Name,Position,Salary from employee where salary >50000;
 
 ##6. List the customer names who registered before 2022-01-01 and have not issued any books yet.
 select Customer_Name,Reg_date from customer as c
 inner join IssueStatus as I ON C.Customer_Id = I.Issued_cust
 inner join Books as B ON B.ISBN = I.Isbn_Book
 where c.Reg_date<'2022-01-01' and B.status='N';
 
 ##7. Display the branch numbers and the total count of employees in each branch.
 select branch_no,count(*) as Number_of_Employees from employee group by branch_no;
 
 ##8. Display the names of customers who have issued books in the month of June 2023.
 select Customer_Name,Issue_date from Customer AS C
 left join IssueStatus AS I ON I.Issued_cust = C.Customer_Id
 where I.Issue_date >='2023-06-01' and I.Issue_date <='2023-06-30';
 
 ##9. Retrieve book_title from book table containing history.
 select book_title from books
 where book_title like '%History%';
 
 ##10. Retrieve the branch numbers along with the count of employees for branches having more than 5 employees--
 select branch_no,count(*) as Count_Emp from employee group by Branch_no
 having count(*) >=5;
 
 ##11. Retrieve the names of employees who manage branches and their respective branch addresses.
 select emp_name,position,branch_address from employee as E
 inner join Branch AS B on B.Branch_No = E.Branch_No
 WHERE POSITION = 'Manager';
 
 ##12.Display the names of customers who have issued books with a rental price higher than Rs. 25.
 select customer_name,ISBN_BOOK,Book_title,Rental_price from customer as c
 right join IssueStatus AS I ON I.ISSUED_CUST = C.CUSTOMER_Id
 left join Books as B ON B.ISBN = I.ISBN_BOOK 
 WHERE B.Rental_Price >25;
 
 

