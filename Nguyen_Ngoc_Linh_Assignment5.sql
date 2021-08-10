------------Tạo ra bảng dữ liệu danh sách giao dịch trong tháng 4 năm 2019 --------

--select *
--into MCI_SQL..Lesson2_201904
--from MCI_SQL..Lesson2
--where
--	DATEPART(YEAR,Trans_Time) = 2019 and
--	DATEPART(MONTH,Trans_Time) = 4

--------------Tạo ra bảng dữ liệu danh sách giao dịch trong tháng 6 năm 2019 --------

--select *
--into MCI_SQL..Lesson2_201906
--from MCI_SQL..Lesson2
--where
--	DATEPART(YEAR,Trans_Time) = 2019 and
--	DATEPART(MONTH,Trans_Time) = 6

------1------So sánh số tiền giao dịch của từng nhân viên trong tháng 4 và tháng 6 

select 
	ISNULL(B.Sale_man_ID,C.Sale_man_ID) Sale_man_ID,
	ISNULL(TongT4,0) TongThang4,
	ISNULL(TongT6,0) TongThang6,
	abs(ISNULL(TongT4,0) - ISNULL(TongT6,0)) ChenhLech
from --(select distinct Sale_man_ID from Lesson2) A
--full outer join
(
	select Sale_man_ID, sum(Sotien_quydoi) TongT4
	from MCI_SQL..BanHang_201904
	group by Sale_man_ID
) B 
	--on A.Sale_man_ID = B.Sale_man_ID
full outer join 
(
	select Sale_man_ID, sum(Sotien_quydoi) TongT6
	from MCI_SQL..BanHang_201906
	group by Sale_man_ID
) C 
	on B.Sale_man_ID = C.Sale_man_ID
--where TongT4 is not null or TongT6 is not null
--where A.Sale_man_ID is null
order by 4 desc



------2------So sánh số tiền mua hàng của từng khách hàng trong tháng 4 và tháng 6

select 
	ISNULL(B.Ma_khachhang,C.Ma_khachhang) Ma_khachhangachHang,
	ISNULL(TongT4,0) TongThang4,
	ISNULL(TongT6,0) TongThang6,
	abs(ISNULL(TongT4,0) - ISNULL(TongT6,0)) ChenhLech
from --(select distinct Ma_khachhang from Lesson2) A
--left join
(
	select Ma_khachhang, sum(Sotien_quydoi) TongT4
	from MCI_SQL..Lesson2_201904
	group by Ma_khachhang) B 
	--on A.Ma_khachhang = B.Ma_khachhang
full outer join 
(
	select Ma_khachhang, sum(Sotien_quydoi) TongT6
	from MCI_SQL..Lesson2_201906
	group by Ma_khachhang) C 
	on B.Ma_khachhang = C.Ma_khachhang
--where TongT4 is not null or TongT6 is not null
order by 4 desc

-------3-----Lấy ra giao dịch có số tiền lớn nhất theo từng ngày và xem chiếm tỷ trọng bao nhiêu so với tổng số tiền của từng cửa hàng đó trong các ngày đó
select 
	A.Store_ID, A.Trans_Time, A.Sotien_quydoi,B.TongSoTien, round((Sotien_quydoi / TongSoTien * 100),2) TyTrong
from 
(
	select *
	from
	(
		select 
			Store_ID, Trans_Time, Sotien_quydoi,
			ROW_NUMBER() Over (Partition by Trans_Time,Sotien_quydoi order by Sotien_quydoi desc) STTTien,
			ROW_NUMBER() Over (Partition by Trans_Time order by Sotien_quydoi desc) STTNgay
		from 
			MCI_SQL..Lesson2
	) a
	where STTNgay = STTTien
) A left join
	(
		select 
			Store_ID, Trans_Time, sum(Sotien_quydoi) TongSoTien 
		from 
			MCI_SQL..Lesson2 
		group by 
			Store_ID, Trans_Time
	) B on A.Store_ID = B.Store_ID and A.Trans_Time = B.Trans_Time
order by A.Trans_Time



WITH tblTONGTIEN_CUAHANG as
( 
	select Store_ID,Trans_time, SUM(Sotien_quydoi) TONGTIEN
	from MCI_SQL..Lesson2
	group by Store_ID,Trans_time
)  

--select * from tblTONGTIEN_CUAHANG

select  
	A.Store_ID,
	A.Trans_time, 
	Sotien_quydoi, 
	((Sotien_quydoi/TONGTIEN)*100)  TYTRONG
from
(
	Select 
		ROW_NUMBER() OVER(PARTITION BY Store_ID, Trans_time order by Sotien_quydoi desc) RowNumber,*
	from MCI_SQL..Lesson2
)  A inner join tblTONGTIEN_CUAHANG  B
on A.Store_ID = B.Store_ID 
	and A.Trans_time = B.Trans_time
where RowNumber = 1 

--------4----Lấy ra khách hàng có số tiền giao lớn nhất theo ngày và theo cửa hàng và xem chiếm tỷ trọng bao nhiêu so với tổng số tiền giao dịch ngày đó của cửa hàng đó
select 
	A.Store_ID, A.Trans_Time, A.Ma_khachhang, A.Sotien_quydoi,B.TongSoTien, round((A.Sotien_quydoi / B.TongSoTien * 100),2) TyTrong
from 
(
	select *
	from
	(
		select 
			Store_ID, Trans_Time, Ma_Khachhang, Sotien_quydoi,
			ROW_NUMBER() Over (Partition by Store_ID,Trans_Time order by Sotien_quydoi desc) STT
		from 
			(select Store_ID, Trans_Time, Ma_khachhang, sum(Sotien_quydoi) Sotien_quydoi from MCI_SQL..Lesson2 group by Store_ID, Trans_Time, Ma_khachhang) a
	) a
	where STT = 1
) A 
left join
(
	select 
		Store_ID, Trans_Time, sum(Sotien_quydoi) TongSoTien 
	from 
		MCI_SQL..Lesson2 
	group by 
		Store_ID, Trans_Time
) B on A.Store_ID = B.Store_ID and A.Trans_Time = B.Trans_Time
order by 1,2


WITH tblTONGTIEN_CUAHANG(Store_ID,Trans_time, TONGTIENCUAHANG) as
( 
	select Store_ID,Trans_time, SUM(Sotien_quydoi) TONGTIEN
	from MCI_SQL..Lesson2
	group by Store_ID,Trans_time
)  

select 
	AA.Store_ID, 
	AA.Trans_time, 
	Ma_khachhang, 
	SoTienGiaoDich, 
	BB.TONGTIENCUAHANG,
	(SoTienGiaoDich/TONGTIENCUAHANG)*100 TY_Trong
from
(
	select 
		ROW_NUMBER() OVER(Partition by Store_ID, Trans_time order by SoTienGiaoDich desc) rownumber,*
	from 
	(
		select 
			Store_ID,
			Trans_time,
			Ma_khachhang, 
			sum(Sotien_quydoi) SoTienGiaoDich
		from 
			MCI_SQL..Lesson2
		Group by Store_ID,Trans_time,Ma_khachhang 
	) a
) AA 
inner join 
tblTONGTIEN_CUAHANG BB
	on AA.Store_ID = BB.Store_ID
	and AA.Trans_time = BB.Trans_time
where AA.rownumber = 1
order by 1,2

------5------Lấy ra giao dịch có số tiền lớn nhất theo từng ngày và từng cửa hàng và xem chiếm tỷ trọng bao nhiêu so với tổng của nhân viên đó trong các ngày đó

select 
	A.Store_ID, A.Trans_Time,  A.Sale_man_ID, A.Sotien_quydoi,B.TongSoTien, round((A.Sotien_quydoi / B.TongSoTien * 100),2) TyTrong
from 
(
	select *
	from
	(
		select 
			Store_ID, Trans_Time, Sale_man_ID,Sale_man, Sotien_quydoi,
			--DENSE_RANK() Over (Partition by Store_ID,Trans_Time order by Sotien_quydoi desc) DENSERANKTien,
			RANK() Over (Partition by Store_ID,Trans_Time order by Sotien_quydoi desc) RANKTien,
			ROW_NUMBER() Over (Partition by Store_ID,Trans_Time order by Sotien_quydoi desc) STT
		from 
			MCI_SQL..Lesson2
	) a
	where STT = 1 or RANKTien = 1
) A 
left join
(
	select 
		Store_ID, Trans_Time, Sale_man_ID, sum(Sotien_quydoi) TongSoTien 
	from 
		MCI_SQL..Lesson2 
	group by 
		Store_ID, Trans_Time, Sale_man_ID
) B on A.Store_ID = B.Store_ID and A.Trans_Time = B.Trans_Time and A.Sale_man_ID = B.Sale_man_ID
order by 1,2,3


WITH tblGiaoDichMAX  as
(
	select  Store_ID, Trans_time, Sale_man_ID, Sotien_quydoi
	from
		(
			Select 
				ROW_NUMBER() OVER(PARTITION BY  Store_ID, Trans_time order by Sotien_quydoi desc) RowNumber,*
			from MCI_SQL..Lesson2
		)  AA
	where RowNumber = 1 
),
tblTongGiaoDich_NV as
(
	select Store_ID, Trans_time, Sale_man_ID, sum(Sotien_quydoi) TongTien_NV
	from 
		MCI_SQL..Lesson2
	group by Sale_man_ID, Store_ID,Trans_time
)

select a.*, b.TongTien_NV, (a.Sotien_quydoi/TongTien_NV)*100 Ty_Trong
from 
	tblGiaoDichMAX a inner join tblTongGiaoDich_NV b
	on a.Sale_man_ID = b.Sale_man_ID and
		a.Store_ID = b.Store_ID and
		a.Trans_time = b.Trans_time 
order by 1,2,3

------6------Tính tổng số tiền giao dịch của từng nhân viên với từng cửa hàng trong từng tháng năm 2019 xem chiếm tỷ trọng bao nhiêu trên tổng doanh thu của cửa hàng trong từng tháng đó
select 
	A.Store_ID, A.Thang, A.Sale_man_ID, A.TongNhanVien, B.TongCuaHang, round((A.TongNhanVien / B.TongCuaHang * 100),4) TyTrong  
from
(
	select Store_ID, DATEPART(Month,Trans_Time) Thang, Sale_man_ID, sum(Sotien_quydoi) TongNhanVien
	from MCI_SQL..Lesson2
	where DATEPART(Year,Trans_Time) = 2019
	group by Store_ID,Sale_man_ID, DATEPART(Month,Trans_Time)
	--order by 1,2,3
) A
left join
(
	select Store_ID, DATEPART(Month,Trans_Time) Thang, sum(Sotien_quydoi) TongCuaHang
	from MCI_SQL..Lesson2
	where DATEPART(Year,Trans_Time) = 2019
	group by Store_ID, DATEPART(Month,Trans_Time)
	--order by 1,2
) B on A.Store_ID = B.Store_ID and A.Thang = B.Thang
order by 1,2,4 desc

-------7-----Lấy ra số tiền giao dịch lớn nhất của từng nhân viên với từng cửa hàng trong năm 2019 xem chiếm tỷ trọng bao nhiêu trên tổng giao dịch của nhân viên đó trong cửa hàng đó
select 
	A.Store_ID, A.Sale_man_ID,A.Sotien_quydoi,B.TongGiaoDich, round((A.Sotien_quydoi / B.TongGiaoDich * 100),2) TyTrong 
from
(
	select * 
	from
	(
		select Store_ID, Sale_man_ID, Sotien_quydoi,
			ROW_NUMBER() OVER(Partition by Store_ID,Sale_man_ID order by Sotien_quydoi desc) RowNumber,
			RANK() OVER(Partition by Store_ID,Sale_man_ID order by Sotien_quydoi desc) RowNumberTien
		from MCI_SQL..Lesson2 
		where DATEPART(YEAR,Trans_Time) = 2019
	) a
	where RowNumber = 1 or RowNumberTien = 1) A
left join
(
	select 
		Store_ID, Sale_man_ID, sum(Sotien_quydoi) TongGiaoDich
	from 
		MCI_SQL..Lesson2
	group by 
		Store_ID, Sale_man_ID) B
on A.Store_ID = B.Store_ID and A.Sale_man_ID = B.Sale_man_ID
--where RowNumber = 2 and RowNumberTien = 2
order by 1,2


WITH tblGiaoDichMAX as
(
	select Store_ID,Sale_man_ID, Sotien_quydoi
	from
	(
		Select 
			ROW_NUMBER() OVER(PARTITION BY  Sale_man_ID,Store_ID order by Sotien_quydoi desc) RowNumber,*
		from MCI_SQL..Lesson2
		where YEAR(Trans_time) = 2019
	)  AA
	where RowNumber = 1 
	
),
tblTongGiaoDich_NV as
(
	select Sale_man_ID, Store_ID, sum(Sotien_quydoi) TongTien_NV
	from 
		MCI_SQL..Lesson2
	where Year(Trans_time) =2019
	group by Sale_man_ID, Store_ID
)

select a.*, TongTien_NV, (a.Sotien_quydoi/TongTien_NV)*100 Ty_Trong
from 
	tblGiaoDichMAX a inner join tblTongGiaoDich_NV b
	on a.Sale_man_ID = b.Sale_man_ID and
		a.Store_ID = b.Store_ID 
order by Store_ID, Sale_man_ID

-----8-------Update bảng Discount cột MucChietKhau = 0.01 nếu MucToiThieu từ 0 -> 5, MucChietKhau = 0.02 nếu MucToiThieu từ 6 -> 10, MucChietKhau = 0.03 nếu MucToiThieu từ 11 -> 30 còn lại mức chiết khấu là 0.05
update MCI_SQL..Discount set MucChietKhau = 
case when MucToiThieu between 0 and 5 then 0.01
	when MucToiThieu between 6 and 10 then 0.02
	when MucToiThieu between 11 and 30 then 0.03
	else 0.05 end

-----9-------Update bảng Customer_New cột STT = 1 nếu Sex = 'MS', STT = 2 nếu Sex = 'MR' còn lại là STT = 3
update MCI_SQL..CustomerNoDuplicate set STT =
case when Sex = 'Ms' then 1
	when Sex = 'Mr' then 2
	else 3 end

------10------Xóa dòng dữ liệu trùng trong bảng Customer
with temptable as(
select *
from
(
	select *,
		ROW_NUMBER() OVER (PARTITION BY CustomerID order by [Address] desc) rownumber
	from MCI_SQL..Customer
)a
where rownumber >= 2
)
delete from temptable

select * from Customer