USE QLBH

SELECT * FROM CTHD
SELECT * FROM HOADON
SELECT * FROM KHACHHANG
SELECT * FROM NHANVIEN
SELECT * FROM SANPHAM


--******** VÍ DỤ: TẠO TRIGGER CẬP NHẬT DỮ LIỆU WAREHOUSE KHI MÀ THÔNG TIN HỢP ĐỒNG ĐƯỢC CẬP NHẬT TRONG BẢNG CTHD (XUẤT/NHẬP HÀNG TỒN) ********
SELECT DISTINCT MASP, 50 AS QUANTITY INTO WAREHOUSE_REMAINING
FROM CTHD

SELECT * FROM WAREHOUSE_REMAINING --- BẢNG CHỨA SL SẢN PHẨM TỒN KHO
SELECT * FROM CTHD --- BẢNG CHỨA THÔNG SẢN PHẨM ĐƯỢC BÁN RA

--- HIỆN TẠI TRONG KHO HÀNG TƯƠNG ỨNG MỖI MASP, TỒN KHO 50 SP
SELECT * FROM WAREHOUSE_REMAINING
SELECT * FROM CTHD

---- 1. ----
--DELETE FROM CTHD WHERE SOHD = 1300
---- 2. ----
--UPDATE WAREHOUSE_REMAINING
--SET QUANTITY = 50 WHERE QUANTITY IS NOT NULL
---- 3. ----




---- I. SQL ĐỘNG ----
---- 1. SỬ DỤNG EXEC()
---- VÍ DỤ 1: SQL ĐỘNG
go
declare @sql nvarchar(max)
set @sql = 'select * from CTHD'
exec(@sql)


---- VÍ DỤ 2: THẾM GIÁ TRỊ VÀO CHUỖI SQL ĐỘNG
go
declare @sql nvarchar(max), @sohd nvarchar(max)
set @sohd = 1001
set @sql = 'select * from CTHD where SOHD = '+@sohd
exec(@sql)

---- VÍ DỤ 3: SỬ DỤNG SQL ĐỘNG TRONG PROCEDURE
---- VÍ DỤ: TẠO PROCEDURE VỚI BIẾN @VAR, TRONG TH @VAR = 1 THÌ TRẢ RA TOÀN BỘ THÔNG TIN BẢNG CTHD
---- TRONG TH @VAR = 2 THÌ TRẢ RA TOÀN BỘ THÔNG TIN BẢNG HOADON
go
declare @sql nvarchar(max), @var nvarchar
set @var = 2
if @var = 1
	set @sql = 'select * from CTHD'
else 
	if @var = 2
		set @sql = 'select * from HOADON'
exec(@sql)


---- 2. SỬ DỤNG SP_EXECUTESQL()
---- VÍ DỤ 1: CẤU TRÚC
---- SP_EXECUTESQL(@[CHUỖI SQL ĐỘNG], @[KHAI BÁO DS BIẾN TRONG CHUỖI SQL ĐỘNG], @[TỪNG BIẾN TRONG DS BIẾN ĐƯỢC KHAI BÁO])
go
declare @sql nvarchar(max)
set @sql = 'select * from CTHD where SOHD = @SOHD and MASP = @MASP'
declare @params nvarchar(max)
set @params = '@SOHD int, @MASP nvarchar(max)'

exec SP_EXECUTESQL @SQL, @PARAMS, @SOHD = 1001, @MASP = 'BC01'

--VD: tạo procedure chứa biến @SOHD, @MAKH, @MANV, để hiển thị thông tin HOADON tương ứng
--nội dung procedure có sử dụng SP_EXECUTESQL
go
create procedure dynamicSQL1 @sohd nvarchar(max), @makh nvarchar(max), @manv nvarchar(max)
as
begin
	declare @SQL nvarchar(max) = 'select * from HOADON where SOHD = @sohd and MAKH = @makh and MANV = @manv'
	declare @params nvarchar(max) = '@sohd int, @makh nvarchar(max), @manv nvarchar(max)'
	exec SP_EXECUTESQL @SQL, @PARAMS, @SOHD, @MAKH, @MANV
end

exec dynamicSQL1 1001, 'KH01', 'NV01'

---- VÍ DỤ: TẠO PROCEDURE TƯƠNG TỰ KHÔNG SỬ DỤNG SP_EXECUTESQL
go
declare @SOHD nvarchar(max) = 1001, @MAKH nvarchar(max) = 'KH01', @MANV nvarchar(max) = 'NV01'
declare @SQL nvarchar(max) = 'select * from HOADON where SOHD = '+@sohd+' and MAKH = '''+@makh+''' and MANV = '''+@manv+''''
exec(@SQL)

--- EXAMPLE 1: Viet vong loop de kiem tra so dong cua cac bang trong db TEST tai ngay hom nay
SELECT * FROM SYS.TABLES where name in ('CTHD', 'HOADON', 'KHACHHANG', 'NHANVIEN', 'SANPHAM') --- DANH SÁCH BẢNG TRONG SQL SERVER
SELECT * FROM SYS.COLUMNS --- DANH SÁCH CỘT TRONG SQL SERVER
go
declare cur cursor for
	SELECT name FROM SYS.TABLES where name in ('CTHD', 'HOADON', 'KHACHHANG', 'NHANVIEN', 'SANPHAM')
open cur 
declare @tablename nvarchar(max)
fetch next from cur into @tablename
while @@FETCH_STATUS = 0
begin
	declare @sql nvarchar(max) = 'select '''+@tablename+''' BANG, count(*) SODONG from '+@tablename
	exec(@sql)
	fetch next from cur into @tablename
end
close cur
deallocate cur

go
declare cur cursor for
	select name from sys.tables where name in ('CTHD','HOADON','KHACHHANG','NHANVIEN','SANPHAM')
open cur
declare @tablename nvarchar(max)
fetch next from cur into @tablename
while @@FETCH_STATUS = 0
begin
	declare @sql nvarchar(max)
	set @sql = 
	'
	declare @SODONG nvarchar(max)
	set @SODONG = (select count(*) from ' +@tablename+')

	declare @kq nvarchar(max)
	set @kq = ''BANG '+@tablename+' CO ''+@SODONG+'' DONG''

	print @kq
	'
	exec(@sql)
	fetch next from cur into @tablename
end
close cur
deallocate cur



--- EXAMPLE 2: Kiem tra so luong gia tri NULL tung cot trong bang CTHD
SELECT * FROM SYS.TABLES
SELECT * FROM SYS.COLUMNS WHERE OBJECT_ID = 245575913




---- 3. BÀI TẬP: SỬ DỤNG TRUY VẤN ĐỘNG THÊM DÒNG TỪ BẢNG CTHD VÀO BẢNG TRỐNG CTHD_2 ----


---- II. PIVOT TABLE ----
---- VÍ DỤ 1: CÓ THỂ ĐƯA RA KẾT QUẢ GIỐNG GROUP BY
select *
into #BANGTAM
from CTHD
where SOHD in (1001, 1002)

---BANG OUTPUT
select *
from #BANGTAM

select [1001], [1002] 
from (select SOHD, SL from #BANGTAM) A
pivot
(
	sum(SL)
	for SOHD in ([1001],[1002])
) A 

----VÍ DỤ: sử dụng pivot tạo bảng output: [MAKH], [NV01], [NV02], [NV03], 
select [MAKH], ISNULL([NV01],0) NV01, ISNULL([NV02],0) NV02, ISNULL([NV03],0)NV03
from 
(
	select MAKH, MANV, TRIGIA
	from HOADON
) a
pivot
(
	sum(TRIGIA)
	for MANV in ([NV01],[NV02],[NV03])
) a
--where MAKH = 'KH01'

--Cách 2:
select MAKH,
sum(case when MANV = 'NV01' then TRIGIA else 0 end) NV01,
sum(case when MANV = 'NV02' then TRIGIA else 0 end) NV02,
sum(case when MANV = 'NV03' then TRIGIA else 0 end) NV03
into #BANG1
from HOADON
group by MAKH

----
select
sum(case when SOHD = 1001 then SL else 0 end) [1001],
sum(case when SOHD = 1002 then SL else 0 end) [1002]
from #BANGTAM

---- VÍ DỤ 2: WITH DAT AS (), SỬA ĐỔI TÊN CỘT HIỂN THỊ


---- VÍ DỤ 3: TÍNH SỐ LƯỢNG MASP SẢN XUẤT TỪ SINGAPORE, THAILAN, TRUNGQUOC, USA, VIETNAM THEO MỖI LOẠI CẶP TENSP, DVT


---- III. UNPIVOT ----
---- VÍ DỤ 1: UNPIVOT VÍ DỤ 2 MỤC II
select * 
from #BANG1

select [MAKH], ISNULL([NV01],0) NV01, ISNULL([NV02],0) NV02, ISNULL([NV03],0)NV03
from 
(
	select MAKH, MANV, TRIGIA
	from HOADON
) a
pivot
(
	sum(TRIGIA)
	for MANV in ([NV01],[NV02],[NV03])
) a
----
select MAKH, MANV, TRIGIA 
from 
(
	select MAKH, NV01, NV02, NV03 from #BANG1
) a
unpivot
(
	TRIGIA
	for MANV in ([NV01],[NV02],[NV03])
) a

---- VÍ DỤ 2: UNPIVOT VÍ DỤ 1 MỤC II
with DAT as
(
	select
	sum(case when SOHD = 1001 then SL else 0 end) [1001],
	sum(case when SOHD = 1002 then SL else 0 end) [1002]
	from #BANGTAM
)
select SOHD, SL
from DAT
unpivot 
(
	SL
	for SOHD in ([1001],[1002])
) a


---- III. PIVOT TABLE - NÂNG CAO ----
---- VÍ DỤ 1: ----
