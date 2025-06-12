-- Unions Allows you to combine the rows of data from seperate tables
-- Union removes all the duplicates while union all includes all the duplicates
Select first_name, last_name
from employee_demographics
Union all
select first_name, last_name
from employee_salary;

-- Labels and Unions
Select first_name, 
		last_name,
        'Oldest Male' as Label
from employee_demographics
where age >= 40 and gender = 'male'
union
Select first_name, 
		last_name,
        'Oldest Female' as Label
from employee_demographics
where age >= 40 and gender = 'female'
union
Select first_name, 
		last_name,
        'Highly Paid' as label
from employee_salary
where salary > 70000
order by last_name