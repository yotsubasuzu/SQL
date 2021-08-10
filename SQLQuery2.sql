create table LopHoc(
	TenLop char(20),
	MaLop char(20) primary key,
	Phong int
);
create table MonThi(
	MonThi char(20),
	MaMon char(20) primary key
);
create table Danhgia(
	DiemThi int,
	XepLoai char(10),
	Id int primary key
);
create table SinhVien(
	TenSv varchar(255),
	MaSv char(20) primary key,
	NgaySinh date,
	MaLop char(20) foreign key references LopHoc(MaLop),
	IdDgia int foreign key references Danhgia(Id)
);
---drop table SinhVien;
create table Svien_Mthi(
	MaSv char(20) foreign key references SinhVien(MaSv),
	MaMon char(20) foreign key references MonThi(MaMon)
);