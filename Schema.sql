-- Creating tables for PH-EmployeeDB 
Create Table departments (
	dept_no VARCHAR (4) NOT NULL,
	dept_name VARCHAR(40) NOT NULL,
	PRIMARY KEY (dept_no),
	UNIQUE (dept_name),
);
DROP TABLE employees CASCADE;
Create table employees (
  	emp_no VARCHAR (6) NOT NULL,
    birth_date DATE NOT NULL,
     first_name VARCHAR NOT NULL,
     last_name VARCHAR NOT NULL,
     gender VARCHAR NOT NULL,
     hire_date DATE NOT NULL,
     PRIMARY KEY (emp_no)
);
DROP TABLE dept_manager CASCADE
;
CREATE TABLE dept_manager (
	dept_no VARCHAR(5) NOT NULL,
	emp_no VARCHAR (6) NOT NULL,
	from_date DATE NOT NULL,
	to_date DATE NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
	FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
	PRIMARY KEY (emp_no, dept_no)
);
DROP TABLE salaries CASCADE;
CREATE TABLE salaries (
	emp_no VARCHAR (6) NOT NULL, 
	salary INT NOT NULL,
	from_date DATE NOT NULL,
	to_date DATE NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
	PRIMARY KEY (emp_no)
);
DROP TABLE titles CASCADE
;
CREATE TABLE titles (
emp_no VARCHAR (6) NOT NULL,
title VARCHAR NOT NULL,
from_date DATE NOT NULL,
to_date DATE NOT NULL,
FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
PRIMARY KEY (emp_no, title, from_date)
);
DROP TABLE dept_emp CASCADE;
CREATE TABLE dept_emp (
emp_no VARCHAR (6) NOT NULL,
dept_no VARCHAR(4) NOT NULL,
from_date DATE NOT NULL,
to_date DATE NOT NULL,
FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
PRIMARY KEY (emp_no, dept_no)
);
ALTER TABLE departments 
	ALTER COLUMN dept_no TYPE VARCHAR(5),
	ALTER COLUMN dept_no SET NOT NULL
	;
ALTER TABLE dept_emp
	ALTER COLUMN dept_no TYPE VARCHAR(5),
	ALTER COLUMN dept_no SET NOT NULL
;
SELECT * FROM departments;
SELECT * FROM employees;
SELECT * FROM titles;
SELECT * FROM salaries;
SELECT * FROM dept_manager;
SELECT * FROM dept_emp;