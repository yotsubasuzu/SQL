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

--I. Scalar Function
--1. Tạo hàm hiển thị thứ trong tuần tương ứng với ngày khai báo
go
create function [weekday]
( 
	@day date
)
returns nvarchar(max)
as
begin
	declare @result nvarchar(max)
	declare @nDay int = (select datediff(day,'00010101',@day))
	if @nDay % 7 = 0 set @result = N'Thứ hai'
	else if @nDay % 7 = 1 set @result = N'Thứ ba'
	else if @nDay % 7 = 2 set @result = N'Thứ tư'
	else if @nDay % 7 = 3 set @result = N'Thứ năm'
	else if @nDay % 7 = 4 set @result = N'Thứ sáu'
	else if @nDay % 7 = 5 set @result = N'Thứ bảy'
	else set @result = N'Chủ nhật'
	return @result
end
go
print dbo.[weekday](GETDATE())

--2. Tạo hàm xác định tuổi khách hàng tại ngày đăng ký 
--Table: [KHACHHANG]
--Tham số đầu vào: [NGSINH], [NGDK]
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

--3. Sử dụng hàm viết ra trong câu 1, 2, viết query hiển thị MAKH, TUOI (tại tk đăng ký), 
--BIRTH_WEEKDAY (Sinh vào thứ mấy trong tuần)
--Table: [KHACHHANG]
select MAKH, TUOI_KH, dbo.weekday(NGSINH) Birth_Weekday
from KHACHHANG

--II. Table Function
--1. Tìm thông tin khách hàng mua nhiều sp nhất tại ngày dd/mm/yyyy (biến đầu vào)
--Table: [CTHD], [HOADON], [KHACHHANG]
go
create function func_KHMN(@date date)
returns @table table
(
	MAKH nvarchar(5),
	SOSANPHAM int
)
as 
begin
	insert into @table(MAKH, SOSANPHAM)
	select B.MAKH,count(MASP) SOSANPHAM
	from
		CTHD A full join
		HOADON B on A.SOHD = B.SOHD full join
		KHACHHANG C on B.MAKH = C.MAKH 
	where B.NGHD = @date
	group by B.MAKH
	return
end
go
select * from func_KHMN('20060823')

--2. Tìm số lượng sp theo từng hợp đồng. Trong trường hợp: 
--Biến đầu vào = 0 thì hiển thị SLSP theo từng HĐ
--Biến đầu vào = @SOHD thì hiển SLSP của @SOHD
--Table: [CTHD]
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

--III. IF…ELSE
--1. Nếu SL không có giá trị NULL va SL >= 100 thì in ra màn hình ‘[SOHD] có [SL] sản phẩm’
--Nếu SL không có giá trị NULL và SL < 100 thì in ra màn hình ‘SOHD có SLSP không đạt’
--Nếu SL có giá trị NULL thì in ra màn hình ‘SLSP chưa được ghi nhận’
--Table: [CTHD]
declare @sohd int
declare cur cursor for 
	select distinct SOHD from CTHD
open cur
fetch next from cur into @sohd

while @@FETCH_STATUS = 0
begin
	declare @slsp int
	set @slsp = (select sum(SL) from CTHD where SOHD = @sohd group by SOHD)

	declare @kq nvarchar(max)
	if @slsp is not null and @slsp >= 100
		set @kq = convert(varchar(max),@sohd) + N' có ' +convert(varchar(max),@slsp)+ N' sản phẩm'
	else if @slsp is not null and @slsp <100 
		set @kq = convert(varchar(max),@sohd) + N' có SLSP không đạt'
	else 
		set @kq = N'SLSP chưa được ghi nhận'
	print @kq
	fetch next from cur into @sohd
end
close cur
deallocate cur

--IV. CASE…WHEN
--1. Đánh dấu khách hàng mới cũ theo từng năm
--Table: [HOADON]
--[Image]
select distinct
	A.MAKH, DATEPART(YEAR,NGHD) NAM_HD,
	case when DATEDIFF(YEAR,A.NGHD,'20060101') = 0 then 'New'
		else 'Existing' end 'flag'
from 
	HOADON A full join
	KHACHHANG B on A.MAKH = B.MAKH
order by 1,2,3 desc

--2. Điền trị giá cho HĐ có mã 1200, 1300, 1400, 2000 lần lượt là 1.200.000, 1.300.000, 1.400.000 và 
--1.500.000 - Using CASE in an UPDATE statement
--Table: [HOADON_2] (SELECT * INTO HOADON_2 FROM HOADON)
select *
into HOADON_2
from HOADON 
insert into HOADON_2 (SOHD) values (1200), (1300), (1400), (2000)
update HOADON_2 
set TRIGIA =
case when SOHD = 1200 then 1200000
	when SOHD = 1300 then 1300000
	when SOHD = 1400 then 1400000
	when SOHD = 2000 then 1500000 
	else [TRIGIA] end

select * from HOADON_2

--V. WHILE
--1. Sử dụng vòng lặp để INSERT INTO vào bảng trống theo từng tháng các thông tin sau:
--▪ MONTH: Tháng thống kê
--▪ REVENUE: Doanh số theo tháng
--▪ TENSP: Ten SP bán được số lượng nhiều nhất trong tháng
--▪ SLSP: Số lượng sp bán tương ứng với TENSP
--▪ SP_DOANHSO: Doanh số TENSP bán được nhiều nhất trong tháng
--▪ MAKH: Mã KH có doanh số cao nhất theo tháng
--▪ TENKH: Tên KH có doanh số cao nhất theo tháng
--▪ TUOI: Tuổi KH có doanh số cao nhất theo tháng
--▪ MANV: Mã NV có doanh số cao nhất theo tháng
--▪ TENNV: Tên NV có doanh số cao nhất theo tháng

CREATE TABLE RESULT
(
	[MONTH] NVARCHAR(MAX),
	REVENUE MONEY,
	TENSP NVARCHAR(MAX),
	SLSP INT,
	SP_DOANHSO MONEY,
	MAKH NVARCHAR(MAX),
	TENKH NVARCHAR(MAX),
	TUOI INT,
	MANV NVARCHAR(MAX),
	TENNV NVARCHAR(MAX)
)
DECLARE @TMPTBL TABLE 
(
	[MONTH] NVARCHAR(MAX),
	MASP NVARCHAR(MAX),
	TENSP NVARCHAR(MAX),
	SL INT,
	GIA MONEY,
	MAKH NVARCHAR(MAX),
	HOTENKH NVARCHAR(MAX),
	TUOIKH INT,
	MANV NVARCHAR(MAX),
	HOTENNV NVARCHAR(MAX)
)
INSERT INTO @TMPTBL 
SELECT * 
FROM
(
	SELECT
		dbo.GetMonth(NGHD) [MONTH], A.MASP, E.TENSP, A.SL, E.GIA, B.MAKH, C.HOTEN HOTENKH, C.TUOI_KH, B.MANV, D.HOTEN HOTENNV
	FROM
		CTHD A INNER JOIN
		HOADON B ON A.SOHD = B.SOHD INNER JOIN
		KHACHHANG C ON B.MAKH = C.MAKH INNER JOIN
		NHANVIEN D ON B.MANV = D.MANV INNER JOIN
		SANPHAM E ON A.MASP = E.MASP
) A

DECLARE @MONTH NVARCHAR(MAX)
DECLARE CUR CURSOR FOR
	SELECT DISTINCT [MONTH] FROM @TMPTBL
OPEN CUR
FETCH NEXT FROM CUR INTO @MONTH
WHILE @@FETCH_STATUS = 0
BEGIN
	INSERT INTO RESULT
	SELECT 
		A.[MONTH], A.REVENUE, TENSP, SLSP, B.SP_DOANHSO, MAKH, HOTENKH, TUOIKH, MANV, HOTENNV
	FROM
	(
		SELECT 
			[MONTH], SUM(SL*GIA) REVENUE
		FROM 
			@TMPTBL
		GROUP BY 
			[MONTH]
	) A
	FULL JOIN
	(
		SELECT
			[MONTH], TENSP, SUM(SL) SLSP, SUM(SL*GIA) SP_DOANHSO,
			ROW_NUMBER() OVER (PARTITION BY [MONTH] ORDER BY SUM(SL) DESC) RNSP
		FROM
			@TMPTBL
		GROUP BY [MONTH], TENSP
	) B 
	ON A.[MONTH] = B.[MONTH]
	FULL JOIN
	(
		SELECT 
			*, ROW_NUMBER() OVER (PARTITION BY [MONTH] ORDER BY DOANHSO DESC) RNKH
		FROM
			(
				SELECT 
					[MONTH], MAKH, HOTENKH,TUOIKH, SUM(SL*GIA) DOANHSO 
				FROM 
					@TMPTBL 
				GROUP BY 
					[MONTH], MAKH, HOTENKH,TUOIKH
			) A
	) C 
	ON A.[MONTH] = C.[MONTH]
	FULL JOIN
	(
		SELECT 
			*, ROW_NUMBER() OVER (PARTITION BY [MONTH] ORDER BY DOANHSO DESC) RNNV
		FROM
		(
			SELECT [MONTH], MANV, HOTENNV, SUM(SL*GIA) DOANHSO
			FROM @TMPTBL
			GROUP BY [MONTH], MANV, HOTENNV
		) A
	) D ON A.[MONTH] = D.[MONTH]
	WHERE 
		RNSP = 1 AND RNKH = 1 AND RNNV = 1 AND A.[MONTH] = @MONTH
	FETCH NEXT FROM CUR INTO @MONTH
END
CLOSE CUR
DEALLOCATE CUR
SELECT * FROM RESULT
DELETE FROM RESULT