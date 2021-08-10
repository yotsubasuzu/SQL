create table Hang(
	MaSoHang int primary key,
	Ten Nvarchar(255),
	Diachi Ntext,
	DienThoai char(20),
);
create table Sanpham(
	ID int primary key identity(1,1),
	TenHang Nvarchar(255) not null,
	Mota NText not null,
	DonVi Nchar(20) not null check(DonVi IN (N'Chiếc',N'Cái',N'Hộp',N'Thùng')),
	Gia decimal(12,4) not null check(Gia>=0 AND Gia<1000000000),
	Soluong int not null check(SoLuong >=0),
	MaSoHang int foreign key references Hang(MaSoHang)
);

--drop table Sanpham;
--drop table Hang;

insert into Hang(MaSoHang,Ten,Diachi,DienThoai)
values('123','Asus','USA','983232');
insert into Hang(MaSoHang,Ten,Diachi,DienThoai)
values('234','MSI','Taiwan','847303'),
('345','Zotac','China','283492');

insert into Sanpham(TenHang,Mota,DonVi,Gia,Soluong,MaSoHang)
values(N'Máy Tính T450',N'Máy nhập cũ',N'Chiếc','1000','10','234'),
(N'Điện Thoại Nokia 5670',N'Điện thoại dang hot',N'Chiếc','200','200','234'),
(N'Máy In Samsung 450',N'Máy in đang loại bình',N'Chiếc','100','10','234');

insert into Sanpham(TenHang,Mota,DonVi,Gia,Soluong,MaSoHang)
values(N'Máy Tính T450',N'Máy nhập cũ',N'Chiếc','1000','0','345'),
(N'Máy Tính T450',N'Máy nhập cũ',N'Chiếc','1000','0','123'),
(N'Máy Tính T450',N'Máy nhập cũ',N'Chiếc','1000','0','234')


select * from Hang;
select * from Sanpham;

select Ten from Hang order by Ten desc;
select TenHang,Gia from Sanpham order by Gia desc;
select * from Hang where Ten like 'Asus';
select * from Sanpham where Soluong < 11;
select * from Sanpham where MaSoHang in (select MaSoHang from Hang where Ten like 'Asus');

select count(MaSoHang) from Hang;
select count(ID) from Sanpham;
select count(ID) from Sanpham group by MaSoHang;
select sum(SoLuong) from Sanpham;

alter table Sanpham add check (Gia >0);
alter table Hang add check (DienThoai like '0%');
SELECT 
  TABLE_NAME,
  CONSTRAINT_NAME,
  CONSTRAINT_TYPE
FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
WHERE CONSTRAINT_TYPE = 'PRIMARY KEY';

SELECT * FROM sys.foreign_keys

create index name_sp on Sanpham(TenHang);
create index mota_sp on Sanpham(Mota);

create view view_Sanpham as
	select ID,TenHang,Gia from Sanpham

select * from view_Sanpham

create view view_Sanpham_Hang as
	select A.ID as Ma_san_pham, A.TenHang as Ten_san_pham, B.Ten as Hang_san_xuat from Sanpham A
	inner join Hang B on A.MaSoHang = B.MaSoHang


select * from view_Sanpham_Hang

create procedure SP_Sanpham_TenHang @th Nvarchar(255) as
	select TenHang from Sanpham where MaSoHang in 
	(select MaSoHang from Hang where Ten like @th)

exec SP_Sanpham_TenHang
@th = 'MSI'

create procedure SP_Sanpham_Gia @gb decimal(12,4) as
	select TenHang, Gia from Sanpham where Gia >= @gb

exec SP_Sanpham_Gia
@gb = 500

create procedure SP_Sanpham_Hethang as
	select TenHang from Sanpham where Soluong = 0

exec SP_Sanpham_Hethang

create trigger TG_Xoa_Hang on Hang
after delete
as
if exists (select * from deleted where MaSoHang in (select MaSoHang from Hang))
	begin
		rollback transaction;
	end
	
delete from Hang where MaSoHang like '123'

create trigger TG_Xoa_SanPham on Sanpham
after delete
as
if exists (select * from deleted where ID in 
(select ID from Sanpham where Soluong > 0))
	begin
		rollback transaction
	end

drop trigger TG_Xoa_Sanpham;

delete from Sanpham where Soluong > 0;
select * from Sanpham;