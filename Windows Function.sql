-- Window Functions
select 
	occupation, 
	gender, 
	avg(salary) over (partition by gender)
from employee_demographics dem
join employee_salary sal
	on dem.employee_id = sal.employee_id;
    
select 
	dem.last_name, 
	gender, 
	sum(salary) over (partition by gender)
from employee_demographics dem
join employee_salary sal
	on dem.employee_id = sal.employee_id;
    
-- Rolling Total: This is where total is added from top to bottom based on each partition
select 
	dem.employee_id, 
	gender, 
    salary,
	sum(salary) over (partition by gender order by dem.employee_id) as rolling_total
from employee_demographics dem
join employee_salary sal
	on dem.employee_id = sal.employee_id;

-- Row Number, Rank and Dense Rank
select 
	dem.last_name, 
	gender, 
    salary,
	row_number() over (partition by gender order by salary desc) as row_num,
    rank() over (partition by gender order by salary desc) as rank_num,
    dense_rank() over (partition by gender order by salary desc) as dense_rank_num
from employee_demographics dem
join employee_salary sal
	on dem.employee_id = sal.employee_id
