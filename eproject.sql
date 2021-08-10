create table Nhom6_Product(
	IdProd int primary key identity(1,1),
	Images text not null,
	Thumb1 text not null,
	Thumb2 text not null,
	Thumb3 text not null,
	Thumb4 text not null,
	NameProd varchar(255) not null,
	Price decimal(12,4) not null
);

create table Nhom6_Customer(
	IdCustomer int primary key identity(1,1),
	NameCustomer varchar(255),
	Phone char(20) not null check (Phone like '0%'),
	Addr text
);

create table Nhom6_OrderForm(
	IdOrder int primary key identity(1,1),
	TongTien decimal not null,
	DateOfPurchase datetime not null,
	IdCustomer int not null foreign key references Nhom6_Customer(IdCustomer)
);

create table Nhom6_Order_Product(
	SoLuong int not null,
	ThanhTien decimal(12,4) not null,
	IdOrder int foreign key references Nhom6_OrderForm(IdOrder),
	IdProd int foreign key references Nhom6_Product(IdProd)
);

drop table Nhom6_Order_Product;
drop table Nhom6_OrderForm;
drop table Nhom6_Customer;
drop table Nhom6_Product;

insert into Nhom6_Product(Images,Thumb1,Thumb2,Thumb3,Thumb4,NameProd,Price) values
('imgs/shirt01.jpg','imgs/thumb_imgs/shirt01_01.jpg','imgs/thumb_imgs/shirt01_02.jpg','imgs/thumb_imgs/shirt01_03.jpg','imgs/thumb_imgs/shirt01_04.jpg','Shirt Uniform 01',20),
('imgs/shirt02.jpg','imgs/thumb_imgs/shirt02_01.jpg','imgs/thumb_imgs/shirt02_02.jpg','imgs/thumb_imgs/shirt02_03.jpg','imgs/thumb_imgs/shirt02_04.jpg','Shirt Uniform 02',21),
('imgs/shirt03.jpg','imgs/thumb_imgs/shirt03_01.jpg','imgs/thumb_imgs/shirt03_02.jpg','imgs/thumb_imgs/shirt03_03.jpg','imgs/thumb_imgs/shirt03_04.jpg','Shirt Uniform 03',22),
('imgs/shirt04.jpg','imgs/thumb_imgs/shirt04_01.jpg','imgs/thumb_imgs/shirt04_02.jpg','imgs/thumb_imgs/shirt04_03.jpg','imgs/thumb_imgs/shirt04_04.jpg','Shirt Uniform 04',23),
('imgs/shirt05.jpg','imgs/thumb_imgs/shirt05_01.jpg','imgs/thumb_imgs/shirt05_02.jpg','imgs/thumb_imgs/shirt05_03.jpg','imgs/thumb_imgs/shirt05_04.jpg','Shirt Uniform 05',24),
('imgs/shirt06.jpg','imgs/thumb_imgs/shirt06_01.jpg','imgs/thumb_imgs/shirt06_02.jpg','imgs/thumb_imgs/shirt06_03.jpg','imgs/thumb_imgs/shirt06_04.jpg','Shirt Uniform 06',25),
('imgs/shirt07.jpg','imgs/thumb_imgs/shirt07_01.jpg','imgs/thumb_imgs/shirt07_02.jpg','imgs/thumb_imgs/shirt07_03.jpg','imgs/thumb_imgs/shirt07_04.jpg','Shirt Uniform 07',26),
('imgs/shirt08.jpg','imgs/thumb_imgs/shirt08_01.jpg','imgs/thumb_imgs/shirt08_02.jpg','imgs/thumb_imgs/shirt08_03.jpg','imgs/thumb_imgs/shirt08_04.jpg','Shirt Uniform 08',27),
('imgs/shirt09.jpg','imgs/thumb_imgs/shirt09_01.jpg','imgs/thumb_imgs/shirt09_02.jpg','imgs/thumb_imgs/shirt09_03.jpg','imgs/thumb_imgs/shirt09_04.jpg','Shirt Uniform 09',28),
('imgs/shirt10.jpg','imgs/thumb_imgs/shirt10_01.jpg','imgs/thumb_imgs/shirt10_02.jpg','imgs/thumb_imgs/shirt10_03.jpg','imgs/thumb_imgs/shirt10_04.jpg','Shirt Uniform 10',29),
('imgs/shirt11.jpg','imgs/thumb_imgs/shirt11_01.jpg','imgs/thumb_imgs/shirt11_02.jpg','imgs/thumb_imgs/shirt11_03.jpg','imgs/thumb_imgs/shirt11_04.jpg','Shirt Uniform 11',30),
('imgs/shirt12.jpg','imgs/thumb_imgs/shirt12_01.jpg','imgs/thumb_imgs/shirt12_02.jpg','imgs/thumb_imgs/shirt12_03.jpg','imgs/thumb_imgs/shirt12_04.jpg','Shirt Uniform 12',31),
('imgs/shirt13.jpg','imgs/thumb_imgs/shirt13_01.jpg','imgs/thumb_imgs/shirt13_02.jpg','imgs/thumb_imgs/shirt13_03.jpg','imgs/thumb_imgs/shirt13_04.jpg','Shirt Uniform 13',32),
('imgs/shirt14.jpg','imgs/thumb_imgs/shirt14_01.jpg','imgs/thumb_imgs/shirt14_02.jpg','imgs/thumb_imgs/shirt14_03.jpg','imgs/thumb_imgs/shirt14_04.jpg','Shirt Uniform 14',33),
('imgs/shirt15.jpg','imgs/thumb_imgs/shirt15_01.jpg','imgs/thumb_imgs/shirt15_02.jpg','imgs/thumb_imgs/shirt15_03.jpg','imgs/thumb_imgs/shirt15_04.jpg','Shirt Uniform 15',34),
('imgs/shirt01.jpg','imgs/thumb_imgs/shirt01_01.jpg','imgs/thumb_imgs/shirt01_02.jpg','imgs/thumb_imgs/shirt01_03.jpg','imgs/thumb_imgs/shirt01_04.jpg','Shirt Uniform 16',30),
('imgs/shirt02.jpg','imgs/thumb_imgs/shirt02_01.jpg','imgs/thumb_imgs/shirt02_02.jpg','imgs/thumb_imgs/shirt02_03.jpg','imgs/thumb_imgs/shirt02_04.jpg','Shirt Uniform 17',31),
('imgs/shirt03.jpg','imgs/thumb_imgs/shirt03_01.jpg','imgs/thumb_imgs/shirt03_02.jpg','imgs/thumb_imgs/shirt03_03.jpg','imgs/thumb_imgs/shirt03_04.jpg','Shirt Uniform 18',32),
('imgs/shirt04.jpg','imgs/thumb_imgs/shirt04_01.jpg','imgs/thumb_imgs/shirt04_02.jpg','imgs/thumb_imgs/shirt04_03.jpg','imgs/thumb_imgs/shirt04_04.jpg','Shirt Uniform 19',33),
('imgs/shirt05.jpg','imgs/thumb_imgs/shirt05_01.jpg','imgs/thumb_imgs/shirt05_02.jpg','imgs/thumb_imgs/shirt05_03.jpg','imgs/thumb_imgs/shirt05_04.jpg','Shirt Uniform 20',34),

('imgs/skirt01.jpg','imgs/thumb_imgs/skirt01_01.jpg','imgs/thumb_imgs/skirt01_02.jpg','imgs/thumb_imgs/skirt01_03.jpg','imgs/thumb_imgs/skirt01_04.jpg','Skirt Uniform 01',21),
('imgs/skirt02.jpg','imgs/thumb_imgs/shirt02_01.jpg','imgs/thumb_imgs/shirt02_02.jpg','imgs/thumb_imgs/shirt02_03.jpg','imgs/thumb_imgs/shirt02_04.jpg','Skirt Uniform 02',22),
('imgs/skirt03.jpg','imgs/thumb_imgs/shirt03_01.jpg','imgs/thumb_imgs/shirt03_02.jpg','imgs/thumb_imgs/shirt03_03.jpg','imgs/thumb_imgs/shirt03_04.jpg','Skirt Uniform 03',23),
('imgs/skirt04.jpg','imgs/thumb_imgs/shirt04_01.jpg','imgs/thumb_imgs/shirt04_02.jpg','imgs/thumb_imgs/shirt04_03.jpg','imgs/thumb_imgs/shirt04_04.jpg','Skirt Uniform 04',24),
('imgs/skirt05.jpg','imgs/thumb_imgs/shirt05_01.jpg','imgs/thumb_imgs/shirt05_02.jpg','imgs/thumb_imgs/shirt05_03.jpg','imgs/thumb_imgs/shirt05_04.jpg','Skirt Uniform 05',25),
('imgs/skirt06.jpg','imgs/thumb_imgs/shirt06_01.jpg','imgs/thumb_imgs/shirt06_02.jpg','imgs/thumb_imgs/shirt06_03.jpg','imgs/thumb_imgs/shirt06_04.jpg','Skirt Uniform 06',26),
('imgs/skirt07.jpg','imgs/thumb_imgs/shirt07_01.jpg','imgs/thumb_imgs/shirt07_02.jpg','imgs/thumb_imgs/shirt07_03.jpg','imgs/thumb_imgs/shirt07_04.jpg','Skirt Uniform 07',27),
('imgs/skirt08.jpg','imgs/thumb_imgs/shirt08_01.jpg','imgs/thumb_imgs/shirt08_02.jpg','imgs/thumb_imgs/shirt08_03.jpg','imgs/thumb_imgs/shirt08_04.jpg','Skirt Uniform 08',28),
('imgs/skirt09.jpg','imgs/thumb_imgs/shirt09_01.jpg','imgs/thumb_imgs/shirt09_02.jpg','imgs/thumb_imgs/shirt09_03.jpg','imgs/thumb_imgs/shirt09_04.jpg','Skirt Uniform 09',29),
('imgs/skirt10.jpg','imgs/thumb_imgs/shirt10_01.jpg','imgs/thumb_imgs/shirt10_02.jpg','imgs/thumb_imgs/shirt10_03.jpg','imgs/thumb_imgs/shirt10_04.jpg','Skirt Uniform 10',30),
('imgs/skirt11.jpg','imgs/thumb_imgs/shirt11_01.jpg','imgs/thumb_imgs/shirt11_02.jpg','imgs/thumb_imgs/shirt11_03.jpg','imgs/thumb_imgs/shirt11_04.jpg','Skirt Uniform 11',31),
('imgs/skirt12.jpg','imgs/thumb_imgs/shirt12_01.jpg','imgs/thumb_imgs/shirt12_02.jpg','imgs/thumb_imgs/shirt12_03.jpg','imgs/thumb_imgs/shirt12_04.jpg','Skirt Uniform 12',32),
('imgs/skirt13.jpg','imgs/thumb_imgs/shirt13_01.jpg','imgs/thumb_imgs/shirt13_02.jpg','imgs/thumb_imgs/shirt13_03.jpg','imgs/thumb_imgs/shirt13_04.jpg','Skirt Uniform 13',33),
('imgs/skirt14.jpg','imgs/thumb_imgs/shirt14_01.jpg','imgs/thumb_imgs/shirt14_02.jpg','imgs/thumb_imgs/shirt14_03.jpg','imgs/thumb_imgs/shirt14_04.jpg','Skirt Uniform 14',34),
('imgs/skirt15.jpg','imgs/thumb_imgs/shirt15_01.jpg','imgs/thumb_imgs/shirt15_02.jpg','imgs/thumb_imgs/shirt15_03.jpg','imgs/thumb_imgs/shirt15_04.jpg','Skirt Uniform 15',35),
('imgs/skirt16.jpg','imgs/thumb_imgs/shirt16_01.jpg','imgs/thumb_imgs/shirt16_02.jpg','imgs/thumb_imgs/shirt16_03.jpg','imgs/thumb_imgs/shirt16_04.jpg','Skirt Uniform 16',31),
('imgs/skirt17.jpg','imgs/thumb_imgs/shirt17_01.jpg','imgs/thumb_imgs/shirt17_02.jpg','imgs/thumb_imgs/shirt17_03.jpg','imgs/thumb_imgs/shirt17_04.jpg','Skirt Uniform 17',32),
('imgs/skirt18.jpg','imgs/thumb_imgs/shirt18_01.jpg','imgs/thumb_imgs/shirt18_02.jpg','imgs/thumb_imgs/shirt18_03.jpg','imgs/thumb_imgs/shirt18_04.jpg','Skirt Uniform 18',33),
('imgs/skirt19.jpg','imgs/thumb_imgs/shirt19_01.jpg','imgs/thumb_imgs/shirt19_02.jpg','imgs/thumb_imgs/shirt19_03.jpg','imgs/thumb_imgs/shirt19_04.jpg','Skirt Uniform 19',34),
('imgs/skirt20.jpg','imgs/thumb_imgs/shirt20_01.jpg','imgs/thumb_imgs/shirt20_02.jpg','imgs/thumb_imgs/shirt20_03.jpg','imgs/thumb_imgs/shirt20_04.jpg','Skirt Uniform 20',35),

('imgs/frock01.jpg','imgs/thumb_imgs/frock01_01.jpg','imgs/thumb_imgs/frock01_02.jpg','imgs/thumb_imgs/frock01_03.jpg','imgs/thumb_imgs/frock01_04.jpg','Frock Uniform 01',21),
('imgs/frock02.jpg','imgs/thumb_imgs/frock02_01.jpg','imgs/thumb_imgs/frock02_02.jpg','imgs/thumb_imgs/frock02_03.jpg','imgs/thumb_imgs/frock02_04.jpg','Frock Uniform 02',22),
('imgs/frock03.jpg','imgs/thumb_imgs/frock03_01.jpg','imgs/thumb_imgs/frock03_02.jpg','imgs/thumb_imgs/frock03_03.jpg','imgs/thumb_imgs/frock03_04.jpg','Frock Uniform 03',23),
('imgs/frock04.jpg','imgs/thumb_imgs/frock04_01.jpg','imgs/thumb_imgs/frock04_02.jpg','imgs/thumb_imgs/frock04_03.jpg','imgs/thumb_imgs/frock04_04.jpg','Frock Uniform 04',24),
('imgs/frock05.jpg','imgs/thumb_imgs/frock05_01.jpg','imgs/thumb_imgs/frock05_02.jpg','imgs/thumb_imgs/frock05_03.jpg','imgs/thumb_imgs/frock05_04.jpg','Frock Uniform 05',25),
('imgs/frock06.jpg','imgs/thumb_imgs/frock06_01.jpg','imgs/thumb_imgs/frock06_02.jpg','imgs/thumb_imgs/frock06_03.jpg','imgs/thumb_imgs/frock06_04.jpg','Frock Uniform 06',26),
('imgs/frock07.jpg','imgs/thumb_imgs/frock07_01.jpg','imgs/thumb_imgs/frock07_02.jpg','imgs/thumb_imgs/frock07_03.jpg','imgs/thumb_imgs/frock07_04.jpg','Frock Uniform 07',27),
('imgs/frock08.jpg','imgs/thumb_imgs/frock08_01.jpg','imgs/thumb_imgs/frock08_02.jpg','imgs/thumb_imgs/frock08_03.jpg','imgs/thumb_imgs/frock08_04.jpg','Frock Uniform 08',28),
('imgs/frock09.jpg','imgs/thumb_imgs/frock09_01.jpg','imgs/thumb_imgs/frock09_02.jpg','imgs/thumb_imgs/frock09_03.jpg','imgs/thumb_imgs/frock09_04.jpg','Frock Uniform 09',29),
('imgs/frock10.jpg','imgs/thumb_imgs/frock10_01.jpg','imgs/thumb_imgs/frock10_02.jpg','imgs/thumb_imgs/frock10_03.jpg','imgs/thumb_imgs/frock10_04.jpg','Frock Uniform 10',30),
('imgs/frock11.jpg','imgs/thumb_imgs/frock11_01.jpg','imgs/thumb_imgs/frock11_02.jpg','imgs/thumb_imgs/frock11_03.jpg','imgs/thumb_imgs/frock11_04.jpg','Frock Uniform 11',31),
('imgs/frock12.jpg','imgs/thumb_imgs/frock12_01.jpg','imgs/thumb_imgs/frock12_02.jpg','imgs/thumb_imgs/frock12_03.jpg','imgs/thumb_imgs/frock12_04.jpg','Frock Uniform 12',32),
('imgs/frock13.jpg','imgs/thumb_imgs/frock13_01.jpg','imgs/thumb_imgs/frock13_02.jpg','imgs/thumb_imgs/frock13_03.jpg','imgs/thumb_imgs/frock13_04.jpg','Frock Uniform 13',33),
('imgs/frock14.jpg','imgs/thumb_imgs/frock14_01.jpg','imgs/thumb_imgs/frock14_02.jpg','imgs/thumb_imgs/frock14_03.jpg','imgs/thumb_imgs/frock14_04.jpg','Frock Uniform 14',34),
('imgs/frock15.jpg','imgs/thumb_imgs/frock15_01.jpg','imgs/thumb_imgs/frock15_02.jpg','imgs/thumb_imgs/frock15_03.jpg','imgs/thumb_imgs/frock15_04.jpg','Frock Uniform 15',35),
('imgs/frock16.jpg','imgs/thumb_imgs/frock16_01.jpg','imgs/thumb_imgs/frock16_02.jpg','imgs/thumb_imgs/frock16_03.jpg','imgs/thumb_imgs/frock16_04.jpg','Frock Uniform 16',36),
('imgs/frock17.jpg','imgs/thumb_imgs/frock17_01.jpg','imgs/thumb_imgs/frock17_02.jpg','imgs/thumb_imgs/frock17_03.jpg','imgs/thumb_imgs/frock17_04.jpg','Frock Uniform 17',37),
('imgs/frock18.jpg','imgs/thumb_imgs/frock18_01.jpg','imgs/thumb_imgs/frock18_02.jpg','imgs/thumb_imgs/frock18_03.jpg','imgs/thumb_imgs/frock18_04.jpg','Frock Uniform 18',38),
('imgs/frock19.jpg','imgs/thumb_imgs/frock19_01.jpg','imgs/thumb_imgs/frock19_02.jpg','imgs/thumb_imgs/frock19_03.jpg','imgs/thumb_imgs/frock19_04.jpg','Frock Uniform 19',39),
('imgs/frock20.jpg','imgs/thumb_imgs/frock20_01.jpg','imgs/thumb_imgs/frock20_02.jpg','imgs/thumb_imgs/frock20_03.jpg','imgs/thumb_imgs/frock20_04.jpg','Frock Uniform 20',40),

('imgs/pt-tshirt01.jpg','imgs/thumb_imgs/pt-tshirt01_01.jpg','imgs/thumb_imgs/pt-tshirt01_02.jpg','imgs/thumb_imgs/pt-tshirt01_03.jpg','imgs/thumb_imgs/pt-tshirt01_04.jpg','P.T. T-shirt Uniform 01',21),
('imgs/pt-tshirt02.jpg','imgs/thumb_imgs/pt-tshirt02_01.jpg','imgs/thumb_imgs/pt-tshirt02_02.jpg','imgs/thumb_imgs/pt-tshirt02_03.jpg','imgs/thumb_imgs/pt-tshirt02_04.jpg','P.T. T-shirt Uniform 02',22),
('imgs/pt-tshirt03.jpeg','imgs/thumb_imgs/pt-tshirt03_01.jpg','imgs/thumb_imgs/pt-tshirt03_02.jpg','imgs/thumb_imgs/pt-tshirt03_03.jpg','imgs/thumb_imgs/pt-tshirt03_04.jpg','P.T. T-shirt Uniform 03',23),
('imgs/pt-tshirt04.jpg','imgs/thumb_imgs/pt-tshirt04_01.jpg','imgs/thumb_imgs/pt-tshirt04_02.jpg','imgs/thumb_imgs/pt-tshirt04_03.jpg','imgs/thumb_imgs/pt-tshirt04_04.jpg','P.T. T-shirt Uniform 04',24),
('imgs/pt-tshirt05.jpg','imgs/thumb_imgs/pt-tshirt05_01.jpg','imgs/thumb_imgs/pt-tshirt05_02.jpg','imgs/thumb_imgs/pt-tshirt05_03.jpg','imgs/thumb_imgs/pt-tshirt05_04.jpg','P.T. T-shirt Uniform 05',25),
('imgs/pt-tshirt06.jpg','imgs/thumb_imgs/pt-tshirt06_01.jpg','imgs/thumb_imgs/pt-tshirt06_02.jpg','imgs/thumb_imgs/pt-tshirt06_03.jpg','imgs/thumb_imgs/pt-tshirt06_04.jpg','P.T. T-shirt Uniform 06',26),
('imgs/pt-tshirt07.jpg','imgs/thumb_imgs/pt-tshirt07_01.jpg','imgs/thumb_imgs/pt-tshirt07_02.jpg','imgs/thumb_imgs/pt-tshirt07_03.jpg','imgs/thumb_imgs/pt-tshirt07_04.jpg','P.T. T-shirt Uniform 07',27),
('imgs/pt-tshirt08.jpeg','imgs/thumb_imgs/pt-tshirt08_01.jpg','imgs/thumb_imgs/pt-tshirt08_02.jpg','imgs/thumb_imgs/pt-tshirt08_03.jpg','imgs/thumb_imgs/pt-tshirt08_04.jpg','P.T. T-shirt Uniform 08',28),
('imgs/pt-tshirt09.jpg','imgs/thumb_imgs/pt-tshirt09_01.jpg','imgs/thumb_imgs/pt-tshirt09_02.jpg','imgs/thumb_imgs/pt-tshirt09_03.jpg','imgs/thumb_imgs/pt-tshirt09_04.jpg','P.T. T-shirt Uniform 09',29),
('imgs/pt-tshirt10.jpg','imgs/thumb_imgs/pt-tshirt10_01.jpg','imgs/thumb_imgs/pt-tshirt10_02.jpg','imgs/thumb_imgs/pt-tshirt10_03.jpg','imgs/thumb_imgs/pt-tshirt10_04.jpg','P.T. T-shirt Uniform 10',30),
('imgs/pt-tshirt11.jpg','imgs/thumb_imgs/pt-tshirt11_01.jpg','imgs/thumb_imgs/pt-tshirt11_02.jpg','imgs/thumb_imgs/pt-tshirt11_03.jpg','imgs/thumb_imgs/pt-tshirt11_04.jpg','P.T. T-shirt Uniform 11',31),
('imgs/pt-tshirt12.jpg','imgs/thumb_imgs/pt-tshirt12_01.jpg','imgs/thumb_imgs/pt-tshirt12_02.jpg','imgs/thumb_imgs/pt-tshirt12_03.jpg','imgs/thumb_imgs/pt-tshirt12_04.jpg','P.T. T-shirt Uniform 12',32),
('imgs/pt-tshirt13.jpg','imgs/thumb_imgs/pt-tshirt13_01.jpg','imgs/thumb_imgs/pt-tshirt13_02.jpg','imgs/thumb_imgs/pt-tshirt13_03.jpg','imgs/thumb_imgs/pt-tshirt13_04.jpg','P.T. T-shirt Uniform 13',33),
('imgs/pt-tshirt14.jpg','imgs/thumb_imgs/pt-tshirt14_01.jpg','imgs/thumb_imgs/pt-tshirt14_02.jpg','imgs/thumb_imgs/pt-tshirt14_03.jpg','imgs/thumb_imgs/pt-tshirt14_04.jpg','P.T. T-shirt Uniform 14',34),
('imgs/pt-tshirt15.jpg','imgs/thumb_imgs/pt-tshirt15_01.jpg','imgs/thumb_imgs/pt-tshirt15_02.jpg','imgs/thumb_imgs/pt-tshirt15_03.jpg','imgs/thumb_imgs/pt-tshirt15_04.jpg','P.T. T-shirt Uniform 15',35),
('imgs/pt-tshirt16.jpg','imgs/thumb_imgs/pt-tshirt16_01.jpg','imgs/thumb_imgs/pt-tshirt16_02.jpg','imgs/thumb_imgs/pt-tshirt16_03.jpg','imgs/thumb_imgs/pt-tshirt16_04.jpg','P.T. T-shirt Uniform 16',36),
('imgs/pt-tshirt17.jpg','imgs/thumb_imgs/pt-tshirt17_01.jpg','imgs/thumb_imgs/pt-tshirt17_02.jpg','imgs/thumb_imgs/pt-tshirt17_03.jpg','imgs/thumb_imgs/pt-tshirt17_04.jpg','P.T. T-shirt Uniform 17',37),
('imgs/pt-tshirt18.jpg','imgs/thumb_imgs/pt-tshirt18_01.jpg','imgs/thumb_imgs/pt-tshirt18_02.jpg','imgs/thumb_imgs/pt-tshirt18_03.jpg','imgs/thumb_imgs/pt-tshirt18_04.jpg','P.T. T-shirt Uniform 18',38),
('imgs/pt-tshirt19.jpg','imgs/thumb_imgs/pt-tshirt19_01.jpg','imgs/thumb_imgs/pt-tshirt19_02.jpg','imgs/thumb_imgs/pt-tshirt19_03.jpg','imgs/thumb_imgs/pt-tshirt20_04.jpg','P.T. T-shirt Uniform 19',39),
('imgs/pt-tshirt20.jpg','imgs/thumb_imgs/pt-tshirt20_01.jpg','imgs/thumb_imgs/pt-tshirt20_02.jpg','imgs/thumb_imgs/pt-tshirt20_03.jpg','imgs/thumb_imgs/pt-tshirt20_04.jpg','P.T. T-shirt Uniform 20',40),

('imgs/pt-short01.jpg','imgs/thumb_imgs/pt-short01_01.jpg','imgs/thumb_imgs/pt-short01_02.jpg','imgs/thumb_imgs/pt-short01_03.jpg','imgs/thumb_imgs/pt-short01_04.jpg','P.T. Short Uniform 01',21),
('imgs/pt-short02.jpg','imgs/thumb_imgs/pt-short02_01.jpg','imgs/thumb_imgs/pt-short02_02.jpg','imgs/thumb_imgs/pt-short02_03.jpg','imgs/thumb_imgs/pt-short02_04.jpg','P.T. Short Uniform 02',22),
('imgs/pt-short03.jpg','imgs/thumb_imgs/pt-short03_01.jpg','imgs/thumb_imgs/pt-short03_02.jpg','imgs/thumb_imgs/pt-short03_03.jpg','imgs/thumb_imgs/pt-short03_04.jpg','P.T. Short Uniform 03',23),
('imgs/pt-short04.jpg','imgs/thumb_imgs/pt-short04_01.jpg','imgs/thumb_imgs/pt-short04_02.jpg','imgs/thumb_imgs/pt-short04_03.jpg','imgs/thumb_imgs/pt-short04_04.jpg','P.T. Short Uniform 04',24),
('imgs/pt-short05.jpg','imgs/thumb_imgs/pt-short05_01.jpg','imgs/thumb_imgs/pt-short05_02.jpg','imgs/thumb_imgs/pt-short05_03.jpg','imgs/thumb_imgs/pt-short05_04.jpg','P.T. Short Uniform 05',25),
('imgs/pt-short01.jpg','imgs/thumb_imgs/pt-short01_01.jpg','imgs/thumb_imgs/pt-short01_02.jpg','imgs/thumb_imgs/pt-short01_03.jpg','imgs/thumb_imgs/pt-short01_04.jpg','P.T. Short Uniform 06',26),
('imgs/pt-short02.jpg','imgs/thumb_imgs/pt-short02_01.jpg','imgs/thumb_imgs/pt-short02_02.jpg','imgs/thumb_imgs/pt-short02_03.jpg','imgs/thumb_imgs/pt-short02_04.jpg','P.T. Short Uniform 07',27),
('imgs/pt-short03.jpg','imgs/thumb_imgs/pt-short03_01.jpg','imgs/thumb_imgs/pt-short03_02.jpg','imgs/thumb_imgs/pt-short03_03.jpg','imgs/thumb_imgs/pt-short03_04.jpg','P.T. Short Uniform 08',28),
('imgs/pt-short04.jpg','imgs/thumb_imgs/pt-short04_01.jpg','imgs/thumb_imgs/pt-short04_02.jpg','imgs/thumb_imgs/pt-short04_03.jpg','imgs/thumb_imgs/pt-short04_04.jpg','P.T. Short Uniform 09',29),
('imgs/pt-short05.jpg','imgs/thumb_imgs/pt-short05_01.jpg','imgs/thumb_imgs/pt-short05_02.jpg','imgs/thumb_imgs/pt-short05_03.jpg','imgs/thumb_imgs/pt-short05_04.jpg','P.T. Short Uniform 10',30),
('imgs/pt-short01.jpg','imgs/thumb_imgs/pt-short01_01.jpg','imgs/thumb_imgs/pt-short01_02.jpg','imgs/thumb_imgs/pt-short01_03.jpg','imgs/thumb_imgs/pt-short01_04.jpg','P.T. Short Uniform 11',31),
('imgs/pt-short02.jpg','imgs/thumb_imgs/pt-short02_01.jpg','imgs/thumb_imgs/pt-short02_02.jpg','imgs/thumb_imgs/pt-short02_03.jpg','imgs/thumb_imgs/pt-short02_04.jpg','P.T. Short Uniform 12',32),
('imgs/pt-short03.jpg','imgs/thumb_imgs/pt-short03_01.jpg','imgs/thumb_imgs/pt-short03_02.jpg','imgs/thumb_imgs/pt-short03_03.jpg','imgs/thumb_imgs/pt-short03_04.jpg','P.T. Short Uniform 13',33),
('imgs/pt-short04.jpg','imgs/thumb_imgs/pt-short04_01.jpg','imgs/thumb_imgs/pt-short04_02.jpg','imgs/thumb_imgs/pt-short04_03.jpg','imgs/thumb_imgs/pt-short04_04.jpg','P.T. Short Uniform 14',34),
('imgs/pt-short05.jpg','imgs/thumb_imgs/pt-short05_01.jpg','imgs/thumb_imgs/pt-short05_02.jpg','imgs/thumb_imgs/pt-short05_03.jpg','imgs/thumb_imgs/pt-short05_04.jpg','P.T. Short Uniform 15',35),
('imgs/pt-short01.jpg','imgs/thumb_imgs/pt-short01_01.jpg','imgs/thumb_imgs/pt-short01_02.jpg','imgs/thumb_imgs/pt-short01_03.jpg','imgs/thumb_imgs/pt-short01_04.jpg','P.T. Short Uniform 16',36),
('imgs/pt-short02.jpg','imgs/thumb_imgs/pt-short02_01.jpg','imgs/thumb_imgs/pt-short02_02.jpg','imgs/thumb_imgs/pt-short02_03.jpg','imgs/thumb_imgs/pt-short02_04.jpg','P.T. Short Uniform 17',37),
('imgs/pt-short03.jpg','imgs/thumb_imgs/pt-short03_01.jpg','imgs/thumb_imgs/pt-short03_02.jpg','imgs/thumb_imgs/pt-short03_03.jpg','imgs/thumb_imgs/pt-short03_04.jpg','P.T. Short Uniform 18',38),
('imgs/pt-short04.jpg','imgs/thumb_imgs/pt-short04_01.jpg','imgs/thumb_imgs/pt-short04_02.jpg','imgs/thumb_imgs/pt-short04_03.jpg','imgs/thumb_imgs/pt-short04_04.jpg','P.T. Short Uniform 19',39),
('imgs/pt-short05.jpg','imgs/thumb_imgs/pt-short05_01.jpg','imgs/thumb_imgs/pt-short05_02.jpg','imgs/thumb_imgs/pt-short05_03.jpg','imgs/thumb_imgs/pt-short05_04.jpg','P.T. Short Uniform 20',40),

('imgs/pt-trackpants01.jpg','imgs/thumb_imgs/pt-trackpants01_01.jpg','imgs/thumb_imgs/pt-trackpants01_02.jpg','imgs/thumb_imgs/pt-trackpants01_03.jpg','imgs/thumb_imgs/pt-trackpants01_04.jpg','P.T. Track Pants 01',21),
('imgs/pt-trackpants02.jpg','imgs/thumb_imgs/pt-trackpants02_01.jpg','imgs/thumb_imgs/pt-trackpants02_02.jpg','imgs/thumb_imgs/pt-trackpants02_03.jpg','imgs/thumb_imgs/pt-trackpants02_04.jpg','P.T. Track Pants 02',22),
('imgs/pt-trackpants03.jpg','imgs/thumb_imgs/pt-trackpants03_01.jpg','imgs/thumb_imgs/pt-trackpants03_02.jpg','imgs/thumb_imgs/pt-trackpants03_03.jpg','imgs/thumb_imgs/pt-trackpants03_04.jpg','P.T. Track Pants 03',23),
('imgs/pt-trackpants04.jpg','imgs/thumb_imgs/pt-trackpants04_01.jpg','imgs/thumb_imgs/pt-trackpants04_02.jpg','imgs/thumb_imgs/pt-trackpants04_03.jpg','imgs/thumb_imgs/pt-trackpants04_04.jpg','P.T. Track Pants 04',24),
('imgs/pt-trackpants05.jpg','imgs/thumb_imgs/pt-trackpants05_01.jpg','imgs/thumb_imgs/pt-trackpants05_02.jpg','imgs/thumb_imgs/pt-trackpants05_03.jpg','imgs/thumb_imgs/pt-trackpants05_04.jpg','P.T. Track Pants 05',25),
('imgs/pt-trackpants06.jpg','imgs/thumb_imgs/pt-trackpants06_01.jpg','imgs/thumb_imgs/pt-trackpants06_02.jpg','imgs/thumb_imgs/pt-trackpants06_03.jpg','imgs/thumb_imgs/pt-trackpants06_04.jpg','P.T. Track Pants 06',26),
('imgs/pt-trackpants07.jpg','imgs/thumb_imgs/pt-trackpants07_01.jpg','imgs/thumb_imgs/pt-trackpants07_02.jpg','imgs/thumb_imgs/pt-trackpants07_03.jpg','imgs/thumb_imgs/pt-trackpants07_04.jpg','P.T. Track Pants 07',27),
('imgs/pt-trackpants08.jpg','imgs/thumb_imgs/pt-trackpants08_01.jpg','imgs/thumb_imgs/pt-trackpants08_02.jpg','imgs/thumb_imgs/pt-trackpants08_03.jpg','imgs/thumb_imgs/pt-trackpants08_04.jpg','P.T. Track Pants 08',28),
('imgs/pt-trackpants09.jpg','imgs/thumb_imgs/pt-trackpants09_01.jpg','imgs/thumb_imgs/pt-trackpants09_02.jpg','imgs/thumb_imgs/pt-trackpants09_03.jpg','imgs/thumb_imgs/pt-trackpants09_04.jpg','P.T. Track Pants 09',29),
('imgs/pt-trackpants10.jpg','imgs/thumb_imgs/pt-trackpants10_01.jpg','imgs/thumb_imgs/pt-trackpants10_02.jpg','imgs/thumb_imgs/pt-trackpants10_03.jpg','imgs/thumb_imgs/pt-trackpants10_04.jpg','P.T. Track Pants 10',30),
('imgs/pt-trackpants11.jpg','imgs/thumb_imgs/pt-trackpants11_01.jpg','imgs/thumb_imgs/pt-trackpants11_02.jpg','imgs/thumb_imgs/pt-trackpants11_03.jpg','imgs/thumb_imgs/pt-trackpants11_04.jpg','P.T. Track Pants 11',31),
('imgs/pt-trackpants12.jpg','imgs/thumb_imgs/pt-trackpants12_01.jpg','imgs/thumb_imgs/pt-trackpants12_02.jpg','imgs/thumb_imgs/pt-trackpants12_03.jpg','imgs/thumb_imgs/pt-trackpants12_04.jpg','P.T. Track Pants 12',32),
('imgs/pt-trackpants01.jpg','imgs/thumb_imgs/pt-trackpants01_01.jpg','imgs/thumb_imgs/pt-trackpants01_02.jpg','imgs/thumb_imgs/pt-trackpants01_03.jpg','imgs/thumb_imgs/pt-trackpants01_04.jpg','P.T. Track Pants 13',33),
('imgs/pt-trackpants02.jpg','imgs/thumb_imgs/pt-trackpants02_01.jpg','imgs/thumb_imgs/pt-trackpants02_02.jpg','imgs/thumb_imgs/pt-trackpants02_03.jpg','imgs/thumb_imgs/pt-trackpants02_04.jpg','P.T. Track Pants 14',34),
('imgs/pt-trackpants03.jpg','imgs/thumb_imgs/pt-trackpants03_01.jpg','imgs/thumb_imgs/pt-trackpants03_02.jpg','imgs/thumb_imgs/pt-trackpants03_03.jpg','imgs/thumb_imgs/pt-trackpants03_04.jpg','P.T. Track Pants 15',35),
('imgs/pt-trackpants04.jpg','imgs/thumb_imgs/pt-trackpants04_01.jpg','imgs/thumb_imgs/pt-trackpants04_02.jpg','imgs/thumb_imgs/pt-trackpants04_03.jpg','imgs/thumb_imgs/pt-trackpants04_04.jpg','P.T. Track Pants 16',36),
('imgs/pt-trackpants05.jpg','imgs/thumb_imgs/pt-trackpants05_01.jpg','imgs/thumb_imgs/pt-trackpants05_02.jpg','imgs/thumb_imgs/pt-trackpants05_03.jpg','imgs/thumb_imgs/pt-trackpants05_04.jpg','P.T. Track Pants 17',37),
('imgs/pt-trackpants06.jpg','imgs/thumb_imgs/pt-trackpants06_01.jpg','imgs/thumb_imgs/pt-trackpants06_02.jpg','imgs/thumb_imgs/pt-trackpants06_03.jpg','imgs/thumb_imgs/pt-trackpants06_04.jpg','P.T. Track Pants 18',38),
('imgs/pt-trackpants07.jpg','imgs/thumb_imgs/pt-trackpants07_01.jpg','imgs/thumb_imgs/pt-trackpants07_02.jpg','imgs/thumb_imgs/pt-trackpants07_03.jpg','imgs/thumb_imgs/pt-trackpants07_04.jpg','P.T. Track Pants 19',39),
('imgs/pt-trackpants08.jpg','imgs/thumb_imgs/pt-trackpants08_01.jpg','imgs/thumb_imgs/pt-trackpants08_02.jpg','imgs/thumb_imgs/pt-trackpants08_03.jpg','imgs/thumb_imgs/pt-trackpants08_04.jpg','P.T. Track Pants 20',40),

('imgs/belt01.jpg','imgs/thumb_imgs/belt01_01.jpg','imgs/thumb_imgs/belt01_02.jpg','imgs/thumb_imgs/belt01_03.jpg','imgs/thumb_imgs/belt01_04.jpg','Belt 01',20),
('imgs/belt02.jpg','imgs/thumb_imgs/belt02_01.jpg','imgs/thumb_imgs/belt02_02.jpg','imgs/thumb_imgs/belt02_03.jpg','imgs/thumb_imgs/belt02_04.jpg','Belt 02',20),
('imgs/belt03.jpg','imgs/thumb_imgs/belt03_01.jpg','imgs/thumb_imgs/belt03_02.jpg','imgs/thumb_imgs/belt03_03.jpg','imgs/thumb_imgs/belt03_04.jpg','Belt 03',20),
('imgs/belt04.jpg','imgs/thumb_imgs/belt04_01.jpg','imgs/thumb_imgs/belt04_02.jpg','imgs/thumb_imgs/belt04_03.jpg','imgs/thumb_imgs/belt04_04.jpg','Belt 04',20),
('imgs/belt05.jpg','imgs/thumb_imgs/belt05_01.jpg','imgs/thumb_imgs/belt05_02.jpg','imgs/thumb_imgs/belt05_03.jpg','imgs/thumb_imgs/belt05_04.jpg','Belt 05',20),
('imgs/belt06.jpg','imgs/thumb_imgs/belt06_01.jpg','imgs/thumb_imgs/belt06_02.jpg','imgs/thumb_imgs/belt06_03.jpg','imgs/thumb_imgs/belt06_04.jpg','Belt 06',20),
('imgs/belt02.jpg','imgs/thumb_imgs/belt02_01.jpg','imgs/thumb_imgs/belt02_02.jpg','imgs/thumb_imgs/belt02_03.jpg','imgs/thumb_imgs/belt02_04.jpg','Belt 07',20),
('imgs/belt03.jpg','imgs/thumb_imgs/belt03_01.jpg','imgs/thumb_imgs/belt03_02.jpg','imgs/thumb_imgs/belt03_03.jpg','imgs/thumb_imgs/belt03_04.jpg','Belt 08',20),
('imgs/belt04.jpg','imgs/thumb_imgs/belt04_01.jpg','imgs/thumb_imgs/belt04_02.jpg','imgs/thumb_imgs/belt04_03.jpg','imgs/thumb_imgs/belt04_04.jpg','Belt 09',20),
('imgs/belt05.jpg','imgs/thumb_imgs/belt05_01.jpg','imgs/thumb_imgs/belt05_02.jpg','imgs/thumb_imgs/belt05_03.jpg','imgs/thumb_imgs/belt05_04.jpg','Belt 10',20),

('imgs/tie01.jpg','imgs/thumb_imgs/tie01_01.jpg','imgs/thumb_imgs/tie01_02.jpg','imgs/thumb_imgs/tie01_03.jpg','imgs/thumb_imgs/tie01_04.jpg','Tie 01',20),
('imgs/tie02.jpg','imgs/thumb_imgs/tie02_01.jpg','imgs/thumb_imgs/tie02_02.jpg','imgs/thumb_imgs/tie02_03.jpg','imgs/thumb_imgs/tie02_04.jpg','Tie 02',20),
('imgs/tie03.jpg','imgs/thumb_imgs/tie03_01.jpg','imgs/thumb_imgs/tie03_02.jpg','imgs/thumb_imgs/tie03_03.jpg','imgs/thumb_imgs/tie03_04.jpg','Tie 03',20),
('imgs/tie04.jpg','imgs/thumb_imgs/tie04_01.jpg','imgs/thumb_imgs/tie04_02.jpg','imgs/thumb_imgs/tie04_03.jpg','imgs/thumb_imgs/tie04_04.jpg','Tie 04',20),
('imgs/tie05.jpg','imgs/thumb_imgs/tie05_01.jpg','imgs/thumb_imgs/tie05_02.jpg','imgs/thumb_imgs/tie05_03.jpg','imgs/thumb_imgs/tie05_04.jpg','Tie 05',20),
('imgs/tie06.jpg','imgs/thumb_imgs/tie06_01.jpg','imgs/thumb_imgs/tie06_02.jpg','imgs/thumb_imgs/tie06_03.jpg','imgs/thumb_imgs/tie06_04.jpg','Tie 06',20),
('imgs/tie07.jpg','imgs/thumb_imgs/tie07_01.jpg','imgs/thumb_imgs/tie07_02.jpg','imgs/thumb_imgs/tie07_03.jpg','imgs/thumb_imgs/tie07_04.jpg','Tie 07',20),
('imgs/tie08.jpg','imgs/thumb_imgs/tie08_01.jpg','imgs/thumb_imgs/tie08_02.jpg','imgs/thumb_imgs/tie08_03.jpg','imgs/thumb_imgs/tie08_04.jpg','Tie 08',20),
('imgs/tie09.jpg','imgs/thumb_imgs/tie09_01.jpg','imgs/thumb_imgs/tie09_02.jpg','imgs/thumb_imgs/tie09_03.jpg','imgs/thumb_imgs/tie09_04.jpg','Tie 09',20),
('imgs/tie10.jpg','imgs/thumb_imgs/tie10_01.jpg','imgs/thumb_imgs/tie10_02.jpg','imgs/thumb_imgs/tie10_03.jpg','imgs/thumb_imgs/tie10_04.jpg','Tie 10',20),

('imgs/sock01.jpg','imgs/thumb_imgs/sock01_01.jpg','imgs/thumb_imgs/sock01_02.jpg','imgs/thumb_imgs/sock01_03.jpg','imgs/thumb_imgs/sock01_04.jpg','Socks 01',10),
('imgs/sock02.jpg','imgs/thumb_imgs/sock02_01.jpg','imgs/thumb_imgs/sock02_02.jpg','imgs/thumb_imgs/sock02_03.jpg','imgs/thumb_imgs/sock02_04.jpg','Socks 02',10),
('imgs/sock03.jpg','imgs/thumb_imgs/sock03_01.jpg','imgs/thumb_imgs/sock03_02.jpg','imgs/thumb_imgs/sock03_03.jpg','imgs/thumb_imgs/sock03_04.jpg','Socks 03',10),
('imgs/sock04.jpg','imgs/thumb_imgs/sock04_01.jpg','imgs/thumb_imgs/sock04_02.jpg','imgs/thumb_imgs/sock04_03.jpg','imgs/thumb_imgs/sock04_04.jpg','Socks 04',10),
('imgs/sock05.jpg','imgs/thumb_imgs/sock05_01.jpg','imgs/thumb_imgs/sock05_02.jpg','imgs/thumb_imgs/sock05_03.jpg','imgs/thumb_imgs/sock05_04.jpg','Socks 05',10),
('imgs/sock06.jpg','imgs/thumb_imgs/sock06_01.jpg','imgs/thumb_imgs/sock06_02.jpg','imgs/thumb_imgs/sock06_03.jpg','imgs/thumb_imgs/sock06_04.jpg','Socks 06',10),
('imgs/sock07.jpg','imgs/thumb_imgs/sock07_01.jpg','imgs/thumb_imgs/sock07_02.jpg','imgs/thumb_imgs/sock07_03.jpg','imgs/thumb_imgs/sock07_04.jpg','Socks 07',10),
('imgs/sock08.jpg','imgs/thumb_imgs/sock08_01.jpg','imgs/thumb_imgs/sock08_02.jpg','imgs/thumb_imgs/sock08_03.jpg','imgs/thumb_imgs/sock08_04.jpg','Socks 08',10),
('imgs/sock09.jpg','imgs/thumb_imgs/sock09_01.jpg','imgs/thumb_imgs/sock09_02.jpg','imgs/thumb_imgs/sock09_03.jpg','imgs/thumb_imgs/sock09_04.jpg','Socks 09',10),
('imgs/sock10.jpg','imgs/thumb_imgs/sock10_01.jpg','imgs/thumb_imgs/sock10_02.jpg','imgs/thumb_imgs/sock10_03.jpg','imgs/thumb_imgs/sock10_04.jpg','Socks 10',10)

select * from Nhom6_Product;
select * from Nhom6_Product where IdProd between 1 and 10;
select * from Nhom6_Product where IdProd between 11 and 20;
select * from Nhom6_Product where IdProd between 21 and 30;
select * from Nhom6_Product where IdProd between 31 and 40;
select * from Nhom6_Product where IdProd between 41 and 50;
select * from Nhom6_Product where IdProd between 51 and 60;
select * from Nhom6_Product where IdProd between 61 and 70;
select * from Nhom6_Product where IdProd between 71 and 80;
select * from Nhom6_Product where IdProd between 81 and 90;
select * from Nhom6_Product where IdProd between 91 and 100;
select * from Nhom6_Product where IdProd between 101 and 110;
select * from Nhom6_Product where IdProd between 111 and 120;
select * from Nhom6_Product where IdProd between 121 and 130;
select * from Nhom6_Product where IdProd between 131 and 140;
select * from Nhom6_Product where IdProd between 141 and 150;

SELECT Top 4 * from Nhom6_Product where NameProd like 'Shirt' ORDER BY NEWID()
select * from Nhom6_Customer;
select * from Nhom6_OrderForm;