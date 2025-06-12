-- Triggers 


select *
from employee_demographics;

select *
from employee_salary;

Delimiter $$
create trigger employee_insert
	after insert on employee_salary
    for each row 
begin
	insert into employee_demographics (employee_id, first_name,last_name)
    values (new.employee_id, new.first_name, new.last_name);

end $$
Delimiter ;

Insert into employee_salary (employee_id, first_name, last_name, occupation,
salary, dept_id)
values (13, 'Yakubu', 'Gang', 'Business Analyst', 250000, 2);


-- Events
Delimiter $$
create event ndic_retire_delete
on schedule every 30 second
do
begin
	delete
    from employee_demographics
    where age >= 60;

end $$
Delimiter ;

show variables like 'event%';

update employee_demographics
set age = 39, gender = 'Male', birth_date = '1986-03-10'
where employee_id = 13;