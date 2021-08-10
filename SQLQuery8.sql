create table NguoiCTN(
	MaSo int primary key,
	TenNguoi Nvarchar(255) not null 
);

create table LoaiSP(
	MaLoai char(20) primary key,
	TenLoai varchar(255) not null,
	MaSo int not null foreign key references NguoiCTN(MaSo)
);

create table Sanpham(
	MaSo char(20) primary key,
	NgaySX date	not null check (NgaySX <= GetDate()),
	MaLoai char(20) not null foreign key references LoaiSP(MaLoai)
);

insert into NguoiCTN(MaSo,TenNguoi)
values('987688',N'Nguyễn Văn An'),
('987689',N'Nguyễn Văn B'),
('987680',N'Nguyễn Văn C'),
('987681',N'Nguyễn Văn D'),
('987682',N'Nguyễn Văn E'),
('987683',N'Nguyễn Văn F'),
('987684',N'Nguyễn Văn G')

select * from NguoiCTN;

insert into LoaiSP(MaLoai,TenLoai,MaSo)
values
('Z37E',N'Máy tính xách tay Z37','987688'),
('Z38E',N'Máy tính xách tay Z38','987689'),
('Z39E',N'Máy tính xách tay Z39','987681'),
('Z40E',N'Máy tính xách tay Z40','987682')

insert into Sanpham(MaSo,NgaySX,MaLoai)
values('Z37 111111','2019/12/12','Z37E'),
('Z37 111112','2019/12/12','Z37E'),
('Z37 111113','2019/12/13','Z37E'),
('Z37 111114','2019/12/14','Z37E'),
('Z37 111115','2019/12/15','Z37E'),
('Z37 111116','2019/12/16','Z37E'),
('Z40 111111','2019/12/17','Z40E'),
('Z39 111111','2019/12/18','Z39E'),
('Z38 111111','2019/12/12','Z38E'),
('Z38 111112','2019/12/12','Z38E')

select * from Sanpham;
select * from LoaiSP;
select * from NguoiCTN;

select * from LoaiSP order by TenLoai asc;
select * from NguoiCTN order by TenNguoi asc;
select * from Sanpham where MaLoai like 'Z37E';
select * from Sanpham where MaLoai in (select MaLoai from LoaiSP where MaSo in
(select MaSo from NguoiCTN where TenNguoi like N'Nguyễn Văn An')) order by MaSo desc;

select COUNT(MaSo) from Sanpham group by MaLoai;

select * from Sanpham A
inner join LoaiSP B on A.MaLoai = B.MaLoai

select C.MaSo,C.TenNguoi,B.MaLoai,B.TenLoai,A.MaSo,A.NgaySX from Sanpham A
inner join LoaiSP B on A.MaLoai = B.MaLoai
inner join NguoiCTN C on B.MaSo = C.MaSo

alter table SanPham add check (NgaySX <= GETDATE())

SELECT 
  OBJECT_NAME(parent_object_id) AS 'Table',name
FROM sys.key_constraints 
WHERE type = 'PK';
select * from sys.objects where type = 'PK';

SELECT *
FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
WHERE TABLE_NAME = 'Sanpham';

SELECT 
  TABLE_NAME,
  CONSTRAINT_NAME,
  CONSTRAINT_TYPE
FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
WHERE CONSTRAINT_TYPE = 'PRIMARY KEY';

SELECT * FROM sys.foreign_keys;
SELECT * FROM sys.check_constraints;
 
alter table SanPham add PhienBan char(20);

create index name_NTCN on NguoiCTN(TenNguoi);

create view view_sanpham as
	select A.MaSo,A.NgaySX,B.TenLoai from Sanpham A
	inner join LoaiSP B on A.MaLoai = B.MaLoai

select * from view_sanpham

create view view_sanpham_NCTN as
	select A.MaSo,A.NgaySX,B.TenNguoi from Sanpham A
	inner join LoaiSP C on C.MaLoai=A.MaLoai
	inner join NguoiCTN B on B.MaSo = C.MaSo

select * from view_sanpham_NCTN

create view view_top_sanpham as
	select top 5 A.MaSo,B.TenLoai,A.NgaySX from Sanpham A
	inner join LoaiSP B on A.MaLoai=B.MaLoai 
	order by NgaySX desc

select * from view_top_sanpham

create procedure them_loaiSP @ml char(20), @tl Nvarchar(255), @ms int as
	if (@ms in(select MaSo from NguoiCTN))
		begin
			insert into LoaiSP(MaLoai,TenLoai,MaSo)
			values(@ml,@tl,@ms)
			select * from LoaiSP
		end
	else
		begin
			print('Ko co ma so nguoi chiu trach nhiem')
		end

exec them_loaiSP
@ml = 'Z41E',
@tl = N'Máy tính xách tay Z41',
@ms = '987681'

create procedure Them_NCTN @ms int, @tn Nvarchar(255) as
	insert into NguoiCTN(MaSo,TenNguoi)
	values(@ms,@tn)
	select * from NguoiCTN

exec Them_NCTN 
@ms = '273192',
@tn = N'Ngô Kiên'

create procedure Them_SP @ms char(20), @nsx date, @ml char(20) as
	if(@ml in (select MaLoai from LoaiSP))
		begin
			insert  into Sanpham(MaSo,NgaySX,MaLoai)
			values(@ms,@nsx,@ml)
			select * from Sanpham
		end
	else
		begin
			print('Ma loai khong ton tai')
		end

exec Them_SP
@ms = 'Z41 223740',
@nsx = '2020/12/25',
@ml = 'Z41E'

create procedure Xoa_SP @ms char(20) as
	if (@ms in (select MaSo from Sanpham))
		begin
			delete from Sanpham where MaSo = @ms
		end
	else
		begin
			print('Ma so san pham ko ton tai')
		end

exec Xoa_SP
@ms = 'Z41 223740'


create procedure Xoa_SP_TL @ml char(20) as
	if(@ml in (select Maloai from Sanpham))
		begin
			delete from Sanpham where MaLoai = @ml
		end
	else
		begin
			print('Ma loai ko ton tai')
		end

exec Xoa_SP_TL
@ml='Z40E'