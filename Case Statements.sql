-- Case Statements

Select first_name,
		last_name,
        age,
case
	when age <= 30 then 'Young'
    when age between 31 and 45 then 'Adult'
    else 'Senior'
end as age_bracket
from employee_demographics;

-- < 50000 then 5%
-- > 50000 then 7%
-- finance dept then 10% bonus
Select first_name,
		last_name,
        salary,
case
        when salary <= 50000 then salary *1.05
        when salary > 50000 then salary *1.07
end as new_salary,
case
	when dept_id = 6 then salary *1.10
end as bounus
from employee_salary
order by salary desc;

-- Subqueries from where clause
Select *
from employee_demographics
where employee_id in (
				select employee_id
                from employee_salary
                where dept_id = 1);

-- Subqueries from select statement
Select first_name, salary, 
			(select avg(salary)
			from employee_salary)
from employee_salary;

-- Subqueries from from statement
Select gender, avg(max_age)
from
(select gender, 
	avg(age) as avg_age, 
    max(age) as max_age, 
    min(age) as min_age, 
    count(age)
from employee_demographics
group by gender) as agg_table
group by gender
