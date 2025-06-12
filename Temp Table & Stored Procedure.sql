-- Temporary Tables

create temporary table temp_table
(
		first_name varchar(50),
		last_name varchar(50),
        favorite_movie varchar(100)
);

Select *
from temp_table;

insert into temp_table
values ('Yakubu', 'Gang', 'Braveheart');

Select *
from temp_table;


Select *
from employee_salary;

create temporary table  salary_over_50k
select *
from employee_salary
where salary >= 50000;

Select *
from salary_over_50k;

-- Stored Procedure

create procedure large_salary()
select *
from employee_salary
where salary > 50000;

call large_salary();

-- Delimiter 
Delimiter $$
create procedure large_salary3()
begin
	select *
	from employee_salary
	where salary >= 50000;
	select *
	from employee_salary
	where salary >= 10000;
end $$
Delimiter ;

call large_salary3();

-- Parameter as varaibles that are passed as an imput into a stored procedure
-- Allow stored value to accept an input value and put it into your code.

Delimiter $$
create procedure large_salary4(p_employee_id int)
begin
	select salary
	from employee_salary
    where employee_id = p_employee_id;
end $$
Delimiter ;

call large_salary4(1)
