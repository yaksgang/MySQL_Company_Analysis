-- Common Table Expressions (CTE's)

With CTE_example (Gender, AVG_sal, Max_sal, Min_sal, Count_sal) as
(
Select 
		gender,
        avg(salary) as avg_sal,
        max(salary) max_sal,
        min(salary) min_sal,
        count(salary) as count_sal
from employee_demographics dem
join employee_salary sal
on dem.employee_id = sal.employee_id
group by gender
)

Select *
from CTE_example;

-- Two CTE's
With cte_example as
(
Select employee_id, gender,birth_date
from employee_demographics
where birth_date > '1985-01-01'
), cte_example1 as
(
Select employee_id, salary
from employee_salary
where salary > 50000
)

Select *
from cte_example
join cte_example1
on cte_example.employee_id = cte_example1.employee_id;