create table KhachHang(
	Ten Nvarchar(255) not null,
	CMT int primary key,
	DiaChi Ntext
);

create table ThueBao(
	SoTB varchar(20) primary key,
	LoaiTB Nvarchar(20) not null,
	NgayDK  date not null check (NgayDK <= GetDate()),
	CMT int foreign key references KhachHang(CMT)
);

--drop table ThueBao;
--drop table KhachHang;

insert into KhachHang(Ten,CMT,DiaChi)
values(N'Nguyễn Nguyệt Nga','123456789',N'Hà Nội'),
(N'Nguyễn Văn A','123456788',N'Hà Nội'),
(N'Trần Thị B','123456787',N'Hà Nội'),
(N'Lê Văn C','123456786',N'Hà Nội'),
(N'Đặng Văn Nam','123456785',N'Hà Nội');

insert into ThueBao(SoTB,LoaiTB,NgayDK,CMT)
values('0123456789',N'Trả trước','12/12/02','123456789'),
('097512842',N'Trả trước','12/12/02',null),
('039183475',N'Trả trước','12/12/02','123456788'),
('078412471',N'Trả trước','12/12/02','123456785'),
('071238791',N'Trả trước','12/12/02','123456788'),
('071376592',N'Trả trước','12/12/02',null),
('034578914',N'Trả trước','12/12/02',null),
('081264823',N'Trả trước','12/12/02','123456787'),
('027349823',N'Trả trước','12/12/02','123456788'),
('092347253',N'Trả trước','12/12/02','123456786');


select * from KhachHang;
select * from ThueBao;

select * from ThueBao where SoTB like '0123456789';
select * from KhachHang where CMT like '123456789';
select SoTB from ThueBao where CMT like '123456788';
select SoTB from ThueBao where NgayDK like '12/12/09';
select SoTB from ThueBao where CMT in (select CMT from KhachHang where DiaChi like N'Hà Nội');

select count(CMT) from KhachHang;
select count(SoTB) from ThueBao;
select count(SoTB) from ThueBao where NgayDK = '12/12/02';
select * from ThueBao A
inner join KhachHang B on A.CMT = B.CMT;

create view view_KhachHang as 
	select * from KhachHang A

select * from view_KhachHang

create view view_KhachHang_ThueBao as
	select A.CMT, A.Ten, B.SoTB from KhachHang A
	inner join ThueBao B on A.CMT = B.CMT

select * from view_KhachHang_ThueBao

create procedure timKH_Sotb @dt char(20) as
select A.Ten,A.CMT,A.DiaChi,B.SoTB from KhachHang A, ThueBao B where A.CMT = B.CMT AND B.SoTB = @dt;
drop procedure timKH_Sotb;

select A.Ten,A.CMT,A.DiaChi,B.SoTB from KhachHang A, ThueBao B where A.CMT = B.CMT AND B.SoTB = '0123456789';

exec timKH_Sotb @dt = '0123456789';

--Liệt kê các số điện thoại của khách hàng theo tên truyền vào
create procedure timTB_tenKH @ten Nvarchar(255) as
select A.SoTB, B.Ten from ThueBao A, KhachHang B where A.CMT = B.CMT AND B.Ten = @ten;

select A.SoTB, B.Ten from ThueBao A, KhachHang B where A.CMT = B.CMT AND B.Ten = N'Nguyễn Văn A';

--thêm mới 1 thuê bao 
create procedure themTB @stb char(20), @loaitb Nchar(20), @ngaydk date, @cmt int as
	insert into ThueBao(SoTB,LoaiTB,NgayDK,CMT)
	values(@stb,@loaitb,@ngaydk,@cmt)
	select * from ThueBao

drop procedure themTB;

exec themTB 
@stb = '0234935283',
@loaitb = N'Trả sau',
@ngaydk = '2020-03-27',
@cmt = null

--Xóa bỏ thuê bao của khách hàng theo Mã khách hàng

create procedure xoaTB_CMT @cmt int as
delete from ThueBao where CMT = @cmt
select * from ThueBao

exec xoaTB_CMT @cmt = '123456787';

create index name_KH on KhachHang(Ten)

alter table ThueBao alter column NgayDK date not null;
alter table ThueBao add check (NgayDK <= GetDate());
alter table ThueBao add check (SoTB like '0%');
alter table ThueBao add DiemThuong int;