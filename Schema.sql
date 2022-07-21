-- Creating tables for PH-EmployeeDB 
Create Table departments (
	dept_no VARCHAR (4) NOT NULL,
	dept_name VARCHAR(40) NOT NULL,
	PRIMARY KEY (dept_no),
	UNIQUE (dept_name)
);
Create table employees (
  	emp_no INT NOT NULL,
     birth_date DATE NOT NULL,
     first_name VARCHAR NOT NULL,
     last_name VARCHAR NOT NULL,
     gender VARCHAR NOT NULL,
     hire_date DATE NOT NULL,
     PRIMARY KEY (emp_no)
);
CREATE TABLE dept_manager (
dept_no VARCHAR(4) NOT NULL,
	emp_no INT NOT NULL,
	from_date DATE NOT NULL,
FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
	PRIMARY KEY (emp_no, dept_no)
);
CREATE TABLE salaries (
	emp_no INT NOT NULL, 
	salary INT NOT NULL,
	from_date DATE NOT NULL,
	to_date DATE NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
	PRIMARY KEY (emp_no)
);
CREATE TABLE titles (
	emp_no INT NOT NULL,
	titles VARCHAR (40),
	from_date DATE NOT NULL,
	to_date DATE NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
	PRIMARY KEY (emp_no)
);
CREATE TABLE dept_emp (
	dept_no VARCHAR (4) NOT NULL,
	emp_no INT NOT NULL,
	fromt_date DATE NOT NULL,
	to_date DATE NOT NULL, 
	FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
	FOREIGN KEY (emp_no) REFERENCES employees (emp_no)
);
ALTER TABLE departments 
	ALTER COLUMN dept_no TYPE VARCHAR(5),
	ALTER COLUMN dept_no SET NOT NULL
	;
ALTER TABLE dept_emp
	ALTER COLUMN dept_no TYPE VARCHAR(5),
	ALTER COLUMN dept_no SET NOT NULL
	;
ALTER TABLE dept_emp 
	ALTER COLUMN emp_no TYPE VARCHAR(5),
	ALTER COLUMN emp_no SET NOT NULL
	;
SELECT * FROM departments;