-- Combining Where and Having in Group by
SELECT occupation, avg(salary)
from employee_salary
where occupation like '%manager%'
group by occupation
having avg(salary) > 75000;

-- Inner Joins Takes vales similar only on both tables
Select dem.employee_id, occupation,salary
From employee_demographics as dem
inner join employee_salary as sal
on sal.employee_id = dem.employee_id;

-- Outer Joins (Left) Takes values from the 1st table and combines with the 2nd
Select *
From employee_demographics as dem
left outer join employee_salary as sal
on sal.employee_id = dem.employee_id;

-- Outer Joins (Right) Takes values from the 2nd table and combines with the 1st
Select *
From employee_demographics as dem
right outer join employee_salary as sal
on sal.employee_id = dem.employee_id;

-- Self Joins 
Select emp1.employee_id as emp_santa_id,
		emp1.last_name as secret_santa,
		emp2.employee_id as receipient_id,
		emp2.last_name as receipient_name
From employee_salary emp1 
join employee_salary emp2
on emp1.employee_id + 1 = emp2.employee_id;

-- Joining multiple tables
Select sal.employee_id,
		sal.last_name,
        dem.gender,
		sal.occupation,
        sal.salary,
        pad.department_name
from employee_demographics as dem
inner join employee_salary as sal
on dem.employee_id = sal.employee_id
inner join parks_departments as pad
on sal.dept_id = pad.department_id;
