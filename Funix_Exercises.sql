create table KHACHHANG(
	MaKH nvarchar(5) primary key,
	TenKH nvarchar(30),
	DiaChi nvarchar(50),
	DT nvarchar(10),
	Email nvarchar(30)
);

create table VATTU(
	MaVT nvarchar(5) primary key,
	TenVT nvarchar(30),
	DVT nvarchar(20),
	GiaMua int,
	SLTon int
);

create table HOADON(
	MaHD nvarchar(10) primary key,
	Ngay datetime,
	MaKH nvarchar(5),
	TONGTG int,
);

create table ChiTietHoaDon(
	MaHD nvarchar(10),
	MaVT nvarchar(5),
	SL int,
	KhuyenMai int,
	GiaBan int
);

--drop table ChiTietHoaDon;
--drop table HOADON;
--drop table VATTU;
--drop table KHACHHANG;

alter table KHACHHANG alter column TenKH nvarchar(30) not null;
alter table KHACHHANG add check (len(DT) <=10);

alter table VATTU alter column TenVT nvarchar(30) not null;
alter table VATTU add check (GiaMua > 0);
alter table VATTU add check (SLTon >= 0);

alter table HOADON add foreign key (MaKH) references KHACHHANG(MaKH);

alter table ChiTietHoaDon add foreign key (MaHD) references HOADON(MaHD);
alter table ChiTietHoaDon add foreign key (MaVT) references VATTU(MaVT);
alter table ChiTietHoaDon add check (SL > 0);

insert into VATTU(MaVT,TenVT,DVT,GiaMua,SLTon) values
('VT01','XI MANG','BAO',50000,5000),
('VT02','CAT','KHOI',45000,50000),
('VT03','GACH ONG','VIEN',120,80000),
('VT04','GACH THE','VIEN',110,80000),
('VT05','DA LON','KHOI',25000,10000),
('VT06','DA NHO','KHOI',33000,10000),
('VT07','LAM GIO','CAI',15000,5000)

insert into KHACHHANG(MaKH,TenKH,DiaChi,DT,Email) values
('KH01','NGUYEN THI BE','TAN BINH','08457895','bnt@yahoo.com'),
('KH02','LE HOANG NAM','BINH CHANH','09878987','namlehoang@abc.com.vn'),
('KH03','TRAN THI CHIEU','TAN BINH','08457895',NULL),
('KH04','MAI THI QUE ANH','BINH CHANH',NULL,NULL),
('KH05','LE VAN SANG','QUAN 10',NULL,'sanglv@hcm.vnn.vn'),
('KH06','TRAN HOANG KHAI','TAN BINH','08457897',NULL)

insert into HOADON(MaHD,Ngay,MaKH) values
('HD001','2000/05/12','KH01'),
('HD002','2000/05/25','KH02'),
('HD003','2000/05/25','KH01'),
('HD004','2000/05/25','KH04'),
('HD005','2000/05/26','KH04'),
('HD006','2000/06/02','KH03'),
('HD007','2000/06/22','KH04'),
('HD008','2000/06/25','KH03'),
('HD009','2000/08/15','KH04'),
('HD010','2000/09/30','KH01'),
('HD011','2000/12/27','KH06'),
('HD012','2000/12/27','KH01')

bulk insert ChiTietHoaDon
from 'C:\Users\tocba\Desktop\new.csv'
with
(
	firstrow = 2,
	fieldterminator = ',',
	rowterminator = '\n'
)

delete from VATTU
delete from ChiTietHoaDon

select * from ChiTietHoaDon;
select * from HOADON;
select * from VATTU;
select * from KHACHHANG;

--1. Hiển danh sách tất cả các khách hàng gồm mã khách hàng, tên khách hàng, địa chỉ, điện thoại, và địa chỉ E-mail.
select * from KHACHHANG;

--2. Hiển danh sách các khách hàng có địa chỉ là “TAN BINH” gồm mã khách hàng, tên khách hàng, địa chỉ, điện thoại, và địa chỉ E-mail.
select * from KHACHHANG where DiaChi = 'TAN BINH';

--3. Hiển danh sách các khách hàng đã có số điện thoại và địa chỉ E-mail gồm mã khách hàng, tên khách hàng, địa chỉ, điện thoại, và địa chỉ E-mail.
select * from KHACHHANG where DT IS NOT NULL and Email IS NOT NULL;

--4. Hiển danh sách tất cả các vật tư gồm mã vật tư, tên vật tư, đơn vị tính và giá mua.
select * from VATTU;

--5. Hiển danh sách các vật tư gồm mã vật tư, tên vật tư, đơn vị tính và giá mua mà có giá mua nằm trong khoảng từ 20000 đến 40000.
select MaVT,TenVT,DVT,GiaMua from VATTU where GiaMua between 20000 and 40000;

--6. Hiển danh sách các vật tư là “GẠCH” (bao gồm các loại gạch) gồm mã vật tư, tên vật tư, đơn vị tính và giá mua.
select MaVT,TenVT,DVT,GiaMua from VATTU where TenVT like 'GACH%';

--7. Hiển thị số lượng vật tư có trong CSDL.
select sum(SLTon) from VATTU;

--8. Hiển thị cho biết mỗi hóa đơn đã mua bao nhiêu loại vật tư. Thông tin lấy về gồm: Mã hóa đơn, số loại vật tư trong hóa đơn này.
select MaHD as MaHoaDon, count(MaVT) as SoLoaiVatTu from ChiTietHoaDon group by MaHD;

--9. Hiển thị cho biết tổng tiền của mỗi hóa đơn. Thông tin lấy về gồm: mã hóa đơn, tổng tiền của hóa đơn (biết rằng tổng tiền của 1 hóa đơn là tổng tiền của các vật tư trong hóa đơn đó).
select MaHD, sum(SL * GIABAN) as TongTien from ChiTietHoaDon group by MaHD;

--10. Hiển thị cho biết mỗi khách hàng đã mua bao nhiêu hóa đơn. Thông tin lấy về gồm: Mã khách hàng, số lượng hóa đơn khách hàng này đã mua.
select MaKH, count(MaHD) from HOADON group by MaKH;

--11. Lấy ra các thông tin gồm Mã hoá đơn, ngày lập hoá đơn, tên khách hàng, địa chỉ khách hàng và số điện thoại.
select A.MaHD, A.Ngay, B.MaKH, B.DiaChi from HOADON A inner join KHACHHANG B on A.MaKH = B.MaKH;

--12. Lấy ra các thông tin gồm Mã hoá đơn, tên khách hàng, địa chỉ khách hàng và số điện thoại của ngày 25/5/2000.
select A.MaHD, B.TenKH, B.DiaChi, B.DT from HOADON A inner join KHACHHANG B on A.MaKH = B.MaKH where Ngay = '2000-05-25';

--13. Lấy ra các thông tin gồm Mã hoá đơn, ngày lập hoá đơn, tên khách hàng, địa chỉ khách hàng và số điện thoại của những hoá đơn trong tháng 6/2000.
select A.MaHD, A.Ngay, B.TenKH, B.DiaChi, B.DT from HOADON A inner join KHACHHANG B on A.MaKH = B.MaKH where Ngay between '2000-05-31' and '2000-07-01';

--14. Lấy ra các thông tin gồm Mã hoá đơn, ngày lập hoá đơn, tên khách hàng, địa chỉ khách hàng và số điện thoại.
select A.MaHD, A.Ngay, B.TenKH, B.DiaChi, B.DT from HOADON A join KHACHHANG B on A.MaKH = B.MaKH;

--15. Lấy ra danh sách những khách hàng (tên khách hàng, địa chỉ, số điện thoại) đã mua hàng trong tháng 6/2000.
select B.TenKH, B.DiaChi, B.DT from HOADON A inner join KHACHHANG B on A.MaKH = B.MaKH where Ngay between '2000-05-31' and '2000-07-01';

--16. Lấy ra danh sách các mặt hàng được bán từ ngày 1/1/2000 đến ngày 1/7/2000. Thông tin gồm: mã vật tư, tên vật tư.
select B.MaVT, B.TenVT from ChiTietHoaDon A inner join VATTU B on A.MaVT = B.MaVT inner join HOADON C on A.MaHD = C.MaHD where Ngay between '2000-01-01' and '2000-07-01';

--17. Lấy ra danh sách các vật tư được bán từ ngày 1/1/2000 đến ngày 1/7/2000. Thông tin gồm: mã vật tư, tên vật tư, tên khách hàng đã mua, ngày mua, số lượng mua.
select B.MaVT, B.TenVT, D.TenKH, C.Ngay, A.SL from ChiTietHoaDon A inner join VATTU B on A.MaVT = B.MaVT inner join HOADON C on A.MaHD = C.MaHD inner join KHACHHANG D on C.MaKH = D.MaKH where Ngay between '2000-01-01' and '2000-07-01';

--18. Lấy ra danh sách các vật tư được mua bởi những khách hàng ở Tân Bình, trong năm 2000. Thông tin lấy ra gồm: mã vật tư, tên vật tư, tên khách hàng, ngày mua, số lượng mua.
select B.MaVT, B.TenVT, D.TenKH, C.Ngay, A.SL from ChiTietHoaDon A inner join VATTU B on A.MaVT = B.MaVT inner join HOADON C on A.MaHD = C.MaHD inner join KHACHHANG D on C.MaKH = D.MaKH where (Ngay between '2000-01-01' and '2000-12-31') and (DiaChi = 'Tan Binh')

--19. Lấy ra danh sách các vật tư được mua bởi những khách hàng ở Tân Bình, trong năm 2000. Thông tin lấy ra gồm: mã vật tư, tên vật tư.
select B.MaVT, B.TenVT from ChiTietHoaDon A inner join VATTU B on A.MaVT = B.MaVT inner join HOADON C on A.MaHD = C.MaHD inner join KHACHHANG D on C.MaKH = D.MaKH where (Ngay between '2000-01-01' and '2000-12-31') and (DiaChi = 'Tan Binh')

--20. Lấy ra danh sách những khách hàng không mua hàng trong tháng 6/2000 gồm các thông tin tên khách hàng, địa chỉ, số điện thoại.
select B.TenKH, B.DiaChi, B.DT from HOADON A right join KHACHHANG B on A.MaKH = B.MaKH where MaHD IS NULL and Ngay between '2000-06-01' and '2000-06-30';

--21. Hiển danh sách các khách hàng có điện thoại là 8457895 gồm mã khách hàng, tên khách hàng, địa chỉ, điện thoại, và địa chỉ E-mail.
select * from KHACHHANG where DT like '%8457895';

--22. Hiển danh sách các vật tư là “DA” (bao gồm các loại đá) có giá mua dưới 30000 gồm mã vật tư, tên vật tư, đơn vị tính và giá mua.
select MaVT,TenVT,DVT,GiaMua from VATTU where TenVT like 'Da%';

--23. Tạo query để lấy ra các thông tin gồm Mã hoá đơn, ngày lập hoá đơn, tên khách hàng, địa chỉ khách hàng và số điện thoại, sắp xếp theo thứ tự ngày tạo hóa đơn giảm dần
select A.MaHD,A.Ngay,B.TenKH,B.DiaChi,B.DT from HOADON A inner join KHACHHANG B on A.MaKH = B.MaKH order by Ngay desc;

--24. Lấy ra danh sách những khách hàng mua hàng trong tháng 6/2000 gồm các thông tin tên khách hàng, địa chỉ, số điện thoại.
select B.TenKH, B.DiaChi, B.DT from HOADON A right join KHACHHANG B on A.MaKH = B.MaKH where MaHD IS NOT NULL and Ngay between '2000-06-01' and '2000-06-30';

--25. Tạo query để lấy ra các chi tiết hoá đơn gồm các thông tin mã hóa đơn, mã vật tư, tên vật tư, giá bán, giá mua, số lượng , trị giá mua 
--(giá mua * số lượng), trị giá bán (giá bán * số lượng), tiền lời (trị giá bán – trị giá mua) mà có giá bán lớn hơn hoặc bằng giá mua.
select A.MaHD,A.MaVT,B.TenVT,A.GiaBan,B.GiaMua,A.SL, (B.GiaMua * A.SL) as TriGiaMua, (A.GiaBan * A.SL) as TriGiaBan, ((A.GiaBan * A.SL) - (B.GiaMua * A.SL)) as TienLoi from ChiTietHoaDon A inner join VATTU B on A.MaVT = B.MaVT where GiaBan > GiaMua;

--26. Lấy ra hoá đơn có tổng trị giá nhỏ nhất trong số các hóa đơn năm 2000, gồm các thông tin: Số hoá đơn, ngày, tên khách hàng, địa chỉ khách hàng, tổng trị giá của hoá đơn.
select MaHD, sum(SL*GiaBan) from ChiTietHoaDon group by MaHD;
update HOADON set TONGTG = 560000 where MaHD = 'HD001';
update HOADON set TONGTG = 1500000 where MaHD = 'HD002';
update HOADON set TONGTG = 1100000 where MaHD = 'HD003';
update HOADON set TONGTG = 9900000 where MaHD = 'HD004';
update HOADON set TONGTG = 1165000 where MaHD = 'HD005';
update HOADON set TONGTG = 1200000 where MaHD = 'HD006';
update HOADON set TONGTG = 2500000 where MaHD = 'HD007';
update HOADON set TONGTG = 6440000 where MaHD = 'HD008';
update HOADON set TONGTG = 1200000 where MaHD = 'HD009';
update HOADON set TONGTG = 1425000 where MaHD = 'HD010';
update HOADON set TONGTG = 2000000 where MaHD = 'HD011';
update HOADON set TONGTG = 3080000 where MaHD = 'HD012';

select top 1 A.MaHD, B.Ngay, C.TenKH, C.DiaChi, B.TONGTG from ChiTietHoaDon A inner join HOADON B on A.MaHD = B.MaHD inner join KHACHHANG C on B.MaKH = C.MaKH where (Ngay between '2000-01-01' and '2000-12-31') order by TongTG;

--27. Lấy ra các thông tin về các khách hàng mua ít loại mặt hàng nhất.
with temptable as 
(select B.MaKH,C.MaHD, count(C.MaVT) SoVTMua from HOADON A inner join KHACHHANG B on A.MaKH = B.MaKH inner join ChiTietHoaDon C on A.MaHD = C.MaHD group by C.MaHD,B.MaKH)

select distinct B.MaKH,B.TenKH,B.DiaChi,B.DT from temptable A inner join KHACHHANG B on A.MaKH = B.MaKH where SoVTMua = (select min(SoVTMua) from temptable)

--28. Lấy ra vật tư có giá mua thấp nhất
select * from VATTU where GiaMua = (select min(GiaMua) from VATTU)

--29. Lấy ra vật tư có giá bán cao nhất trong số các vật tư được bán trong năm 2000.
select top 1 A.MaVT, A.TenVT, A.DVT, A.GiaMua, B.GiaBan, B.SL
from VATTU A inner join ChiTietHoaDon B on A.MaVT = B.MaVT inner join HOADON C on C.MaHD = B.MaHD where C.Ngay between '20000101' and '20001231' order by GiaBan desc

--30. Cho biết mỗi vật tư đã được bán tổng số bao nhiêu đơn vị (chiếc, cái,… )
select A.MaVT, A.TenVT, A.DVT, sum(B.SL)
from VATTU A inner join ChiTietHoaDon B on A.MaVT = B.MaVT group by A.MaVT,A.TenVT,A.DVT order by 1


--Hãy thực hiện đánh chỉ mục cho các trường dữ liệu sau:

--1. Trường GiaMua trong bảng VATTU
create index idx_GiaMua on VATTU(GiaMua);

--2. Trường SLTon trong bảng VATTU
create index idx_SLTon on VATTU(SLTon);

--3. Trường Ngay trong bảng HOADON.
create index idx_Ngay on HOADON(Ngay);

--Hãy chọn loại chỉ mục mà bạn cho là phù hợp với các trường này.

--1. Transaction thực hiện:

--Chèn thông tin hóa đơn có nội dung như sau:
--(MaHD, Ngay, MaKH) có giá trị ('HD20', '2 Dec 2019', 'KH01') và hóa đơn này bao gồm các sản phẩm:
--- VT01, 10 đơn vị, giá bán 55000
--- VT01, 2 đơn vị, giá bán 47000
begin tran
	insert into HOADON(MaHD, Ngay, MaKH) values ('HD20', '2 Dec 2019', 'KH01')
	insert into ChiTietHoaDon(MaHD, MaVT, SL, GiaBan) values ('HD20','VT01',10,55000),('HD20','VT02',2,47000)
commit tran

--2. Transaction thực hiện xóa thông tin về hóa đơn HD008 trong CSDL
begin tran
	delete from ChiTietHoaDon where MaHD = 'HD008'
	delete from HOADON where MaHD = 'HD008'
commit tran

--Trên CSDL đã tạo trong Bài tập Exercise 4, hãy tạo các trigger để đảm bảo các ràng buộc sau:
--1. Giá bán của một vật tư bất kỳ cần lớn hơn hoặc bằng giá mua của sản phẩm đó.
create trigger GiaVT 
on ChiTietHoaDon
after insert
as
if exists (select * from inserted A where GiaBan <= (select GiaMua from VATTU B where A.MaVT = B.MaVT))
	begin
		print 'Gia Ban nho hoac bang gia mua';
		rollback tran
	end

select * from VATTU join ChiTietHoaDon on ChiTietHoaDon.MaVT = VATTU.MaVT
insert into ChiTietHoaDon(MaHD,MaVT,SL,KhuyenMai,GiaBan) values
('HD001','VT01',10,null,50000)

--2. Mỗi khi một vật tư được bán ra với một số lượng nào đó,
--thì thuộc tính SLTon trong bảng VATTU cần giảm đi tương ứng.
create trigger SoLuongTon
on ChiTietHoaDon
after insert
as
begin
	--begin tran;
	declare @mavtdau varchar(5) = (select top 1 MaVT from VATTU order by 1)
	declare @mavtcuoi varchar(5) = (select top 1 MaVT from VATTU order by 1 desc)
	declare @mavt varchar(5) = @mavtdau
	while @mavt <= @mavtcuoi
		begin
			if exists (select * from inserted where MaVT = @mavt)
				begin
					--begin tran;
					if exists (select * from inserted where MaVT = @mavt and SL <= (select SLTon from VATTU where MaVT = @mavt))
						begin
							update VATTU set SLTon = SLTon - (select SL from inserted where MaVT = @mavt) where MaVT = @mavt
							set @mavt = 'VT0' + convert(varchar,convert(int,substring(@mavt,3,4)) + 1);
						end
					else
						begin
							print N'Số lượng tồn không đủ';
							rollback tran;
						end
				end
			else
				begin
					set @mavt = 'VT0' + convert(varchar,convert(int,substring(@mavt,3,4)) + 1);
					continue;
				end
		end
	--commit tran;
end


drop trigger SoLuongTon

insert into ChiTietHoaDon(MaHD,MaVT,SL,KhuyenMai,GiaBan) values
('HD001','VT01',20,null,53000),
('HD001','VT07',50,null,33000)

select * from VATTU
select * from ChiTietHoaDon

--3. Đảm bảo giá bán của một sản phẩm bất kỳ, chỉ có thể cập nhật tăng, không thể cập nhật giảm.
create trigger SuaGia
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

drop trigger SuaGia

update ChiTietHoaDon set GiaBan = 49000 where MaVT = 'VT01' and MaHD = 'HD001'

--4. Mỗi khi có sự thay đổi về vật tư được bán trong một hóa đơn nào đó,
--thuộc tính TONGGT trong bảng HOADON được cập nhật tương ứng.
create trigger TongGT
on ChiTietHoaDon
after update
as
if exists (select MaHD from inserted where MaHD in (select MaHD from HOADON))
begin
	declare @mahd varchar(10) = (select MaHD from inserted);
	declare @mavt varchar(5) = (select MaVT from inserted);
	
	update HOADON set TONGTG = (select SL from inserted) * (select GiaBan from ChiTietHoaDon where MaHD = @mahd and MaVT = @mavt)
	where MaHD = @mahd;
	
end

drop trigger TongGT;

update ChiTietHoaDon set SL = 5 where MaHD = 'HD001' and MaVT = 'VT01';
update HOADON set TONGTG = null

select * from HOADON
select * from ChiTietHoaDon
select * from VATTU

--Trên CSDL đã tạo trong bài tập Exercise 4, hãy tạo các Stored procedure sau:

--1. Viết procedure sp_Cau1 cập nhật thông tin TONGGT trong bảng hóa đơn theo dữ liệu thực tế của bảng CHITIETHOADON
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
					print @mahd + ' - ' + @mavt
					if exists (select * from ChiTietHoaDon where MaHD = @mahd and MaVT = @mavt)
						update HOADON set TONGTG = TONGTG + (select SL from ChiTietHoaDon where MaHD = @mahd and MaVT = @mavt) * (select GiaBan from ChiTietHoaDon where MaHD = @mahd and MaVT = @mavt) where MaHD = @mahd;
					set @mavt = 'VT0' + convert(varchar,convert(int,substring(@mavt,3,4)) + 1);
				end
			--end
			print @mahd
			if (@mahd < 'HD009')
				begin
				set @mahd = 'HD00' + convert(varchar,convert(int,substring(@mahd,4,5)) + 1);
				print @mahd
				end
			else
				set @mahd = 'HD0' + convert(varchar,convert(int,substring(@mahd,4,5)) + 1);
		end
end

drop procedure sp_Cau1
exec sp_Cau1
select * from HOADON

--2. Viết procedure sp_Cau2 có đầu vào là số điện thoại, kiểm tra xem đã có khách hàng có số điện thoại này trong CSDL chưa? Hiện thông báo (bằng lệnh print) để nêu rõ đã có/ chưa có khách hàng này.
create procedure sp_Cau2 @dt varchar(10) as
begin
if exists (select DT from KHACHHANG where DT = @dt)
	begin
		print 'Da co khach hang co so dien thoai ' +@dt+ ' trong co so du lieu roi.';
	end
else
	begin
		print 'Chua co khac hang co so dien thoai '+@dt+' trong co so du lieu.';
	end
end

drop procedure sp_Cau2

exec sp_Cau2 '08457895'
select DT from KHACHHANG where DT = '08457895'

--3. Viết procedure sp_Cau3 có đầu vào là mã khách hàng, hãy tính tổng số tiền mà khách hàng này đã mua trong toàn hệ thống, kết quả trả về trong một tham số kiểu output.
create procedure sp_Cau3 @makh varchar(5) as
begin
	select B.MaKH, sum(TONGTG) TongSoTien from HOADON A right join KHACHHANG B on A.MaKH = B.MaKH where B.MaKH = @makh group by B.MaKH 
end

drop procedure sp_Cau3
exec sp_Cau3 'KH02'

select * from KHACHHANG
select B.MaKH, sum(TONGTG) from HOADON A right join KHACHHANG B on A.MaKH = B.MaKH group by B.MaKH 

--4. Viết procedure sp_Cau4 có hai tham số kiểu output là @mavt nvarchar(5) và @tenvt nvarchar(30) để trả về mã và tên của vật tư đã bán được nhiều nhất (được tổng tiền nhiều nhất).
create procedure sp_Cau4 as
begin
select top 1 B.MaVT, B.TenVT, sum(A.SL*A.GiaBan) from ChiTietHoaDon A inner join VATTU B on A.MaVT = B.MaVT group by B.MaVT, B.TenVT order by 3 desc
end

exec sp_Cau4


--1. Viết hàm fc_Cau1 có kiểu dữ liệu trả về là int, nhập vào 1 mã vật tư, tìm xem giá mua của vật tư này là bao nhiêu. Kết quả trả về cho hàm là giá mua tìm được.
CREATE FUNCTION dbo.fc_Cau1(@mavt varchar(5))
RETURNS INT
AS
BEGIN
    RETURN (select GiaMua from VATTU where MaVT = @mavt)
END

drop function fc_Cau1

select *,dbo.fc_Cau1(MaVT) GiaNhap from ChiTietHoaDon

--2. Viết hàm fc_Cau2 có kiểu dữ liệu trả về là nvarchar(30), nhập vào 1 mã khách hàng, tìm xem khách hàng này có tên là gì. Kết quả trả về cho hàm là tên khách hàng tìm được.
create function dbo.fc_Cau2 (@makh varchar(5))
returns nvarchar(30)
as
begin
	return (select TenKH from KHACHHANG where MaKH = @makh)
end

select *,dbo.fc_Cau2(MaKH) TenKhachHang from HOADON 

--3. Viết hàm fc_Cau3 có kiểu dữ liệu trả về là int, nhập vào 1 mã khách hàng rồi đếm xem khách hàng này đã mua tổng cộng bao nhiêu tiền. Kết quả trả về cho hàm là tổng số tiền mà khách hàng đã mua.
create function dbo.fc_Cau3 (@makh varchar(5))
returns int
as
begin
	return (select sum(TongTG) from HOADON where MaKH = @makh)
end

select *, dbo.fc_Cau3(MaKH) TongTienDaMua from KHACHHANG

--4. Viết hàm fc_Cau4 có kiểu dữ liệu trả về là nvarchar(5), tìm xem vật tư nào là vật tư bán được nhiều nhất (nhiều tiền nhất). 
--Kết quả trả về cho hàm là mã của vật tư này (trường hợp có nhiều vật tư cùng bán được nhiều nhất, chỉ cần trả về 1 mã bất kỳ trong số đó).

create function dbo.fc_Cau4 ()
returns nvarchar(5)
as
begin
	return (select MaVT from 
	(select top 1 B.MaVT, sum(A.SL*A.GiaBan) TongSoTien from ChiTietHoaDon A inner join VATTU B on A.MaVT = B.MaVT group by B.MaVT order by 2 desc) a) 
end

select dbo.fc_Cau4