create table KhachHang(
	TenKH Nvarchar(255) not null,
	DiaChi Ntext,
	DienThoai char(20) primary key
);
create table DonHang(
	MaDH int primary key identity(1,1),
	NgayDH datetime not null check(NgayDH <= GETDATE()),
	TongTien decimal(12,4) not null check(TongTien >=0),
	DtKHang char(20) foreign key references KhachHang(DienThoai)
);
create table HangHoa(
	ID int primary key identity(1,1),
	TenHang Nvarchar(255) not null,
	Mota Ntext,
	DonVi Nchar(20) not null check(DonVi IN (N'Chiếc',N'Cái',N'Hộp',N'Thùng')),
	Gia decimal(12,4) not null check(Gia>=0 AND Gia<1000000000)
);
create table DHang_HHoa(
	Soluong int not null check(SoLuong >0),
	ThanhTien decimal(12,4) not null check(ThanhTien >=0),
	MaDH int not null foreign key references DonHang(MaDH),
	ID int not null foreign key references HangHoa(ID)
);
drop table DHang_HHoa;
drop table HangHoa;
drop table DonHang;
drop table KhachHang;
