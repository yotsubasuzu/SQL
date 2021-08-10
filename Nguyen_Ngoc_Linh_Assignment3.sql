select top 5 * 
from MCI_SQL..Lesson2

--1. Tính tổng số tiền theo từng mã cửa hàng và theo từng vùng dựa theo địa chỉ nhân viên (Miền Bắc, Miền Trung, Miền Nam). 
select
	Store_ID,
	case when Sale_man_address in 
		('Ha Noi', 'Quang Ninh', 'Vinh Phuc', 'Bac Ninh', 'Hai Duong', 'Hai Phong', 'Hung Yen', 'Thai Binh',
		'Ha Nam', 'Nam Dinh', 'Ninh Binh', 'Ha Giang', 'Cao Bang', 'Lao Cai', 'Bac Kan', 'Lang Son', 'Tuyen Quang', 
		'Yen Bai','Thai Nguyen', 'Phu Tho', 'Bac Giang', 'Lai Chau', 'Dien Bien', 'Son La', 'Hoa Binh') then 'Mien Bac'
		when Sale_man_address in 
		('Binh Phuoc', 'Binh Duong', 'Dong Nai', 'Tay Ninh', 'Ba Ria Vung Tau', 'TP Ho Chi Minh', 'Long An', 'Dong Thap',
		'Tien Giang', 'An Giang', 'Ben Tre', 'Vinh Long', 'Tra Vinh', 'Hau Giang', 'Kien Giang', 'Soc Trang', 'Bac Lieu',
		'Ca Mau', 'Can Tho') then 'Mien Nam'
		else 'Mien Trung' end as VungMien,
		sum(Sotien_nguyente) TongSoTien
from 
	MCI_SQL..Lesson2
group by
	Store_ID,
	case when Sale_man_address in 
		('Ha Noi', 'Quang Ninh', 'Vinh Phuc', 'Bac Ninh', 'Hai Duong', 'Hai Phong', 'Hung Yen', 'Thai Binh',
		'Ha Nam', 'Nam Dinh', 'Ninh Binh', 'Ha Giang', 'Cao Bang', 'Lao Cai', 'Bac Kan', 'Lang Son', 'Tuyen Quang', 
		'Yen Bai','Thai Nguyen', 'Phu Tho', 'Bac Giang', 'Lai Chau', 'Dien Bien', 'Son La', 'Hoa Binh') then 'Mien Bac'
		when Sale_man_address in 
		('Binh Phuoc', 'Binh Duong', 'Dong Nai', 'Tay Ninh', 'Ba Ria Vung Tau', 'TP Ho Chi Minh', 'Long An', 'Dong Thap',
		'Tien Giang', 'An Giang', 'Ben Tre', 'Vinh Long', 'Tra Vinh', 'Hau Giang', 'Kien Giang', 'Soc Trang', 'Bac Lieu',
		'Ca Mau', 'Can Tho') then 'Mien Nam'
		else 'Mien Trung' end
order by 1, 2

--2. Tính tổng số tiền theo từng mã cửa hàng và theo từng nhóm năm của thời điểm giao dịch như sau 
--từ tháng 1 – tháng 6 2019(Quý 1 20219), từ tháng 7 – tháng 12 2019(Quý 2 20219), từ tháng 1 – 6 năm 2020(Quý 1 20220), từ tháng 7 – 12 năm 2020(Quý 2 20220). 
select 
	STORE_ID,
	case when Trans_Time between '20190101' and '20190630' then 'Nua dau 2019'
		when Trans_Time between '20190701' and '20191231' then 'Nua cuoi 2019'
		when Trans_Time between '20200101' and '20200630' then 'Nua dau 2020'
		else 'Nua cuoi 2020' end as ThoiDiemGiaoDich,
	sum(Sotien_nguyente) TongSoTien
from 
	MCI_SQL..Lesson2
group by
	Store_ID,
	case when Trans_Time between '20190101' and '20190630' then 'Nua dau 2019'
		when Trans_Time between '20190701' and '20191231' then 'Nua cuoi 2019'
		when Trans_Time between '20200101' and '20200630' then 'Nua dau 2020'
		else 'Nua cuoi 2020' end
order by 1,2

--3. Tính tổng số tiền theo từng mã cửa hàng và theo từng nhóm mã khách hàng chia như sau: 
--Nhóm 1: Tên Khách Hàng nhỏ hơn 8 kí tự 
--Nhóm 2: Tên Khách Hàng từ 8 - 12 kí tự 
--Nhóm 3: Tên Khách Hàng từ 12 - 15 kí tự
--Nhóm 4: Tên Khách Hàng > 15 kí tự 
--(Sử dụng hàm Len để đếm số kí tự từ tên khách hàng) 
select
	STORE_ID,
	case when len(Ten_khachhang) < 8 then 'TenKH duoi 8 ky tu'
		when len(Ten_khachhang) between 8 and 12 then 'TenKH 8-12 ky tu'
		when len(Ten_Khachhang) between 12 and 15 then 'TenKH 12-15 ky tu'
		else 'Ten KH tren 15 ky tu' end as TenKhachHang,
		sum(Sotien_nguyente) TongSoTien
from
	MCI_SQL..Lesson2
group by
	STORE_ID,
	case when len(Ten_khachhang) < 8 then 'TenKH duoi 8 ky tu'
		when len(Ten_khachhang) between 8 and 12 then 'TenKH 8-12 ky tu'
		when len(Ten_Khachhang) between 12 and 15 then 'TenKH 12-15 ky tu'
		else 'Ten KH tren 15 ky tu' end
order by 1 asc, 2 desc

--4. Lấy ra thông tin giao dịch có số tiền lớn nhất theo từng ngày và từng cửa hàng 
select * 
from
(
	Select 
		ROW_NUMBER() OVER(PARTITION BY STORE_ID, Trans_Time order by Sotien_nguyente desc) RowNumber, *
	from MCI_SQL..Lesson2
) a
where RowNumber = 1

--5. Lấy ra khách có số tiền lớn nhất theo từng ngày và từng cửa hàng 
select *
from
(
	select
		ROW_NUMBER() OVER(PARTITION BY Store_ID, Trans_time order by Sotien_nguyente desc) RowNumber, *
	from 
	(select Store_ID, Trans_Time, Ma_khachhang, Ten_khachhang, Loai_khachhang, sum (Sotien_nguyente) Sotien_nguyente 
	from MCI_SQL..Lesson2 group by Store_ID, Trans_Time, Ma_khachhang, Ten_khachhang, Loai_khachhang) a
) a
where
	RowNumber = 1

--6. Sử dụng insert into thêm dữ liệu vào bảng discount như trong file Lesson2-data.xlsb. 
insert into 
	MCI_SQL..Lesson2 
	(Sotien_nguyente,Sotien_quydoi,Muc_chiet_khau,Sotien_cham_tra,Loai_khachhang) 
values 
	(null,5,1.00,50,3),
	(5,10,1.50,100,3),
	(10,20,1.58,500,2),
	(20,40,1.65,1000,2),
	(40,80,1.74,2000,1),
	(80,160,1.82,4000,1),
	(160,320,1.91,8000,1),
	(320,640,2.01,16000,1),
	(640,1280,2.11,32000,1),
	(1280,2560,2.22,64000,1),
	(2560,null,2.33,128000,1)

--7. Tạo bảng và sử dụng insert into thêm 10 dòng dữ liệu vào bảng Cus_ID như trong file Lesson2-data.xlsb. 
create table MCI_SQL..Customer(
	CustomerID varchar(10),
	CustomerName varchar(50),
	Address Nvarchar(20),
	Sex varchar(5),
	Company varchar(20),
	Email varchar(50),
	PhoneNum varchar(15)
);

bulk insert MCI_SQL..Customer
from 'C:\Users\tocba\Desktop\cusid.csv'
with(
	firstrow = 2,
	fieldterminator = '\t',
	rowterminator = '\n',
	codepage ='65001'
);

select * from MCI_SQL..Customer;
--delete from MCI_SQL..Customer;

--8. Update cột số điện thoại của bảng Cus_ID bằng cách thêm số 0 vào đầu 
update 
	MCI_SQL..Customer 
set 
	PhoneNum = concat('0',PhoneNum);

--9. Update cột Email của bảng Cus_ID bằng cách xóa chữ @gmail.com đi 
update 
	MCI_SQL..Customer 
set 
	Email = replace(Email,'@gmail.com','');

--10. Xóa các công ty có tên có độ dài >= 13 kí tự 
update 
	MCI_SQL..Customer 
set 
	Company = null 
where 
	len(Company) >= 13; --sửa giá trị của cột company có dộ dài >= 13 ký tự về null

delete from 
	MCI_SQL..Customer 
where 
	len(Company) >= 13; --xóa dòng có giá trị của cột company có độ dài >= 13 ký tự (có vẻ đúng với đề hơn)
