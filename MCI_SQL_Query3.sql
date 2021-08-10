----1.----Tạo các câu lệnh có thể tự động upload file BanHang.csv lên SQL thỏa mãn các đk sau
--1. Nếu bảng bán hàng đã có thì phải tự động xóa đi và tạo lại, chưa có thì tạo mới
--2. Kiểm tra dữ liệu sau khi up lên nếu tổng số dòng dữ liệu = 0 thì in ra lỗi như sau:
--"kiểm tra lại dữ liệu trong file excel bán hàng"

IF exists 
(
	select * 
	from MCI_SQL.INFORMATION_SCHEMA.TABLES
	where
		TABLE_TYPE = 'BASE TABLE' and
		TABLE_NAME = 'BANHANG'
)
	BEGIN
		drop table MCI_SQL..BANHANG;
	END
create table MCI_SQL..BANHANG(
	Store_ID varchar(30),
	Trans_Time date,
	Saleman nvarchar(255),
	Saleman_ID varchar(50),
	Saleman_address nvarchar(255),
	Ten_KH nvarchar(255),
	Ma_KH varchar(255),
	Retail_bill varchar(50),
	Total_bill varchar(50),
	Loai_tien varchar(10),
	Loai_hang nvarchar(255), 
	Unit_Price float,
	Muavao_Banra varchar(3),
	Sotien_nguyente float,
	Sotien_quydoi float,
	Hoa_hong float,
	Muc_chietkhau float,
	Sotien_chamtra float,
	Ngay_denhan_trano date,
	Loai_KH int
);
bulk insert MCI_SQL..BANHANG
from 'C:\Users\tocba\Documents\MCI_SQL_Lv1\BanHang.csv'
with
(
	firstrow = 2,
	fieldterminator = ',',
	rowterminator = '\n'
);
if (select count(*) from MCI_SQL..BANHANG) = 0
	begin
		print N'Kiểm tra lại dữ liệu trong file excel bán hàng.'
	end
else
	begin
	 print N'Upload dữ liệu thành công.'
	end


---Tạo các câu lệnh có thể tự động upload file Khách hàng.csv lên SQL----
---Thỏa mãn các điều kiện sau------
---1. Nếu bảng khách hàng đã có thì phải tự động xóa đi và tạo lại---------
---2. Xóa đi các dòng dữ liệu trùng của file khách hàng.
---3. Kiểm tra dữ liệu sau khi up lên nếu tổng số dòng dữ liệu = 0 thì in ra lỗi như sau. "Kiểm tra lại dữ liệu trong file excel ban hang"---------
---4. Kiểm tra dữ liệu sau khi up lên nếu bị trùng mã khách hàng thì in ra lỗi như sau. "Kiểm tra lại dữ liệu trong file excel ban hang"---------

IF exists 
(
	select * 
	from MCI_SQL.INFORMATION_SCHEMA.TABLES
	where
		TABLE_TYPE = 'BASE TABLE' and
		TABLE_NAME = 'KHACHHANG'
)
	BEGIN
		drop table MCI_SQL..KHACHHANG;
	END
create table MCI_SQL..KHACHHANG(
	CustomerID varchar(10),
	CustomerName varchar(50),
	[Address] nvarchar(20),
	Sex varchar(5),
	Company varchar(20),
	Email varchar(50),
	PhoneNum varchar(15)
);
bulk insert MCI_SQL..KHACHHANG
from 'C:\Users\tocba\Documents\MCI_SQL_Lv1\KhachHang.csv'
with
(
	firstrow = 2,
	fieldterminator = '\t',
	rowterminator = '\r',
	codepage = '65001'
);

with temptable as
(
	select *
	from
	(
		select *,
			ROW_NUMBER() OVER (PARTITION BY CustomerID order by [Address] desc) rownumber
		from MCI_SQL..KHACHHANG
	)a
	where rownumber >= 2
)
delete from temptable

if (select count(*) from MCI_SQL..KHACHHANG) = 0
	begin
		print N'Kiểm tra lại dữ liệu trong file excel bán hàng.'
	end
else
	begin
	print N'Upload dữ liệu thành công.'
	if 
		(
			select count(*)
			from
			(
				select *,
					ROW_NUMBER() OVER (PARTITION BY CustomerID order by [Address] desc) rownumber
				from MCI_SQL..KHACHHANG
			)a
			where rownumber >= 2
		) = 0
		begin
			print N'Dữ liệu không trùng.'
		end
	end

---Tạo các câu lệnh có thể tự động upload file Bán Hàng.csv lên SQL----
---Thỏa mãn các điều kiện sau------
---1. Nếu bảng bán hàng đã có thì phải tự động xóa đi và tạo lại. Chưa có thì tạo mới---------
---2. Kiểm tra dữ liệu sau khi up lên nếu tổng số dòng dữ liệu = 0 thì in ra lỗi như sau. "Kiểm tra lại dữ liệu trong file excel ban hang"---------
---3. Thêm dữ liệu tỷ giá và thông tin khách hàng vào bảng bán hàng--------

IF exists 
(
	select * 
	from MCI_SQL.INFORMATION_SCHEMA.TABLES
	where
		TABLE_TYPE = 'BASE TABLE' and
		TABLE_NAME in ('BANHANG')
)
	BEGIN
		drop table MCI_SQL..BANHANG
	END
create table MCI_SQL..BANHANGtmp(
	Store_ID varchar(30),
	Trans_Time date,
	Saleman nvarchar(255),
	Saleman_ID varchar(50),
	Saleman_address nvarchar(255),
	Ten_KH nvarchar(255),
	Ma_KH varchar(255),
	Retail_bill varchar(50),
	Total_bill varchar(50),
	Loai_tien varchar(10),
	Loai_hang nvarchar(255), 
	Unit_Price float,
	Muavao_Banra varchar(3),
	Sotien_nguyente float,
	Sotien_quydoi float,
	Hoa_hong float,
	Muc_chietkhau float,
	Sotien_chamtra float,
	Ngay_denhan_trano date,
	Loai_KH int
);
bulk insert MCI_SQL..BANHANGtmp
from 'C:\Users\tocba\Documents\MCI_SQL_Lv1\BanHang.csv'
with
(
	firstrow = 2,
	fieldterminator = ',',
	rowterminator = '\n'
);
if (select count(*) from MCI_SQL..BANHANGtmp) = 0
	begin
		print N'Kiểm tra lại dữ liệu trong file excel bán hàng.'
	end
else
	begin
		print N'Upload dữ liệu thành công.'
	end
create table MCI_SQL..TyGiatmp(
	Ngay date,
	LoaiTien varchar(5),
	TyGia float
)
bulk insert MCI_SQL..TyGiatmp
from 'C:\Users\tocba\Documents\MCI_SQL_Lv1\TyGia.csv'
with
	(
		firstrow = 2,
		fieldterminator = ',',
		rowterminator = '\r'
	)
select *
into
	MCI_SQL..BANHANG 
from
(
	select 
		A.*, 
		ISNULL(B.TyGia,1) TyGia,
		C.CustomerName, C.Company, C.Address, C.Email, C.PhoneNum, C.Sex
	from 
		MCI_SQL..BANHANGtmp A full outer join
		MCI_SQL..TyGiatmp B
		on A.Trans_Time = B.Ngay and 
			A.Loai_tien = B.LoaiTien full outer join
		MCI_SQL..KHACHHANG C
		on A.Ma_KH = C.CustomerID
	where A.Store_ID is not null
) a
drop table MCI_SQL..BANHANGtmp
drop table MCI_SQL..TyGiatmp

