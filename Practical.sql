create table Customer(
	CustomerId int primary key identity(1,1),
	Name Nvarchar(50),
	City Nvarchar(50),
	Country Nvarchar(50),
	Phone Nvarchar(15) unique,
	Email Nvarchar(50) unique
);

create table CustomerAccount(
	AccountNumber char(9) primary key,
	CustomerId int not null foreign key references Customer(CustomerId),
	Balance money not null check (Balance > 0),
	MinAccount money
);

create table CustomerTransaction(
	TransactionId int primary key identity(1,1),
	AccountNumber char(9) foreign key references CustomerAccount(AccountNumber),
	TransactionDate smalldatetime check (TransactionDate <= GETDATE()),
	Amount money check (Amount > 0),
	DepositorWithdraw bit
);

--drop table CustomerTransaction;
--drop table CustomerAccount;
--drop table Customer;

insert into Customer(Name,City,Country,Phone,Email) values
('Linh','Hanoi','VietNam','','linh1@gmail.com'),
('Lien','','VietNam','0773738293','lien@gmail.com'),
('Linh','Hanoi','VietNam','0773738291','linh@gmail.com'),
('Long','Hanoi','','0773738292','')

insert into CustomerAccount(AccountNumber,CustomerId,Balance,MinAccount) values
('123456789',1,1237200,50000),
('123456788',2,12517200,''),
('123456787',3,123200,50000),
('123456786',4,2437200,50000)

insert into CustomerTransaction(AccountNumber,TransactionDate,Amount,DepositorWithdraw) values
('123456789','2019/09/20',150000,''),
('123456789','2019/09/20',50000,1),
('123456788','2019/09/21',150000,''),
('123456788','2019/09/21',150000,0),
('123456786','2019/09/23',150000,0),
('123456787','2019/09/23',150000,1)

select * from Customer;
select * from CustomerAccount;
select * from CustomerTransaction;

select * from Customer where City like 'Hanoi';

select A.Name, A.Phone, A.Email, B.AccountNumber, B.Balance from Customer A
inner join CustomerAccount B on A.CustomerId = B.CustomerId;

alter table CustomerTransaction add check (Amount <= 1000000 AND Amount > 0);

create view vCustomerTransactions as
select A.Name, B.AccountNumber, C.TransactionDate, C.Amount, C.DepositorWithdraw
from Customer A inner join CustomerAccount B on A.CustomerId = B.CustomerId
inner join CustomerTransaction C on B.AccountNumber = C.AccountNumber;

select * from vCustomerTransactions;