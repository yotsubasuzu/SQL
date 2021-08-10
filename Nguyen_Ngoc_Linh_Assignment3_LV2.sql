--******** VÍ DỤ: TẠO TRIGGER CẬP NHẬT DỮ LIỆU WAREHOUSE KHI MÀ THÔNG TIN HỢP ĐỒNG ĐƯỢC CẬP NHẬT TRONG BẢNG CTHD (XUẤT/NHẬP HÀNG TỒN) ********
go
select distinct MASP, (200 - SL) QUANTITY into WAREHOUSE_REMAINING
from 
(
	select MASP, sum(SL) SL
	from CTHD
	group by MASP
) a
--drop table WAREHOUSE_REMAINING
SELECT * FROM WAREHOUSE_REMAINING --- BẢNG CHỨA SL SẢN PHẨM TỒN KHO
SELECT * FROM CTHD --- BẢNG CHỨA THÔNG SẢN PHẨM ĐƯỢC BÁN RA

--- HIỆN TẠI TRONG KHO HÀNG TƯƠNG ỨNG MỖI MASP, TỒN KHO 50 SP
SELECT * FROM WAREHOUSE_REMAINING
SELECT * FROM CTHD

---- 1. ----
--DELETE FROM CTHD WHERE SOHD = 1300
go
create trigger trg_delHD
on CTHD
for delete
as
begin
	declare cur1 cursor for
		select distinct SOHD from deleted
	open cur1
	declare @sohd nvarchar(max)
	fetch next from cur1 into @sohd
	while @@FETCH_STATUS = 0
	begin
		declare cur2 cursor for
			select distinct MASP from deleted where SOHD = @sohd
		open cur2
		declare @masp nvarchar(max)
		fetch next from cur2 into @masp
		while @@FETCH_STATUS = 0
		begin
			declare @sl int
			select @sl = SL from deleted where SOHD = @sohd and MASP = @masp
			update WAREHOUSE_REMAINING set QUANTITY = QUANTITY + @sl where MASP = @masp
			fetch next from cur2 into @masp
		end
		fetch next from cur1 into @sohd
		close cur2
		deallocate cur2
	end
	close cur1
	deallocate cur1
end

begin tran
delete from CTHD where SOHD in (1001,1002)
select * from CTHD
select * from WAREHOUSE_REMAINING
rollback tran
--1001: BC01 5 (195), BC02 10(110), ST01 5(165), ST08 10(80), TV02 10(169)
--1002: BB01 20(130), BB02 20(50), BC04 20(120)

---- 2. ----
--UPDATE WAREHOUSE_REMAINING
--SET QUANTITY = 50 WHERE QUANTITY IS NOT NULL
go
create trigger trg_udtHD
on CTHD
for update
as
begin
	declare cur1 cursor for
		select distinct SOHD from deleted
	open cur1
	declare @sohd nvarchar(max)
	fetch next from cur1 into @sohd
	while @@FETCH_STATUS = 0
	begin
		declare cur2 cursor for
			select distinct MASP from deleted where SOHD = @sohd
		open cur2
		declare @maspD nvarchar(max)
		fetch next from cur2 into @maspD

		declare @maspI nvarchar(max)
		select @maspI = MASP from inserted where SOHD = @sohd
		while @@FETCH_STATUS = 0
		begin
			declare @slD int, @slI int
			select @slD = SL from deleted where SOHD = @sohd and MASP = @maspD
			select @slI = SL from inserted where SOHD = @sohd and MASP = @maspI
			update WAREHOUSE_REMAINING set QUANTITY = QUANTITY + @slD where MASP = @maspD
			update WAREHOUSE_REMAINING set QUANTITY = QUANTITY - @slI where MASP = @maspI
			fetch next from cur2 into @maspD
		end
		fetch next from cur1 into @sohd
		close cur2
		deallocate cur2
	end
	close cur1
	deallocate cur1
end

begin tran
update CTHD set MASP = 'BC01', SL = 30 where SOHD in (1001,1002) and MASP in ('BC01', 'BB01')
select * from CTHD
select * from WAREHOUSE_REMAINING
rollback tran

--1001: BC01 5 (195), BC02 10(110), ST01 5(165), ST08 10(80), TV02 10(169)
--1002: BB01 20(130), BB02 20(50), BC04 20(120)
--BC01: 195, BC02:110, BB01: 130, BB03 183
----insert----
go
create trigger trg_insHD
on CTHD
for insert
as
begin
	declare cur1 cursor for
		select distinct SOHD from inserted
	open cur1
	declare @sohd nvarchar(max)
	fetch next from cur1 into @sohd
	while @@FETCH_STATUS = 0
	begin
		declare cur2 cursor for
			select distinct MASP from inserted where SOHD = @sohd
		open cur2
		declare @masp nvarchar(max)
		fetch next from cur2 into @masp
		while @@FETCH_STATUS = 0
		begin
			declare @sl int
			select @sl = SL from inserted where SOHD = @sohd and MASP = @masp
			update WAREHOUSE_REMAINING set QUANTITY = QUANTITY - @sl where MASP = @masp
			fetch next from cur2 into @masp
		end
		fetch next from cur1 into @sohd
		close cur2
		deallocate cur2
	end
	close cur1
	deallocate cur1
end

-----------

--1. TẠO TRIGGER ĐỂ CẬP NHẬT THÔNG TIN TRIGIA TRONG BẢNG HOADON TỪ VIỆC TÍNH TOÁN 
--SL*GIA CỦA TỪNG MÃ SẢN PHẨM, ÁP DỤNG CHO 3 KIỂU THAY ĐỔI DỮ LIỆU LÀ INSERT, UPDATE, DELETE
--TABLE: [CTHD], [HOADON], [SANPHAM]
go
create trigger trg_calcTrigia
on CTHD
for insert, update, delete
as
begin
	if exists (select * from inserted) and not exists (select * from deleted) --insert
		begin
			declare cur1 cursor for
				select distinct SOHD from inserted
			open cur1
			declare @sohdI nvarchar(max)
			fetch next from cur1 into @sohdI
			while @@FETCH_STATUS = 0
			begin
				if not exists (select * from inserted where SOHD = @sohdI and SOHD in (select SOHD from HOADON)) --check SOHD da ton tai o bang HOADON chua, neu chua dua SOHD moi vao bang HOADON
					insert into HOADON(SOHD, TRIGIA) values (@sohdI,0)
				declare cur2 cursor for
					select distinct MASP from inserted where SOHD = @sohdI
				open cur2
				declare @maspI nvarchar(max)
				fetch next from cur2 into @maspI
				declare @trigiaI int = (select TRIGIA from HOADON where SOHD = @sohdI)
				while @@FETCH_STATUS = 0
				begin
					set @trigiaI = @trigiaI +
					(select 
						sum(A.SL*B.GIA) THANHTIEN
					from 
						inserted A inner join SANPHAM B on A.MASP = B.MASP
					where A.MASP = @maspI and A.SOHD = @sohdI
					group by A.SOHD, A.MASP)
					fetch next from cur2 into @maspI
				end
				update HOADON set TRIGIA = @trigiaI where SOHD = @sohdI
				fetch next from cur1 into @sohdI
				close cur2
				deallocate cur2
			end
			close cur1
			deallocate cur1
		end
	else
		if exists (select * from deleted) and not exists (select * from inserted) --delete
			begin
				declare cur1 cursor for
					select distinct SOHD from deleted
				open cur1
				declare @sohdD nvarchar(max)
				fetch next from cur1 into @sohdD
				while @@FETCH_STATUS = 0
				begin
					declare cur2 cursor for
						select distinct MASP from deleted where SOHD = @sohdD
					open cur2
					declare @maspD nvarchar(max)
					fetch next from cur2 into @maspD
					declare @trigiaD int = (select TRIGIA from HOADON where SOHD = @sohdD)
					while @@FETCH_STATUS = 0
					begin
						set @trigiaD = @trigiaD -
						(select 
							sum(A.SL*B.GIA) THANHTIEN
						from 
							deleted A inner join SANPHAM B on A.MASP = B.MASP
						where A.MASP = @maspD and A.SOHD = @sohdD
						group by A.SOHD, A.MASP)
						fetch next from cur2 into @maspD
					end
					update HOADON set TRIGIA = @trigiaD where SOHD = @sohdD
					fetch next from cur1 into @sohdD
					close cur2
					deallocate cur2
				end
				close cur1
				deallocate cur1
			end
		else --update
			begin
				declare cur1 cursor for
					select distinct SOHD from deleted
				open cur1
				declare @sohdU nvarchar(max)
				fetch next from cur1 into @sohdU
				while @@FETCH_STATUS = 0
				begin
					declare cur2 cursor for
						select distinct MASP from deleted where SOHD = @sohdU
					open cur2
					declare @maspUD nvarchar(max)
					fetch next from cur2 into @maspUD
					declare @maspUI nvarchar(max)
					select @maspUI = MASP from inserted where SOHD = @sohdU
					declare @trigiaU int = (select TRIGIA from HOADON where SOHD = @sohdU)
					while @@FETCH_STATUS = 0
					begin
						set @trigiaU = @trigiaU +
						(select 
							sum(A.SL*B.GIA) THANHTIEN
						from 
							inserted A inner join SANPHAM B on A.MASP = B.MASP
						where A.MASP = @maspUI and A.SOHD = @sohdU
						group by A.SOHD, A.MASP) - 
						(select 
							sum(A.SL*B.GIA) THANHTIEN
						from 
							deleted A inner join SANPHAM B on A.MASP = B.MASP
						where A.MASP = @maspUD and A.SOHD = @sohdU
						group by A.SOHD, A.MASP)
						fetch next from cur2 into @maspUD
					end
					update HOADON set TRIGIA = @trigiaU where SOHD = @sohdU
					fetch next from cur1 into @sohdU
					close cur2
					deallocate cur2
				end
				close cur1
				deallocate cur1
			end
end


begin tran
insert into CTHD(SOHD, MASP, SL) values  
(1027,'BB01',10), (1027,'BC01', 10), (1027, 'BC02',10)

delete from CTHD where SOHD = 1027 and MASP in ('BB01', 'BC01')

update CTHD set MASP = 'ST02', SL = 20 where SOHD in (1027,1001) and MASP = 'BC02'
rollback tran

select * from CTHD  --1001: BB01: 5, BC02: 10, ST01: 5, ST02: 20, ST08: 10, TV02: 10
select * from SANPHAM --BB01: 5000, BC01: 3000, BC02: 5000, ST02: 55000
select * from HOADON --1001: 320000, 1027: 0
select * from WAREHOUSE_REMAINING --BB01: 130, BC01: 195, BC02: 110, ST01: 165
select A.MASP, A.SL, B.GIA, SL*GIA THANHTIEN
from
	CTHD A inner join
	SANPHAM B on A.MASP = B.MASP
where SOHD = 1027


--2. TẠO TRIGGER THÔNG BÁO NẾU SỐ LƯỢNG HÀNG TỒN KHO CỦA MASP <= 10
--TRONG TRƯỜNG HỢP XUẤT HÀNG > SL TỒN KHO -> HIỂN THỊ THÔNG BÁO VỀ SLSP CẦN NHẬP 
--THÊM VÀ NUOCSX MASP ĐÓ.
--TABLE: [CTHD], [WAREHOUSE_REMAINING]
--SELECT DISTINCT MASP, 50 AS QUANTITY INTO WAREHOUSE_REMAINING
--FROM CTHD
--VÍ DỤ:
--‘MÃ SẢN PHẨM BB01 HIỆN CHỈ CÒN 6 SẢN PHẨM’
--‘CẦN NHẬP THÊM 5 SẢN PHẨM MÃ BB02 TỪ TRUNG QUỐC’
go
create trigger trg_tonkho
on CTHD
for insert, update
as
begin
	declare cur1 cursor for
		select distinct SOHD from inserted
	open cur1
	declare @sohd nvarchar(max)
	fetch next from cur1 into @sohd
	while @@FETCH_STATUS = 0
	begin
		declare cur2 cursor for
			select distinct MASP from inserted where SOHD = @sohd
		open cur2
		declare @masp nvarchar(max)
		fetch next from cur2 into @masp
		while @@FETCH_STATUS = 0
			begin
				declare @sl1 int, @sl2 int
				select @sl1 = QUANTITY from WAREHOUSE_REMAINING where MASP = @masp
				select @sl2 = SL from inserted where SOHD = @sohd and MASP = @masp
				declare @nsx nvarchar(max) = (select NUOCSX from SANPHAM where MASP = @masp)
				declare @text nvarchar(max), @text2 nvarchar(max)
				if @sl1 between 0 and 10
					begin
						set @text = N'Mã sản phẩm ' +@masp+ N' hiện chỉ còn ' +CONVERT(nvarchar(max),@sl1)+ N' sản phẩm.'
						print @textI
					end
				else
					if @sl1 < 0
						begin
							update WAREHOUSE_REMAINING set QUANTITY = QUANTITY + @sl2 where MASP = @masp
							select @sl1 = QUANTITY from WAREHOUSE_REMAINING where MASP = @masp
							set @text = N'Mã sản phẩm ' +@masp+ N' hiện chỉ còn ' +CONVERT(nvarchar(max),@sl1)+ N' sản phẩm.'
							print @text
							set @text2 = N'Cần nhập thêm ' +convert(nvarchar(max),@sl2 - @sl1)+ N' sản phẩm mã ' +@masp+ N' từ ' +@nsx+ '.'
							print @text2
						end
				fetch next from cur2 into @masp
			end
		fetch next from cur1 into @sohd
		close cur2
		deallocate cur2
	end
	close cur1
	deallocate cur1
end


begin tran
insert into CTHD (SOHD, MASP, SL) values
(1027, 'BB02', 55), (1028,'BB02',15)
update CTHD set MASP = 'ST08', SL = 85 where SOHD = 1027 and MASP = 'BB02'
rollback tran

delete from CTHD where SOHD = 1027

select * from CTHD
select * from WAREHOUSE_REMAINING

--3. TẠO TRIGGER CẬP NHẬT DỮ LIỆU WAREHOUSE KHI MÀ THÔNG TIN HỢP ĐỒNG ĐƯỢC CẬP NHẬT 
--VÀO TRONG CTHD
------ TẠO BẢNG HÀNG TỒN KHO (WAREHOUSE):
--SELECT DISTINCT MASP, 50 AS QUANTITY INTO WAREHOUSE_REMAINING
--FROM CTHD

--drop trigger trg_delHD
--drop trigger trg_udtHD
--drop trigger trg_insHD
--drop trigger trg_tonkho
go
create trigger trg_updateWarehouse
on CTHD
for insert
as
begin
	declare cur cursor for
		select distinct MASP from inserted
	open cur
	declare @masp nvarchar(max)
	fetch next from cur into @masp
	while @@FETCH_STATUS = 0
		begin
			declare @slxuat int, @sltontruoc int, @sltonsau int
			set @slxuat = (select sum(SL) from inserted where MASP = @masp)
			set @sltontruoc = (select QUANTITY from WAREHOUSE_REMAINING where MASP = @masp)
			update WAREHOUSE_REMAINING set QUANTITY = QUANTITY - @slxuat where MASP = @masp
			set @sltonsau = (select QUANTITY from WAREHOUSE_REMAINING where MASP = @masp)
			declare @nsx nvarchar(max) = (select NUOCSX from SANPHAM where MASP = @masp)
			declare @text nvarchar(max), @text2 nvarchar(max)
			if @sltonsau <=10 and @sltonsau >= 0
				begin
					set @text = N'Mã sản phẩm ' +@masp+ N' hiện chỉ còn ' +CONVERT(nvarchar(max),@sltonsau)+ N' sản phẩm.'
					print @text
				end
			else
				if @sltonsau < 0
					begin
						update WAREHOUSE_REMAINING set QUANTITY = @sltontruoc where MASP = @masp
						set @text = N'Mã sản phẩm ' +@masp+ N' hiện chỉ còn ' +CONVERT(nvarchar(max),@sltontruoc)+ N' sản phẩm.'
						print @text
						set @text2 = N'Cần nhập thêm ' +convert(nvarchar(max),@slxuat - @sltontruoc)+ N' sản phẩm mã ' +@masp+ N' từ ' +@nsx+ '.'
						print @text2
					end
			fetch next from cur into @masp
		end
	close cur
	deallocate cur
end


begin tran
insert into CTHD(SOHD, MASP, SL) values (1027, 'BB02', 40), (1028, 'BB02', 40)
delete from CTHD where SOHD = 1027 and MASP = 'BB01'
update CTHD set MASP = 'ST01', SL = 170 where SOHD = 1027 and MASP = 'BB02'
rollback tran

select * from CTHD
select * from WAREHOUSE_REMAINING --BB01: 130, BB02: 50, ST01: 165