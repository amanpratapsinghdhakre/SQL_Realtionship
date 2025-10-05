/*
Scenario 1 (Fresher Level – One-to-Many):

We have a small company. The company has departments, and each department has employees.

Task:

Create tables for Departments and Employees.

Decide which columns are needed and how to relate them.

Implement the one-to-many relationship where each department can have multiple employees,
but each employee belongs to only one department.
*/

CREATE TABLE DEPARTMENT
(
DID INT PRIMARY KEY,
DNAME NVARCHAR(30) uNIQUE
);

CREATE TABLE EMPLOYEES
(
EMPID INT PRIMARY KEY,
EMPNAME NVARCHAR(30),
EMAIL NVARCHAR(50) UNIQUE,
DID INT REFERENCES DEPARTMENT(DID)
);


/*
Scenario 2:

We have a school.

Students can enroll in multiple courses, and each course can have multiple students.

Task:

Create tables for Students and Courses.

Design an additional table to implement the many-to-many relationship.

Decide on the columns and relationships.
*/

CREATE TABLE COURSES
(
COURSEID INT PRIMARY KEY,
COURSENAME NVARCHAR(50) UNIQUE,
)

CREATE TABLE STUDENTS
(
STD_ID INT PRIMARY KEY,
STD_NAME NVARCHAR(50)
);

CREATE TABLE ENROLLMENT
(
ENROLL_ID INT PRIMARY KEY,
COURSEID INT REFERENCES COURSES(COURSEID),
STD_ID INT REFERENCES STUDENTS(STD_ID)
);


/*
Scenario 3:

In a company, each employee can have a manager.

Every employee has an EmployeeID.

A manager is also an employee, so we need a relationship inside the same table.

Task:

Create a table for Employees where an employee can reference another employee as their manager.
*/

CREATE TABLE EMPLOYEE
(
EMPID INT PRIMARY KEY,
EMP_NAME NVARCHAR(30),
MANAGERID INT REFERENCES EMPLOYEE(EMPID)
);


/*
Scenario 4:

In a company, departments can have sub-departments.

Each department has a DepartmentID and a DepartmentName.

A sub-department belongs to a parent department (but still stored in the same table).

Task:

Create a Departments table where a department can reference another department as its parent department.
*/

CREATE TABLE DEPARTMENTS
(
DID INT PRIMARY KEY,
DNAME NVARCHAR(20),
PARENT_DID INT REFERENCES DEPARTMENTS(DID)
);


/*
Scenario 5:

We are building a simple shopping system.

A Customer can place many Orders.

Each Order can have many OrderDetails (products inside that order).

Each OrderDetail belongs to one Product.

Task:

Create tables for Customers, Orders, OrderDetails, and Products, with the right primary keys, 
foreign keys, and relationships.

(Hint: This is a 3-level chain: Customers → Orders → OrderDetails, with Products connected too.)
*/

CREATE TABLE CUSTOMERS
(
CUSTOMERID INT PRIMARY KEY,
CUSTOMERNAME NVARCHAR(30)
);

CREATE TABLE ORDERS
(
ORDERID INT PRIMARY KEY,
ORDER_TOKEN INT,
CUSTOMERID INT REFERENCES CUSTOMERS(CUSTOMERID)
);

CREATE TABLE PRODUCTS
(
PRODUCTID INT PRIMARY KEY,
PRODUCTNAME NVARCHAR(30)
);

CREATE TABLE ORDERDETAILS
(
ORDERDETAILS_ID INT PRIMARY KEY,
ORDERID INT REFERENCES ORDERS(ORDERID),
PRODUCTID INT REFERENCES PRODUCTS(PRODUCTID)
);


/*
Scenario 6:

In a university:

Each Professor can teach many Courses.

Each Course is taught by only one Professor.

Task:
Create tables for Professors and Courses, with the correct primary key, foreign key, and relationship.

This is a classic one-to-many relationship.
*/


CREATE TABLE PROFESSOR
(
PID INT PRIMARY KEY,
PNAME NVARCHAR(30)
);

CREATE TABLE COURSES
(
COURSEID INT PRIMARY KEY,
COURSENAME NVARCHAR(30) UNIQUE,
PID INT REFERENCES PROFESSOR(PID)
);


/*
Scenario 7:

In the same university:

A Student can enroll in many Courses.

A Course can have many Students.

Task:
Create tables for Students and Courses, and design a third table (Enrollments) to handle
the many-to-many relationship.

Each student should have a unique ID and name.

Each course should have a unique ID and name.

The enrollments table should connect students and courses with proper keys.
*/

CREATE TABLE STUDENTS
(
STU_ID INT PRIMARY KEY,
STU_NAME NVARCHAR(50)
);

CREATE TABLE COURSES
(
COURSEID INT PRIMARY KEY,
COURSENAME NVARCHAR(30) UNIQUE
)

CREATE TABLE ENROLLMENTS
(
ENROLLMENT_ID INT PRIMARY KEY,
STU_ID INT REFERENCES STUDENTS(STU_ID),
COURSEID INT REFERENCES COURSES(COURSEID)
);


/*
Scenario 8:

In a library:

Members can borrow multiple Books over time → many-to-many relationship.

Each Book belongs to a Category → one-to-many relationship.

Task for you:

Create tables for Members, Books, and Categories.

Include a BorrowedBooks table for the many-to-many relationship between Members and Books.

Make sure all primary keys and foreign keys are correctly defined.
*/

CREATE TABLE MEMBERS
(
MEMBER_ID INT PRIMARY KEY,
MEMBER_NAME NVARCHAR(30)
)


CREATE TABLE CATEGORY
(
CATEGORY_ID INT PRIMARY KEY,
CATEGORY_NAME NVARCHAR(40) UNIQUE
);

CREATE TABLE BOOKS
(
BOOK_ID INT PRIMARY KEY,
BOOK_NAME NVARCHAR(30) UNIQUE,
CATEGORY_ID INT REFERENCES CATEGORY(CATEGORY_ID)
);

CREATE TABLE BORROWEDBOOKS
(
BORROWED_DATE DATE,
MEMBER_ID INT REFERENCES MEMBERS(MEMBER_ID),
BOOK_ID INT REFERENCES BOOKS(BOOK_ID),
PRIMARY KEY(BORROWED_DATE,MEMBER_ID,BOOK_ID)
);

/*
Scenario 9:

A restaurant management system:

Each Chef can manage multiple Dishes.

Each Dish is cooked by only one Chef.
*/

CREATE TABLE CHEF
(
CHEF_ID INT PRIMARY KEY,
CHEF_NAME NVARCHAR(50)
);

CREATE TABLE DISH
(
DISH_ID INT PRIMARY KEY,
DISH_NAME NVARCHAR(50) UNIQUE,
CHEF_ID INT REFERENCES CHEF(CHEF_ID)
);


/*
Scenario 10:

A music platform:

Artists can create multiple Albums.

Albums can feature multiple Artists (collaborations).
*/

CREATE TABLE ARTISTS
(
ARTIST_ID INT PRIMARY KEY,
ARTIST_NAME NVARCHAR(40)
);

CREATE TABLE ALBUMS
(
ALBUM_ID INT PRIMARY KEY,
ALBUM_NAME NVARCHAR(40) UNIQUE
);

CREATE TABLE COLLABORATION
(
RELEASE_DATE DATE,
ARTIST_ID INT REFERENCES ARTISTS(ARTIST_ID),
ALBUM_ID INT REFERENCES ALBUMS(ALBUM_ID),
PRIMARY KEY(RELEASE_DATE,ARTIST_ID,ALBUM_ID)
);


/*
Scenario 11:

A company hierarchy:

Employees can have managers who are also employees.

Some employees may not have a manager (top-level).
*/

CREATE TABLE EMPLOYEES
(
EMP_ID INT PRIMARY KEY,
EMP_NAME NVARCHAR(40),
MANAGER_ID INT REFERENCES EMPLOYEES(EMP_ID) ON DELETE SET NULL
);

/*
Scenario 12:

A fitness center:

Trainers can train multiple Members → one-to-many.

Members can attend multiple Classes, and Classes can have multiple Members → many-to-many.

Task: Design tables for Trainers, Members, Classes, and the relationship table(s).
*/

CREATE TABLE TRAINERS
(
TRAINER_ID INT PRIMARY KEY,
TRAINER_NAME NVARCHAR(50)
);

CREATE TABLE MEMBERS
(
MEMBER_ID INT PRIMARY KEY,
MEMBER_NAME NVARCHAR(40),
TRAINER_ID INT REFERENCES TRAINERS(TRAINER_ID)
);

CREATE TABLE CLASSES
(
CLASS_TIME DATETIME2,
TRAINER_ID INT REFERENCES TRAINERS(TRAINER_ID),
MEMBER_ID INT REFERENCES MEMBERS(MEMBER_ID),
PRIMARY KEY(CLASS_TIME,TRAINER_ID,MEMBER_ID)
); 


/*
Scenario 13:

An online store:

Suppliers supply Products → one-to-many.

Products appear in Orders → one-to-many.

Orders are placed by Customers → one-to-many.

Task: Design the tables and relationships for Suppliers, Products, Orders, and Customers.
*/

CREATE TABLE SUPPLIERS
(
SUPPLIER_ID INT PRIMARY KEY,
SUPPLIER_NAME NVARCHAR(40) UNIQUE
);

CREATE TABLE PRODUCTS
(
PRODUCT_ID INT PRIMARY KEY,
PRODUCT_NAME NVARCHAR(40),
QUANTITY INT,
SUPPLIER_ID INT REFERENCES SUPPLIERS(SUPPLIER_ID)
);

CREATE TABLE CUSTOMERS
(
CUSTOMER_ID INT PRIMARY KEY,
CUSTOMER_NAME NVARCHAR(40)
);


CREATE TABLE ORDERS
(
ORDER_ID INT PRIMARY KEY,
ORDER_DATE DATETIME2,
CUSTOMER_ID INT REFERENCES CUSTOMERS(CUSTOMER_ID),
PRODUCT_ID INT REFERENCES PRODUCTS(PRODUCT_ID)
);

CREATE TABLE ORDERDETAILS
(
ORDERDETAIL_ID INT PRIMARY KEY,
ORDER_DETAIL NVARCHAR(100),
QUANTITY INT,
PRICE DECIMAL(10,2),
ORDER_ID INT REFERENCES ORDERS(ORDER_ID),
PRODUCT_ID INT REFERENCES PRODUCTS(PRODUCT_ID)
);

/*
Scenario 14:

Each GymBranch can have multiple Equipment.

Each Equipment belongs to only one GymBranch.

Task:
Create tables for GymBranch and Equipment with proper columns, primary keys, 
foreign keys, and the one-to-many relationship.
*/

CREATE TABLE GYMBRANCH
(
GYM_ID INT PRIMARY KEY,
GYMBRANCH NVARCHAR(40) UNIQUE,
LOCATION NVARCHAR(100)
);

CREATE TABLE EQUIPMENT
(
EQUIPMENT_ID INT PRIMARY KEY,
EQUIPMENT_NAME NVARCHAR(25) UNIQUE,
PURCHASE_DATE DATE,
GYM_ID INT REFERENCES GYMBRANCH(GYM_ID)
);


/*
Scenario 15:

Members & Trainers with Sessions

A Member can train with multiple Trainers.

A Trainer can train multiple Members.

Each training session should also store the date and time of the session.

Task:

Create tables for Members, Trainers, and a junction table (Sessions) to capture the many-to-many relationship.

Make sure the junction table has proper foreign keys and a composite key so that a member and trainer
can’t have duplicate session entries at the same date/time.
*/

CREATE TABLE TRAINERS
(
TRAINER_ID INT PRIMARY KEY,
TRAINER_NAME NVARCHAR(30),
SPECIALIZATION NVARCHAR(30)
);

CREATE TABLE MEMBERS
(
MEMBER_ID INT PRIMARY KEY,
MEMBER_NAME NVARCHAR(30),
PHONE BIGINT,
JOIN_DATE DATE
);

CREATE TABLE SESSIONS
(
SESSION_IDS INT,
SESSION_TIME DATETIME2,
TRAINER_ID INT REFERENCES TRAINERS(TRAINER_ID),
MEMBER_ID INT REFERENCES MEMBERS(MEMBER_ID)
);

/* ================= OR ==================== */

CREATE TABLE SESSIONS
(
    SESSION_TIME DATETIME2,
    TRAINER_ID INT REFERENCES TRAINERS(TRAINER_ID),
    MEMBER_ID INT REFERENCES MEMBERS(MEMBER_ID),
    PRIMARY KEY (SESSION_TIME, TRAINER_ID, MEMBER_ID)
);


/*
SESSIONS 16:

Students & Courses with Grades

Requirements:

A Student can enroll in multiple Courses.

A Course can have multiple Students.

Each enrollment needs to store extra details:

EnrollmentDate

Grade (optional, can be NULL until course is completed).
*/

CREATE TABLE STUDENTS
(
STU_ID INT PRIMARY KEY,
STU_NAME NVARCHAR(30),
EMAIL NVARCHAR(30),
ENROLLMENT_YEAR DATE
);

CREATE TABLE COURSES
(
COURSE_ID INT PRIMARY KEY,
COURSE_NAME NVARCHAR(30)
);

CREATE TABLE ENROLLMENT
(
ENROLLMENT_ID INT PRIMARY KEY,
ENROLLMENTDATE DATE,
GRADE NVARCHAR(10) CHECK(GRADE IN('A','B','C','D','E','F')),
STU_ID INT REFERENCES STUDENTS(STU_ID),
COURSE_ID INT REFERENCES COURSES(COURSE_ID)
);


/*
SCENARIO 17:

Employees working on Projects with Roles

Requirements:

An Employee can work on multiple Projects.

A Project can have multiple Employees.

For each assignment, we want to store additional information:

• Role (e.g., Developer, Tester, Manager)

• AssignedDate
*/

CREATE TABLE EMPLOYEES
(
    EMP_ID INT PRIMARY KEY,
    EMP_NAME NVARCHAR(40),
    EMAIL NVARCHAR(30) UNIQUE,
    JOIN_DATE DATE
);

CREATE TABLE PROJECTS
(
    PROJECT_ID INT PRIMARY KEY,
    PROJECT_NAME NVARCHAR(50),
    START_DATE DATE,
    END_DATE DATE
);

CREATE TABLE ASSIGNMENT
(
    ASSIGNMENT_ID INT PRIMARY KEY,  -- Surrogate key
    ROLE NVARCHAR(20) CHECK(ROLE IN ('DEVELOPER','TESTER','MANAGER')),
    ASSIGNED_DATE DATE,
    EMP_ID INT REFERENCES EMPLOYEES(EMP_ID),
    PROJECT_ID INT REFERENCES PROJECTS(PROJECT_ID),
	CONSTRAINT UQ_EMP_PROJECT UNIQUE (EMP_ID, PROJECT_ID)  -- Prevent duplicate assignments
);


/*
SESSIONS 18:

Company Departments and Employees (Self-Referencing + Many-to-Many)

Business Case:

You’re designing a system for a large company that tracks:

Employees (who can manage and collaborate across departments)

Departments (each has one manager but many employees)

Projects (can involve employees from multiple departments)
*/

CREATE TABLE DEPARTMENTS
(
DEPT_ID INT PRIMARY KEY,
DEPT_NAME NVARCHAR(50)
);

CREATE TABLE EMPLOYEES
(
EMP_ID INT PRIMARY KEY,
EMP_NAME NVARCHAR(30),
EMAIL NVARCHAR(30),
MANAGERID INT REFERENCES EMPLOYEES(EMP_ID),
DEPT_ID INT REFERENCES DEPARTMENTS(DEPT_ID)
);

CREATE TABLE PROJECTS
(
PROJECT_ID INT PRIMARY KEY,
PROJECT_NAME NVARCHAR(50),
START_DATE DATE,
END_DATE DATE
);

CREATE TABLE EMPLOYEE_PROJECTS
(
EMP_PROJECT_ID INT PRIMARY KEY,
HOURSWORKED DECIMAL(5,2),
ROLEINPROJECT NVARCHAR(30) CHECK(ROLEINPROJECT IN('DEVELOPER', 'TESTER', 'MANAGER','Analyst','Designer')),
EMP_ID INT REFERENCES EMPLOYEES(EMP_ID),
DEPT_ID INT REFERENCES DEPARTMENTS(DEPT_ID),
PROJECT_ID INT REFERENCES PROJECTS(PROJECT_ID),
CONSTRAINT UQ_EMP_PROJECT UNIQUE (EMP_ID, PROJECT_ID) -- prevents assigning the same employee twice to the same project.
);

/*
SESSIONS 19:

Hospital Management System (Doctors, Patients & Medications)

Business Case:

You’re building a hospital database that tracks which Doctors prescribe which Medications to which Patients.

A Doctor can treat many Patients.

A Patient can be treated by many Doctors.

A Doctor can prescribe many Medications, and the same Medication can be prescribed by many Doctors.

A Prescription connects all three — it’s a ternary relationship (Doctor ↔ Patient ↔ Medication).
*/

CREATE TABLE DOCTORS
(
    DOCTOR_ID INT PRIMARY KEY,
    DOCTOR_NAME NVARCHAR(30),
    SPECIALIZATION NVARCHAR(30)
);

CREATE TABLE PATIENTS
(
    PATIENT_ID INT PRIMARY KEY,
    PATIENT_NAME NVARCHAR(30),
    VISIT_DATE DATE
);

CREATE TABLE MEDICATIONS
(
    MEDICINE_ID INT PRIMARY KEY,
    MEDICINE_NAME NVARCHAR(30)
);

CREATE TABLE PRESCRIPTIONS
(
    PRESCRIPTION_ID INT PRIMARY KEY,
    PRESCRIBED_DATE DATE,
    DOSAGE NVARCHAR(30),
    DURATION INT,  -- duration in days
    DOCTOR_ID INT REFERENCES DOCTORS(DOCTOR_ID),
    PATIENT_ID INT REFERENCES PATIENTS(PATIENT_ID),
    MEDICINE_ID INT REFERENCES MEDICATIONS(MEDICINE_ID),
    CONSTRAINT UQ_PRESCRIPTION UNIQUE (DOCTOR_ID, PATIENT_ID, MEDICINE_ID)
);


/*
SESSIONS 20:

University Course Grade History System (Many-to-Many + Change Tracking)

Business Case:

A university wants to keep track of students, courses, and grades over time — not just the latest grade.

Sometimes grades are updated (e.g., re-evaluation, makeup exams), and the system must record every grade 
change, not overwrite it.
*/

CREATE TABLE STUDENTS
(
    STU_ID INT PRIMARY KEY,
    STU_NAME NVARCHAR(30),
    ENROLLMENT_YEAR DATE
);

CREATE TABLE COURSES
(
    COURSE_ID INT PRIMARY KEY,
    COURSE_NAME NVARCHAR(50),
    CREDITS INT CHECK (CREDITS > 0)
);

CREATE TABLE ENROLLMENTS
(
    ENROLLMENT_ID INT PRIMARY KEY,
    STU_ID INT REFERENCES STUDENTS(STU_ID),
    COURSE_ID INT REFERENCES COURSES(COURSE_ID),
    CONSTRAINT UQ_ENROLL UNIQUE (STU_ID, COURSE_ID)
);

CREATE TABLE GRADE_HISTORY
(
    GRADE_ID INT PRIMARY KEY,
    ENROLLMENT_ID INT REFERENCES ENROLLMENTS(ENROLLMENT_ID),
    GRADE NVARCHAR(2) CHECK (GRADE IN ('A','B','C','D','E','F','I')),
    DATE_UPDATED DATETIME2,
    UPDATED_BY NVARCHAR(20)
        CHECK (UPDATED_BY IN ('ADMIN', 'FACULTY_REEVAL'))
);


/*
SESSIONS 21:

Retail Store Inventory & Sales Tracking System

Business Case:

A retail store sells various products to customers.
The system must:

Track suppliers, products, customers, and sales transactions.

Update inventory quantities after each sale.

Maintain a record of what each customer bought, at what price, and when.
*/

CREATE TABLE SUPPLIERS
(
    SUPPLIER_ID INT PRIMARY KEY,
    SUPPLIER_NAME NVARCHAR(30) UNIQUE
);

CREATE TABLE PRODUCTS
(
    PRODUCT_ID INT PRIMARY KEY,
    PRODUCT_NAME NVARCHAR(30),
    QUANTITY INT CHECK (QUANTITY >= 0),
    PRICE DECIMAL(10,2) CHECK (PRICE > 0),
    REORDER_LEVEL INT CHECK (REORDER_LEVEL >= 0),
    SUPPLIER_ID INT REFERENCES SUPPLIERS(SUPPLIER_ID)
);

CREATE TABLE CUSTOMERS
(
    CUSTOMER_ID INT PRIMARY KEY,
    CUSTOMER_NAME NVARCHAR(30),
    PHONE BIGINT,
    EMAIL NVARCHAR(30)
);

CREATE TABLE SALES
(
    SALE_ID INT PRIMARY KEY,
    SALE_DATE DATETIME2,
    CUSTOMER_ID INT REFERENCES CUSTOMERS(CUSTOMER_ID)
);

CREATE TABLE SALE_DETAILS
(
    SALE_DETAIL_ID INT PRIMARY KEY,
    SALE_ID INT REFERENCES SALES(SALE_ID),
    PRODUCT_ID INT REFERENCES PRODUCTS(PRODUCT_ID),
    UNIT_SOLD INT CHECK (UNIT_SOLD > 0),
    SALE_PRICE DECIMAL(10,2) CHECK (SALE_PRICE > 0),
    CONSTRAINT UQ_SALE_PRODUCT UNIQUE (SALE_ID, PRODUCT_ID)
);
