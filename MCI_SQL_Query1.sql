create table MCI_SQL.dbo.Lesson1(
	DayID varchar(8),
	RECID varchar(70),
	CUSTOMER varchar(20),
	CATEGORY int,
	CATE_NAME Nvarchar(1000),
	CURRENCY varchar(20),
	CLOSE_BAL float,
	INTEREST_RATE float,
	LOC_TERM varchar(20),
	CO_CODE varchar(50),
	VALUE_DATE varchar(8),
	MATURITY_DATE varchar(8),
	SECTOR int,
	SECTOR_NAME nvarchar(500),
	ROLLOVER_TERM varchar(20),
	LOAI_SP Nvarchar(100),
	EXCHANGE_RATE float,
	CU_SEGMENTS int,
	TK int,
	SUPP_AMT float,
	INDUSTRY int,
	SBV_INDUSTRY_MAP int,
	SBV_SECTOR_MAP int,
	RESIDENCE varchar(20),
	QUY_DOI float,
	SEAB_PRODUCT_DE int
);

select * from Lesson1;

bulk insert MCI_SQL.dbo.Lesson1
from 'C:\Users\tocba\Documents\MCI_SQL_Lv1\deposit_201701.csv'
with 
(
	firstrow = 2,
	fieldterminator = ',',
	rowterminator = '\n'
)

create table MCI_SQL.dbo.Lesson2(
	Store_ID varchar(30),
	Trans_Time date,
	Sale_man nvarchar(255),
	Sale_man_ID varchar(50),
	Sale_man_address nvarchar(255),
	Ten_khachhang nvarchar(255),
	Ma_khachhang varchar(255),
	Retail_bill varchar(50),
	Total_bill varchar(50),
	Loai_tien varchar(10),
	Loai_hang nvarchar(255), 
	Unit_Price float,
	Muavao_Banra varchar(3),
	Sotien_nguyente float,
	Sotien_quydoi float,
	Hoa_hong float,
	Muc_chiet_khau float,
	Sotien_cham_tra float,
	Ngay_den_han_tra_no date,
	Loai_khachhang int
);


bulk insert Lesson2
from 'C:\Users\tocba\Documents\MCI_SQL_Lv1\Lesson2-data.csv'
with
(
	firstrow = 2,
	fieldterminator = ',',
	rowterminator = '\n'
)

select * from Lesson2;

select * from Lesson2 where Sotien_quydoi > POWER(10,6) order by Sotien_quydoi asc;

select * from Lesson2 where Sale_man_address like 'Dak Lak';

select * from Lesson2 where Trans_Time > '2019-06-17' order by Trans_Time desc;

select * 
from 
	Lesson2 
where 
	Sale_man_address like 'Dak Lak' and 
	Trans_Time = '2019-06-17' and 
	Store_ID like 'Store 1'
order by Sotien_quydoi;

select * 
from 
	Lesson2 
where 
	Sotien_quydoi > Power(10,6) and
	Sotien_quydoi <= 5*Power(10,8) and
	Sale_man_ID = '153-07-9313'
order by Sotien_quydoi desc;

select * 
from 
	Lesson2 
where 
	(Sotien_quydoi between power(10,6) and 5*power(10,8)) and
	Sale_man_ID like '153-07-9313' and
	(Store_ID like 'STORE 3' or Store_ID like 'STORE 1')
order by Sotien_quydoi desc;

select * 
from 
	Lesson2 
where 
	(Sotien_quydoi between power(10,6) and 5*power(10,8)) and
	Sale_man_ID like '153-07-9313' and
	(Store_ID in ('STORE 1','STORE 3'))
order by Sotien_quydoi desc;

select distinct Store_ID
from Lesson2
order by Store_ID asc;

select distinct Sale_man_ID, Sale_man
from Lesson2
where
	Trans_Time like '2019-04-20';

select distinct Sale_man_address
from Lesson2;

--lấy ra giao dịch có số tiền nhỏ nhất
select top 1 * from Lesson2 order by Sotien_quydoi asc;
select * from Lesson2 where Sotien_quydoi = (select min(Sotien_quydoi) Sotien_quydoi from Lesson2);

--lấy ra giao dịch có số tiền lớn nhất

select top 1 * from Lesson2 order by Sotien_quydoi desc;
select * 
from 
	Lesson2 
where 
	Sotien_quydoi = 
	(select top 1 Sotien_quydoi 
	from 
		Lesson2 
	order by 
		Sotien_quydoi desc);

select sum(Sotien_quydoi) Sotien_quydoi
from Lesson2
where 
	Trans_time like '2019-04-02'

select max(Sotien_quydoi) Sotien_quydoi
from Lesson2
where 
	Trans_time like '2019-04-02'

select min(Sotien_quydoi) Sotien_quydoi
from Lesson2
where 
	Trans_time like '2019-04-02'

select avg(Sotien_quydoi) Sotien_quydoi
from Lesson2
where 
	Trans_time like '2019-04-02'

select * 
from Lesson2
where
	Ten_Khachhang like 'Lucas%';

select * 
from Lesson2
where
	Ten_Khachhang like '%Garcia';
	
select * 
from Lesson2
where
	Ten_Khachhang like '%Gar%';

select top 5 * from Lesson2 


--lấy tổng số tiền theo từng cửa hàng
select Store_ID, sum(Sotien_nguyente) from MCI_SQL..Lesson2 group by Store_ID order by Store_ID;

--lấy tổng số tiền theo từng mã cửa hàng có loại hàng là Metal Angel, LL Road Pedal, Internal Lock Washer, Hex Nut 11
select Store_ID, sum(Sotien_nguyente) from MCI_SQL..Lesson2 where Loai_hang in ('Metal Angel','LL Road Pedal','Internal Lock Washer','Hex Nut 11') group by Store_ID order by Store_ID;

--Lấy tổng số tiền theo từng mã cửa hàng có loại hàng bắt đầu bằng các chữ cái sau LL, ML, HL 
select Store_ID, Loai_hang, sum(Sotien_nguyente) from MCI_SQL..Lesson2 where Loai_hang like 'LL%' or Loai_hang like 'ML%' or Loai_hang like 'HL%' group by Store_ID,Loai_hang order by Store_ID;

--Lấy tổng số tiền theo từng mã cửa hàng có thời điểm giao dịch vào ngày 20190402 
select Store_ID, sum(Sotien_nguyente) from MCI_SQL..Lesson2 where Trans_Time = '20190402' group by Store_ID order by Store_ID;

--Lấy tổng số tiền theo từng mã cửa hàng có thời điểm giao dịch vào ngày 20190402 của những giao dịch có số tiền > 100 triệu
select Store_ID, sum(Sotien_nguyente) from MCI_SQL..Lesson2 where Trans_Time = '20190402' and Sotien_nguyente > power(10,8) group by Store_ID order by Store_ID;

--Lấy tổng số tiền giao dịch, tổng số tiền chiết khấu, tổng số tiền chậm trả theo từng mã cửa hàng có thời điểm giao dịch vào ngày 20190402 của những loại hàng có tên có từ Frame
select Store_ID, sum(Sotien_nguyente), sum(Muc_chiet_khau), sum(Sotien_cham_tra) from MCI_SQL..Lesson2 where Trans_Time = '20190402' and Loai_hang like '%Frame%' group by Store_ID order by Store_ID;

--Lấy ra số lượng giao dịch theo từng loại khách hàng trong ngày 20190402
select Loai_khachhang, count(Retail_bill) from MCI_SQL..Lesson2 where Trans_Time = '20190402' group by Loai_khachhang order by Loai_khachhang;
select Loai_khachhang, count(*) from MCI_SQL..Lesson2 where Trans_Time = '20190402' group by Loai_khachhang order by Loai_khachhang;

--Lấy ra tổng số tiền giao dịch,số lượng giao dịch theo từng loại khách hàng trong ngày 20190402
select Loai_khachhang, count(Retail_bill), sum(Sotien_nguyente) from MCI_SQL..Lesson2 where Trans_Time = '20190402' group by Loai_khachhang order by Loai_khachhang;

--Lấy ra số tiền giao dịch lớn nhất của từng cửa hàng trong ngày 20190402
select Store_ID, max(Sotien_nguyente) from MCI_SQL..Lesson2 where Trans_Time = '20190402' group by Store_ID order by Store_ID;

--Lấy ra số tiền giao dịch nhỏ nhất của từng cửa hàng trong ngày 20190402
select Store_ID, min(Sotien_nguyente) from MCI_SQL..Lesson2 where Trans_Time = '20190402' group by Store_ID order by Store_ID;

--Lấy ra tổng số tiền giao dịch của từng của hàng và từng nhân viên trong cửa hàng đó
select Store_ID, sum(Sotien_nguyente) from MCI_SQL..Lesson2 group by Store_ID order by Store_ID;
select Store_ID, Sale_man_ID, sum(Sotien_nguyente) from MCI_SQL..Lesson2 group by Store_ID, Sale_man_ID order by Store_ID;

--Lấy ra tổng số tiền giao dịch, Số lượng giao dịch, tổng số tiền hoa hồng (bằng hoa hông * so tien nguyen te / 100) của từng cửa hàng và từng nhân viên trong cửa hàng đó
select Store_ID, sum(Sotien_nguyente), count(retail_bill), sum(Hoa_hong) * sum(Sotien_nguyente)/100 from MCI_SQL..Lesson2 group by Store_ID order by Store_ID;
select top 5 Store_ID, Sale_man_ID, sum(Sotien_nguyente), count(retail_bill), sum(Hoa_hong) * sum(Sotien_nguyente)/100 from MCI_SQL..Lesson2 group by Store_ID,Sale_man_ID order by Store_ID;

--Lấy ra tổng số tiền giao dịch theo từng khách hàng của từng cửa hàng. Chỉ lấy ra những khách hàng có tổng số tiền > 500 triệu
select Store_ID, Ma_khachhang, sum(Sotien_nguyente) from MCI_SQL..Lesson2 group by Store_ID, Ma_khachhang having sum(Sotien_nguyente) > 5*power(10,8) order by 3;

--Lấy ra tổng số tiền giao dịch theo từng khách hàng của từng cửa hàng. Chỉ lấy ra những khách hàng có tổng số tiền > 500 triệu và chỉ lấy các giao dịch của ngày 20190402
select Store_ID, Ma_khachhang, sum(Sotien_nguyente) from MCI_SQL..Lesson2 where Trans_Time = '20190402' group by Store_ID, Ma_khachhang having sum(Sotien_nguyente) > 5*power(10,8) order by 3;

--Lấy ra 10 nhân viên có số tiền giao dịch lớn nhất tại ngày 20190402 của cửa hàng STORE 1
select top 10 Sale_man_ID, sum(Sotien_nguyente) from MCI_SQL..Lesson2 where Trans_Time = '20190402' and Store_ID = 'STORE 1' group by Sale_man_ID order by sum(Sotien_nguyente) desc;

--Lấy ra 10 nhân viên có số tiền giao dịch nhỏ nhất tại ngày 20190402 của cửa hàng STORE 1 có tổng số tiền giao dịch > 500 triệu
select top 10 Sale_man_ID, sum(Sotien_nguyente) from MCI_SQL..Lesson2 where Trans_Time = '20190402' and Store_ID = 'STORE 1' group by Sale_man_ID order by sum(Sotien_nguyente);

--Lấy ra giao dịch của các nhân viên có chữ thứ 2 của tên nhân viên là a
select * from MCI_SQL..Lesson2 where Sale_man like '_a%' group by Sale_man order by Sale_man;

--Lấy ra giao dịch của các nhân viên có chữ thứ 3 của tên nhân viên là c
select * from MCI_SQL..Lesson2 where Sale_man like '__c%' group by Sale_man order by Sale_man;

--Tính tổng số tiền của cửa hàng 1 có thời điểm giao dịch là 20190402 và có địa chỉ nhân viên ở Kontum và
--Tổng số tiền của cửa hàng 3 có địa chỉ nhân viên ở DakNong và Tổng số tiền của cửa hàng 23 có địa chỉ nhân viên ở Đồng Tháp
select Store_ID, Sale_man_address, sum(Sotien_nguyente) from MCI_SQL..Lesson2 where Trans_Time = '20190402' and 
(Sale_man_address = 'Kon tum' and Store_ID = 'Store 1') or 
(Sale_man_address = 'Dak Nong' and Store_ID = 'Store 3') or 
(Sale_man_address = 'Đồng Tháp' and Store_ID = 'Store 23')
group by Store_Id, Sale_man_address order by Store_ID;

--Tính tổng số tiền của các cửa hàng STORE 1, STORE 3, STORE 42 trong các ngày 20190402,20190613,20190618 trong đó mỗi cửa hàng là 1 cột và mỗi ngày là 1 dòng 
select Store_ID, Trans_Time, sum(Sotien_nguyente) from MCI_SQL..Lesson2 where Store_ID in ('Store 1','Store 3','Store 42') and Trans_Time in ('20190402','20190613','20190618') group by Store_ID,Trans_Time;

select * from (select Store_ID, Trans_Time, sum(Sotien_nguyente) as Tong from MCI_SQL..Lesson2 where Store_ID in ('Store 1','Store 3','Store 42') and Trans_Time in ('20190402','20190613','20190618') group by Store_ID, Trans_Time) a
union all
select * from (select Store_ID, Trans_Time, sum(Sotien_nguyente) as Tong from MCI_SQL..Lesson2 where Store_ID in ('Store 1','Store 3','Store 42') and Trans_Time in ('20190402','20190613','20190618') group by Store_ID, Trans_Time) b


select * from 
(select Store_ID, Trans_Time, Sotien_nguyente from MCI_SQL..Lesson2 where Store_ID in ('Store 1','Store 3','Store 42') and Trans_Time in ('20190402','20190613','20190618')) src
pivot
(sum(Sotien_nguyente) for Store_Id in ([Store 1],[Store 3],[Store 42])) piv order by piv.Trans_Time;


--Lấy ra cửa hàng có số tiền giao dịch nhỏ nhất và cửa hàng có số tiền giao dịch lớn nhất
select * from (select top 1 Store_ID, Sotien_nguyente from MCI_SQL..Lesson2 order by Sotien_nguyente) a
union all
select * from (select top 1 Store_ID, Sotien_nguyente from MCI_SQL..Lesson2 order by Sotien_nguyente desc) b
select top 1 Store_ID, max(Sotien_nguyente) from MCI_SQL..Lesson2 group by Store_ID order by 2 desc

-------1. Lấy ra thông tin giao dịch có số tiền lớn nhất trong mỗi cửa hàng----
select top 5 * from Lesson2

select * 
from
	(Select 
		ROW_NUMBER() OVER(PARTITION BY STORE_ID ORDER BY Sotien_nguyente DESC) row_num, *
	from MCI_SQL..Lesson2
	) a
where
	row_num = 1 


select 
	ROW_NUMBER() OVER(ORDER BY Sotien_nguyente DESC) row_num, *
FROM Lesson2

-------2. Lấy ra khách hàng có số tiền giao dịch lớn nhất trong từng cửa hàng----

select *
from
(
	Select 
		ROW_NUMBER() OVER(PARTITION BY Store_ID ORDER BY STGD DESC) row_num, *
	from 
		(select Store_ID, Ma_khachhang, sum(Sotien_nguyente) STGD from Lesson2 group by Store_ID, Ma_khachhang) a
) a
where
	row_num = 1

create table Discount(
	MucToiThieu int,
	MucToiDa int,
	MucChietKhau float,
	DieuKien float,
	LoaiKHToiThieu int
);

delete from Discount

insert into MCI_SQL..Discount (MucToiThieu, MucToiDa, MucChietKhau, DieuKien, LoaiKHToiThieu) values (0,5,0.01,50,3)
insert into MCI_SQL..Discount (MucToiThieu, MucToiDa, MucChietKhau, DieuKien) values (0,5,0.01,50)
insert into MCI_SQL..Discount (MucToiThieu, MucToiDa, MucChietKhau, LoaiKHToiThieu) values (0,5,0.01,3)
insert into MCI_SQL..Discount (MucToiDa, MucChietKhau, LoaiKHToiThieu) values (5,0.01,3)
insert into MCI_SQL..Discount values (0,5,0.01,50,3)
insert into MCI_SQL..Discount (MucToiThieu, MucChietKhau, DieuKien, LoaiKHToiThieu) 
select 0,0.01,50,3

insert into MCI_SQL..Discount (MucToiThieu, MucToiDa, MucChietKhau, DieuKien, LoaiKHToiThieu) 
select top 10
	Loai_khachhang,
	Loai_khachhang,
	Loai_khachhang,
	Loai_khachhang,
	Loai_khachhang
from MCI_SQL..Lesson2

select * from Discount
--update--
update MCI_SQL..Discount set MucToiThieu = 0
update MCI_SQL..Discount set DieuKien = 20 where DieuKien is null

--update  set DieuKien

--delete--
delete MCI_SQL..Discount where LoaiKHToiThieu is null
delete MCI_SQL..Discount where LoaiKHToiThieu = 3 and DieuKien = 50
delete MCI_SQL..Discount

--truncate--
truncate table MCI_SQL..Discount

select * from MCI_SQL..Discount

--câu lệnh bulk insert nếu có dấu phẩy trong dữ liệu, sẽ bị lỗi

select * from MCI_SQL.dbo.Branch
select * from Staff

create table MCI_SQL.dbo.A(
	ID varchar(20),
	Amount float
);

create table MCI_SQL.dbo.B(
	MaCN varchar(20),
	HoaHong float
);


insert into MCI_SQL..A values ('MM100110','20000000')
insert into MCI_SQL..A values ('MM100111','10000000')
insert into MCI_SQL..A values ('MM100112','30000000')

insert into MCI_SQL..B values ('MM100110','50000')
insert into MCI_SQL..B values ('MM100110','20000')
insert into MCI_SQL..B values ('MM100112','40000')
insert into MCI_SQL..B values ('MM100114','45000')

select * into MCI_SQL..Customerv1
from Customer

select 
	CustomerID,
	CustomerName,
	[Address]
into MCI_SQL..CustomerV1
from MCI_SQL..Customer

select distinct CustomerID from Customer

--drop table MCI_SQL..Customerv1

select CustomerID,Address,count(*)
from MCI_SQL..Customer
group by 
	CustomerID, [Address]
having 
	count(*) = 1
order by Address desc

select * 
into CustomerNoDuplicate
from
	(
	select * 
	from
		(Select 
			ROW_NUMBER() OVER(PARTITION BY CustomerID ORDER BY Address DESC) row_num, *
		from MCI_SQL..Customer
		) a
	where
		row_num = 1 
) a

select * from MCI_SQL..Customer where CustomerID = 'MKH810947'
select * from MCI_SQL..CustomerNoDuplicate where CustomerID = 'MKH810947'

--lấy ra khách hàng có giao dịch nhưng ko có tên trong bảng khách hàng
select A.*,B.CustomerName from MCI_SQL..Lesson2 A left join
MCI_SQL..CustomerNoDuplicate B on A.Ma_khachhang = B.CustomerID
where b.CustomerID is null

select * from MCI_SQL..CustomerNoDuplicate where CustomerID = 'MKH648538'
delete from MCI_SQL..CustomerNoDuplicate where CustomerID = 'MKH648538'

--lấy ra KH có giao dịch và có tên trong bảng khách hàng
select A.*,B.CustomerName from MCI_SQL..Lesson2 A left join
MCI_SQL..CustomerNoDuplicate B on A.Ma_khachhang = B.CustomerID
where b.CustomerID is not null

--lấy ra KH có thông tin nhưng ko có giao dịch nào cả
select A.*,B.* from MCI_SQL..Lesson2 A right join
MCI_SQL..CustomerNoDuplicate B on A.Ma_khachhang = B.CustomerID
where a.Ma_khachhang is null

--lấy ra KH có thông tin và có giao dịch
select A.*,B.* from MCI_SQL..Lesson2 A left join
MCI_SQL..CustomerNoDuplicate B on A.Ma_khachhang = B.CustomerID
where a.Ma_khachhang is not null

--tính tổng số tiền theo từng khách hàng có thông tên KH và ĐC
select B.CustomerID, B.Address, sum(Sotien_nguyente) TONGSOTIEN
from MCI_SQL..Lesson2 A left join
MCI_SQL..CustomerNoDuplicate B on A.Ma_khachhang = B.CustomerID
where b.CustomerID is not null
group by B.CustomerID, B.Address
order by 3

--tính tổng só tiền theo từng vùng miền của khách hàng
--theo 3 miền bắc trung nam được giao dịch trong ngày 2/4/2019

select
	case when [Address] in 
		('Hà Nội', 'Quảng Ninh', 'Vĩnh Phúc', 'Bắc Ninh', 'Hải Dương', 'Hải Phòng', 'Hưng Yên', 'Thái Bình',
		'Hà Nam', 'Nam Định', 'Ninh Bình', 'Hà Giang', 'Cao Bằng', 'Lào Cai', 'Bắc Kạn', 'Lạng Sơn', 'Tuyên Quang', 
		'Yên Bái','Thái Nguyên', 'Phú Thọ', 'Bắc Giang', 'Lai Châu', 'Điện Biên', 'Sơn La', 'Hòa Bình') then 'Mien Bac'
		when [Address] in 
		('Bình Phước', 'Bình Dương', 'Đồng Nai', 'Tây Ninh', 'Bà Rịa Vũng Tàu', 'TP Hồ Chí Minh', 'Long An', 'Đồng Tháp',
		'Tiền Giang', 'An Giang', 'Bến Tre', 'Vĩnh Long', 'Trà Vinh', 'Hậu Giang', 'Kiên Giang', 'Sóc Trăng', 'Bạc Liêu',
		'Ca Mau', 'Can Tho') then 'Mien Nam'
		else 'Mien Trung' end as VungMien,
		sum(Sotien_nguyente) TongSoTien
from 
	MCI_SQL..Lesson2 A
	left join MCI_SQL..CustomerNoDuplicate B on A.Ma_khachhang = B.CustomerID
where Trans_Time = '20190402'
group by
	case when [Address] in 
		('Hà Nội', 'Quảng Ninh', 'Vĩnh Phúc', 'Bắc Ninh', 'Hải Dương', 'Hải Phòng', 'Hưng Yên', 'Thái Bình',
		'Hà Nam', 'Nam Định', 'Ninh Bình', 'Hà Giang', 'Cao Bằng', 'Lào Cai', 'Bắc Kạn', 'Lạng Sơn', 'Tuyên Quang', 
		'Yên Bái','Thái Nguyên', 'Phú Thọ', 'Bắc Giang', 'Lai Châu', 'Điện Biên', 'Sơn La', 'Hòa Bình') then 'Mien Bac'
		when [Address] in 
		('Bình Phước', 'Bình Dương', 'Đồng Nai', 'Tây Ninh', 'Bà Rịa Vũng Tàu', 'TP Hồ Chí Minh', 'Long An', 'Đồng Tháp',
		'Tiền Giang', 'An Giang', 'Bến Tre', 'Vĩnh Long', 'Trà Vinh', 'Hậu Giang', 'Kiên Giang', 'Sóc Trăng', 'Bạc Liêu',
		'Ca Mau', 'Can Tho') then 'Mien Nam'
		else 'Mien Trung' end

select distinct [Address] from MCI_SQL..CustomerNoDuplicate


--so sánh số tiền của cửa hàng 1 và 2 theo từng tháng trong năm 2019
select a.THANG, TONGSOTIENSTORE1, TONGSOTIENSTORE2
from
(
select DATEPART(MONTH,Trans_Time) THANG, sum(Sotien_nguyente) TONGSOTIENSTORE1
from MCI_SQL..Lesson2
where Store_ID = 'Store 1' and 
Trans_Time between '20190101' and '20191231'
group by DATEPART(MONTH,Trans_Time)) a

full outer join
(
select DATEPART(MONTH,Trans_Time) THANG, sum(Sotien_nguyente) TONGSOTIENSTORE2
from MCI_SQL..Lesson2
where Store_ID = 'Store 2' and 
Trans_Time between '20190101' and '20191231'
group by DATEPART(MONTH,Trans_Time)) b

on a.THANG = b.THANG

Select
	isnull(a.Ma_khachhang,b.Ma_khachhang) Ma_khachhang,
	isnull(a.Tien2019,0) Tien2019,
	isnull(b.Tien2020,0) Tien2020,
	(isnull(a.Tien2019,0) - isnull(b.Tien2020,0)) Chenhlech,
	c.*
from
	(
		select Ma_khachhang, sum(Sotien_nguyente) Tien2019
		from MCI_SQL..Lesson2
		where Year(Trans_Time) = 2019
		group by Ma_khachhang,year(Trans_Time)
	) a 
full outer join
	(
		select Ma_khachhang, sum(Sotien_nguyente) Tien2020
		from MCI_SQL..Lesson2
		where Year(Trans_Time) = 2020
		group by Ma_khachhang,year(Trans_Time)
	) b
	on a.Ma_khachhang = b.Ma_khachhang
left join MCI_SQL..CustomerNoDuplicate c
on isnull(a.Ma_khachhang,b.Ma_khachhang) = c.CustomerID

--so sánh giao dịch theo từng khách hàng qua các năm 2019, 2020
--có lấy ra thông tin của khách hàng như tên, mã

select 
	A.*, Tong2020, (Tong2019 - Tong2020) ChenhLech
from
	(
		select c.*,Tong2019
		from
		(
			select distinct Ma_khachhang
			from MCI_SQL..Lesson2
		) a 
		left join
		(
			select Ma_khachhang, sum(Sotien_nguyente) Tong2019
			from MCI_SQL..Lesson2
			where Year(Trans_Time) = 2019
			group by Ma_khachhang
		) b
		on a.Ma_khachhang = b.Ma_khachhang
		left join
		(
			select * from MCI_SQL..CustomerNoDuplicate 
		) c
		on a.Ma_khachhang = c.CustomerID
		where CustomerID is not null

	) A										

full outer join
	(
	select c.*, Tong2020
	from
		(
			select distinct Ma_khachhang
			from MCI_SQL..Lesson2
		) a 
		left join
		(
			select Ma_khachhang, sum(Sotien_nguyente) Tong2020
			from MCI_SQL..Lesson2
			where Year(Trans_Time) = 2020
			group by Ma_khachhang
		) b
		on a.Ma_khachhang = b.Ma_khachhang
		left join
		(
			select * from MCI_SQL..CustomerNoDuplicate 
		) c
		on a.Ma_khachhang = c.CustomerID
		where CustomerID is not null
	) B
on A.CustomerID = B.CustomerID
order by 1
