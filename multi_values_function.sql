


create type emp_loc_type as object
(
emp number,
dep number
)

create type emp_loc_table_type as table of emp_loc_type;


create or replace function emp_loc_fnc(i_loc_id in number) 
return emp_loc_table_type 
as 
elt emp_loc_table_type := emp_loc_table_type();
begin 
select emp_loc_type(emp.EMPLOYEE_ID,dep.LOCATION_ID)
bulk collect into elt from 
hr.employees emp join hr.departments dep 
on emp.DEPARTMENT_ID = dep.DEPARTMENT_ID
where 1=1
and dep.location_id = i_loc_id;
return elt;
end;
/

select * from table(emp_loc_fnc(i_loc_id => 1500));

