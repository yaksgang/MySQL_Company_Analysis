-- String Functions
-- 1) Length

Select first_name, Length(first_name) 
from employee_demographics
order by 2;

-- 2) Upper and Lower
Select last_name, upper(last_name)
from employee_demographics;

Select last_name, lower(last_name)
from employee_demographics;

-- 3) Trim (ltrim and rtrim)
Select  rtrim('                          Yakubu                          ');

-- 4) Substring
Select first_name, 
left(first_name,4),
right(first_name,4),
substring(first_name,1,3) as email_name,
substring(birth_date,6,2) as birth_month
from employee_demographics;

-- 5) Replace and Locate
Select first_name,
		replace(first_name, 'A', 'Z')
        from employee_demographics;

Select first_name,
		locate('A', first_name)
        from employee_demographics;
        
-- 6) Concat combine two coloumns into one
Select last_name,
		concat(last_name, ' ', first_name) as full_name,
        concat(last_name, lower(substring(first_name,1,2)), employee_id, '@ndic.gov.ng') as emp_email
        from employee_demographics