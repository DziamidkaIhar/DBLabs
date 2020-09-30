use AdventureWorks2012
go

--------1 Task
--Вывести на экран холостых сотрудников, которые родились раньше 1960 года (включая 1960 год).
select
	BusinessEntityID,
	BirthDate,
	MaritalStatus,
	Gender,
	HireDate
from 
	HumanResources.Employee
where 
	BirthDate < '1961-01-01';


--------2 Task
--Вывести на экран сотрудников, работающих на позиции ‘Design Engineer’,
--отсортированных в порядке убывания принятия их на работу.
select 
	BusinessEntityID,
	JobTitle,
	BirthDate, 
	Gender, 
	HireDate
from
	HumanResources.Employee
where 
	JobTitle = 'Design Engineer'
order by HireDate desc;

--------3 Task
--Вывести на экран количество лет, отработанных каждым сотрудником отделе ‘Engineering’ ([DepartmentID] = 1).
--Если поле EndDate = NULL это значит, что сотрудник работает в отделе по настоящее время.
select 
	Employee.BusinessEntityID,
	EmployeeDepartmentHistory.DepartmentID,
	EmployeeDepartmentHistory.StartDate,
	EmployeeDepartmentHistory.EndDate,
	datediff(year, StartDate, (select isnull(EndDate, getdate()))) as YearsWorked
from
	HumanResources.Employee
inner join
	HumanResources.EmployeeDepartmentHistory
on
	HumanResources.Employee.BusinessEntityID = HumanResources.EmployeeDepartmentHistory.BusinessEntityID
where
	DepartmentID = 1

