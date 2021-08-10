--ví dụ: sử dụng vòng lặp hiển thị thông báo N'[MAKH] và [MANV] ĐEM LẠI DOANH SỐ [TRIGIA]'
go
declare cur cursor for
	select distinct MAKH, MANV from HOADON where MAKH is not null
open cur
declare @makh nvarchar(max), @manv nvarchar(max)
fetch next from cur into @makh, @manv

while @@FETCH_STATUS = 0
begin
	declare @trigia nvarchar(max)
	select @trigia = sum(trigia) from HOADON where MAKH = @makh and MANV = @manv

	declare @kq nvarchar(max)
	set @kq = @makh +N' và '+ @manv +N' đem lại doanh số ' +@trigia
	print @kq
	fetch next from cur into @makh, @manv
end
close cur
deallocate cur
go
--cách 2: ko dùng cursor
set nocount on
declare @makh nvarchar(max), @manv nvarchar(max), @stt int = 1
while @stt > 0
begin
	declare @table table(
		MAKH nvarchar(max), 
		MANV nvarchar(max),
		STT int
	)
	insert into @table
	select MAKH, MANV, DENSE_RANK() OVER (ORDER BY MAKH,MANV) STT
	from HOADON 
	where MAKH is not null
	--select * from @table
	if exists (select * from @table where STT = @stt) 
		begin
			select @makh = MAKH, @manv = MANV from @table where STT = @stt
			declare @trigia nvarchar(max) = (select sum(TRIGIA) from HOADON where MAKH = @makh and MANV = @manv)
			declare @kq nvarchar(max)
			set @kq = @makh +N' và '+ @manv +N' đem lại doanh số ' +@trigia
			print @kq
			set @stt += 1
		end
	else
		break
end
go

--Ví dụ:
--nếu SL >= 100 thì in ra màn hình '[SOHD] có [SL] sản phẩm'
--nếu SL < 100 thì in ra màn hình 'SOHD có SLSP không đạt'
--nếu SL có giá trị null thì in ra màn hình 'phát hiện có giá trị SL chưa được ghi nhận'
create procedure check_SOHD (@sohd nvarchar(max))
as
begin
declare @slsp int
set @slsp = (select sum(SL) from CTHD where SOHD = @sohd)
if exists (select * from CTHD where SOHD = @sohd and SL is null)
	print @sohd + N' phát hiện có giá trị SL chưa được ghi nhận'
else
	if @slsp >= 100
		print @sohd + ' có ' + convert(varchar(max),@slsp) + N' sản phẩm'
	else
		print @sohd + N' có SLSP không đạt'
end

exec check_SOHD 1010
insert into CTHD(SOHD, MASP) values (1026, 'BB01')
select * from CTHD
go

----1. đánh dấu khách hàng mới cũ theo từng năm
select 
	MAKH,
	NAM_HD,
	case when ROW_NUMBER() over (partition by MAKH order by NAM_HD) = 1 then 'New'
		else 'Existing' end Flag
from 
	(
		select distinct 
			MAKH, YEAR(NGHD) NAM_HD
		from HOADON
		where MAKH is not null
	) a


