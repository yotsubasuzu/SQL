create table TacGia(
	ID int primary key identity(1,1),
	TenTacGia Nvarchar(255) not null,
);

create table LoaiSach(
	ID int primary key identity(1,1),
	TenLoai Nvarchar(255) not null
);

create table NhaXB(
	ID int primary key identity(1,1),
	TenNXB Nvarchar(255) not null,
	DiaChi Ntext not null
);

create table Sach(
	MaSach char(20) primary key,
	TenSach Nvarchar(255) not null,
	NDTT Ntext,
	NamXB int not null check (NamXB < 2100 AND NamXB > 1900),
	LanXB int not null check (LanXB > 0),
	GiaBan decimal(12,4) not null check (GiaBan > 0 AND GiaBan < 100000000),
	SoLuong int not null check (SoLuong > 0),
	IDLS int not null foreign key references LoaiSach(ID),
	IDNXB int not null foreign key references NhaXB(ID),
	IDTG int not null foreign key references TacGia(ID)
);

--drop table Sach
--drop table NhaXB
--drop table TacGia
--drop table LoaiSach

insert into LoaiSach(TenLoai) values
(N'Khoa học xã hội'),
(N'Tin học'),
(N'Toán học'),
(N'Văn học'),
(N'Kinh Tế'),
(N'Từ điển');

insert into NhaXB(TenNXB,DiaChi) values
(N'Tri Thức',N'53 Nguyễn Du, Hai Bà Trưng, Hà Nội'),
(N'Tri Thức 1',N'53 Nguyễn Du, Hai Bà Trưng, Hà Nội'),
(N'Tri Thức 2',N'53 Nguyễn Du, Hai Bà Trưng, Hà Nội');

insert into TacGia(TenTacGia) values
('Eran Katz'),
('J.K. Rowling'),
('Murakami'),
('Makoto Shinkai');

insert into Sach(MaSach,TenSach,NDTT,NamXB,LanXB,GiaBan,SoLuong,IDTG,IDLS,IDNXB) values
('B001',N'Trí Tuệ Do Thái',N'Bạn có muốn biết: Người Do Thái sáng tạo ra cái gì 
và nguồn gốc trí tuệ của họ xuất phát từ đâu không? Cuốn sách này sẽ dần hé lộ những bí ẩn 
về sự thông thái của người Do Thái, của một dân tộc thông tuệ với những phương pháp và 
kỹ thuật phát triển tầng lớp trí thức đã được giữ kín hàng nghìn năm như một bí ẩn mang tính
 văn hóa.',2010,1,79000,100,1,1,1),
 ('B002',N'Trí Tuệ Do Thái',N'Bạn có muốn biết: Người Do Thái sáng tạo ra cái gì 
và nguồn gốc trí tuệ của họ xuất phát từ đâu không? Cuốn sách này sẽ dần hé lộ những bí ẩn 
về sự thông thái của người Do Thái, của một dân tộc thông tuệ với những phương pháp và 
kỹ thuật phát triển tầng lớp trí thức đã được giữ kín hàng nghìn năm như một bí ẩn mang tính
 văn hóa.',2009,1,80000,100,2,3,2),
 ('B003',N'Trí Tuệ Do Thái',N'Bạn có muốn biết: Người Do Thái sáng tạo ra cái gì 
và nguồn gốc trí tuệ của họ xuất phát từ đâu không? Cuốn sách này sẽ dần hé lộ những bí ẩn 
về sự thông thái của người Do Thái, của một dân tộc thông tuệ với những phương pháp và 
kỹ thuật phát triển tầng lớp trí thức đã được giữ kín hàng nghìn năm như một bí ẩn mang tính
 văn hóa.',2007,3,89000,100,2,4,3),
 ('B004',N'Trí Tuệ Do Thái',N'Bạn có muốn biết: Người Do Thái sáng tạo ra cái gì 
và nguồn gốc trí tuệ của họ xuất phát từ đâu không? Cuốn sách này sẽ dần hé lộ những bí ẩn 
về sự thông thái của người Do Thái, của một dân tộc thông tuệ với những phương pháp và 
kỹ thuật phát triển tầng lớp trí thức đã được giữ kín hàng nghìn năm như một bí ẩn mang tính
 văn hóa.',2008,2,59000,100,4,4,2),
 ('B005',N'Trí Tuệ Do Thái',N'Bạn có muốn biết: Người Do Thái sáng tạo ra cái gì 
và nguồn gốc trí tuệ của họ xuất phát từ đâu không? Cuốn sách này sẽ dần hé lộ những bí ẩn 
về sự thông thái của người Do Thái, của một dân tộc thông tuệ với những phương pháp và 
kỹ thuật phát triển tầng lớp trí thức đã được giữ kín hàng nghìn năm như một bí ẩn mang tính
 văn hóa.',2017,6,9000,600,3,6,3),
 ('B006',N'Trí Tuệ Do Thái',N'Bạn có muốn biết: Người Do Thái sáng tạo ra cái gì 
và nguồn gốc trí tuệ của họ xuất phát từ đâu không? Cuốn sách này sẽ dần hé lộ những bí ẩn 
về sự thông thái của người Do Thái, của một dân tộc thông tuệ với những phương pháp và 
kỹ thuật phát triển tầng lớp trí thức đã được giữ kín hàng nghìn năm như một bí ẩn mang tính
 văn hóa.',2018,2,7000,300,1,5,3),
('B008',N'Trí Tuệ Do Thái',N'Bạn có muốn biết: Người Do Thái sáng tạo ra cái gì 
và nguồn gốc trí tuệ của họ xuất phát từ đâu không? Cuốn sách này sẽ dần hé lộ những bí ẩn 
về sự thông thái của người Do Thái, của một dân tộc thông tuệ với những phương pháp và 
kỹ thuật phát triển tầng lớp trí thức đã được giữ kín hàng nghìn năm như một bí ẩn mang tính
 văn hóa.',2019,6,169000,100,2,3,3),
 ('B009',N'Trí Tuệ Do Thái',N'Bạn có muốn biết: Người Do Thái sáng tạo ra cái gì 
và nguồn gốc trí tuệ của họ xuất phát từ đâu không? Cuốn sách này sẽ dần hé lộ những bí ẩn 
về sự thông thái của người Do Thái, của một dân tộc thông tuệ với những phương pháp và 
kỹ thuật phát triển tầng lớp trí thức đã được giữ kín hàng nghìn năm như một bí ẩn mang tính
 văn hóa.',2019,1,29000,200,1,2,2),
 ('B010',N'Trí Tuệ Do Thái',N'Bạn có muốn biết: Người Do Thái sáng tạo ra cái gì 
và nguồn gốc trí tuệ của họ xuất phát từ đâu không? Cuốn sách này sẽ dần hé lộ những bí ẩn 
về sự thông thái của người Do Thái, của một dân tộc thông tuệ với những phương pháp và 
kỹ thuật phát triển tầng lớp trí thức đã được giữ kín hàng nghìn năm như một bí ẩn mang tính
 văn hóa.',2019,1,69000,1000,2,1,1),
 ('B007',N'Trí Tuệ Do Thái',N'Bạn có muốn biết: Người Do Thái sáng tạo ra cái gì 
và nguồn gốc trí tuệ của họ xuất phát từ đâu không? Cuốn sách này sẽ dần hé lộ những bí ẩn 
về sự thông thái của người Do Thái, của một dân tộc thông tuệ với những phương pháp và 
kỹ thuật phát triển tầng lớp trí thức đã được giữ kín hàng nghìn năm như một bí ẩn mang tính
 văn hóa.',2019,1,69000,1000,2,1,2);

select * from TacGia;
select * from LoaiSach;
select * from NhaXB;
select * from Sach;

select * from Sach where NamXb > 2008;
select top 10 * from Sach where GiaBan <= (select max(GiaBan) from Sach) order by (GiaBan) DESC;
select * from Sach where TenSach like N'%tin học%';
select * from Sach where TenSach like N'T%' order by GiaBan DESC;

select * from Sach where MaSach in
(select MaSach from LoaiSach where ID in
(select IDLS from NhaXB where TenNXB like N'Tri Thức'));

select TenNXB as Ten_NXB,DiaChi as Dia_Chi from NhaXB where ID in 
(select IDNXB from Sach where TenSach like N'Trí Tuệ Do Thái');

select A.MaSach as Ma_Sach, A.TenSach as Ten_Sach, 
A.NamXB as Nam_Xuat_Ban, C.TenNXB as Ten_Nha_Xuat_Ban, 
B.TenLoai as Ten_Loai from Sach A
inner join LoaiSach B on A.IDLS=B.ID
inner join NhaXB C on A.IDNXB = C.ID;

select * from Sach where GiaBan = (select max(GiaBan) from Sach);
select * from Sach where SoLuong = (select max(SoLuong) from Sach);
select * from Sach where IDTG in 
(select ID from TacGia where TenTacGia like 'Eran Katz');

update Sach set GiaBan = (GiaBan * 0.9) where NamXB < 2008;
select * from Sach group by (IDNXB);

select * from Sach;
select B.TenNXB as Nha_Xuat_Ban, sum(SoLuong) as So_dau_sach 
from Sach A inner join NhaXB B on A.IDNXB = B.ID group by (B.TenNXB);

select * from Sach;
select * from LoaiSach;
select B.TenLoai as Loai_Sach, sum(SoLuong) as So_dau_sach 
from Sach A inner join LoaiSach B on A.IDLS = B.ID group by (B.TenLoai);

create index ten_sach_index on Sach(TenSach);

create view view_Ttin_Sach as
	select A.MaSach as Ma_Sach, A.TenSach as Ten_Sach,
	B.TenTacGia as Ten_Tac_Gia, C.TenNXB as Nha_XB,
	A.GiaBan as Gia_Ban from Sach A inner join TacGia B on A.IDTG = B.ID
	inner join NhaXB C on A.IDNXB = C.ID;

select * from view_Ttin_Sach

create procedure SP_Them_Sach 
@ms char(20), @ts Nvarchar(255), @nd Ntext, @nam int, @lxb int, 
@gb decimal(12,4), @sl int, @idls int, @idnxb int, @idtg int as
	if(@ms in (select MaSach from Sach))
		print('Ma sach da ton tai')
	else
		begin
			insert into Sach(MaSach,TenSach,NDTT,NamXB,LanXB,GiaBan,SoLuong,IDLS,IDNXB,IDTG)
			values(@ms,@ts,@nd,@nam,@lxb,@gb,@sl,@idls,@idnxb,@idtg);
			select * from Sach;
		end

drop procedure SP_Them_Sach

exec SP_Them_Sach 
@ms='B012',
@ts=N'Nhà giả kim',
@nd=N'Bạn có muốn biết',
@nam=2015,
@lxb=3,
@gb=79000,
@sl=250,
@idls=3,
@idnxb=3,
@idtg=3

create procedure SP_Tim_Sach @tk Nvarchar(255) as
	select * from Sach where TenSach like @tk OR NDTT like @tk

exec SP_Tim_Sach @tk=N'%Bạn%'

create procedure SP_Sach_ChuyenMuc @ml int as
	select * from Sach where IDLS = @ml

exec SP_Sach_ChuyenMuc @ml = 1

create trigger Khong_xoa_Sach on Sach
after delete as
if exists (select * from deleted where SoLuong > 0)
	begin
		rollback transaction
		print('Sach con trong kho, khong xoa duoc')
	end

drop trigger Khong_Xoa_Sach;

delete from Sach where MaSach like 'B012';

insert into LoaiSach(TenLoai) values
(N'Danh mục')
select * from LoaiSach

insert into Sach(MaSach,TenSach,NDTT,NamXB,LanXB,GiaBan,SoLuong,IDTG,IDLS,IDNXB) values
('B124','Sql server','sql server',2020,1,50000,0,1,7,1);

alter table Sach drop constraint CK__Sach__SoLuong__3A81B327;
alter table Sach add check (SoLuong >=0);

create trigger Xoa_Danh_Muc on LoaiSach
after delete as
if exists (select * from deleted where ID in
(select IDLS from Sach where SoLuong = 0))
	begin
		delete from Sach where SoLuong = 0;
		commit transaction;
	end
else
	rollback transaction;
	
drop trigger Xoa_Danh_Muc

select sum(SoLuong), IDLS from Sach group by (IDLS);

select * from LoaiSach where ID in (select IDLS from Sach where SoLuong =0)
delete from LoaiSach where ID in (select IDLS from Sach where SoLuong > 0)
delete from Sach where SoLuong = 0;

delete from LoaiSach where ID = 7