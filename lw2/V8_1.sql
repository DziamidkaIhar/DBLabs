use AdventureWorks2012;
go

-----1 Task
--??????? ?? ????? ?????? ??????????? ??????? ???????? ?????? ??? ???????????????.

select 
	  [JobCandidate].[BusinessEntityID] as [BusinessEntityID]
	, [Employee].[OrganizationLevel]
	, [Employee].[JobTitle]
	, [JobCandidateID]
	, [Resume]
from 
	[HumanResources].[JobCandidate]
inner join 
	[HumanResources].[Employee]
on 
	[HumanResources].[Employee].[BusinessEntityID] = [HumanResources].[JobCandidate].[BusinessEntityID]
where
	[JobCandidate].[BusinessEntityID] is not null;

-----2 Task
-----??????? ?? ????? ???????? ???????, ? ??????? ???????? ????? 10-?? ???????????

with depCount as
(
	select 
		  [EmployeeDepartmentHistory].[DepartmentID]
		, count(BusinessEntityID) as EmpCount
		from [HumanResources].[EmployeeDepartmentHistory]
	group by [EmployeeDepartmentHistory].[DepartmentID]
	having count(BusinessEntityID) > 10
)

select 
	  [depCount].[DepartmentID]
	, [Department].[Name]
	, [EmpCount]
from
	depCount
inner join [HumanResources].[Department]
on [Department].[DepartmentID] = [depCount].[DepartmentID];

-----3 Task
--??????? ?? ????? ????????????? ????? ????? ??????? ?? ??????? ??????? (SickLeaveHours) ? ?????? ??????? ??????.
--????? ?????? ????????????? ?? ???? ??????????????? ??????????? (HireDate).

with sickEmp as
(
	select 
		  [Department].[Name]	
		, [Employee].[HireDate]
		, [Employee].[SickLeaveHours]
	from [HumanResources].[Employee]
	inner join [HumanResources].[EmployeeDepartmentHistory]
	on [EmployeeDepartmentHistory].[BusinessEntityID] = [Employee].[BusinessEntityID]
	inner join [HumanResources].[Department]
	on [EmployeeDepartmentHistory].[DepartmentID] = [Department].[DepartmentID]
)

select 
	  [Name]
	, [HireDate]
	, [SickLeaveHours]
	, sum(SickLeaveHours)
	over(
		partition by [Name]
		order by [HireDate]
	) as AccumulativeSum
from sickEmp