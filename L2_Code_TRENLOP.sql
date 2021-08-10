USE [QLBH]

SELECT * from [dbo].[CTHD] --- [SOHD, MASP]: Pri key, MASP, SL
SELECT * from [dbo].[HOADON] --- [SOHD]: Pri key [MAKH, MANV]: Foreign Key, NGHD, MAKH, MANV, TRIGIA
SELECT * from [dbo].[KHACHHANG] --- [MAKH]: Pri key, HOTEN, DCHI, SODT, NGSINH, NGDK, DOANHSO
SELECT * from [dbo].[NHANVIEN] --- [MANV]: Pri key, HOTEN, SODT, NGVL
SELECT * from [dbo].[SANPHAM] --- [MASP]: Pri key, TENSP, DVT, NUOCSX, GIA

---- BTVN - STORED PROCEDURE
---- 1. TẠO THỦ TỤC LẤY RA TÊN NHÂN VIÊN CÓ DOANH SỐ CAO NHẤT THEO THÁNG ?



---- 2. TẠO THỦ TỤC XÁC ĐỊNH MASP CÓ SLSP BIẾN ĐỘNG LỚN NHẤT/NHỎ NHẤT GIỮA GIỮA 2 THỜI ĐIỂM @DATE1, @DATE2



---- I. FUNCTIONS ----
---- A. SCALAR FUNCTIONS ----
------- EXAMPLE 2: Tinh tong 2 so -------
go
CREATE FUNCTION [dbo].[Tong_2_So]
(
    @param1 float,
	@param2 float
)
RETURNS FLOAT
AS
BEGIN

    RETURN @param1 + @param2

END
go
--drop function dbo.Tong_2_So
print dbo.Tong_2_So (15.7,6.2)

--ví dụ: tạo scalar function get_age(@date1, @date2) để tính toán tuổi của khách hàng
go
create function get_age
(
	@date1 date,
	@date2 date
)
returns int
as
begin
	return datediff(YEAR, @date2, @date1)
end
go

alter table KHACHHANG
add Tuoi_KH int

update KHACHHANG 
set TUOI_KH = DBO.get_age(NGDK,NGSINH)

select * from KHACHHANG
go

------- EXAMPLE 2: TẠO FUNCTION DE TRA RA KET QUA LA YYYYMM VỚI BIẾN TRUYỀN VÀO CÓ ĐỊNH DẠNG DATETIME
------- VD: '2006-07-23 00:00:00' -> 200607
SELECT * FROM HOADON
--SELECT NGHD, DBO.GET_MONTH(NGHD) AS MONTHID FROM HOADON
go
create function [dbo].GetMonth
(
	@date datetime
)
returns nvarchar(6)
as
begin
	return format(@date, 'yyyyMM')
end
go
print dbo.GetMonth('2006-09-03 00:00:00')
go

---- A. TABLE-VALUED FUNCTIONS ----
---- TABLE-VALUED FUNCTION KHÔNG CÓ BIẾN
CREATE FUNCTION [dbo].GETCTHD()
RETURNS TABLE AS RETURN
(
    SELECT * FROM CTHD
)
go


 --- KHÔNG CẦN DBO.
--WHERE NUOCSX = 'VIET NAM'
select * 
from GETCTHD()
where MASP = 'TV07'

----- EXAMPLE 1: TAO HAM DE HIEN THI BANG THONG TIN CHO TUNG TENSP
----- TABLE: SANPHAM
SELECT * FROM SANPHAM
----
go
create function GET_TENSP(@tensp nvarchar(max))
returns table
as
return
(
	select * from SANPHAM
	where TENSP = @tensp
)
go
select * from GET_TENSP('but chi')

----- EXAMPLE 2: TAO HAM DE HIEN THI DANH SACH CAC HD CO TONG SO LUONG SP > GIA TRI NHAT DINH
----- TABLE: CTHD
go
create function get_hd(@var int)
returns table as
return
(
	select SOHD
	from CTHD 
	group by SOHD
	having sum(SL) > @var
)
--drop function get_hd
go
select * from get_hd(30)

--cách 2: sử dụng biến kiểu bảng
create function get_sohd(@sl int)
returns @table1 table
(
	SOHD int
)
as
begin
	--if can be used here
	insert into @table1(SOHD)
	select SOHD from CTHD
	group by SOHD
	having sum(SL) > @sl

	return 
end
----- EXAMPLE 3: TAO HÀM HIỂN THỊ MAKH MUA NHIEU HON n SAN PHAM, sử dụng biến kiểu bảng
go
create function makhmua (@a int)
returns @table table
(
	makh varchar(5)
)
as
begin
	insert into @table(makh)
	select makh
	from 
		cthd a full join
		hoadon b on a.sohd = b.sohd
	where makh is not null
	group by makh
	having count(masp) > @a

	return
end
go

select * from MAKHmua (3)


----- KHÁI NIỆM BIẾN KIỂU BẢNG -----------
---- KHAI BÁO BIẾN
---- INSERT INTO = SET ---- TRUYỀN GIÁ TRỊ CHO BIẾN
---- SELECT * FROM = PRINT ---- HIỂN THỊ GIÁ TRỊ BIẾN

---- VI DỤ: TẠO BIẾN KIỂU BẢNG CHỨA DANH SÁCH MAKH TRONG BẢNG HOADON



----- #### TABLE-VALUED FUNCTION SỬ DỤNG BIẾN KIỂU BẢNG ####
----- EXAMPLE 4: TAO HAM DE HIEN THI DANH SACH CAC HD CO TONG SO LUONG SP > GIA TRI NHAT DINH
----- TABLE: CTHD


----- PHÂN BIỆT SCALAR VÀ TABLE_VALUED FUNCTION
----- 1. SCALAR: dbo.
----- + TRẢ RA KẾT QUẢ DUY NHẤT CÓ ĐỊNH DẠNG KÝ TỰ, SỐ, NGÀY,...
----- + SỬ DỤNG SAU MỆNH ĐỀ SELECT, TRƯỚC MỆNH ĐỀ FROM HOẶC SAU MỆNH ĐỀ WHERE
----- + ĐỐI TƯỢNG TÁC ĐỘNG LÊN LÀ CỘT CỦA BẢNG
----- 2. TABLE-VALUED: ko can dbo.
----- + TRẢ RA KẾT QUẢ LÀ BẢNG
----- + SỬ DỤNG SAU MỆNH ĐỀ FROM GIỐNG NHƯ BẢNG THÔNG THƯỜNG


---- II. IF/ELSE ----
------- A. CHI CO IF -------
---- 1. NEU A > B THI HIEN THI N'Đúng'
go
if 'A' < 'B' 
	print N'Đúng'
else 
	print 'Sai'

if 2 > 1
	print '2 > 1'

------- B. IF...ELSE -------
---- 1. Neu A > B thi hien thi N'Đúng', nguoc lai là N'Sai'
if 6>=5
	print N'Lớn hơn hoặc bằng 5'
else if 6 <= 3
	print N'Nhỏ hơn hoặc bằng 3'
else
	print N'Bằng 4'

if 6 >= 5
	print N'Lớn hơn hoặc bằng 5'
if 6 <= 3
	print N'Nhỏ hơn hoặc bằng 3'
else
	print N'Bằng 4'

---- 2. SỬ DỤNG IF/ELSE VỚI BIẾN
declare @input int = 6
if @input>=5
	print N'Lớn hơn hoặc bằng 5'
else if @input <= 3
	print N'Nhỏ hơn hoặc bằng 3'
else
	print N'Bằng 4'


------- C. IF...ELSE lồng nhau -------
---- 1. CHECK XEM GIÁ TRỊ NHẬP VÀO LÀ SỐ NGUYÊN HAY SỐ THẬP PHÂN ?
---- TẠO PROCEDURE
go
create procedure test_number (@number float)
as
begin
	if @number < convert(int,@number) + 1 and @number > convert(int,@number)
		print N'Đây là số thập phân.'
	else
		print N'Đây là số nguyên.'
end
go
exec test_number 16

---- TẠO SCALAR FUNCTION
go
create function [dbo].func_test_number 
(
	@number float
)
returns nvarchar(max)
as
begin
	declare @kq nvarchar(max)
	if @number < convert(int,@number) + 1 and @number > convert(int,@number)
		set @kq = N'Đây là số thập phân.'
	else
		set @kq = N'Đây là số nguyên.'
	return @kq
end
go

print dbo.func_test_number (16.5)


---- 2. Check xem gia tri nhap vao la so nguyen duong chia het cho 3 hay khong ?
---- CÓ 3 TRƯỜNG HỢP: N'GIÁ TRỊ NHẬP VÀO KHÔNG PHẢI LÀ SỐ NGUYÊN', N'GIÁ TRỊ NHẬP VÀO LÀ SỐ NGUYÊN DƯƠNG CHIA HẾT CHO 3'
---- , N'GIÁ TRỊ NHẬP VÀO KHÔNG LÀ SỐ NGUYÊN DƯƠNG CHIA HẾT CHO 3'
go
create function func_test_number 
(
	@a float
)
returns nvarchar(max)
as
begin
	declare @result nvarchar(max)
	if @a % 1 = 0
		if @a % 3 = 0
			set @result = N'GIÁ TRỊ NHẬP VÀO LÀ SỐ NGUYÊN DƯƠNG CHIA HẾT CHO 3'
		else
			set @result = N'GIÁ TRỊ NHẬP VÀO LÀ SỐ NGUYÊN DƯƠNG KHÔNG CHIA HẾT CHO 3'
	else
		set @result = N'GIÁ TRỊ NHẬP VÀO KHÔNG PHẢI LÀ SỐ NGUYÊN'
	return @result
end
go

---- VÍ DỤ: TẠO TABLE-VALUED FUNCTION BIẾN KIỂU BẢNG VÀ IF/ELSE
----Ví dụ: tạo table-valued function chứa biến @SOHD, @var thỏa mãn
----@var = 0 @SOHD = N'Không có' -> trả ra toàn bộ dữ liệu bảng CTHD
----@var = 1 -> trả ra dữ liệu của SOHD = @SOHD trong bảng CTHD
go
create function func_table_valued_1 (@var int, @SOHD nvarchar(max))
returns @table table
(
	SOHD int,
	MASP varchar(4),
	SL int
)
as
begin
	if @var = 0 and @SOHD = N'Không có'
		insert into @table (SOHD, MASP, SL)
		select * from CTHD
	else if @var = 1 and @SOHD != N'Không có'
		insert into @table(SOHD, MASP, SL)
		select * from CTHD where SOHD = @SOHD
	return
end
go

select * from func_table_valued_1 (1,1001)

------- III. VONG LAP WHILE -------
------- EXAMPLE 1: Tinh tong tu 1-10 -------
DECLARE @Number INT = 1
DECLARE @Total INT = 0

WHILE @Number <= 10
BEGIN
	SET @Total = @Total + @Number
	SET @Number = @Number + 1
	SELECT @TOTAL AS TOTAL, @NUMBER AS NUMBER
END
PRINT @TOTAL
GO

------- EXAMPLE 2: Tinh tong tu 1-10, sử dụng BREAK -------
declare @a int = 1
declare @total int = 0
while @a <= 20
begin
	set @total += @a
	set @a += 1
	if @a = 11
		break
end
print @total
go
------- EXAMPLE 3: Tinh tong tu 1-10, sử dụng CONTINUE -------
declare @a int = 1
declare @total int = 0
while @a <= 11
begin
	if @a = 11
		begin
		set @a += 1
		continue
		end
	set @total += @a
	set @a += 1
end
print @total

--###### ĐỐI VỚI CHUỖI BAO GỒM CÁC GIÁ TRỊ LÀ KÝ TỰ ######--
-- CÁCH 1: SỬ DỤNG BIẾN CON TRỎ CURSOR
------- EXAMPLE 4: Thong ke so luong sp ban ra voi tung MASP -------
------- HIỂN THỊ DÒNG THÔNG BÁO N'[MASP] BÁN ĐƯỢC [SLSP] SẢN PHẨM'
go
select 
	MASP, sum(SL) SLSP
from
	CTHD
group by MASP
------
declare @masp nvarchar(max) 
declare cur cursor for --khai báo biến con trỏ
	select distinct MASP from CTHD --danh sách cần đưa vào vòng lặp
open cur --kích hoạt biến con trỏ
fetch next from cur into @masp -- đưa giá trị đầu tiên trong danh sách vào biến @masp

while @@FETCH_STATUS = 0 --điều kiện mặc định, trường hợp con trỏ vẫn gắp được dữ liệu
begin
	---nội dung từng bước trong vòng lặp
	declare @slsp int 
	set @slsp = (select sum(SL) from CTHD where MASP = @masp)

	declare @kq nvarchar(max)
	set @kq = @masp+N' bán được ' +convert(nvarchar(max),@slsp)+ N' sản phẩm.'
	print @kq
	fetch next from cur into @masp --cập nhật giá trị mới cho biến @masp
end
close cur --đóng biến con trỏ
deallocate cur -- xóa bỏ biến con trỏ
go

--in ra màn hình thông báo '[MANV] đem lại doanh số [TRIGIA] cho cửa hàng'
declare @manv nvarchar(max) 
declare cur cursor for --khai báo biến con trỏ
	select distinct MANV from HOADON --danh sách cần đưa vào vòng lặp
open cur --kích hoạt biến con trỏ
fetch next from cur into @manv -- đưa giá trị đầu tiên trong danh sách vào biến @masp

while @@FETCH_STATUS = 0 --điều kiện mặc định, trường hợp con trỏ vẫn gắp được dữ liệu
begin
	---nội dung từng bước trong vòng lặp
	declare @trigia int 
	set @trigia = (select sum(TRIGIA) from HOADON where MANV = @manv)

	declare @kq nvarchar(max)
	set @kq = @manv+N' đem lại ' +convert(nvarchar(max),@trigia)+ N' cho cửa hàng.'
	print @kq
	fetch next from cur into @manv --cập nhật giá trị mới cho biến @masp
end
close cur --đóng biến con trỏ
deallocate cur -- xóa bỏ biến con trỏ


-- CÁCH 2: SỬ DỤNG BIẾN DANH SÁCH VÀ LẶP THEO TỪNG DÒNG, KHÔNG SỬ DỤNG CURSOR
--Gợi ý: đánh stt cho từng phần tử trong ds lặp
go
declare @masp nvarchar(max), @stt int =1
while @stt > 0
begin
	declare @table table(
		SOHD int, 
		MASP nvarchar(5), 
		SL int,
		STT int
	)
	insert into @table(SOHD,MASP,SL,STT)
	select *, DENSE_RANK() OVER (ORDER BY MASP) 'STT'
	from CTHD 
	if exists (select * from @table where STT = @stt) 
		begin
			set @masp = (select distinct MASP from @table where STT = @stt)
			declare @slsp int = (select sum(SL) from CTHD where MASP = @masp)
			declare @kq nvarchar(max)
			set @kq = @masp+N' bán được ' +convert(nvarchar(max),@slsp)+ N' sản phẩm.'
			print @kq
			set @stt += 1
		end
	else
		break
end
go

