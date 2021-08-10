USE QLBH

SELECT * FROM CTHD
SELECT * FROM HOADON
SELECT * FROM KHACHHANG
SELECT * FROM NHANVIEN
SELECT * FROM SANPHAM


--******** TẠO THÔNG BÁO KHI CÓ THAO TÁC THAY ĐỔI DỮ LIỆU CỦA BẢNG ********
----- 1. KHỞI TẠO TRIGGER
go
create trigger trg_test1
on CTHD
for insert
as
begin
	print N'Bảng CTHD vừa được thêm dữ liệu'
end

BEGIN TRANSACTION
INSERT INTO CTHD(SOHD, MASP, SL) VALUES(1800, 'BB01', 20)
DELETE FROM CTHD WHERE SOHD = 1700
UPDATE CTHD
SET SOHD = 1700 WHERE SOHD = 1800
ROLLBACK TRANSACTION

SELECT * FROM CTHD
----
go
alter trigger trg_test1
on CTHD
for insert, update, delete
as
begin
	print N'Bảng CTHD vừa được thay đổi dữ liệu'
end
---- BẢNG INSERTED VÀ BẢNG DELETED TRONG TRIGGER
	--- XÓA BỎ TRIGGER
go
alter trigger trg_test1
on CTHD
for insert, update, delete
as
begin
	select * from inserted
	select * from deleted
end


BEGIN TRANSACTION
INSERT INTO CTHD(SOHD, MASP, SL) VALUES(1800, 'BB01', 20)
DELETE FROM CTHD WHERE SOHD = 1700
UPDATE CTHD
SET SOHD = 1700, SL = 25 WHERE SOHD = 1800
ROLLBACK TRANSACTION

drop trigger trg_test1

--- TẠO TRIGGER CHO BẢNG CTHD VỚI MỆNH ĐỀ INSERT, DELETE, UPDATE
--- INSERT -> IN RA MÀN HÌNH N'BANG CTHD VUA DUOC THEM DU LIEU'
--- DELETE -> IN RA MÀN HÌNH N'BANG CTHD VUA DUOC XOA DU LIEU'
--- UPDATE -> IN RA MÀN HÌNH N'BANG CTHD VUA DUOC CAP NHAT DU LIEU'
--- GỢI Ý: EXISTS, NOT EXISTS
SELECT * FROM CTHD
WHERE EXISTS(SELECT * FROM HOADON WHERE SOHD = 1700) --- NẾU TỒN TẠI DÒNG DỮ LIỆU TRONG ()

SELECT * FROM CTHD
WHERE NOT EXISTS(SELECT * FROM HOADON WHERE SOHD = 1700) --- NẾU KHÔNG TỒN TẠI DÒNG DỮ LIỆU TRONG ()
--- 
go
create trigger trg_print
on CTHD
for insert, update, delete
as
begin
	if exists (select * from inserted) and not exists (select * from deleted)
		print N'Bảng CTHD vừa được thêm dữ liệu'
	else
		if not exists (select * from inserted) and exists (select * from deleted)
			print N'Bảng CTHD vừa được xóa dữ liệu'
		else
			print N'Bảng CTHD vừa được cập nhật dữ liệu'
end



BEGIN TRANSACTION
INSERT INTO CTHD(SOHD, MASP, SL) VALUES(1800, 'BB01', 20)
DELETE FROM CTHD WHERE SOHD = 1700
UPDATE CTHD
SET SOHD = 1700, SL = 25 WHERE SOHD = 1800
ROLLBACK TRANSACTION

DROP TRIGGER TRG_CTHD1

----- 2. SỬA ĐỔI TRIGGER

----- 3. XÓA TRIGGER

---- VÍ DỤ: TẠO 1 TRIGGER IN RA NGOÀI MÀN HÌNH THÔNG BÁO
---- 1. N'BẢNG CTHD ĐÃ ĐƯỢC THÊM DỮ LIỆU' - INSERT
---- 2. N'BẢNG CTHD ĐÃ ĐƯỢC THAY ĐỔI DỮ LIỆU' - UPDATE
---- 3. N'BẢNG CTHD CÓ DỮ LIỆU BỊ XÓA' - DELETE
---- IF EXISTS VÀ NOT EXISTS
--SELECT * FROM HOADON
--WHERE NOT EXISTS(SELECT * FROM CTHD WHERE SOHD = 1001)


----- VÍ DỤ: CẬP NHẬT DỮ LIỆU CỘT MAKH TRONG BẢNG KHACHHANG, THÌ BẢNG HOADON CŨNG ĐƯỢC CẬP NHẤT DỮ LIỆU
----- 1. DELETE DỮ LIỆU MAKH BẢNG KHACHHANG, THÌ CÁC DÒNG CHỨA MAKH TƯƠNG ỨNG TRONG BẢNG HOADON CŨNG ĐƯỢC XÓA
----- 2. UPDATE DỮ LIỆU MAKH BẢNG KHACHHANG, THÌ CÁC DÒNG CHỨA MAKH TƯƠNG ỨNG TRONG BẢNG HOADON CŨNG ĐƯỢC UPDATE
SELECT * FROM KHACHHANG
SELECT * FROM HOADON
----- 
go
create trigger trg_matchtable
on KHACHHANG
for delete, update
as
begin
	declare @makh nvarchar(max)
	if exists (select * from deleted) and not exists (select * from inserted)
		begin
			set @makh = (select MAKH from deleted)
			delete from HOADON where MAKH = @makh
			print N'Bảng KHACHHANG và HOADON vừa được xóa mã khách hàng'
		end
	else
		begin
			declare @makhcu nvarchar(max)
			set @makh = (select MAKH from inserted)
			set @makhcu = (select MAKH from deleted)
			update HOADON set MAKH = @makh where MAKH = @makhcu
			print N'Bảng KHACHHANG và HOADON vừa được cập nhật mã khách hàng'
		end
end

---chữa bài
go
create trigger trg_test2
on KHACHHANG
for update, delete
as
begin
	if exists (select * from deleted) and not exists (select * from inserted)
	begin
		delete from HOADON where MAKH in (select MAKH from deleted)
	end

	if exists (select * from deleted) and exists (select * from inserted)
	begin
		update HOADON
		set MAKH = (select distinct MAKH from inserted)
		where MAKH in (select MAKH from deleted)
	end
end

BEGIN TRANSACTION
DELETE FROM KHACHHANG WHERE MAKH = 'KH01'
UPDATE KHACHHANG
SET MAKH = 'KH99' WHERE MAKH = 'KH08'

DELETE FROM KHACHHANG WHERE MAKH IN ('KH02', 'KH03')
ROLLBACK TRANSACTION
----
SELECT * FROM KHACHHANG
SELECT * FROM HOADON WHERE MAKH = 'KH99'
delete from HOADON

---- VÍ DỤ: TẠO TRIGGER ĐỂ NGĂN VIỆC INSERT, UPDATE GIÁ TRỊ ÂM VÀO CỘT SL TRONG BẢNG CTHD
---- THỬ NGHIỆM CHO 1 DÒNG DỮ LIỆU
---- IN RA MÀN HÌNH THÔNG BÁO 'GIÁ TRỊ THÊM/SỬA ĐỔI LÀ GIÁ TRỊ ÂM' TRONG TRƯỜNG GIÁ TRỊ SL INSERT < 0
---- GỢI Ý: SỬ DỤNG ROLLBACK TRANSACTION
go
create trigger trg_minus
on CTHD
for insert, update
as
begin
	if (select top 1 SL from inserted) < 0
		rollback tran
		print N'Giá trị thêm/sửa đổi là giá trị âm'
end

BEGIN TRANSACTION
INSERT INTO CTHD(SOHD, MASP, SL) VALUES(1800, 'BC01', -5)
update CTHD set SL = -10
ROLLBACK TRANSACTION

SELECT * FROM CTHD

---- 2. TẠO TRIGGER KHI THỰC HIỆN VỚI NHIỀU DÒNG DỮ LIỆU
---- GỢI Ý: SỬ DỤNG VÒNG LẶP
go
alter trigger trg_minus
on CTHD
for insert, update
as
begin
	declare cur cursor for
		select distinct SL from inserted
	open cur
	declare @sl int
	fetch next from cur into @sl
	while @@FETCH_STATUS = 0
	begin
		if @sl < 0
		begin
			print N'Giá trị thêm/sửa đổi có giá trị âm'
			rollback tran
		end
		fetch next from cur into @sl
	end
	close cur
	deallocate cur
end

BEGIN TRANSACTION
INSERT INTO CTHD(SOHD, MASP, SL)
SELECT 1300 AS SOHD, MASP, CASE WHEN MASP = 'BC01' THEN -10 ELSE SL END AS SL FROM CTHD WHERE SOHD = 1001

UPDATE CTHD
SET SL = -15 WHERE MASP ='BB01'

ROLLBACK TRANSACTION

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
	declare cur cursor for
		select distinct MASP from deleted
	open cur
	declare @masp nvarchar(max)
	fetch next from cur2 into @masp
	while @@FETCH_STATUS = 0
	begin
		declare @sl int
		select @sl = sum(SL) from deleted where MASP = @masp
		update WAREHOUSE_REMAINING set QUANTITY = QUANTITY + @sl where MASP = @masp
		fetch next from cur into @masp
	end
	close cur2
	deallocate cur2
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
	declare cur cursor for
		select MASP, SL from deleted
		union
		select MASP, SL*-1 from inserted
	open cur
	declare @masp nvarchar(max), @sl int
	fetch next from cur into @masp, @sl

	while @@FETCH_STATUS = 0
	begin
		update WAREHOUSE_REMAINING 
		set QUANTITY = QUANTITY + @sl 
		where MASP = @masp
		fetch next from cur into @masp, @sl
	end
	close cur
	deallocate cur
end

begin tran
update CTHD set MASP = 'BC01', SL = 30 where SOHD in (1001,1002) and MASP in ('BC01', 'BB01')
select * from CTHD
select * from WAREHOUSE_REMAINING
rollback tran

--1001: BC01 5 (195), BC02 10(110), ST01 5(165), ST08 10(80), TV02 10(169)
--1002: BB01 20(130), BB02 20(50), BC04 20(120)
--BC01: 195, BC02:110, BB01: 130, BB03: 183
go
create trigger trg_insHD
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
		declare @sl int
		select @sl = sum(SL) from inserted where MASP = @masp
		update WAREHOUSE_REMAINING set QUANTITY = QUANTITY - @sl where MASP = @masp
		fetch next from cur into @masp
	end
	close cur
	deallocate cur
end

begin tran
insert into CTHD values (1024,'BB01',10), (1024,'BB02',10)  --130,50
select * from WAREHOUSE_REMAINING
select * from CTHD
rollback tran
---- 3. ----




