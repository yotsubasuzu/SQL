--1. lấy tổng số tiền theo từng cửa hàng
select 
	Store_ID, sum(Sotien_nguyente) TongGiaoDich
from 
	MCI_SQL..Lesson2 
group by 
	Store_ID 
order by Store_ID;

--2. lấy tổng số tiền theo từng mã cửa hàng có loại hàng là Metal Angel, LL Road Pedal, Internal Lock Washer, Hex Nut 11
select 
	Store_ID, sum(Sotien_nguyente) TongGiaoDich
from 
	MCI_SQL..Lesson2 
where 
	Loai_hang in ('Metal Angel','LL Road Pedal','Internal Lock Washer','Hex Nut 11') 
group by
	Store_ID 
order by Store_ID;

--3. Lấy tổng số tiền theo từng mã cửa hàng có loại hàng bắt đầu bằng các chữ cái sau LL, ML, HL 
select 
	Store_ID, Loai_hang, sum(Sotien_nguyente) TongGiaoDich
from 
	MCI_SQL..Lesson2 
where 
	Loai_hang like 'LL%' or 
	Loai_hang like 'ML%' or 
	Loai_hang like 'HL%' 
group by 
	Store_ID,Loai_hang 
order by Store_ID;

--4. Lấy tổng số tiền theo từng mã cửa hàng có thời điểm giao dịch vào ngày 20190402 
select 
	Store_ID, sum(Sotien_nguyente) TongGiaoDich
from 
	MCI_SQL..Lesson2 
where 
	Trans_Time = '20190402' 
group by 
	Store_ID 
order by Store_ID;

--5.Lấy tổng số tiền theo từng mã cửa hàng có thời điểm giao dịch vào ngày 20190402 của những giao dịch có số tiền > 100 triệu
select 
	Store_ID, sum(Sotien_nguyente) TongGiaoDich
from 
	MCI_SQL..Lesson2 
where 
	Trans_Time = '20190402' and 
	Sotien_nguyente > power(10,8) 
group by 
	Store_ID 
order by Store_ID;

--6. Lấy tổng số tiền giao dịch, tổng số tiền chiết khấu, tổng số tiền chậm trả theo từng mã cửa hàng có thời điểm giao dịch vào ngày 20190402 của những loại hàng có tên có từ Frame
select 
	Store_ID, 
	sum(Sotien_nguyente) TongGiaoDich, 
	sum(Muc_chiet_khau) TongChietKhau, 
	sum(Sotien_cham_tra) TongChamTra 
from 
	MCI_SQL..Lesson2 
where 
	Trans_Time = '20190402' and 
	Loai_hang like '%Frame%' 
group by 
	Store_ID 
order by Store_ID;

--7. Lấy ra số lượng giao dịch theo từng loại khách hàng trong ngày 20190402
select 
	Loai_khachhang, count(Retail_bill) 
from 
	MCI_SQL..Lesson2 
where 
	Trans_Time = '20190402' 
group by 
	Loai_khachhang 
order by Loai_khachhang;

--8. Lấy ra tổng số tiền giao dịch,số lượng giao dịch theo từng loại khách hàng trong ngày 20190402
select 
	Loai_khachhang, 
	count(Retail_bill) SoLuongGiaoDich, 
	sum(Sotien_nguyente) TongGiaoDich
from 
	MCI_SQL..Lesson2 
where 
	Trans_Time = '20190402' 
group by 
	Loai_khachhang 
order by Loai_khachhang;

--9. Lấy ra số tiền giao dịch lớn nhất của từng cửa hàng trong ngày 20190402
select 
	Store_ID, max(Sotien_nguyente) STGDLonNhat
from 
	MCI_SQL..Lesson2 
where 
	Trans_Time = '20190402' 
group by 
	Store_ID 
order by Store_ID;

--10. Lấy ra số tiền giao dịch nhỏ nhất của từng cửa hàng trong ngày 20190402
select 
	Store_ID, min(Sotien_nguyente) STGDNhoNhat
from 
	MCI_SQL..Lesson2 
where 
	Trans_Time = '20190402' 
group by 
	Store_ID 
order by Store_ID;

--11. Lấy ra tổng số tiền giao dịch của từng của hàng và từng nhân viên trong cửa hàng đó
--Tổng số tiền giao dịch từng cửa hàng
select 
	Store_ID, sum(Sotien_nguyente) TongGiaoDich
from 
	MCI_SQL..Lesson2 
group by 
	Store_ID 
order by Store_ID; 
--Tổng số tiền giao dịch từng nhân viên
select 
	Store_ID, Sale_man_ID, Sale_man, sum(Sotien_nguyente) TongGiaoDich 
from 
	MCI_SQL..Lesson2 
group by 
	Store_ID, Sale_man_ID, Sale_man
order by Store_ID, sum(Sotien_nguyente) desc; 

--12. Lấy ra tổng số tiền giao dịch, Số lượng giao dịch, tổng số tiền hoa hồng (bằng hoa hông * so tien nguyen te / 100) của từng cửa hàng và từng nhân viên trong cửa hàng đó
--Từng cửa hàng
select 
	Store_ID, sum(Sotien_nguyente) TongGiaoDich, 
	count(retail_bill) SoLuongGiaoDich, 
	sum(Hoa_hong) * sum(Sotien_nguyente)/100 TongHoaHong
from 
	MCI_SQL..Lesson2 
group by 
	Store_ID 
order by Store_ID, sum(Sotien_nguyente);

--Từng nhân viên trong cửa hàng
select 
	Store_ID, Sale_man_ID, Sale_man,
	sum(Sotien_nguyente) TongGiaoDich, 
	count(retail_bill) SoLuongGiaoDich, 
	sum(Hoa_hong) * sum(Sotien_nguyente)/100 TongHoaHong
from 
	MCI_SQL..Lesson2 
group by 
	Store_ID,Sale_man_ID, Sale_man
order by Store_ID, sum(Sotien_nguyente);

--13. Lấy ra tổng số tiền giao dịch theo từng khách hàng của từng cửa hàng. Chỉ lấy ra những khách hàng có tổng số tiền > 500 triệu
select 
	Store_ID, Ma_khachhang, 
	sum(Sotien_nguyente) TongGiaoDich
from 
	MCI_SQL..Lesson2 
group by 
	Store_ID, Ma_khachhang 
having 
	sum(Sotien_nguyente) > 5*power(10,8) 
order by 3;

--14. Lấy ra tổng số tiền giao dịch theo từng khách hàng của từng cửa hàng. Chỉ lấy ra những khách hàng có tổng số tiền > 500 triệu và chỉ lấy các giao dịch của ngày 20190402
select 
	Store_ID, Ma_khachhang, 
	sum(Sotien_nguyente) TongGiaoDich
from 
	MCI_SQL..Lesson2 
where 
	Trans_Time = '20190402' 
group by 
	Store_ID, Ma_khachhang 
having 
	sum(Sotien_nguyente) > 5*power(10,8) 
order by 3;

--15. Lấy ra 10 nhân viên có số tiền giao dịch lớn nhất tại ngày 20190402 của cửa hàng STORE 1
select top 10 
	Sale_man_ID, 
	sum(Sotien_nguyente) TongGiaoDich
from 
	MCI_SQL..Lesson2 
where 
	Trans_Time = '20190402' and 
	Store_ID = 'STORE 1' 
group by 
	Sale_man_ID 
order by sum(Sotien_nguyente) desc;

--16. Lấy ra 10 nhân viên có số tiền giao dịch nhỏ nhất tại ngày 20190402 của cửa hàng STORE 1 có tổng số tiền giao dịch > 500 triệu
select top 10 
	Sale_man_ID, 
	sum(Sotien_nguyente) TongGiaoDich
from 
	MCI_SQL..Lesson2 
where 
	Trans_Time = '20190402' and 
	Store_ID = 'STORE 1' 
group by 
	Sale_man_ID 
order by sum(Sotien_nguyente);

--17. Lấy ra giao dịch của các nhân viên có chữ thứ 2 của tên nhân viên là a
select * 
from 
	MCI_SQL..Lesson2 
where 
	Sale_man like '_a%'
group by 
	Sale_man 
order by Sale_man;

--18. Lấy ra giao dịch của các nhân viên có chữ thứ 3 của tên nhân viên là c
select * 
from 
	MCI_SQL..Lesson2 
where 
	Sale_man like '__c%' 
group by 
	Sale_man 
order by Sale_man;

--19. Tính tổng số tiền của cửa hàng 1 có thời điểm giao dịch là 20190402 và có địa chỉ nhân viên ở Kon tum và
--Tổng số tiền của cửa hàng 3 có địa chỉ nhân viên ở Dak Nong và 
--Tổng số tiền của cửa hàng 23 có địa chỉ nhân viên ở Dong Thap
select 
	Store_ID, Sale_man_address, sum(Sotien_nguyente) TongGiaoDich
from 
	MCI_SQL..Lesson2 
where 
Trans_Time = '20190402' and 
(Sale_man_address = 'Kon tum' and Store_ID = 'Store 1') or 
(Sale_man_address = 'Dak Nong' and Store_ID = 'Store 3') or 
(Sale_man_address = 'Dong Thap' and Store_ID = 'Store 23')
group by 
	Store_Id, Sale_man_address 
order by Store_ID;

--20. Tính tổng số tiền của các cửa hàng STORE 1, STORE 3, STORE 42 trong các ngày 20190402,20190613,20190618 trong đó mỗi cửa hàng là 1 cột và mỗi ngày là 1 dòng 
select * 
from (
select 
	Store_ID, Trans_Time, Sotien_nguyente 
from 
	MCI_SQL..Lesson2 where 
	Store_ID in ('Store 1','Store 3','Store 42') and 
	Trans_Time in ('20190402','20190613','20190618')) src
pivot (
	sum(Sotien_nguyente) 
	for 
		Store_Id in ([Store 1],[Store 3],[Store 42])) piv 
	order by piv.Trans_Time;


--21. Lấy ra cửa hàng có số tiền giao dịch nhỏ nhất và cửa hàng có số tiền giao dịch lớn nhất
select * 
from (
	select top 1 
		Store_ID, Sotien_nguyente 
	from 
		MCI_SQL..Lesson2 
	order by Sotien_nguyente) a
union all
select * 
from (
	select top 1 
		Store_ID, Sotien_nguyente 
	from 
		MCI_SQL..Lesson2 
	order by Sotien_nguyente desc) b

----------------------------------------------------------

-----BTVN
select top 5 * from MCI_SQL..Lesson1;

--1. Lấy tổng số tiền theo từng mã chi nhánh 
select 
	CO_CODE, sum(QUY_DOI) TongSoTien
from 
	MCI_SQL..Lesson1
group by
	CO_CODE
order by CO_CODE;

--2. Lấy tổng số tiền theo từng mã chi nhánh có kỳ hạn là 1,2,3,4,5,6 tháng 
select 
	CO_CODE, sum(QUY_DOI) TongSoTien
from 
	MCI_SQL..Lesson1
where
	LOC_TERM in ('1','2','3','4','5','6')
group by
	CO_CODE
order by CO_CODE;

--3. Lấy tổng số tiền theo từng mã chi nhánh có ngày mở hợp đồng là 20170101 và chỉ lấy các chi nhánh có tổng số tiền > 1 tỷ 
select 
	CO_CODE, sum(QUY_DOI) TongSoTien
from 
	MCI_SQL..Lesson1
where
	VALUE_DATE = '20170103'
group by
	CO_CODE
having sum(QUY_DOI) > POWER(10,9)
order by CO_CODE;

--4. Lấy ra số tiền lớn nhất và nhỏ nhất theo từng chi nhánh 
select * from 
	(select
		CO_CODE, min(QUY_DOI) SoTienMin
	from 
		MCI_SQL..Lesson1
	group by
		CO_CODE) nhonhat
union all
select * from 
	(select
		CO_CODE, max(QUY_DOI) SotienMax
	from 
		MCI_SQL..Lesson1
	group by
		CO_CODE) lonnhat
order by 1,2

--5. Lấy tổng số tiền theo từng mã chi nhánh và kỳ hạn đi kèm sắp xếp theo thứ tự tăng dần của tổng số tiền 
select 
	CO_CODE, LOC_TERM, sum(QUY_DOI) TongSoTien
from 
	MCI_SQL..Lesson1
group by
	CO_CODE, LOC_TERM
order by sum(QUY_DOI);

--6. Tính tổng số tiền theo từng mã chi nhánh,số tiền bình quân theo từng chi nhánh và tính tỷ lệ số tiền bình quân trên tổng số tiền 
select 
	CO_CODE, sum(QUY_DOI) TongSoTien, avg(QUY_DOI), avg(QUY_DOI) / sum(QUY_DOI) * 100
from
	MCI_SQL..Lesson1
group by 
	CO_CODE
order by CO_CODE;

--7. Tính số lượng khách hàng theo mỗi chi nhánh(chú ý 1 khách hàng có nhiều hợp đồng), số lượng hợp đồng theo mỗi chi nhánh 
select 
	CO_CODE, count(distinct CUSTOMER) SoKhachHang, 
	count(RECID) SoHopDong
from 
	MCI_SQL..Lesson1
group by
	CO_CODE
order by CO_CODE;

--8. Lấy ra khách hàng có số tiền lớn nhất và khách hàng có số tiền nhỏ nhất 
select 
	CUSTOMER, sum(QUY_DOI) TongSoTien
from 
	MCI_SQL..Lesson1
group by 
	CUSTOMER
having sum(QUY_DOI) = (select top 1 sum(QUY_DOI) from MCI_SQL..Lesson1 group by CUSTOMER order by sum(QUY_DOI))

union all

select 
	CUSTOMER, sum(QUY_DOI) TongSoTien 
from 
	MCI_SQL..Lesson1
group by 
	CUSTOMER
having sum(QUY_DOI) = (select top 1 sum(QUY_DOI) from MCI_SQL..Lesson1 group by CUSTOMER order by sum(QUY_DOI) desc)

--9. Lấy ra tổng số tiền theo từng kỳ hạn chia theo các nhóm sau: 
----H00, null => KKH 
select 
	'KKH', sum(QUY_DOI) TongSoTien
from 
	MCI_SQL..Lesson1
where 
	LOC_TERM is null or LOC_TERM = 'H00'
union all
----(D03,D05,D06,D07,D08,D11,D12,D13,D14,D15,D17,D19,D20,D21,D22,D24) => CKH <= 1M 
select 
	'CKH <= 1M', sum(QUY_DOI) TongSoTien
from 
	MCI_SQL..Lesson1
where 
	LOC_TERM in ('7D','14D','21D')
union all

----(M01,M02,M03) => CKH <= 3M 
select 
	'CKH <= 3M', sum(QUY_DOI) TongSoTien
from 
	MCI_SQL..Lesson1
where 
	LOC_TERM in ('1','2','3')
union all

----(M04,M05,M06) => CKH 46M
select 
	'CKH 46M', sum(QUY_DOI) TongSoTien
from 
	MCI_SQL..Lesson1
where 
	LOC_TERM in ('4','5','6')
union all

----(M07,M08,M09,M10,M11,M12) => CKH 712M 
select 
	'CKH 712M', sum(QUY_DOI) TongSoTien
from 
	MCI_SQL..Lesson1
where 
	LOC_TERM in ('7','8','9','10','11','12','366D')
union all

----Các kỳ hạn còn lại vào nhóm CKH > 12M 
select 
	'CKH > 12M', sum(QUY_DOI) TongSoTien
from 
	MCI_SQL..Lesson1
where 
	LOC_TERM not in ('7D','14D','21D','1','2','3','4','5','6','7','8','9','10','11','12','366D')

--10. Lấy ra tổng số tiền theo từng chi nhánh chia theo các nhóm dựa vào số tiền trên hợp đồng như sau. Và sắp xếp kết quả theo mã chi nhánh tăng dần: 

----Dưới 500 triệu 
select 
	'<500tr', sum(QUY_DOI) TongSoTien
from 
	MCI_SQL..Lesson1
where
	QUY_DOI < 5*POWER(10,8) 
union all
----Từ 500 triệu – 1 tỷ 
select 
	'500tr-1ty', sum(QUY_DOI) TongSoTien
from 
	MCI_SQL..Lesson1
where
	QUY_DOI between 5*POWER(10,8) and POWER(10,9)
union all
----Lớn hơn 1 tỷ và nhỏ hơn bằng 5 tỷ 
select 
	'1ty-5ty', sum(QUY_DOI) TongSoTien
from 
	MCI_SQL..Lesson1
where
	QUY_DOI between POWER(10,9) and 5*CONVERT(bigint, POWER(10,9))
union all

----Lớn hơn 5 tỷ và nhỏ hơn bằng 10 tỷ 
select 
	'5ty-10ty', sum(QUY_DOI) TongSoTien
from 
	MCI_SQL..Lesson1
where
	QUY_DOI between 5*CONVERT(bigint, POWER(10,9)) and 10000000000
union all

----Lớn hơn 10 tỷ 
select 
	'>10ty', sum(QUY_DOI) TongSoTien
from 
	MCI_SQL..Lesson1
where
	QUY_DOI > 10000000000

--Bai 9
select 
	--RECID, 
	--LOC_TERM, 
	case when LOC_TERM = 'H00' or LOC_TERM is null then 'KKH'
		when LOC_TERM in ('7D','14D','21D') then 'CKH <=1M'
		when LOC_TERM in ('1','2','3') then 'CKH <= 3M'
		when LOC_TERM in ('4','5','6') then 'CKH 4-6M'
		when LOC_TERM in ('7','8','9','10','11','12','366D') then 'CKH 7-12'
		else 'CKH > 12M' end as Tenor,
	sum(QUY_DOI) TongSoTien
from
	MCI_SQL..Lesson1
group by 
	case when LOC_TERM = 'H00' or LOC_TERM is null then 'KKH'
		when LOC_TERM in ('7D','14D','21D') then 'CKH <=1M'
		when LOC_TERM in ('1','2','3') then 'CKH <= 3M'
		when LOC_TERM in ('4','5','6') then 'CKH 4-6M'
		when LOC_TERM in ('7','8','9','10','11','12','366D') then 'CKH 7-12'
		else 'CKH > 12M' end
order by 1

--Bai 10
select
	case when QUY_DOI < 5*POWER(10,8) then '<500tr'
		when QUY_DOI between 5*POWER(10,8) and POWER(10,9) then '500tr-1ty'
		when QUY_DOI between POWER(10,9) and 5*CONVERT(bigint,POWER(10,9)) then '1ty-5ty'
		when QUY_DOI between 5*CONVERT(bigint,POWER(10,9)) and 10*CONVERT(bigint,POWER(10,9)) then '5ty-10ty'
		when QUY_DOI > 10*CONVERT(bigint,POWER(10,9)) then '>10ty' end as MucGiaoDich,
	sum(QUY_DOI) TongSoTien
from 
	MCI_SQL..Lesson1
group by
	case when QUY_DOI < 5*POWER(10,8) then '<500tr'
		when QUY_DOI between 5*POWER(10,8) and POWER(10,9) then '500tr-1ty'
		when QUY_DOI between POWER(10,9) and 5*CONVERT(bigint,POWER(10,9)) then '1ty-5ty'
		when QUY_DOI between 5*CONVERT(bigint,POWER(10,9)) and 10*CONVERT(bigint,POWER(10,9)) then '5ty-10ty'
		when QUY_DOI > 10*CONVERT(bigint,POWER(10,9)) then '>10ty' end
order by 1

