---- 1. DATABASE - QLBH_1004_TEST
use [QLBH]
select * from [dbo].[CTHD] --- [SOHD, MASP]: Pri key
select * from [dbo].[HOADON] --- [SOHD]: Pri key [MAKH, MANV]: Foreign Key
select * from [dbo].[KHACHHANG] --- [MAKH]: Pri key
select * from [dbo].[NHANVIEN] --- [MANV]: Pri key
select * from [dbo].[SANPHAM] --- [MASP]: Pri key

--ví dụ: thống kê masp bán đc doanh số lớn nhất (SL*GIA) bởi từng mãnv theo từng tháng

select THANG, MANV, MASP, TENSP, DOANHSO
from 
(
	select FORMAT(NGHD,'yyyyMM') THANG, A.MANV, C.MASP,C.TENSP, sum(B.SL*C.GIA) DOANHSO,
	ROW_NUMBER() OVER(PARTITION BY FORMAT(NGHD,'yyyyMM'), A.MANV ORDER BY sum(B.SL*C.GIA) desc) rownumber
	from 
		HOADON A full outer join
		CTHD B on A.SOHD = B.SOHD full outer join
		SANPHAM C on B.MASP = C.MASP
	where
		MANV is not null and C.MASP is not null
	group by
		FORMAT(NGHD,'yyyyMM'), A.MANV, C.MASP,C.TENSP,B.SL*C.GIA
) a
where rownumber = 1


--- 1. Tạo Store Procedure
--- 1.1 Tạo bằng SQL Server Management Studio (SSMS)
------- Screenshot

go
--- 1.2 Tạo bằng SQL Server Management Studio (SSMS)
--- 1.2.1 Tạo procedure không truyền tham số
create proc TEST1 
as
begin
	select * from CTHD
end
go

--- THỰC THI PROCEDURE
exec TEST1
go

--- THAY ĐỔI NỘI DUNG PROCEDURE
alter proc test1
as
begin
	select *
	into CTHD_BK
	from CTHD

	select * from CTHD_BK
end
go

exec test1
--- TRAO QUYỀN EXECUTE CHO USER TEST3
--- DONE

--- XÓA BỎ PROCEDURE
drop proc test1
go

---- BIẾN TRONG SQL SERVER
declare @var nvarchar(max) 

---- TRUYỀN GIÁ TRỊ CHO BIẾN THÔNG QUA SET, SELECT, EXECUTE
set @var = 'abc'
print @var
go
---- SELECT
declare @var nvarchar(max) 
select @var = sum(SL) from CTHD --lấy giá trị cuối cùng
print @var
go
---- EXECUTE


--SELECT TRIGIA FROM HOADON

----- VÍ DỤ: TẠO THỦ TỤC TÍNH TỔNG 2 SỐ
create proc Tong2So (@var1 float, @var2 float)
as
begin
	print @var1 + @var2
end

exec Tong2So 123.23,12343.43012
go
---- VÍ DỤ: TÍNH TỔNG 3 SỐ 1, 2, 3 TỪ PROCEDURE TONG_2_SO KẾT HỢP VỚI CÁC MỆNH ĐỀ KHÁC NẾU CÓ
--- TÍNH TỔNG 2 SỐ BẤT KỲ 1, 2 => 3 -> TÍNH TIẾP TỔNG 3, 3


---- MỆNH ĐỀ RETURN TRONG PROCEDURE SẼ CHỈ TRẢ RA KẾT QUẢ LÀ SỐ NGUYÊN INT
CREATE PROC Test3
	@LENH int
AS 
BEGIN   
	IF (@Lenh = 1)
		RETURN 1  
	IF (@Lenh = 2)
	BEGIN
		DECLARE @FLOAT FLOAT
		SET @FLOAT = 2.6
		RETURN @FLOAT --- MỆNH ĐỀ RETURN CHỈ TRẢ GIÁ TRỊ LÀ INT
	END --- MỆNH ĐỂ BEGIN...END ĐỂ NGĂN CÁCH CÁC CÂU QUERY ĐỘC LẬP

	IF (@Lenh = 3)
	BEGIN
		DECLARE @CHAR varchar(50)
		SET @CHAR = 'hello'
		RETURN @CHAR
	END
END  
GO
------
DECLARE @VAR NVARCHAR(MAX)
EXEC @VAR = TEST3 @LENH = 3
PRINT @VAR
go
---- VÍ DỤ: TẠO PROCEDURE ĐỂ HIỂN THỊ SOHD CO TRIGIA TRONG KHOANG TU @VAR1 VA @VAR2
---- TABLE: HOADON
create proc HienThiSoHD @var1 int, @var2 int
as
begin
	select SOHD from HOADON where TRIGIA between @var1 and @var2
end
go
exec HienThiSoHD 100000, 200000
--- TRUYỀN GIÁ TRỊ THAM SỐ VÀO CHUỖI STRING
declare @NAME nvarchar(max)
set @NAME = 1123

declare @HELLO nvarchar(max)
set @HELLO = 'HELLO ' + CONVERT(nvarchar,@NAME) + '!'
print @HELLO


go
--- VÍ DỤ: TẠO PROCEDURE TÍNH TOÁN TỔNG DOANH SỐ GIỮA 2 THỜI ĐIỂM
--- TABLE: HOADON
create proc TinhTongDS @var1 date, @var2 date
as
begin
	declare @KQ float
	select @KQ = 
	(
		select sum(TRIGIA) TONGDOANHSO
		from HOADON
		where NGHD between @var1 and @var2
	)
	print @KQ
end
go
exec TinhTongDS '20060101' , '20061231'

--- 1.6.1 THAM SỐ CHỨA KQ ĐẦU RA


--- TƯƠNG TỰ VỚI



--- VÍ DỤ: TẠO THỦ TỤC LẤY RA 2 LOẠI SẢN PHẨM CÓ DOANH SỐ CAO NHẤT VÀ 2 LOẠI SẢN PHẨM 
--- CÓ DOANH SỐ THẤP NHẤT TRONG THÁNG
--- DOANH SỐ = SL*GIA
--- 1 BIẾN @THANG HOẶC 2 BIẾN @THANG, @NAM
--- BẢNG KQ:
--- THANG:
--- MASP:
--- DOANH_SO:
--- LABEL: 'CAO NHAT', 'THAP NHAT'
--- TẠO BẢNG TRỐNG ĐỂ CHỨA DỮ LIỆU CHẠY TỪ PROCEDURE
--- 200607, 'BB01', 100000, 'THAP NHAT'
SELECT * FROM CTHD --- SOHD, MASP, SL
SELECT * FROM HOADON --- SOHD, NGHD
SELECT * FROM SANPHAM --- MASP, GIA

--- BƯỚC 1: VIẾT CÂU QUERY ĐỂ LẤY DANH SÁCH 2 MASP DOANH SỐ CAO NHẤT TRONG THÁNG 10/2006

select *
from
(
	select 
		FORMAT(NGHD, 'yyyyMM') THANG, A.MASP, sum(A.SL * C.GIA) DOANHSO,
		ROW_NUMBER() OVER (PARTITION BY FORMAT(NGHD, 'yyyyMM') ORDER BY sum(A.SL * C.GIA) desc) RN
	from
		CTHD A full outer join
		HOADON B on A.SOHD = B.SOHD full outer join
		SANPHAM C on A.MASP = C.MASP
	where FORMAT(NGHD, 'yyyyMM') = '200610'
	group by FORMAT(NGHD, 'yyyyMM'), A.MASP
) a
where RN <= 2

--- BƯỚC 2: VIẾT CÂU QUERY ĐỂ LẤY DANH SÁCH 2 MASP DOANH SỐ THẤP NHẤT TRONG THÁNG 10/2006
select *
from
(
	select 
		FORMAT(NGHD, 'yyyyMM') THANG, A.MASP, sum(A.SL * C.GIA) DOANHSO,
		ROW_NUMBER() OVER (PARTITION BY FORMAT(NGHD, 'yyyyMM') ORDER BY sum(A.SL * C.GIA)) RN
	from
		CTHD A full outer join
		HOADON B on A.SOHD = B.SOHD full outer join
		SANPHAM C on A.MASP = C.MASP
	where FORMAT(NGHD, 'yyyyMM') = '200610'
	group by FORMAT(NGHD, 'yyyyMM'), A.MASP
) a
where RN <= 2

--- BƯỚC 3: TẠO BẢNG ĐỂ CHỨA KẾT QUẢ THỐNG KÊ
create table BANG_KQ(
	THANG nvarchar(max),
	MASP nvarchar(max),
	DOANHSO float,
	[LABEL] nvarchar(max)
);

--- BƯỚC 4: TẠO PROCEDURE
create proc DanhSach2MaSP @var1 nvarchar(max)
as
begin
	insert into BANG_KQ 
	select * from
	(
		select THANG, MASP, DOANHSO, 'CAO NHAT' [LABEL]
		from
		(
			select 
				FORMAT(NGHD, 'yyyyMM') THANG, A.MASP, sum(A.SL * C.GIA) DOANHSO,
				ROW_NUMBER() OVER (PARTITION BY FORMAT(NGHD, 'yyyyMM') ORDER BY sum(A.SL * C.GIA) desc) RN
			from
				CTHD A full outer join
				HOADON B on A.SOHD = B.SOHD full outer join
				SANPHAM C on A.MASP = C.MASP
			where FORMAT(NGHD, 'yyyyMM') = @var1
			group by FORMAT(NGHD, 'yyyyMM'), A.MASP
		) a
		where RN <= 2
	) a

	insert into BANG_KQ
	select * 
	from
	(
		select THANG, MASP, DOANHSO, 'THAP NHAT' [LABEL]
		from
		(
			select 
				FORMAT(NGHD, 'yyyyMM') THANG, A.MASP, sum(A.SL * C.GIA) DOANHSO,
				ROW_NUMBER() OVER (PARTITION BY FORMAT(NGHD, 'yyyyMM') ORDER BY sum(A.SL * C.GIA)) RN
			from
				CTHD A full outer join
				HOADON B on A.SOHD = B.SOHD full outer join
				SANPHAM C on A.MASP = C.MASP
			where FORMAT(NGHD, 'yyyyMM') = @var1
			group by FORMAT(NGHD, 'yyyyMM'), A.MASP
		) a
		where RN <= 2
	) a
end

exec DanhSach2MaSP '200607'
select * from BANG_KQ
drop proc DanhSach2MaSP