use master;
go

create database NewDatabase;
go

use NewDatabase;
go

create schema sales;
GO

create schema persons;
GO

create table sales.Orders (OrderNum int null);
go

backup database NewDatabase
to disk = 'D:\University\7Life\DB\1Lab\Ihar_Dziamidka.bak';

restore database NewDatabase
from disk = 'D:\University\7Life\DB\1Lab\Ihar_Dziamidka.bak';