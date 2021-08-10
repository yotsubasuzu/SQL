--LAB 2
--I. Hãy viết câu lệnh tạo một cơ sở dữ liệu có tên “BANHANG” và các câu lệnh trên CSDL này để tạo các bảng theo liệt kê bên dưới. 
--Trong mỗi bảng, thuộc tính được gạch chân là khóa chính của bảng. Khi tạo bảng cần đảm bảo các thuộc tính có kiểu dữ liệu như yêu cầu, đồng thời tạo các ràng buộc đi kèm.
--Ràng buộc cần có trong bảng BANHANG: TENKH not null, DT có thể từ 7 đến 10 chữ số. 
--Ràng buộc cần có trong bảng VATTU: TENVT not null, GIAMUA >0, SLTON >=0.
--Ràng buộc cần có trong bảng HOADON: MAKH là khóa ngoại tham chiếu tới MAKH trong bảng KHACHHANG. Giá trị nhập vào cho trường NGAY phải trước ngày hiện hành
--Ràng buộc cần có trong bảng CHITIET: MAHD là khóa ngoại tham chiếu tới MAHD trong bảng HOADON, MAVT là khóa ngoại tham chiếu tới MAVT trong bảng VATTU. Giá trị nhập vào cho trường SL phải lớn hơn 0

create table BANHANG..KHACHHANG(
	MAKH Nvarchar(5) primary key,
	TENKH Nvarchar(30) not null,
	DIACHI Nvarchar(50),
	DT Nvarchar(10) check (len(DT) between 7 and 10),
	EMAIL Nvarchar(30)
);
create table BANHANG..VATTU(
	MAVT Nvarchar(5) primary key,
	TENVT Nvarchar(30) not null,
	DVT Nvarchar(20),
	GIAMUA int check (GIAMUA > 0),
	SLTON int check (SLTON >= 0)
);
create table BANHANG..HOADON(
	MAHD Nvarchar(10) primary key,
	NGAY DateTime check (Ngay < GETDATE()),
	MAKH Nvarchar(5) foreign key references BANHANG..KHACHHANG(MaKH),
	TONGTG int
);
create table BANHANG..CHITIETHOADON(
	MAHD Nvarchar(10) foreign key references BANHANG..HOADON(MaHD),
	MAVT Nvarchar(5) foreign key references BANHANG..VATTU(MaVT),
	SL int check (SL>0),
	KHUYENMAI int,
	GIABAN int,
);

--II. Tiếp theo, hãy viết câu lệnh để điền các dữ liệu như được liệt kê dưới đây vào Cơ sở dữ liệu đã tạo
select * from BANHANG..KHACHHANG
select * from BANHANG..HOADON
select * from BANHANG..VATTU
select * from BANHANG..CHITIETHOADON

--drop table CHITIETHOADON
--drop table HOADON
--drop table VATTU
--drop table KHACHHANG

bulk insert BANHANG..CHITIETHOADON
from 'C:\Users\tocba\Desktop\new.csv'
with 
(
	firstrow = 2,
	fieldterminator = '\t',
	rowterminator = '\n'
)

--LAB 3

--Câu 1. Hiển danh sách các khách hàng có điện thoại là 8457895 gồm mã khách hàng, tên khách hàng, địa chỉ, điện thoại, và địa chỉ E-mail.
select * 
from BANHANG..KHACHHANG 
where DT = '8457895'

--Câu 2.Hiển danh sách các vật tư là “DA” (bao gồm các loại đá) có giá mua dưới 30000 gồm mã vật tư, tên vật tư, đơn vị tính và giá mua .
select MAVT, TENVT, DVT, GIAMUA 
from BANHANG..VATTU 
where TENVT like 'DA%' and GIAMUA < 30000


--Câu 3.Tạo query để lấy ra các thông tin gồm Mã hoá đơn, ngày lập hoá đơn, tên khách hàng, địa chỉ khách hàng và số điện thoại, sắp xếp theo thứ tự ngày tạo hóa đơn giảm dần
select MAHD, NGAY, TENKH, DIACHI, DT 
from BANHANG..HOADON A inner join
	BANHANG..KHACHHANG B 
	on A.MAKH = B.MAKH 
order by NGAY desc


--Câu 4.Lấy ra danh sách những khách hàng mua hàng trong tháng 6/2000 gồm các thông tin tên khách hàng, địa chỉ, số điện thoại.
select TENKH, DIACHI, DT 
from BANHANG..KHACHHANG A inner join 
	HOADON B 
	on A.MAKH = B.MAKH 
where NGAY between '20000601' and '20000630'

--Câu 5.Tạo query để lấy ra các chi tiết hoá đơn gồm các thông tin mã hóa đơn, ,mã vật tư, tên vật tư, giá bán, giá mua, số lượng , trị giá mua (giá mua * số lượng), trị giá bán , (giá bán * số lượng),
--tiền lời (trị giá bán – trị giá mua) mà có giá bán lớn hơn hoặc bằng giá mua.
select A.MAHD, A.MAVT, TENVT, GIABAN, SL, GIAMUA*SL TRIGIAMUA, GIABAN*SL TRIGIABAN, (GIABAN*SL) - (GIAMUA*SL) TIENLOI
from CHITIETHOADON A inner join
	HOADON B on A.MAHD = B.MAHD inner join
	VATTU C on A.MAVT = C.MAVT
where GIABAN > GIAMUA

--Câu 6.Lấy ra hoá đơn có tổng trị giá nhỏ nhất trong số các hóa đơn năm 2000, gồm các thông tin: Số hoá đơn, ngày, tên khách hàng, địa chỉ khách hàng, tổng trị giá của hoá đơn.

select top 1 
	A.MAHD, NGAY, TENKH, DIACHI, DT, TONGTIEN 
from 
	HOADON A inner join
	(
		select MaHD, sum(THANHTIEN) TONGTIEN 
		from
			(
				select *, SL*GIABAN THANHTIEN 
				from CHITIETHOADON
			) a
		group by MAHD
	) B on A.MAHD = B.MAHD inner join 
	KHACHHANG C on A.MAKH = C.MAKH
where 
	NGAY between '20000101' and '20001231'
order by TONGTIEN 

--Câu 7.Lấy ra các thông tin về các khách hàng mua ít loại mặt hàng nhất.
select
	C.MAKH, C.TENKH, C.DIACHI, C.DT, A.MAHD, B.SOLUONGMUA
from 
	HOADON A inner join
	(
		select MAHD, count(*) SOLUONGMUA
		from CHITIETHOADON
		group by MAHD
	) B on A.MAHD = B.MAHD inner join
	KHACHHANG C on A.MAKH = C.MAKH
where 
	SOLUONGMUA = 
	(
		select min(SOLUONGMUA) 
		from 
			(
			select MAHD, count(*) SOLUONGMUA
			from CHITIETHOADON
			group by MAHD
			) b
	)
order by 1

--Câu 8.Lấy ra vật tư có giá mua thấp nhất
select top 1 * from VATTU order by GIAMUA

--Câu 9.Lấy ra vật tư có giá bán cao nhất trong số các vật tư được bán trong năm 2000.
select top 1
	A.MAVT, TENVT, GIAMUA, GIABAN, NGAY
from 
	CHITIETHOADON A inner join 
	VATTU B on A.MAVT = B.MAVT inner join 
	HOADON C on A.MAHD = C.MAHD 
where 
	NGAY between '20000101' and '20001231' 
order by GIABAN desc

--Câu 10.Cho biết mỗi vật tư đã được bán tổng số bao nhiêu đơn vị (chiếc, cái,… )
select 
	A.MAVT, TENVT, DVT, sum(SL) SLDABAN 
from 
	CHITIETHOADON A right join 
	VATTU B on A.MAVT = B.MAVT
group by 
	A.MAVT, TENVT, DVT

--Chú ý: Có thể có những vật tư chưa bán được đơn vị nào, khi đó cần hiển thị là đã bán 0 đơn vị.




--LAB 4

--Trên CSDL BanHang đã thao tác trong Lab2 và Lab3, hãy viết các Stored Procedure (SP), Trigger và Function như yêu cầu dưới đây:
--Viết câu lệnh tạo SP có tên sp_Cau1 cập nhật thông tin TONGGT trong bảng HOADON theo dữ liệu thực tế trong bảng CHITIETHOADON.
create procedure sp_Cau1 as
begin
	declare @mahddau varchar(10) = (select top 1 MaHD from ChiTietHoaDon order by 1)
	declare @mahdcuoi varchar(10) = (select top 1 MaHD from ChiTietHoaDon order by 1 desc)
	declare @mahd varchar(10) = @mahddau
	update HOADON set TONGTG = 0 where MaHD	= @mahd
	while @mahd <= @mahdcuoi
		begin
			declare @mavtdau varchar(5) = (select top 1 MaVT from VATTU order by 1)
			declare @mavtcuoi varchar(5) = (select top 1 MaVT from VATTU order by 1 desc)
			declare @mavt varchar(5) = @mavtdau
			--if exists (select * from HOADON where MaHD = @mahd)
			--begin
				while @mavt <= @mavtcuoi
				begin
					--print @mahd + ' - ' + @mavt
					if exists (select * from ChiTietHoaDon where MaHD = @mahd and MaVT = @mavt)
						update HOADON set TONGTG = TONGTG + (select SL from ChiTietHoaDon where MaHD = @mahd and MaVT = @mavt) * (select GiaBan from ChiTietHoaDon where MaHD = @mahd and MaVT = @mavt) where MaHD = @mahd;
					set @mavt = 'VT0' + convert(varchar,convert(int,substring(@mavt,3,4)) + 1);
				end
			--end
			--print @mahd
			if (@mahd < 'HD009')
				begin
				set @mahd = 'HD00' + convert(varchar,convert(int,substring(@mahd,4,5)) + 1);
				--print @mahd
				end
			else
				set @mahd = 'HD0' + convert(varchar,convert(int,substring(@mahd,4,5)) + 1);
		end
end
drop procedure sp_Cau1
exec sp_Cau1

select * from HOADON

--Viết câu lệnh tạo hàm (function) có tên fc_Cau3 có kiểu dữ liệu trả về là INT, nhập vào 1 mã khách hàng rồi đếm xem khách hàng này đã mua tổng cộng bao nhiêu tiền. 
--Kết quả trả về của hàm là số tiền mà khách hàng đã mua.
create function dbo.fc_Cau3 (@makh varchar(5))
returns int
as
begin
	return (select sum(TongTG) from HOADON where MaKH = @makh)
end

select *, dbo.fc_Cau3(MaKH) TongTienDaMua from KHACHHANG

--Viết câu lệnh tạo hàm fc_cau4 có kiểu dữ liệu trả về là NVARCHAR(5), tìm xem vật tư nào là vật tư bán được nhiều tiền nhất. Kết quả trả về cho hàm là mã của vật tư này. 
--Trong trường hợp có nhiều vật tư cùng bán được số tiền nhiều nhất như nhau, chỉ cần trả về mã của một trong số các vật tư này.
create function dbo.fc_Cau4 ()
returns nvarchar(5)
as
begin
	return (select MaVT from 
	(select top 1 B.MaVT, sum(A.SL*A.GiaBan) TongSoTien from ChiTietHoaDon A inner join VATTU B on A.MaVT = B.MaVT group by B.MaVT order by 2 desc) a) 
end

--Viết câu lệnh tạo SP có sp_Cau5, có hai tham số kiểu output là @MaVT NVARCHAR(5) và @TenVT NVARCHAR(30) để trả về mã và tên của vật tư bán được nhiều tiền nhất. 
--Trong trường hợp có nhiều vật tư cùng bán được số tiền nhiều nhất như nhau, chỉ cần trả về mã và tên của một trong số các vật tư này.
create procedure sp_Cau4 as
begin
select top 1 B.MaVT, B.TenVT, sum(A.SL*A.GiaBan) from ChiTietHoaDon A inner join VATTU B on A.MaVT = B.MaVT group by B.MaVT, B.TenVT order by 3 desc
end


--Viết câu lệnh tạo trigger có tên tg_Cau6 để đảm bảo ràng buộc: nếu cập nhật giá mua của vật tư (trong bảng VATTU) thì chỉ có thể cập nhật tăng, không được cập nhật giảm giá.
create trigger tg_Cau6
on ChiTietHoaDon 
after update
as
declare @mavt varchar(5) = (select MaVT from inserted)
declare @mahd varchar(10) = (select MaHD from inserted)
if exists (select GiaBan from inserted where MAVT = @mavt and MaHD = @mahd and GiaBan < 
(select GiaBan from deleted where MAVT = @mavt and MaHD = @mahd))
begin
	print 'Gia sua thap hon gia cu.'
	rollback tran
end

--Viết câu lệnh tạo trigger có tên tg_Cau7 để đảm bảo ràng buộc: khi thêm một hóa đơn vào CSDL, cần đảm bảo khách hàng đã mua hóa đơn này đã có trong bảng KHACHHANG. 
--Trường hợp khách hàng chưa có trong bảng khách hàng, hãy thêm thông tin khách hàng vào bảng KHACHHANG trước. 
--Trong đó, KHACHHANG sẽ có tên và mã số giống nhau, chính là mã số khách hàng trong thông tin hóa đơn. Các thông tin còn lại của khách hàng lấy giá trị NULL.
create trigger tg_Cau7 
on HOADON
after insert
as
begin
declare @mahd varchar(10) = (select MaHD from inserted)
declare @makh varchar(5) = (select MaKH from inserted)
if not exists (select * from KHACHHANG where MAKH = @makh)
	begin
		print 'Ma KH chua co trong CSDL, them MaKH vao CSDL'
		insert into KHACHHANG(MAKH, TENKH) values (@makh,@makh);
		--commit tran;
	end
--commit tran;
end

drop trigger tg_Cau7
insert into HOADON(MAHD,NGAY,MAKH) values ('HD015','20001231','KH07')
delete from HOADON where MAHD = 'HD013'
select * from KHACHHANG
select * from HOADON
--Hãy viết một Transaction, đảm bảo thực hiện việc xóa thông tin về một hóa đơn sẽ xóa đồng thời thông tin về hóa đơn này trong cả hai bảng CHITIETHOADON và HOADON.
begin tran
	declare @mahdon varchar(5);

	delete from CHITIETHOADON where MAHD = @mahdon
	delete from HOADON where MAHD = @mahdon
commit tran

--lay kh co ten bat dau bang chu Le va sap xep theo thu tu giam dan cua mKH
select * from KHACHHANG where TENKH like 'LE%' order by MAKH desc


--nhập chi tiết hoa đơn
insert into HOADON(MAHD,NGAY,MAKH) values
('HD017','20210525','KH04')
insert into VATTU(MAVT,
insert into CHITIETHOADON(MaHD, MAVT, SL,GIABAN) values
('HD017', 'VT17', 100, 2000)

