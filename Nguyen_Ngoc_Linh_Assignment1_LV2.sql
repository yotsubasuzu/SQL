--Sử dụng các bảng sau để tạo thủ tục yêu cầu như bên dưới:

use[QLBH]
select * from KHACHHANG
select * from[dbo].[CTHD] 
---[SOHD, MASP]: Pri key, SL: so luong

select * from[dbo].[HOADON] 
---[SOHD]: Prikey [MAKH, MANV]: Foreign Key, NGHD: Ngay hop dong, TRIGIA: gia tri HD

select * from[dbo].[NHANVIEN] 
---[MANV]: Pri key, HOTEN: Ten nhan vien, SODT: So dien thoai cua nv---, NGVL: Ngay bat dau lam viec

select * from[dbo].[SANPHAM] 
---[MASP]: Pri key, TENSP: Ten san pham, DVT: Don vi tinh, NUOCSX: Noi sanxuat---, GIA: gia thanh sp
go
--1. TẠO THỦ TỤC LẤY RA TÊN NHÂN VIÊN CÓ DOANH SỐ CAO NHẤT THEO NGÀY ?
create proc TenNVcoDSmax @thang int
as
begin
	declare @tennv nvarchar(max)
	set @tennv =
	(
		select 
			top 1 B.HOTEN
		from 
			HOADON A left join
			NHANVIEN B
			on A.MANV = B.MANV
		where
			format(A.NGHD, 'yyyyMM') = @thang
		group by
			B.HOTEN
		order by sum(A.TRIGIA) desc
	)
	print @tennv
end
--drop proc TenNVcoDSmax
exec TenNVcoDSmax 200701
go
--2. TẠO THỦ TỤC THỐNG KÊ DOANH SỐ BÁN HÀNG TRONG THÁNG THEO MAKH TẠI NGÀY CUỐI CÙNG CỦA THÁNG. 
--TRONG ĐÓ PHÂN LOẠI KH NEW VÀ KH OLD TRONG NĂM 2006. 
--(BIẾT RẰNG NGAYDK <= NGAYHD, KH MỚI LÀ KH CÓ LỊCH SỬ MUA HÀNG LẦN ĐẦU TIÊN)

--tạo bảng HOADON_NEW với tình trạng cũ mới của khách hàng
CREATE TABLE [dbo].[HOADON_NEW](
	[SOHD] [int] NOT NULL,
	[NGHD] [smalldatetime] NULL,
	[MAKH] [varchar](4) NULL,
	[MANV] [varchar](4) NULL,
	[TRIGIA] [money] NULL,
	[CU_MOI] varchar(5) null
)
declare @sohd int = 1001
declare @sohdcuoi int = (select top 1 SOHD from HOADON where DATEPART(YEAR,NGHD) = 2006 order by SOHD desc)
while @sohd <= @sohdcuoi
begin
	insert into HOADON_NEW 
	select *,
	case when MaKH in (select MAKH from HOADON where NGHD < (select NGHD from HOADON where SOHD = @sohd)) then 'CU'
		else 'MOI' end CU_MOI
	from HOADON 
	where SOHD = @sohd 
	set @sohd += 1
end
insert into HOADON_NEW
select *,'' from HOADON where SOHD > @sohd

select * from HOADON_NEW
--delete from HOADON_NEW
go
--tạo procedure
create proc TKDSTrongThangTheoMKH @makh nvarchar(5)
as
begin
	select 
		THANG, MAKH, DOANHSO, CU_MOI
	from
	(
		select 
			case when DATEPART(MONTH,B.NGHD) = 2 then CONVERT(date,FORMAT(B.NGHD,'yyyy-MM') + '-28')
				when DATEPART(MONTH,B.NGHD) in (1,3,5,7,8,10,12) then CONVERT(date,FORMAT(B.NGHD,'yyyy-MM') + '-31')
				else CONVERT(date,FORMAT(B.NGHD,'yyyy-MM') + '-30') end THANG, 
			B.MAKH, sum(A.SL * C.GIA) DOANHSO, B.CU_MOI
		from 
			CTHD A left join
			HOADON_NEW B on A.SOHD = B.SOHD left join
			SANPHAM C on A.MASP = C.MASP left join
			KHACHHANG D on B.MAKH = D.MAKH
		where
			B.MAKH is not null
		group by
			case when DATEPART(MONTH,B.NGHD) = 2 then CONVERT(date,FORMAT(B.NGHD,'yyyy-MM') + '-28')
				when DATEPART(MONTH,B.NGHD) in (1,3,5,7,8,10,12) then CONVERT(date,FORMAT(B.NGHD,'yyyy-MM') + '-31')
				else CONVERT(date,FORMAT(B.NGHD,'yyyy-MM') + '-30') end, 
			B.MAKH, B.CU_MOI
		having sum(A.SL * C.GIA) is not null
	) a
	where MAKH = @makh
	order by THANG
end

exec TKDSTrongThangTheoMKH 'kh03'
go


--3. TẠO THỦ TỤC TÍNH HOA HỒNG CHO TỪNG NHÂN VIÊN TRONG THÁNG BIẾT RẰNG COMMISION RATE NHƯ SAU:
--BÁN CÁC SP TỪ VN > COMMISION RATE 10%
--BÁN CÁC SP TỪ TQ > COMMISION RATE 12 %
--BÁN CÁC SP OTHER COUNTRIES > COMMISION RATE 8%
create proc TinhHoaHong @thang nvarchar(10)
as
begin
	select 
		THANG, MANV, sum(THANHTIEN) TONGDOANHSO, CONVERT(int,sum(THANHTIEN * COMMISIONRATE)) HOAHONG
	from
	(
		select 
			FORMAT(B.NGHD, 'yyyyMM') THANG, MANV, A.MASP, NUOCSX, SL*GIA THANHTIEN,
			case when NUOCSX = 'Viet Nam' then 0.1
				when NUOCSX = 'Trung Quoc' then 0.12
				else 0.8 end COMMISIONRATE
		from
			CTHD A left join
			HOADON B on A.SOHD = B.SOHD left join
			SANPHAM C on A.MASP = C.MASP
	) a
	where
		THANG = @thang
	group by 
		THANG, MANV
	having
		CONVERT(int,sum(THANHTIEN * COMMISIONRATE)) is not null
	order by THANG, MANV
end

exec TinhHoaHong '200608'

--4. TẠO THỦ TỤC TÍNH TOP 3 SP BIẾN ĐỘNG SL MAX/MIN GIỮA CÁC NGÀY
--select * from HOADON
--select * from SANPHAM
--select * from CTHD
--insert into HOADON(SOHD, NGHD, MAKH, MANV) values
--(111,'20210606','KH01','NV01'),
--(112,'20210607','KH02','NV02')
--insert into CTHD(SOHD, MASP, SL) values
--(111,'BB01',20),(111,'BB02',50),(111,'BB03',10),(111,'BB06',5),
--(111,'BC01',20),(111,'BC02',50),(111,'BC03',10),(111,'BC04',5),
--(112,'BB01',21),(112,'BB02',52),(112,'BB03',13),(112,'BB06',10),
--(112,'BC01',30),(112,'BC02',70),(112,'BC03',40),(112,'BC04',50)
--delete from HOADON where SOHD in (111,112)
--delete from CTHD where SOHD in (111,112)
go
--biến kiểu bảng
declare @table table
(
	SOHD int, 
	MASP nvarchar(5), 
	SL int
)

insert into @table(SOHD, MASP, SL)
select * from CTHD

select * from @table
go
--VD: In giá trị biến kiểu bảng chứa dữ liệu bao gồm cột SOHD, TRIGIA trong bảng HOADON
declare @table table(
	SOHD int,
	TRIGIA int
)
insert into @table(SOHD, TRIGIA)
select SOHD, TRIGIA from HOADON
select * from @table

go
create procedure TopSPBienDong @thang1 int, @thang2 int
as
begin
	SET NOCOUNT ON
	declare @table table (
		THANG int,
		MASANPHAM nvarchar(5),
		SOLUONG1 int,
		SOLUONG2 int,
		BIENDONG int
	)
	insert into @table(THANG, MASANPHAM, SOLUONG1, SOLUONG2, BIENDONG)
	select *
	from
	(
		select 
			ISNULL(A.THANG, B.THANG) THANG,
			ISNULL(A.MASP, B.MASP) MASANPHAM,
			ISNULL(A.SOLUONG1,0) SOLUONG1,
			ISNULL(B.SOLUONG2,0) SOLUONG2,
			(ISNULL(B.SOLUONG2,0) - ISNULL(A.SOLUONG1,0)) BIENDONG
		from
		(
			select format(B.NGHD,'yyyyMM') THANG, MASP, sum(SL) SOLUONG1
			from
				CTHD A full join
				HOADON B on A.SOHD = B.SOHD
			where 
				format(B.NGHD,'yyyyMM') = 200607
			group by 
				format(B.NGHD,'yyyyMM'), MASP
		) A
		full join
		(
			select format(B.NGHD,'yyyyMM') THANG, MASP, sum(SL) SOLUONG2
			from
				CTHD A full join
				HOADON B on A.SOHD = B.SOHD
			where 
				format(B.NGHD,'yyyyMM') = 200610
			group by 
				format(B.NGHD,'yyyyMM'), MASP
		) B
		on A.MASP = B.MASP
	) a

	declare @maspmin nvarchar(5), @maspmax nvarchar(5), @slmin int, @slmax int
	set @maspmin = (select top 1 MASANPHAM from @table order by BIENDONG)
	set @slmin = (select top 1 BIENDONG from @table order by BIENDONG)
	set @maspmax = (select top 1 MASANPHAM from @table order by BIENDONG desc)
	set @slmax = (select top 1 BIENDONG from @table order by BIENDONG desc)

	print @maspmin + N' biến động thấp nhất là '+convert(nvarchar(max),@slmin)+N' sản phẩm'
	print @maspmax + N' biến động nhiều nhất là '+convert(nvarchar(max),@slmax)+N' sản phẩm'
end

--drop proc TopSPBienDong
exec TopSPBienDong 200607,200610
