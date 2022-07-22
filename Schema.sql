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
SELECT * FROM dept_emp
;
SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1952-01-01' AND '1955-12-31'
;
SELECT first_name, last_name
FROM employees 
WHERE birth_date BETWEEN '1952-01-01' AND '1952-12-31'
;
-- Retirement eligibility
SELECT first_name, last_name
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31')
;
-- Number of employees retiring
SELECT COUNT(first_name)
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31')
;
SELECT first_name, last_name
INTO retirement_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31')
;
SELECT * FROM retirement_info
;
DROP TABLE retirement_info
;
-- Create new table for retiring employees
SELECT emp_no, first_name, last_name
INTO retirement_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');
-- Check the table
SELECT * FROM retirement_info;
SELECT e.emp_no, e.first_name, e.last_name,
ti.title, ti.from_date, ti.to_date
INTO retirement_titles
FROM employees AS e
INNER JOIN titles AS ti
on e.emp_no = ti.emp_no
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY e.emp_no
;
-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (rt.emp_no)rt.emp_no,
rt.first_name,
rt.last_name, rt.title
INTO unique_titles
FROM retirement_titles as rt
WHERE to_date = ('9999-01-01')
ORDER BY rt.emp_no ASC, to_date DESC
;
-- Number of employees about to retire
SELECT COUNT(ut.title), ut.title
INTO retiring_titles
FROM unique_titles AS ut
GROUP BY ut.title
ORDER BY (ut.count) DESC
;
-- Mentorship Eligibility Table
SELECT DISTINCT ON(e.emp_no)e.emp_no, e.first_name, 
e.last_name, e.birth_date, de.from_date, de.to_date,ti.title
INTO mentorship_eligibility
FROM employees AS e
INNER JOIN dept_emp AS de
ON (e.emp_no = de.emp_no)
INNER JOIN titles AS ti
ON (e.emp_no = ti.emp_no)
WHERE (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
AND de.to_date = ('9999-01-01')
ORDER BY emp_no
;