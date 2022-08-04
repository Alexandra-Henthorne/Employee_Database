--Queries


--Retirement Eligibility
SELECT emp_no, first_name, last_name
INTO retirement_info
FROM employees
WHERE (birth_date BETWEEN '1925-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND  '1988-12-31');

-- Number of employees retiring
Select Count (first_name)
From employees
Where (birth_date Between '1925-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

--Joining Departments
Select d.dept_name,
	dm.emp_no,
	dm.from_date,
	dm.to_date
	FROM departments as d
INNER JOIN dept_manager as dm
ON d.dept_no = dm.dept_no
WHERE dm.to_date = ('9999-01-01');

--Selecting current employees
SELECT ri.emp_no,
ri.first_name,
ri.last_name,
de.to_date
INTO current_emp
FROM retirement_info as ri
LEFT JOIN dept_emp as de
ON ri.emp_no = de.emp_no
WHERE de.to_date = ('9999-01-01');

-- Employee count by department number
SELECT COUNT(ce.emp_no), de.dept_no
FROM current_emp as ce
LEFT JOIN dept_emp as de
ON ce.emp_no = de.emp_no
GROUP BY de.dept_no
ORDER BY de.dept_no;

-- Employee list Gender and Salary
SELECT e.emp_no,
e.first_name,
e.last_name
INTO emp_info
FROM employees as e
INNER JOIN salaries as s 
ON (e.emp_no = s.emp_no)
INNER JOIN dept_emp as de
ON (e.emp_no = de.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (e.hire_date BETWEEN '1985-01-01' AND '1988-12-31')
AND ( de.to_date = '9999-01-01');

--List of managers
SELECT dm.dept_no,
d.dept_name,
dm.emp_no,
ce.last_name,
ce.first_name,
dm.from_date,
dm.to_date
INTO manager_info
FROM dept_manager as dm
INNER JOIN departments as d
ON (dm.dept_no =d.dept_no)
INNER JOIN current_emp as ce
ON (dm.emp_no =ce.emp_no);

--List of employees with dept
SELECT ce.emp_no,
ce.first_name,
ce.last_name,
d.dept_name
INTO dept_info
FROM current_emp as ce
INNER JOIN dept_emp AS de
ON (ce.emp_no = de.emp_no)
INNER JOIN departments AS d
ON (de.dept_no = d.dept_no);

--list of  sales employees
SELECT ce.emp_no,
ce.first_name,
ce.last_name,
d.dept_name
INTO sales_info
FROM current_emp as ce
INNER JOIN dept_emp as de
on (ce.emp_no = de.emp_no)
INNER JOIN departments as d
ON (de.dept_no = d.dept_no)
WHERE d.dept_name = 'Sales';

--List of sales and development 
SELECT ce.emp_no,
ce.first_name,
ce.last_name,
d.dept_name
INTO sales_dev
FROM current_emp as ce
INNER JOIN dept_emp AS de
ON (ce.emp_no = de.emp_no)
INNER JOIN departments AS d
ON(de.dept_no = d.dept_no)
WHERE d.dept_name IN ('Sales', 'Development')
ORDER BY ce.emp_no;

SELECT * FROM sales_dev;