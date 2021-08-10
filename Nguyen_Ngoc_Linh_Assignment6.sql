---------------------Bài tập group by--------------

-----------Tạo bảng BanHang_Result-------
drop table MCI_SQL..BanHang_Result
Create table MCI_SQL..BanHang_Result (
	ThoiDiemGiaoDich date,
	ChiTieu varchar(50),
	MaCuaHang varchar(50),
	LoaiTien varchar(20),
	LoaiHang varchar(100),
	LoaiKH int,
	MuaVaoBanRa varchar(2),
	SoTienQuyDoi float
)

select * from MCI_SQL..BanHang_Result

select * from MCI_SQL..Lesson2


------Tính tổng số tiền theo từng ngày, Từng Tháng, Từng Năm và nhóm theo các chiều ThoiDiemGiaoDich,MaCuaHang,LoaiTien,LoaiHang,LoaiKH 
-----trường chỉ tiêu đặt là Tong Giao Dich và đưa kết quả vào bảng MCI_SQL..BanHang_Result---------------
--Từng ngày
insert into MCI_SQL..BanHang_Result
select 
	Trans_time,
	'Tong Giao Dich Theo Ngay',
	Store_ID,
	Loai_tien,
	Loai_hang,
	Loai_khachhang,
	Muavao_Banra,
	sum(SoTien_quydoi) TongSoTienQuyDoi
from 
	MCI_SQL..Lesson2
group by
	Trans_time,
	Store_ID,
	Loai_tien,
	Loai_hang,
	Loai_khachhang,
	Muavao_Banra
order by 
	Trans_Time, 
	Store_ID, 
	Loai_tien, 
	Loai_hang, 
	Loai_khachhang, 
	Muavao_Banra

--Từng tháng
insert into MCI_SQL..BanHang_Result
select 
	CONVERT(date,
		(
		CONVERT(varchar(4),DATEPART(YEAR,Trans_time)) + 
		case when DATEPART(MONTH,Trans_time) < 10 then '0' + CONVERT(varchar(2),DATEPART(MONTH,Trans_time))
			else CONVERT(varchar(2),DATEPART(MONTH,Trans_time)) end +
		CONVERT(varchar(2),
			(case when DATEPART(MONTH,Trans_time) = 2 then 28
				when DATEPART(MONTH,Trans_time) in (1,3,5,7,8,10,12) then 31
				else 30 end))
		),112),
	'Tong Giao Dich Theo Thang',
	Store_ID,
	Loai_tien,
	Loai_hang,
	Loai_khachhang,
	Muavao_Banra,
	sum(SoTien_quydoi) TongSoTienQuyDoi
from 
	MCI_SQL..Lesson2
group by
	DATEPART(YEAR,Trans_time),
	DATEPART(Month,Trans_time),
	Store_ID,
	Loai_tien,
	Loai_hang,
	Loai_khachhang,
	Muavao_Banra
order by 
	DATEPART(YEAR,Trans_time),
	DATEPART(Month,Trans_time), 
	Store_ID, 
	Loai_tien, 
	Loai_hang, 
	Loai_khachhang, 
	Muavao_Banra
	
--Từng năm
insert into MCI_SQL..BanHang_Result
select 
	CONVERT(date,
		(
		CONVERT(varchar(4),DATEPART(YEAR,Trans_time)) + '1231'
		),112),
	'Tong Giao Dich Theo Nam',
	Store_ID,
	Loai_tien,
	Loai_hang,
	Loai_khachhang,
	Muavao_Banra,
	sum(SoTien_quydoi) TongSoTienQuyDoi
from 
	MCI_SQL..Lesson2
group by
	DATEPART(YEAR,Trans_time),
	Store_ID,
	Loai_tien,
	Loai_hang,
	Loai_khachhang,
	Muavao_Banra
order by 
	DATEPART(YEAR,Trans_time),
	Store_ID, 
	Loai_tien, 
	Loai_hang, 
	Loai_khachhang, 
	Muavao_Banra


------Tính Bình Quân theo từng ngày, Từng Tháng, Từng Năm và nhóm theo các chiều ThoiDiemGiaoDich,MaCuaHang,LoaiTien,LoaiHang,LoaiKH 
----------trường chỉ tiêu đặt là Binh Quan Giao Dich và đưa kết quả vào bảng MCI_SQL..BanHang_Result---------------
--Từng ngày
insert into MCI_SQL..BanHang_Result
select 
	Trans_time,
	'Binh Quan Giao Dich Theo Ngay',
	Store_ID,
	Loai_tien,
	Loai_hang,
	Loai_khachhang,
	Muavao_Banra,
	avg(SoTien_quydoi) BinhQuanGiaoDich
from 
	MCI_SQL..Lesson2
group by
	Trans_time,
	Store_ID,
	Loai_tien,
	Loai_hang,
	Loai_khachhang,
	Muavao_Banra
order by 
	Trans_Time, 
	Store_ID, 
	Loai_tien, 
	Loai_hang, 
	Loai_khachhang, 
	Muavao_Banra

--Từng tháng
insert into MCI_SQL..BanHang_Result
select 
	CONVERT(date,
		(
		CONVERT(varchar(4),DATEPART(YEAR,Trans_time)) + 
		case when DATEPART(MONTH,Trans_time) < 10 then '0' + CONVERT(varchar(2),DATEPART(MONTH,Trans_time))
			else CONVERT(varchar(2),DATEPART(MONTH,Trans_time)) end +
		CONVERT(varchar(2),
			(case when DATEPART(MONTH,Trans_time) = 2 then 28
				when DATEPART(MONTH,Trans_time) in (1,3,5,7,8,10,12) then 31
				else 30 end))
		),112),
	'Binh Quan Giao Dich Theo Thang',
	Store_ID,
	Loai_tien,
	Loai_hang,
	Loai_khachhang,
	Muavao_Banra,
	avg(SoTien_quydoi) BinhQuanGiaoDich
from 
	MCI_SQL..Lesson2
group by
	DATEPART(YEAR,Trans_time),
	DATEPART(Month,Trans_time),
	Store_ID,
	Loai_tien,
	Loai_hang,
	Loai_khachhang,
	Muavao_Banra
order by 
	DATEPART(YEAR,Trans_time),
	DATEPART(Month,Trans_time), 
	Store_ID, 
	Loai_tien, 
	Loai_hang, 
	Loai_khachhang, 
	Muavao_Banra
	
--Từng năm
insert into MCI_SQL..BanHang_Result
select 
	CONVERT(date,
		(
		CONVERT(varchar(4),DATEPART(YEAR,Trans_time)) + '1231'
		),112),
	'Binh Quan Giao Dich Theo Nam',
	Store_ID,
	Loai_tien,
	Loai_hang,
	Loai_khachhang,
	Muavao_Banra,
	avg(SoTien_quydoi) BinhQuanGiaoDich
from 
	MCI_SQL..Lesson2
group by
	DATEPART(YEAR,Trans_time),
	Store_ID,
	Loai_tien,
	Loai_hang,
	Loai_khachhang,
	Muavao_Banra
order by 
	DATEPART(YEAR,Trans_time),
	Store_ID, 
	Loai_tien, 
	Loai_hang, 
	Loai_khachhang, 
	Muavao_Banra


------Tính tổng số tiền hoa hồng theo từng ngày, Từng Tháng, Từng Năm và nhóm theo các chiều ThoiDiemGiaoDich,MaCuaHang,LoaiTien,LoaiHang,LoaiKH 
------trường chỉ tiêu đặt là Tong Hoa Hong và đưa kết quả vào bảng MCI_SQL..BanHang_Result---------------
--Từng ngày
insert into MCI_SQL..BanHang_Result
select 
	Trans_time,
	'Tong Hoa Hong Theo Ngay',
	Store_ID,
	Loai_tien,
	Loai_hang,
	Loai_khachhang,
	Muavao_Banra,
	sum(SoTien_quydoi * Hoa_hong) TongHoaHong
from 
	MCI_SQL..Lesson2
group by
	Trans_time,
	Store_ID,
	Loai_tien,
	Loai_hang,
	Loai_khachhang,
	Muavao_Banra
order by 
	Trans_Time, 
	Store_ID, 
	Loai_tien, 
	Loai_hang, 
	Loai_khachhang, 
	Muavao_Banra

--Từng tháng
insert into MCI_SQL..BanHang_Result
select 
	CONVERT(date,
		(
		CONVERT(varchar(4),DATEPART(YEAR,Trans_time)) + 
		case when DATEPART(MONTH,Trans_time) < 10 then '0' + CONVERT(varchar(2),DATEPART(MONTH,Trans_time))
			else CONVERT(varchar(2),DATEPART(MONTH,Trans_time)) end +
		CONVERT(varchar(2),
			(case when DATEPART(MONTH,Trans_time) = 2 then 28
				when DATEPART(MONTH,Trans_time) in (1,3,5,7,8,10,12) then 31
				else 30 end))
		),112),
	'Tong Hoa Hong Theo Thang',
	Store_ID,
	Loai_tien,
	Loai_hang,
	Loai_khachhang,
	Muavao_Banra,
	sum(SoTien_quydoi * Hoa_hong) TongHoaHong
from 
	MCI_SQL..Lesson2
group by
	DATEPART(YEAR,Trans_time),
	DATEPART(Month,Trans_time),
	Store_ID,
	Loai_tien,
	Loai_hang,
	Loai_khachhang,
	Muavao_Banra
order by 
	DATEPART(YEAR,Trans_time),
	DATEPART(Month,Trans_time), 
	Store_ID, 
	Loai_tien, 
	Loai_hang, 
	Loai_khachhang, 
	Muavao_Banra
	
--Từng năm
insert into MCI_SQL..BanHang_Result
select 
	CONVERT(date,
		(
		CONVERT(varchar(4),DATEPART(YEAR,Trans_time)) + '1231'
		),112),
	'Tong Hoa Hong Theo Nam',
	Store_ID,
	Loai_tien,
	Loai_hang,
	Loai_khachhang,
	Muavao_Banra,
	sum(SoTien_quydoi * Hoa_hong) TongHoaHong
from 
	MCI_SQL..Lesson2
group by
	DATEPART(YEAR,Trans_time),
	Store_ID,
	Loai_tien,
	Loai_hang,
	Loai_khachhang,
	Muavao_Banra
order by 
	DATEPART(YEAR,Trans_time),
	Store_ID, 
	Loai_tien, 
	Loai_hang, 
	Loai_khachhang, 
	Muavao_Banra


------Tính tổng số tiền chiết khấu theo từng ngày, Từng Tháng, Từng Năm và nhóm theo các chiều ThoiDiemGiaoDich,MaCuaHang,LoaiTien,LoaiHang,LoaiKH 
------trường chỉ tiêu đặt là Tong Chiet Khau và đưa kết quả vào bảng MCI_SQL..BanHang_Result---------------
--Từng ngày
insert into MCI_SQL..BanHang_Result
select 
	Trans_time,
	'Tong Chiet Khau Theo Ngay',
	Store_ID,
	Loai_tien,
	Loai_hang,
	Loai_khachhang,
	Muavao_Banra,
	sum(Muc_chiet_khau) TongChietKhau
from 
	MCI_SQL..Lesson2
group by
	Trans_time,
	Store_ID,
	Loai_tien,
	Loai_hang,
	Loai_khachhang,
	Muavao_Banra
order by 
	Trans_Time, 
	Store_ID, 
	Loai_tien, 
	Loai_hang, 
	Loai_khachhang, 
	Muavao_Banra

--Từng tháng
insert into MCI_SQL..BanHang_Result
select 
	CONVERT(date,
		(
		CONVERT(varchar(4),DATEPART(YEAR,Trans_time)) + 
		case when DATEPART(MONTH,Trans_time) < 10 then '0' + CONVERT(varchar(2),DATEPART(MONTH,Trans_time))
			else CONVERT(varchar(2),DATEPART(MONTH,Trans_time)) end +
		CONVERT(varchar(2),
			(case when DATEPART(MONTH,Trans_time) = 2 then 28
				when DATEPART(MONTH,Trans_time) in (1,3,5,7,8,10,12) then 31
				else 30 end))
		),112),
	'Tong Chiet Khau Theo Thang',
	Store_ID,
	Loai_tien,
	Loai_hang,
	Loai_khachhang,
	Muavao_Banra,
	sum(Muc_chiet_khau) TongChietKhau
from 
	MCI_SQL..Lesson2
group by
	DATEPART(YEAR,Trans_time),
	DATEPART(Month,Trans_time),
	Store_ID,
	Loai_tien,
	Loai_hang,
	Loai_khachhang,
	Muavao_Banra
order by 
	DATEPART(YEAR,Trans_time),
	DATEPART(Month,Trans_time), 
	Store_ID, 
	Loai_tien, 
	Loai_hang, 
	Loai_khachhang, 
	Muavao_Banra
	
--Từng năm
insert into MCI_SQL..BanHang_Result
select 
	CONVERT(date,
		(
		CONVERT(varchar(4),DATEPART(YEAR,Trans_time)) + '1231'
		),112),
	'Tong Chiet Khau Theo Nam',
	Store_ID,
	Loai_tien,
	Loai_hang,
	Loai_khachhang,
	Muavao_Banra,
	sum(Muc_chiet_khau) TongChietKhau
from 
	MCI_SQL..Lesson2
group by
	DATEPART(YEAR,Trans_time),
	Store_ID,
	Loai_tien,
	Loai_hang,
	Loai_khachhang,
	Muavao_Banra
order by 
	DATEPART(YEAR,Trans_time),
	Store_ID, 
	Loai_tien, 
	Loai_hang, 
	Loai_khachhang, 
	Muavao_Banra


------Tính tổng số tiền chậm trả theo từng ngày, Từng Tháng, Từng Năm và nhóm theo các chiều ThoiDiemGiaoDich,MaCuaHang,LoaiTien,LoaiHang,LoaiKH 
------trường chỉ tiêu đặt là Tong Cham Tra và đưa kết quả vào bảng MCI_SQL..BanHang_Result---------------
--Từng ngày
insert into MCI_SQL..BanHang_Result
select 
	Trans_time,
	'Tong Cham Tra Theo Ngay',
	Store_ID,
	Loai_tien,
	Loai_hang,
	Loai_khachhang,
	Muavao_Banra,
	sum(Sotien_cham_tra) TongChamTra
from 
	MCI_SQL..Lesson2
group by
	Trans_time,
	Store_ID,
	Loai_tien,
	Loai_hang,
	Loai_khachhang,
	Muavao_Banra
order by 
	Trans_Time, 
	Store_ID, 
	Loai_tien, 
	Loai_hang, 
	Loai_khachhang, 
	Muavao_Banra

--Từng tháng
insert into MCI_SQL..BanHang_Result
select 
	CONVERT(date,
		(
		CONVERT(varchar(4),DATEPART(YEAR,Trans_time)) + 
		case when DATEPART(MONTH,Trans_time) < 10 then '0' + CONVERT(varchar(2),DATEPART(MONTH,Trans_time))
			else CONVERT(varchar(2),DATEPART(MONTH,Trans_time)) end +
		CONVERT(varchar(2),
			(case when DATEPART(MONTH,Trans_time) = 2 then 28
				when DATEPART(MONTH,Trans_time) in (1,3,5,7,8,10,12) then 31
				else 30 end))
		),112),
	'Tong Cham Tra Theo Thang',
	Store_ID,
	Loai_tien,
	Loai_hang,
	Loai_khachhang,
	Muavao_Banra,
	sum(Sotien_cham_tra) TongChamTra
from 
	MCI_SQL..Lesson2
group by
	DATEPART(YEAR,Trans_time),
	DATEPART(Month,Trans_time),
	Store_ID,
	Loai_tien,
	Loai_hang,
	Loai_khachhang,
	Muavao_Banra
order by 
	DATEPART(YEAR,Trans_time),
	DATEPART(Month,Trans_time), 
	Store_ID, 
	Loai_tien, 
	Loai_hang, 
	Loai_khachhang, 
	Muavao_Banra
	
--Từng năm
insert into MCI_SQL..BanHang_Result
select 
	CONVERT(date,
		(
		CONVERT(varchar(4),DATEPART(YEAR,Trans_time)) + '1231'
		),112),
	'Tong Cham Tra Theo Nam',
	Store_ID,
	Loai_tien,
	Loai_hang,
	Loai_khachhang,
	Muavao_Banra,
	sum(Sotien_cham_tra) TongChamTra
from 
	MCI_SQL..Lesson2
group by
	DATEPART(YEAR,Trans_time),
	Store_ID,
	Loai_tien,
	Loai_hang,
	Loai_khachhang,
	Muavao_Banra
order by 
	DATEPART(YEAR,Trans_time),
	Store_ID, 
	Loai_tien, 
	Loai_hang, 
	Loai_khachhang, 
	Muavao_Banra