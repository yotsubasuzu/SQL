--create table MCI_SQL..A (
--	MaCN varchar(50),
--	Amount float
--)


--create table MCI_SQL..B (
--	MaCN varchar(50),
--	HoaHong float
--)

--insert into MCI_SQL..A values ('MM100110','20000000')
--insert into MCI_SQL..A values ('MM100111','10000000')
--insert into MCI_SQL..A values ('MM100112','30000000')

--insert into MCI_SQL..B values ('MM100110','50000')
--insert into MCI_SQL..B values ('MM100110','20000')
--insert into MCI_SQL..B values ('MM100112','40000')
--insert into MCI_SQL..B values ('MM100114','45000')


--select * from MCI_SQL..A
--select * from MCI_SQL..B

--select * 
--from MCI_SQL..A a left join
--	MCI_SQL..B b on a.MaCN = b.MaCN

--select * 
--from MCI_SQL..B b left join
--	MCI_SQL..A a on b.MaCN = a.MaCN

--select * 
--from MCI_SQL..A a right join
--	MCI_SQL..B b on a.MaCN = b.MaCN

--select * 
--from MCI_SQL..B b right join
--	MCI_SQL..A a on b.MaCN = a.MaCN

--select * 
--from MCI_SQL..A a inner join
--	MCI_SQL..B b on a.MaCN = b.MaCN

--select * 
--from MCI_SQL..B a inner join
--	MCI_SQL..a b on b.MaCN = a.MaCN

--select * 
--from MCI_SQL..A a cross join
--	MCI_SQL..B b 

--select * from MCI_SQL..A
--select * from MCI_SQL..B


--create table MCI_SQL..PhongBan (
--	ID int,
--	USERNAME nvarchar(50),
--	DEPARTMENT_NAME  nvarchar(50),
--	MANAGER_ID nvarchar(50)
--)

--insert into MCI_SQL..PhongBan values (1,'PHÙNG','IT','1')
--insert into MCI_SQL..PhongBan values (2,'CHUNG','SALES','2')
--insert into MCI_SQL..PhongBan values (3,'TÌNH','SALES','2')
--insert into MCI_SQL..PhongBan values (4,'HÒA','SALES','2')
--insert into MCI_SQL..PhongBan values (5,'HÀ','IT','1')

--drop table MCI_SQL..PhongBan

--select * from MCI_SQL..PhongBan

--SELECT 
--	a.ID, 
--	a.USERNAME, 
--	a.DEPARTMENT_NAME, 
--	b.USERNAME AS MANAGER_NAME
--FROM MCI_SQL..PhongBan AS a JOIN 
--	MCI_SQL..PhongBan AS b ON a.MANAGER_ID = b.ID

--SELECT 
--	a.ID, 
--	a.USERNAME, 
--	a.DEPARTMENT_NAME, 
--	b.USERNAME AS MANAGER_NAME
--FROM MCI_SQL..PhongBan AS a JOIN 
--	MCI_SQL..PhongBan AS b ON a.ID = b.MANAGER_ID


------------Lấy ra tên khách hàng trong mỗi giao dịch----------

select count(*)--a.*,b.CustomerName
from MCI_SQL..Lesson2 a left join
	MCI_SQL..Customer b on a.Ma_khachhang = b.CustomerID

select count(*)
from MCI_SQL..Lesson2


select CustomerID,count(*)
from MCI_SQL..Customer
group by 
	CustomerID
having 
	count(*) >= 2

select * from MCI_SQL..Customer where CustomerID = 'MKH870854'

----------Lấy ra khách hàng có giao dịch nhưng không có tên trong bảng khách hàng--------------

----------Lấy ra khách hàng có giao dịch và có tên trong bảng khách hàng--------------

delete from MCI_SQL..Customer where CustomerID = 'MKH648538'

select a.*,b.CustomerName
from MCI_SQL..Lesson2 a left join
	MCI_SQL..Customer b on a.Ma_khachhang = b.CustomerID
where
	b.CustomerID is not null



----------Lấy ra khách hàng có thông tin nhưng không có giao dịch--------------

select a.*,b.CustomerName
from MCI_SQL..Lesson2 a right join
	MCI_SQL..Customer b on a.Ma_khachhang = b.CustomerID
where
	Ma_khachhang is null

----------Chỉ Lấy ra khách hàng có thông tin và có giao dịch--------------


select a.*,b.CustomerName
from MCI_SQL..Lesson2 a inner join
	MCI_SQL..Customer b on a.Ma_khachhang = b.CustomerID


----------Tính tổng số tiền theo từng khách hàng có thông tin tên khách hàng và địa chỉ khách hàng--------------

select a.Ma_khachhang,b.[Address],sum(Sotien_nguyente) Sotien_nguyente
from MCI_SQL..Lesson2 a left join
	MCI_SQL..Customer b on a.Ma_khachhang = b.CustomerID
where
	b.CustomerID is not null
group by
	a.Ma_khachhang,b.[Address]

----------Tính tổng số tiền theo từng khách hàng có thông tin tên khách hàng và địa chỉ khách hàng, Email khách hàng--------------

select a.Ma_khachhang,b.[Address],Email,sum(Sotien_nguyente) Sotien_nguyente
from MCI_SQL..Lesson2 a left join
	MCI_SQL..Customer b on a.Ma_khachhang = b.CustomerID
where
	b.CustomerID is not null
group by
	a.Ma_khachhang,b.[Address],Email

----------Tính tổng số tiền theo từng vùng miền của khách hàng theo 3 miền bắc trung nam được giao dịch trong ngày 02-04-2019--------------

select 
	a.Ma_khachhang,
	case when b.[Address] in ('An Giang','Bạc Liêu') then 'MienNam'
		else 'Others' end [Address],
		sum(Sotien_nguyente) Sotien_nguyente
from MCI_SQL..Lesson2 a left join
	MCI_SQL..Customer b on a.Ma_khachhang = b.CustomerID
where
	b.CustomerID is not null and Trans_Time = '02-04-2019'
group by
	a.Ma_khachhang,
	case when b.[Address] in ('An Giang','Bạc Liêu') then 'MienNam'
		else 'Others' end 


------------Lấy tổng số tiền của nhân viên có giao dịch trong ngày 02-04-2019, thông tin nhân viên phải có đủ tên, ngày vào công ty hệ và hệ số lương--------

create table NhanVien (
	stt int,
	ten nvarchar(100),
	KyHieu nvarchar(100),
	MaNhanVien nvarchar(100),
	NgayVaoCongTy date,
	HeSoLuong int
)

select * from MCI_SQL..Staff

select 
	a.Sale_man_ID,
	Sale_man,
	b.NgayVaoCongTy,
	b.HeSoLuong,
	sum(Sotien_nguyente) Sotien_nguyente
from MCI_SQL..Lesson2 a left join
	MCI_SQL..Staff b on a.Sale_man_ID = b.MaNhanVien
where
	Trans_Time = '02-04-2019'
group by
	a.Sale_man_ID,
	Sale_man,
	b.NgayVaoCongTy,
	b.HeSoLuong

------------Lấy tổng số tiền của nhân viên có giao dịch trong ngày 02-04-2019 và vào công ty năm 2019--------

select 
	a.Sale_man_ID,
	Sale_man,
	b.NgayVaoCongTy,
	sum(Sotien_nguyente) Sotien_nguyente
from MCI_SQL..Lesson2 a left join
	MCI_SQL..Staff b on a.Sale_man_ID = b.MaNhanVien
where
	Trans_Time = '02-04-2019' and DATEPART(YEAR,NgayVaoCongTy) = '2019'
group by
	a.Sale_man_ID,
	Sale_man,
	b.NgayVaoCongTy

------------Lấy tổng số tiền các nhân viên và nhóm theo năm vào công ty từ 2016 - 2019 --------

select 
	a.Sale_man_ID,
	Sale_man,
	DATEPART(YEAR,NgayVaoCongTy) NgayVaoCongTy,
	sum(Sotien_nguyente) Sotien_nguyente
from MCI_SQL..Lesson2 a left join
	MCI_SQL..Staff b on a.Sale_man_ID = b.MaNhanVien
where
	Trans_Time = '02-04-2019' and DATEPART(YEAR,NgayVaoCongTy) >= 2016 and DATEPART(YEAR,NgayVaoCongTy) <= 2019
group by
	a.Sale_man_ID,
	Sale_man,
	DATEPART(YEAR,NgayVaoCongTy)

------------Lấy thông tin giao dịch có thông tin địa điểm của hàng, thông tin tên khách hàng --------
--create table MCI_SQL..CuaHang (
--	MaCuaHang varchar(20),
--	DiaDiem nvarchar(100),
--	QuanLy nvarchar(100)
--)

select * from MCI_SQL..Branch

select 
	*
from MCI_SQL..Lesson2 a left join
	MCI_SQL..Customer b on a.Ma_khachhang = b.CustomerID left join
	MCI_SQL..Branch c on a.Store_ID = c.MaCuaHang
	
	
	----BTVN
------------Lấy thông tin giao dịch có thông tin địa điểm của hàng, thông tin email và số điện thoại khách hàng, và tỷ giá tại ngày đó --------
select * from MCI_SQL..Branch
select * from MCI_SQL..Customer
select * from MCI_SQL..TYGIA
select * from MCI_SQL..Lesson2
select * from MCI_SQL..Staff

select *
from 
	MCI_SQL..Lesson2 A inner join --Thông tin giao dịch, bỏ những giao dịch ko có tt đđ cửa hàng
	MCI_SQL..Branch B on A.Store_ID = B.MaCuaHang inner join --những cửa hàng có giao dịch
	MCI_SQL..Customer C on A.Ma_khachhang = C.CustomerID inner join --những khách có giao dịch
	MCI_SQL..TYGIA D on A.Trans_Time = D.Ngày --tỷ giá của ngày có giao dịch

------------Tạo ra bảng dữ liệu danh sách giao dịch trong tháng 4 năm 2019 --------
select * 
from
	MCI_SQL..Lesson2 A left join
	MCI_SQL..Branch B on A.Store_ID = B.MaCuaHang left join
	MCI_SQL..Staff C on A.Sale_man_ID = C.MaNhanVien left join
	MCI_SQL..Customer D on A.Ma_khachhang = D.CustomerID left join
	MCI_SQL..TYGIA E on A.Trans_Time = E.Ngày
where
	Trans_Time between '20190401' and '20190430'
order by 2


------------Tạo ra bảng dữ liệu danh sách giao dịch trong tháng 6 năm 2019 --------
select * 
from
	MCI_SQL..Lesson2 A left join
	MCI_SQL..Branch B on A.Store_ID = B.MaCuaHang left join
	MCI_SQL..Staff C on A.Sale_man_ID = C.MaNhanVien left join
	MCI_SQL..Customer D on A.Ma_khachhang = D.CustomerID left join
	MCI_SQL..TYGIA E on A.Trans_Time = E.Ngày
where
	Trans_Time between '20190601' and '20190630'
order by 2


------------Tìm những nhân viên có giao dịch trong tháng 4-2019 nhưng không giao dịch trong tháng 6 năm 2019 từ 2 bảng vừa được tạo trên--------
select distinct
	a.Trans_Time, a.Sale_man, a.Sale_man_ID, a.Sale_man_address
from
(
select * 
from
	MCI_SQL..Lesson2 A left join
	MCI_SQL..Branch B on A.Store_ID = B.MaCuaHang left join
	MCI_SQL..Staff C on A.Sale_man_ID = C.MaNhanVien left join
	MCI_SQL..Customer D on A.Ma_khachhang = D.CustomerID left join
	MCI_SQL..TYGIA E on A.Trans_Time = E.Ngày
where
	Trans_Time between '20190401' and '20190430'
) a
left join
(
select * 
from
	MCI_SQL..Lesson2 A left join
	MCI_SQL..Branch B on A.Store_ID = B.MaCuaHang left join
	MCI_SQL..Staff C on A.Sale_man_ID = C.MaNhanVien left join
	MCI_SQL..Customer D on A.Ma_khachhang = D.CustomerID left join
	MCI_SQL..TYGIA E on A.Trans_Time = E.Ngày
where
	Trans_Time between '20190601' and '20190630'
) b
on a.Sale_man_ID = b.Sale_man_ID
order by 1

----------Tìm danh sách khách hàng có mua hàng trong cả tháng 4 và tháng 6 từ 2 bảng vừa được tạo trên-------------
select distinct
	a.Ma_khachhang, a.Ten_khachhang, a.Address--, a.Trans_Time, b.Trans_Time
from
(
select * 
from
	MCI_SQL..Lesson2 A left join
	MCI_SQL..Branch B on A.Store_ID = B.MaCuaHang left join
	MCI_SQL..Staff C on A.Sale_man_ID = C.MaNhanVien left join
	MCI_SQL..Customer D on A.Ma_khachhang = D.CustomerID left join
	MCI_SQL..TYGIA E on A.Trans_Time = E.Ngày
where
	Trans_Time between '20190401' and '20190430'
) a
inner join
(
select *
from
	MCI_SQL..Lesson2 A left join
	MCI_SQL..Branch B on A.Store_ID = B.MaCuaHang left join
	MCI_SQL..Staff C on A.Sale_man_ID = C.MaNhanVien left join
	MCI_SQL..Customer D on A.Ma_khachhang = D.CustomerID left join
	MCI_SQL..TYGIA E on A.Trans_Time = E.Ngày
where
	Trans_Time between '20190601' and '20190630'
) b
on a.Ma_khachhang = b.Ma_khachhang
order by 1

--TEST
select distinct
	a.Ma_khachhang--, a.Trans_Time, b.Trans_Time
from
(
select Trans_Time,Ma_Khachhang 
from MCI_SQL..Lesson2
where Trans_Time between '20190401' and '20190430' ) a
--order by 2
inner join
(
select Trans_Time,Ma_Khachhang
from MCI_SQL..Lesson2
where Trans_Time between '20190601' and '20190630' ) b
--order by 2
on a.Ma_khachhang = b.Ma_khachhang

----------Tìm danh sách khách hàng có mua hàng trong tháng 4 nhưng không mua trong tháng 6 và ngược lại  từ 2 bảng vừa được tạo trên-------------
--Có mua tháng 4 nhưng không mua tháng 6
select distinct
	a.Ma_khachhang, a.Ten_khachhang, a.Address--, a.Trans_Time, b.Trans_Time
from
(
select * 
from
	MCI_SQL..Lesson2 A left join		
	MCI_SQL..Branch B on A.Store_ID = B.MaCuaHang left join
	MCI_SQL..Staff C on A.Sale_man_ID = C.MaNhanVien left join
	MCI_SQL..Customer D on A.Ma_khachhang = D.CustomerID left join
	MCI_SQL..TYGIA E on A.Trans_Time = E.Ngày
where
	Trans_Time between '20190401' and '20190430'
) a
left join
(
select *
from
	MCI_SQL..Lesson2 A left join
	MCI_SQL..Branch B on A.Store_ID = B.MaCuaHang left join
	MCI_SQL..Staff C on A.Sale_man_ID = C.MaNhanVien left join
	MCI_SQL..Customer D on A.Ma_khachhang = D.CustomerID left join
	MCI_SQL..TYGIA E on A.Trans_Time = E.Ngày
where
	Trans_Time between '20190601' and '20190630'
) b
on a.Ma_khachhang = b.Ma_khachhang
order by 1

--Có mua tháng 6 nhưng ko mua tháng 4
select distinct
	a.Ma_khachhang, a.Ten_khachhang, a.Address--, a.Trans_Time, b.Trans_Time
from
(
select * 
from
	MCI_SQL..Lesson2 A left join
	MCI_SQL..Branch B on A.Store_ID = B.MaCuaHang left join
	MCI_SQL..Staff C on A.Sale_man_ID = C.MaNhanVien left join
	MCI_SQL..Customer D on A.Ma_khachhang = D.CustomerID left join
	MCI_SQL..TYGIA E on A.Trans_Time = E.Ngày
where
	Trans_Time between '20190401' and '20190430'
) a
right join
(
select *
from
	MCI_SQL..Lesson2 A left join
	MCI_SQL..Branch B on A.Store_ID = B.MaCuaHang left join
	MCI_SQL..Staff C on A.Sale_man_ID = C.MaNhanVien left join
	MCI_SQL..Customer D on A.Ma_khachhang = D.CustomerID left join
	MCI_SQL..TYGIA E on A.Trans_Time = E.Ngày
where
	Trans_Time between '20190601' and '20190630'
) b
on a.Ma_khachhang = b.Ma_khachhang
order by 1

----------So sánh số tiền giao dịch của từng nhân viên trong tháng 4 và tháng 6-------------
select 
	A.Sale_man_ID, Tongt4, Tongt6, (Tongt6 - TongT4) ChenhLech
from
	(
		select a.Sale_man_ID, Tongt6
		from
		(
			select distinct Sale_man_ID
			from MCI_SQL..Lesson2
		) a 
		left join
		(
			select Sale_man_ID, sum(Sotien_nguyente) Tongt6
			from MCI_SQL..Lesson2
			where Trans_Time between '20190601' and '20190630'
			group by Sale_man_ID
		) b
		on a.Sale_man_ID = b.Sale_man_ID
	) A

full outer join
	(
	select a.Sale_man_ID, Tongt4
	from
		(
			select distinct Sale_man_ID
			from MCI_SQL..Lesson2
		) a 
		left join
		(
			select Sale_man_ID, sum(Sotien_nguyente) Tongt4
			from MCI_SQL..Lesson2
			where Trans_Time between '20190401' and '20190430'
			group by Sale_man_ID
		) b
		on a.Sale_man_ID = b.Sale_man_ID
	) B

	on A.Sale_man_ID = B.Sale_man_ID
	order by 4 desc

--TEST 
select Sale_man_ID, sum(Sotien_nguyente) TONG
from MCI_SQL..Lesson2
where Sale_man_ID = '043-05-7011' and
Trans_Time between '20190401' and '20190430'
group by Sale_man_ID

----------So sánh số tiền mua hàng của từng khách hàng trong tháng 4 và tháng 6-------------
select 
	A.Ma_khachhang, Tongt4, Tongt6, (Tongt6 - TongT4) ChenhLech
from
	(
		select a.Ma_khachhang, Tongt6
		from
		(
			select distinct Ma_khachhang -- Bản khách hàng có giao dịch trong tháng, phân biệt
			from MCI_SQL..Lesson2
		) a 
		left join
		(
			select Ma_khachhang, sum(Sotien_nguyente) Tongt6 --Tổng số tiền giao dịch của từng khách, nối vào bảng khách phân biệt
			from MCI_SQL..Lesson2
			where Trans_Time between '20190601' and '20190630'
			group by Ma_khachhang
		) b
		on a.Ma_khachhang = b.Ma_khachhang
	) A										-- được bảng từng khách có giao dịch trong tháng 6

full outer join
	(
	select a.Ma_khachhang, Tongt4
	from
		(
			select distinct Ma_khachhang
			from MCI_SQL..Lesson2
		) a 
		left join
		(
			select Ma_khachhang, sum(Sotien_nguyente) Tongt4
			from MCI_SQL..Lesson2
			where Trans_Time between '20190401' and '20190430'
			group by Ma_khachhang
		) b
		on a.Ma_khachhang = b.Ma_khachhang
	) B

	on A.Ma_khachhang = B.Ma_khachhang
	order by 4 desc
