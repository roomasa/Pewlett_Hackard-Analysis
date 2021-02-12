--create retirement table for employees who are born between January 1, 1952 and December 31, 1955
SELECT e.emp_no,e.first_name, e.last_name, title.title, title.from_date, title.to_date
INTO retirement_titles
FROM employees as e
INNER JOIN title 
ON e.emp_no=title.emp_no
WHERE birth_date BETWEEN '1952-01-01' AND '1955-12-31'
ORDER BY e.emp_no;

-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (r.emp_no) r.emp_no,
r.first_name, 
r.last_name, 
r.title
INTO unique_titles
FROM retirement_titles as r 
ORDER BY r.emp_no, to_date DESC;

-- Number of titles filled by employees who are retiring
SELECT COUNT(u.emp_no), u.title
INTO retiring_titles
FROM unique_titles as u
GROUP BY u.title 
ORDER BY count DESC;


--Mentorship Eligibility--
SELECT DISTINCT ON (e.emp_no) e.emp_no,e.first_name, e.last_name, e.birth_date, de.from_date, de.to_date, ti.title
INTO mentorship_eligibilty
FROM employees as e
INNER JOIN dept_emp as de
ON e.emp_no=de.emp_no
INNER JOIN title as ti
ON e.emp_no=ti.emp_no
WHERE (de.to_date = '9999-01-01') AND (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
ORDER BY e.emp_no

--extras--
SELECT * from mentorship_eligibilty
SELECT * from retiring_titles
DROP TABLE mentorship_eligibilty cascade
SELECT * from mentorship_eligibilty
