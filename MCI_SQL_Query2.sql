------Tạo bảng với khóa chính--------

drop table MCI_SQL..CUSTOMERPK

---------Tạo bảng customer với khóa chính-------------
CREATE TABLE MCI_SQL..CUSTOMERPK (
   ID INT not null,
   [NAME] VARCHAR(20) not null,
   AGE  INT,
   [ADDRESS] VARCHAR(25), 
   SALARY float
);

ALTER TABLE MCI_SQL..CUSTOMERPK ADD PRIMARY KEY (ID);
ALTER TABLE MCI_SQL..CUSTOMERPK ADD PRIMARY KEY ([NAME]);

CREATE TABLE MCI_SQL..CUSTOMERPK (
   ID INT PRIMARY KEY,
   NAME VARCHAR (20),
   AGE  INT,
   [ADDRESS] CHAR (25),
   SALARY float,
);


CREATE TABLE MCI_SQL..CUSTOMERPK (
   ID INT,
   NAME VARCHAR (20),
   AGE  INT,
   [ADDRESS] CHAR (25),
   SALARY float,
   CONSTRAINT PK_Person PRIMARY KEY (ID)
)


CREATE TABLE MCI_SQL..CUSTOMERPK (
   ID INT,
   NAME VARCHAR (20),
   AGE  INT,
   [ADDRESS] CHAR (25),
   SALARY float,
   CONSTRAINT PK_Person PRIMARY KEY (ID,[NAME])
);

INSERT INTO MCI_SQL..CUSTOMERPK (ID,NAME,AGE,ADDRESS,SALARY) VALUES (1, 'Ha Anh', 32, 'Da Nang', 2000.00 );
INSERT INTO MCI_SQL..CUSTOMERPK (ID,NAME,AGE,ADDRESS,SALARY) VALUES (2, 'Ha Anh', 32, 'Da Nang', 2000.00);

INSERT INTO MCI_SQL..CUSTOMERPK (ID,NAME,AGE,ADDRESS,SALARY) VALUES (2, 'Van Ha', 25, 'Ha Noi', 1500.00 );
INSERT INTO MCI_SQL..CUSTOMERPK (ID,NAME,AGE,ADDRESS,SALARY) VALUES (null, 'Van Ha', 25, 'Ha Noi', 1500.00 );

select * from MCI_SQL..CUSTOMERPK

delete from MCI_SQL..CUSTOMERPK

---------Khóa ngoại-------------

CREATE TABLE MCI_SQL..Persons (
    PersonID int PRIMARY KEY,
    LastName varchar(255),
    FirstName varchar(255),
    Age int default 3
);

CREATE TABLE MCI_SQL..Orders (
    OrderID int,
    OrderNumber int,
    PersonID int,
    PRIMARY KEY (OrderID),
    FOREIGN KEY (PersonID) REFERENCES Persons(PersonID)
);

insert into Persons values (1,'Hansen','Ola',30)
insert into Persons values (2,'Svendson','Tove',23)
insert into Persons values (3,'Pettersen','Kari',20)

insert into Orders values (1,77895,3)
insert into Orders values (2,44678,3)
insert into Orders values (3,22456,2)
insert into Orders values (4,24562,1)

select * from Orders

select * from Persons

delete from Orders

delete from Persons

ALTER TABLE Orders ADD FOREIGN KEY (PersonID) REFERENCES Persons(ID);


-------------Constraint trong sql--------------

---------NOT NULL------------

drop table Orders;
drop table Persons;
CREATE TABLE Persons (
    ID int ,
    LastName varchar(255) NOT NULL,
    FirstName varchar(255) NOT NULL,
    Age int default 3
);

ALTER TABLE Persons alter column Age int;

ALTER TABLE Persons alter column Age int NOT NULL;

select * from Persons

insert into Persons values (1,'A',null,null)

delete from Persons
insert into Persons(ID,LastName,FirstName,Age) values (1,'A','B',7)
insert into Persons(ID,LastName,FirstName,Age) values (1,'A','B',null)

insert into Persons (ID,LastName,FirstName) values (1,'A','B')

---------Default------------
ALTER TABLE Persons ADD CONSTRAINT cs_LastName DEFAULT 'C' FOR LastName;

-----------------------VIEW Trong SQL
CREATE TABLE MCI_SQL..CUSTOMERPK (
   ID INT,
   NAME VARCHAR (20),
   AGE  INT,
   [ADDRESS] CHAR (25),
   SALARY float,
   PRIMARY KEY (ID)
);

INSERT INTO MCI_SQL..CUSTOMERPK (ID,NAME,AGE,ADDRESS,SALARY) VALUES (1, 'Ha Anh', 32, 'Da Nang', 2000.00 );
INSERT INTO MCI_SQL..CUSTOMERPK (ID,NAME,AGE,ADDRESS,SALARY) VALUES (2, 'Van Ha', 25, 'Ha Noi', 1500.00 );
INSERT INTO MCI_SQL..CUSTOMERPK (ID,NAME,AGE,ADDRESS,SALARY) VALUES (3, 'Vu Bang', 23, 'Vinh', 2000.00 );
INSERT INTO MCI_SQL..CUSTOMERPK (ID,NAME,AGE,ADDRESS,SALARY) VALUES (4, 'Thu Minh', 25, 'Ha Noi', 6500.00 );
INSERT INTO MCI_SQL..CUSTOMERPK (ID,NAME,AGE,ADDRESS,SALARY) VALUES (5, 'Hai An', 27, 'Ha Noi', 8500.00 );
INSERT INTO MCI_SQL..CUSTOMERPK (ID,NAME,AGE,ADDRESS,SALARY) VALUES (6, 'Hoang', 22, 'Ha Noi', 4500.00 );
INSERT INTO MCI_SQL..CUSTOMERPK (ID,NAME,AGE,ADDRESS,SALARY) VALUES (7, 'Binh', 24, 'Ha Noi', 10000.00 );

select *
from BFRBD_Query..MCI_SQL..CUSTOMERPK

alter VIEW CUSTOMERPK_VIEW AS
SELECT id, name, age
FROM  MCI_SQL..CUSTOMERPK;

CREATE VIEW CUSTOMERPK_VIEW AS
SELECT id, name, age
FROM  MCI_SQL..CUSTOMERPK
WHERE age IS NOT NULL
WITH CHECK OPTION;

select * from BFRBD_Query..CUSTOMERPK_VIEW

INSERT INTO CUSTOMERPK_VIEW VALUES(14, 'TEST', null)

INSERT INTO BFRBD_Query..MCI_SQL..CUSTOMERPK(id, name, age) VALUES(14, 'TEST', null)

update BFRBD_Query..CUSTOMERPK_VIEW set age = 100 where name = 'TEST'

select * from BFRBD_Query..CUSTOMERPK_VIEW

select * from BFRBD_Query..MCI_SQL..CUSTOMERPK


------------Tạo view cho 2 kết quả đã select ra trong bài tập về nhà-----------------

---------------------Bài tập group by--------------

-----------Tạo bảng BanHang_Result-------
drop table MCI_SQL..BanHang_Result
Create table MCI_SQL..BanHang_Result (
	ThoiDiemGiaoDich date,
	ChiTieu varchar(50),
	MaCuaHang varchar(50),
	LoaiTien varchar(20),
	LoaiHang varchar(100),
	LoaiKH int,
	MuaVaoBanRa varchar(2),
	SoTienQuyDoi float
)

select * from MCI_SQL..BanHang_Result

select * from MCI_SQL..Lesson2


------Tính tổng số tiền theo từng ngày, Từng Tháng, Từng Năm và nhóm theo các chiều ThoiDiemGiaoDich,MaCuaHang,LoaiTien,LoaiHang,LoaiKH 
-----trường chỉ tiêu đặt là Tong Giao Dich và đưa kết quả vào bảng MCI_SQL..BanHang_Result---------------
--Từng ngày
insert into MCI_SQL..BanHang_Result
select 
	Trans_time,
	'Tong Giao Dich Theo Ngay',
	Store_ID,
	Loai_tien,
	Loai_hang,
	Loai_khachhang,
	Muavao_Banra,
	sum(SoTien_quydoi) TongSoTienQuyDoi
from 
	MCI_SQL..Lesson2
group by
	Trans_time,
	Store_ID,
	Loai_tien,
	Loai_hang,
	Loai_khachhang,
	Muavao_Banra
order by 
	Trans_Time, 
	Store_ID, 
	Loai_tien, 
	Loai_hang, 
	Loai_khachhang, 
	Muavao_Banra

--Từng tháng
insert into MCI_SQL..BanHang_Result
select 
	CONVERT(date,
		(
		CONVERT(varchar(4),DATEPART(YEAR,Trans_time)) + 
		case when DATEPART(MONTH,Trans_time) < 10 then '0' + CONVERT(varchar(2),DATEPART(MONTH,Trans_time))
			else CONVERT(varchar(2),DATEPART(MONTH,Trans_time)) end +
		CONVERT(varchar(2),
			(case when DATEPART(MONTH,Trans_time) = 2 then 28
				when DATEPART(MONTH,Trans_time) in (1,3,5,7,8,10,12) then 31
				else 30 end))
		),112),
	'Tong Giao Dich Theo Thang',
	Store_ID,
	Loai_tien,
	Loai_hang,
	Loai_khachhang,
	Muavao_Banra,
	sum(SoTien_quydoi) TongSoTienQuyDoi
from 
	MCI_SQL..Lesson2
group by
	DATEPART(YEAR,Trans_time),
	DATEPART(Month,Trans_time),
	Store_ID,
	Loai_tien,
	Loai_hang,
	Loai_khachhang,
	Muavao_Banra
order by 
	DATEPART(YEAR,Trans_time),
	DATEPART(Month,Trans_time), 
	Store_ID, 
	Loai_tien, 
	Loai_hang, 
	Loai_khachhang, 
	Muavao_Banra
	
--Từng năm
insert into MCI_SQL..BanHang_Result
select 
	CONVERT(date,
		(
		CONVERT(varchar(4),DATEPART(YEAR,Trans_time)) + '1231'
		),112),
	'Tong Giao Dich Theo Nam',
	Store_ID,
	Loai_tien,
	Loai_hang,
	Loai_khachhang,
	Muavao_Banra,
	sum(SoTien_quydoi) TongSoTienQuyDoi
from 
	MCI_SQL..Lesson2
group by
	DATEPART(YEAR,Trans_time),
	Store_ID,
	Loai_tien,
	Loai_hang,
	Loai_khachhang,
	Muavao_Banra
order by 
	DATEPART(YEAR,Trans_time),
	Store_ID, 
	Loai_tien, 
	Loai_hang, 
	Loai_khachhang, 
	Muavao_Banra


------Tính Bình Quân theo từng ngày, Từng Tháng, Từng Năm và nhóm theo các chiều ThoiDiemGiaoDich,MaCuaHang,LoaiTien,LoaiHang,LoaiKH 
----------trường chỉ tiêu đặt là Binh Quan Giao Dich và đưa kết quả vào bảng MCI_SQL..BanHang_Result---------------
--Từng ngày
insert into MCI_SQL..BanHang_Result
select 
	Trans_time,
	'Binh Quan Giao Dich Theo Ngay',
	Store_ID,
	Loai_tien,
	Loai_hang,
	Loai_khachhang,
	Muavao_Banra,
	avg(SoTien_quydoi) BinhQuanGiaoDich
from 
	MCI_SQL..Lesson2
group by
	Trans_time,
	Store_ID,
	Loai_tien,
	Loai_hang,
	Loai_khachhang,
	Muavao_Banra
order by 
	Trans_Time, 
	Store_ID, 
	Loai_tien, 
	Loai_hang, 
	Loai_khachhang, 
	Muavao_Banra

--Từng tháng
insert into MCI_SQL..BanHang_Result
select 
	CONVERT(date,
		(
		CONVERT(varchar(4),DATEPART(YEAR,Trans_time)) + 
		case when DATEPART(MONTH,Trans_time) < 10 then '0' + CONVERT(varchar(2),DATEPART(MONTH,Trans_time))
			else CONVERT(varchar(2),DATEPART(MONTH,Trans_time)) end +
		CONVERT(varchar(2),
			(case when DATEPART(MONTH,Trans_time) = 2 then 28
				when DATEPART(MONTH,Trans_time) in (1,3,5,7,8,10,12) then 31
				else 30 end))
		),112),
	'Binh Quan Giao Dich Theo Thang',
	Store_ID,
	Loai_tien,
	Loai_hang,
	Loai_khachhang,
	Muavao_Banra,
	avg(SoTien_quydoi) BinhQuanGiaoDich
from 
	MCI_SQL..Lesson2
group by
	DATEPART(YEAR,Trans_time),
	DATEPART(Month,Trans_time),
	Store_ID,
	Loai_tien,
	Loai_hang,
	Loai_khachhang,
	Muavao_Banra
order by 
	DATEPART(YEAR,Trans_time),
	DATEPART(Month,Trans_time), 
	Store_ID, 
	Loai_tien, 
	Loai_hang, 
	Loai_khachhang, 
	Muavao_Banra
	
--Từng năm
insert into MCI_SQL..BanHang_Result
select 
	CONVERT(date,
		(
		CONVERT(varchar(4),DATEPART(YEAR,Trans_time)) + '1231'
		),112),
	'Binh Quan Giao Dich Theo Nam',
	Store_ID,
	Loai_tien,
	Loai_hang,
	Loai_khachhang,
	Muavao_Banra,
	avg(SoTien_quydoi) BinhQuanGiaoDich
from 
	MCI_SQL..Lesson2
group by
	DATEPART(YEAR,Trans_time),
	Store_ID,
	Loai_tien,
	Loai_hang,
	Loai_khachhang,
	Muavao_Banra
order by 
	DATEPART(YEAR,Trans_time),
	Store_ID, 
	Loai_tien, 
	Loai_hang, 
	Loai_khachhang, 
	Muavao_Banra


------Tính tổng số tiền hoa hồng theo từng ngày, Từng Tháng, Từng Năm và nhóm theo các chiều ThoiDiemGiaoDich,MaCuaHang,LoaiTien,LoaiHang,LoaiKH 
------trường chỉ tiêu đặt là Tong Hoa Hong và đưa kết quả vào bảng MCI_SQL..BanHang_Result---------------
--Từng ngày
insert into MCI_SQL..BanHang_Result
select 
	Trans_time,
	'Tong Hoa Hong Theo Ngay',
	Store_ID,
	Loai_tien,
	Loai_hang,
	Loai_khachhang,
	Muavao_Banra,
	sum(SoTien_quydoi * Hoa_hong) TongHoaHong
from 
	MCI_SQL..Lesson2
group by
	Trans_time,
	Store_ID,
	Loai_tien,
	Loai_hang,
	Loai_khachhang,
	Muavao_Banra
order by 
	Trans_Time, 
	Store_ID, 
	Loai_tien, 
	Loai_hang, 
	Loai_khachhang, 
	Muavao_Banra

--Từng tháng
insert into MCI_SQL..BanHang_Result
select 
	CONVERT(date,
		(
		CONVERT(varchar(4),DATEPART(YEAR,Trans_time)) + 
		case when DATEPART(MONTH,Trans_time) < 10 then '0' + CONVERT(varchar(2),DATEPART(MONTH,Trans_time))
			else CONVERT(varchar(2),DATEPART(MONTH,Trans_time)) end +
		CONVERT(varchar(2),
			(case when DATEPART(MONTH,Trans_time) = 2 then 28
				when DATEPART(MONTH,Trans_time) in (1,3,5,7,8,10,12) then 31
				else 30 end))
		),112),
	'Tong Hoa Hong Theo Thang',
	Store_ID,
	Loai_tien,
	Loai_hang,
	Loai_khachhang,
	Muavao_Banra,
	sum(SoTien_quydoi * Hoa_hong) TongHoaHong
from 
	MCI_SQL..Lesson2
group by
	DATEPART(YEAR,Trans_time),
	DATEPART(Month,Trans_time),
	Store_ID,
	Loai_tien,
	Loai_hang,
	Loai_khachhang,
	Muavao_Banra
order by 
	DATEPART(YEAR,Trans_time),
	DATEPART(Month,Trans_time), 
	Store_ID, 
	Loai_tien, 
	Loai_hang, 
	Loai_khachhang, 
	Muavao_Banra
	
--Từng năm
insert into MCI_SQL..BanHang_Result
select 
	CONVERT(date,
		(
		CONVERT(varchar(4),DATEPART(YEAR,Trans_time)) + '1231'
		),112),
	'Tong Hoa Hong Theo Nam',
	Store_ID,
	Loai_tien,
	Loai_hang,
	Loai_khachhang,
	Muavao_Banra,
	sum(SoTien_quydoi * Hoa_hong) TongHoaHong
from 
	MCI_SQL..Lesson2
group by
	DATEPART(YEAR,Trans_time),
	Store_ID,
	Loai_tien,
	Loai_hang,
	Loai_khachhang,
	Muavao_Banra
order by 
	DATEPART(YEAR,Trans_time),
	Store_ID, 
	Loai_tien, 
	Loai_hang, 
	Loai_khachhang, 
	Muavao_Banra


------Tính tổng số tiền chiết khấu theo từng ngày, Từng Tháng, Từng Năm và nhóm theo các chiều ThoiDiemGiaoDich,MaCuaHang,LoaiTien,LoaiHang,LoaiKH 
------trường chỉ tiêu đặt là Tong Chiet Khau và đưa kết quả vào bảng MCI_SQL..BanHang_Result---------------
--Từng ngày
insert into MCI_SQL..BanHang_Result
select 
	Trans_time,
	'Tong Chiet Khau Theo Ngay',
	Store_ID,
	Loai_tien,
	Loai_hang,
	Loai_khachhang,
	Muavao_Banra,
	sum(Muc_chiet_khau) TongChietKhau
from 
	MCI_SQL..Lesson2
group by
	Trans_time,
	Store_ID,
	Loai_tien,
	Loai_hang,
	Loai_khachhang,
	Muavao_Banra
order by 
	Trans_Time, 
	Store_ID, 
	Loai_tien, 
	Loai_hang, 
	Loai_khachhang, 
	Muavao_Banra

--Từng tháng
insert into MCI_SQL..BanHang_Result
select 
	CONVERT(date,
		(
		CONVERT(varchar(4),DATEPART(YEAR,Trans_time)) + 
		case when DATEPART(MONTH,Trans_time) < 10 then '0' + CONVERT(varchar(2),DATEPART(MONTH,Trans_time))
			else CONVERT(varchar(2),DATEPART(MONTH,Trans_time)) end +
		CONVERT(varchar(2),
			(case when DATEPART(MONTH,Trans_time) = 2 then 28
				when DATEPART(MONTH,Trans_time) in (1,3,5,7,8,10,12) then 31
				else 30 end))
		),112),
	'Tong Chiet Khau Theo Thang',
	Store_ID,
	Loai_tien,
	Loai_hang,
	Loai_khachhang,
	Muavao_Banra,
	sum(Muc_chiet_khau) TongChietKhau
from 
	MCI_SQL..Lesson2
group by
	DATEPART(YEAR,Trans_time),
	DATEPART(Month,Trans_time),
	Store_ID,
	Loai_tien,
	Loai_hang,
	Loai_khachhang,
	Muavao_Banra
order by 
	DATEPART(YEAR,Trans_time),
	DATEPART(Month,Trans_time), 
	Store_ID, 
	Loai_tien, 
	Loai_hang, 
	Loai_khachhang, 
	Muavao_Banra
	
--Từng năm
insert into MCI_SQL..BanHang_Result
select 
	CONVERT(date,
		(
		CONVERT(varchar(4),DATEPART(YEAR,Trans_time)) + '1231'
		),112),
	'Tong Chiet Khau Theo Nam',
	Store_ID,
	Loai_tien,
	Loai_hang,
	Loai_khachhang,
	Muavao_Banra,
	sum(Muc_chiet_khau) TongChietKhau
from 
	MCI_SQL..Lesson2
group by
	DATEPART(YEAR,Trans_time),
	Store_ID,
	Loai_tien,
	Loai_hang,
	Loai_khachhang,
	Muavao_Banra
order by 
	DATEPART(YEAR,Trans_time),
	Store_ID, 
	Loai_tien, 
	Loai_hang, 
	Loai_khachhang, 
	Muavao_Banra


------Tính tổng số tiền chậm trả theo từng ngày, Từng Tháng, Từng Năm và nhóm theo các chiều ThoiDiemGiaoDich,MaCuaHang,LoaiTien,LoaiHang,LoaiKH 
------trường chỉ tiêu đặt là Tong Cham Tra và đưa kết quả vào bảng MCI_SQL..BanHang_Result---------------
--Từng ngày
insert into MCI_SQL..BanHang_Result
select 
	Trans_time,
	'Tong Cham Tra Theo Ngay',
	Store_ID,
	Loai_tien,
	Loai_hang,
	Loai_khachhang,
	Muavao_Banra,
	sum(Sotien_cham_tra) TongChamTra
from 
	MCI_SQL..Lesson2
group by
	Trans_time,
	Store_ID,
	Loai_tien,
	Loai_hang,
	Loai_khachhang,
	Muavao_Banra
order by 
	Trans_Time, 
	Store_ID, 
	Loai_tien, 
	Loai_hang, 
	Loai_khachhang, 
	Muavao_Banra

--Từng tháng
insert into MCI_SQL..BanHang_Result
select 
	CONVERT(date,
		(
		CONVERT(varchar(4),DATEPART(YEAR,Trans_time)) + 
		case when DATEPART(MONTH,Trans_time) < 10 then '0' + CONVERT(varchar(2),DATEPART(MONTH,Trans_time))
			else CONVERT(varchar(2),DATEPART(MONTH,Trans_time)) end +
		CONVERT(varchar(2),
			(case when DATEPART(MONTH,Trans_time) = 2 then 28
				when DATEPART(MONTH,Trans_time) in (1,3,5,7,8,10,12) then 31
				else 30 end))
		),112),
	'Tong Cham Tra Theo Thang',
	Store_ID,
	Loai_tien,
	Loai_hang,
	Loai_khachhang,
	Muavao_Banra,
	sum(Sotien_cham_tra) TongChamTra
from 
	MCI_SQL..Lesson2
group by
	DATEPART(YEAR,Trans_time),
	DATEPART(Month,Trans_time),
	Store_ID,
	Loai_tien,
	Loai_hang,
	Loai_khachhang,
	Muavao_Banra
order by 
	DATEPART(YEAR,Trans_time),
	DATEPART(Month,Trans_time), 
	Store_ID, 
	Loai_tien, 
	Loai_hang, 
	Loai_khachhang, 
	Muavao_Banra
	
--Từng năm
insert into MCI_SQL..BanHang_Result
select 
	CONVERT(date,
		(
		CONVERT(varchar(4),DATEPART(YEAR,Trans_time)) + '1231'
		),112),
	'Tong Cham Tra Theo Nam',
	Store_ID,
	Loai_tien,
	Loai_hang,
	Loai_khachhang,
	Muavao_Banra,
	sum(Sotien_cham_tra) TongChamTra
from 
	MCI_SQL..Lesson2
group by
	DATEPART(YEAR,Trans_time),
	Store_ID,
	Loai_tien,
	Loai_hang,
	Loai_khachhang,
	Muavao_Banra
order by 
	DATEPART(YEAR,Trans_time),
	Store_ID, 
	Loai_tien, 
	Loai_hang, 
	Loai_khachhang, 
	Muavao_Banra

