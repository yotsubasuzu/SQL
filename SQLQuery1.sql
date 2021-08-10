create table TacGia(
	TenTacGia varchar(255) not null,
	GioiTinh varchar(100) not null 
	--check(GioiTinh like 'M' OR GioiTinh like 'F' OR GioiTinh like 'O'),
	check(GioiTinh IN ('M','F','O')),
	DienThoai varchar(20) not null unique check(DienThoai like '0%'), 
	Id int primary key
);
---drop table TacGia;

create table LoaiSach(
	TenLoaiSach varchar(255) not null unique,
	Id int primary key
);
create table NhaXuatBan(
	Ten varchar(255) not null unique,
	DiaChi text,
	Id int primary key
);
create table Sach(
	MaSach char(20) primary key,
	Ten varchar(255) not null,
	NoiDung text,
	GiaBan decimal(12,4) not null check(GiaBan>=0),
	SoLuong int not null check(SoLuong >=0 AND SoLuong<=1000),
	LanXb int not null check(LanXb>1 AND LanXb <20),
	NamXb int not null check(NamXb >=1950 AND NamXb<=YEAR(GetDATE())),
	IdNxban int not null foreign key references NhaXuatBan(Id),
	IdTacGia int not null foreign key references TacGia(Id),
	IdLoaiSach int not null foreign key references LoaiSach(Id)
);