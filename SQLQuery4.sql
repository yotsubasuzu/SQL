--Them khach hang
insert into KhachHang(TenKH,DiaChi,DienThoai)
values(N'Nguyễn Văn An',N'111 Nguyễn Trãi','0987654321');

insert into KhachHang(TenKH,DiaChi,DienThoai)
values(N'Trần Linh','','0987654381');

--liet ke
select * from KhachHang;

--cap nhat
update KhachHang set TenKH = N'Trần Nguyễn' where DienThoai like '0987654323';
update KhachHang set TenKH = N'Trần Minh Anh' where DienThoai in ('0987654324','0987654326');
update KhachHang set DiaChi = N'111 Nguyễn Trãi, Thanh Xuân, Hà Nội' where DienThoai like '0987654321';

--xoa du lieu
delete from KhachHang where DienThoai like '0773738291';

--CRUD voi bang Don hang
insert into DonHang(NgayDH,TongTien,DtKHang)
values('2021/03/15',650000,'0987654324');

insert into DonHang(NgayDH,TongTien,DtKHang)
values('11/18/19','1500','0987654321');
select * from KhachHang;
select * from DonHang;
select * from HangHoa;
select * from DHang_HHoa;
insert into HangHoa(TenHang,Mota,DonVi,Gia)
values(N'Máy Tính T450',N'Máy nhập mới',N'Chiếc','1000'),
(N'Điện Thoại N5670',N'Điện thoại đang hot',N'Chiếc','200'),
(N'Máy In Samusung 450',N'Máy in đang ế',N'Chiếc','100');

insert into DHang_HHoa(Soluong,ThanhTien,MaDH,ID)
values(2,2000000,2,3),(1,50000,2,4),(1,750000,2,5);

-- loc va tim kiem
select DienThoai as Dt, TenKH as Name, DiaChi as Addr from KhachHang;
select * from KhachHang	where TenKH like N'Nguyễn Văn An';
select * from KhachHang where DienThoai like '0987%' AND TenKH like '%An';

--sap xep
select * from KhachHang order by TenKH asc;
select * from KhachHang order by TenKH desc;

--lay theo so luong mong muon
select top 1 * from HangHoa order by Gia desc;
select top 1 TenHang,Gia from HangHoa order by Gia desc;
select top 50 percent * from HangHoa order by Gia desc;

--thong ke
select count(*) as TongsoDonhang from DonHang;
select sum(TongTien) as TongDoanhThu from DonHang where NgayDH >= '2000/03/01';
select AVG(TongTien) as TrungBinhDon from DonHang;

--thong ke theo nhom
select DtKHang,COUNT(*) as SoLuongDon,Sum(TongTien) as TongTien from DonHang where TongTien > 500 group by DtKHang having DtKHang like '098%';

--
declare @dt char(20) = (select DienThoai from KhachHang where TenKH like N'%Linh');
select * from DonHang where DtKHang like @dt;

--truy van con (subquery)
select * from DonHang where DtKHang in (select DienThoai from KhachHang where TenKH like N'%An');
select * from HangHoa where ID in (select ID from DHang_HHoa where MaDH in (select MaDh from DonHang where DtKHang in (select DienThoai from KhachHang where TenKH like N'%An')));

select count(DienThoai) from KhachHang;
select count(ID) from HangHoa;
select TongTien from DonHang;

select * from DonHang
inner join KhachHang on DonHang.DtKHang = KhachHang.DienThoai;

select * from DonHang
left join KhachHang on DonHang.DtKHang = KhachHang.DienThoai;

select * from DonHang
right join KhachHang on DonHang.DtKHang = KhachHang.DienThoai;

select A.MaDH, A.TongTien, B.TenKH, B.DienThoai
from DonHang A inner join KhachHang B on A.DtKHang = B.DienThoai
where A.TongTien >=1000;

select * from DHang_HHoa A 
left join DonHang B on A.MaDH = B.MaDH
left join KhachHang C on B.DtKHang = C.DienThoai
left join HangHoa D on A.ID = D.ID;

select * from DonHang A --lọc rồi nối, giảm thời gian tìm
inner join (select * from KhachHang where DienThoai like '0987%') B on A.DtKHang = B.DienThoai; 

--tao view
create view lietke_kh_dh as
	select A.MaDH, A.TongTien,B.TenKH as TenKH,B.DienThoai,B.DiaChi
	from DonHang A
	inner join KhachHang B on A.DtKHang=B.DienThoai

select * from lietke_kh_dh where TongTien>1000;
--xoa view
drop view lietke_kh_dh;

--procedure
--ko tham so
create procedure lietke_tatca as
select * from HangHoa;
select * from DonHang;
select * from KhachHang;

drop procedure lietke_tatca;

exec lietke_tatca;

--co tham so
create procedure them_khachhang @dt char(20),@tkh Nvarchar(255), @dc Ntext as
if (@dt like '0%')
	begin
		insert into KhachHang(DienThoai,TenKH,DiaChi)
		values(@dt,@tkh,@dc);
		select * from KhachHang;
	end
else
	begin
		print 'Khong the them KH vi sai so dien thoai';
	end

drop procedure them_khachhang;

exec them_khachhang @dt = '0793738292',
@tkh = N'Nguyễn Ngọc Linh',
@dc = N'Duy Tân, Cầu Giấy, Hà Nội';

create trigger khong_cho_xoa_KH
on KhachHang
after delete
as
if exists (select * from deleted where DienThoai in('0773738292','0987654321'))
	begin
		rollback transaction;
	end

drop trigger khong_cho_xoa_KH;

delete from KhachHang where DienThoai like '0987654322';
select * from KhachHang;

create table blacklist(
	DienThoai char(20)
);

insert into blacklist(DienThoai)
values('0912387502');

create trigger chan_KH
on KhachHang
after insert
as
if exists (select * from inserted where DienThoai in (select DienThoai from blacklist))
	begin
		rollback transaction;
	end

drop trigger chan_KH

insert into KhachHang(TenKH,DiaChi,DienThoai)
values(N'Đỗ Mỹ Linh',N'8 Liễu Giai','0912387502')

--ko doi ten khach hang
create trigger ko_doiten_KH
on KhachHang
after update
as
if not exists (select TenKH from inserted where TenKH in (select TenKH from deleted))
	begin
		rollback transaction
	end
drop trigger ko_doiten_KH

update KhachHang set TenKH = N'Lê Nam' where TenKH like N'Đỗ Mỹ Linh';

--viet trigger ko cho sua gia san pham thap hon gia cu

create trigger suagia_thap
on HangHoa
after update
as
if exists (select Gia from inserted where Gia < (select Gia from deleted))
	begin
		rollback transaction
		insert into Log_Gia(ID,Giacu,Giamoi,NgaySua)
		values((select ID from deleted),
		(select Gia from deleted),
		(select Gia from inserted),
		GETDATE())
	end

drop trigger suagia_thap
update HangHoa set Gia = '1500' where ID=5
select * from HangHoa
select * from Log_Gia

create table Log_Gia(
	ID int not null,
	Giacu decimal(12,4) not null,
	Giamoi decimal(12,4) not null,
	NgaySua date not null
);

alter table KhachHang add DiemThuong int;
alter table KhachHang alter column DiemThuong float;
alter table KhachHang drop column DiemThuong;

alter table KhachHang add check(DiemThuong >=0);
alter table KhachHang drop constraint CK__KhachHang__DiemT__10566F31;

create table SinhVien(
	ID int,
	name Nvarchar(255),
	age int
);

insert into SinhVien(ID,name,age)
values(3,'Linh',20),
(1,'Nam',24),
(2,'Vu',29)

select * from SinhVien

create clustered index id_index on SinhVien(ID);
create index name_index on SinhVien(name);
create index age_index on SinhVien(age);
create index name_age_index on SinhVien(name,age)