create table QuangCao(
	MaQuangCao int primary key identity(1,1),
	NoiDungQC nvarchar(max) not null,
	AnhQC varchar(255) not null,
	LinkQC varchar(255),
	TenQC nvarchar(50)
);

create table LoaiTaiKhoan(
	MaLoaiTK int primary key identity(1,1),
	QuyenHan nvarchar(255) not null,
	TenLoai varchar(50) not null
);

create table TaiKhoan(
	MaTaiKhoan int primary key identity(1,1),
	TenTK varchar(20) not null,
	MatKhau varchar(20) not null,
	DiaChiIP varchar(10) not null,
	AnhDaiDien varchar(255),
	LoaiTK int foreign key references LoaiTaiKhoan(MaLoaiTK)
);

create table ChuyenMuc(
	MaChuyenMuc int primary key identity(1,1),
	TenChuyenMuc nvarchar(50) not null,
	ChuyenMucCon nvarchar(50),
);

create table BaiBao(
	MaBaiBao int primary key identity(1,1),
	TuaDe nvarchar(50) not null,
	Anh varchar(50),
	TomTat nvarchar(max) not null,
	NgayDang datetime not null check(NgayDang <= GETDATE()),
	BaiViet nvarchar(max) not null,
	MaChuDe int foreign key references ChuyenMuc(MaChuyenMuc),
	NguoiDang int foreign key references TaiKhoan(MaTaiKhoan),
	NguoiDuyet int foreign key references TaiKhoan(MaTaiKhoan),
	LuotXem int 
);

create table TacGia(
	MaTacGia int foreign key references TaiKhoan(MaTaiKhoan),
	HoTen varchar(50) not null,
	ThongTin varchar(max),
	MaBaiBao int foreign key references BaiBao(MaBaiBao)
);

create table BinhLuan(
	MaBinhLuan int primary key identity(1,1),
	NoiDung nvarchar(max) not null,
	LuotDanhGia int,
	MaBaiBao int foreign key references BaiBao(MaBaiBao)
);
--drop table BinhLuan
--drop table TacGia
--drop table BaiBao
--drop table ChuyenMuc
--drop table TaiKhoan
--drop table LoaiTaiKhoan
--drop table QuangCao

insert into QuangCao(NoiDungQC,AnhQC,LinkQC,TenQC) values
('Noi Dung Quang Cao 1','Anh Quang Cao 1','Link Quang Cao 1','Ten Quang Cao 1'),
('Noi Dung Quang Cao 2','Anh Quang Cao 2','Link Quang Cao 2','Ten Quang Cao 2'),
('Noi Dung Quang Cao 3','Anh Quang Cao 3','Link Quang Cao 3','Ten Quang Cao 3'),
('Noi Dung Quang Cao 4','Anh Quang Cao 4','Link Quang Cao 4','Ten Quang Cao 4'),
('Noi Dung Quang Cao 5','Anh Quang Cao 5','Link Quang Cao 5','Ten Quang Cao 5'),
('Noi Dung Quang Cao 6','Anh Quang Cao 6','Link Quang Cao 6','Ten Quang Cao 6'),
('Noi Dung Quang Cao 7','Anh Quang Cao 7','Link Quang Cao 7','Ten Quang Cao 7'),
('Noi Dung Quang Cao 8','Anh Quang Cao 8','Link Quang Cao 8','Ten Quang Cao 8'),
('Noi Dung Quang Cao 9','Anh Quang Cao 9','Link Quang Cao 9','Ten Quang Cao 9'),
('Noi Dung Quang Cao 10','Anh Quang Cao 10','Link Quang Cao 10','Ten Quang Cao 10')

insert into LoaiTaiKhoan(QuyenHan,TenLoai) values
('Quyen Han 1','Tong Bien Tap'),
('Quyen Han 2','Tac Gia'),
('Quyen Han 3','Nguoi Dung')

insert into TaiKhoan(TenTK,MatKhau,DiaChiIP,AnhDaiDien,LoaiTK) values
('Ten Tai Khoan 1','Mat Khau 1','DiaChiIP1','Anh Dai Dien 1',1),
('Ten Tai Khoan 2','Mat Khau 2','DiaChiIP2','Anh Dai Dien 2',2),
('Ten Tai Khoan 3','Mat Khau 3','DiaChiIP3','Anh Dai Dien 3',2),
('Ten Tai Khoan 4','Mat Khau 4','DiaChiIP4','Anh Dai Dien 4',2),
('Ten Tai Khoan 5','Mat Khau 5','DiaChiIP5','Anh Dai Dien 5',3),
('Ten Tai Khoan 6','Mat Khau 6','DiaChiIP6','Anh Dai Dien 6',3),
('Ten Tai Khoan 7','Mat Khau 7','DiaChiIP7','Anh Dai Dien 7',3),
('Ten Tai Khoan 8','Mat Khau 8','DiaChiIP8','Anh Dai Dien 8',3),
('Ten Tai Khoan 9','Mat Khau 9','DiaChiIP9','Anh Dai Dien 9',3),
('Ten Tai Khoan 10','Mat Khau 10','DiaChiIP10','Anh Dai Dien 10',3)

insert into ChuyenMuc(TenChuyenMuc,ChuyenMucCon) values
('Ten Chuyen Muc 1','Chuyen Muc Con 1'),
('Ten Chuyen Muc 2','Chuyen Muc Con 2'),
('Ten Chuyen Muc 3','Chuyen Muc Con 3'),
('Ten Chuyen Muc 4','Chuyen Muc Con 4'),
('Ten Chuyen Muc 5','Chuyen Muc Con 5'),
('Ten Chuyen Muc 6','Chuyen Muc Con 6'),
('Ten Chuyen Muc 7','Chuyen Muc Con 7'),
('Ten Chuyen Muc 8','Chuyen Muc Con 8'),
('Ten Chuyen Muc 9','Chuyen Muc Con 9'),
('Ten Chuyen Muc 10','Chuyen Muc Con 10')

insert into BaiBao(TuaDe,Anh,TomTat,NgayDang,BaiViet,MaChuDe,NguoiDang,NguoiDuyet,LuotXem) values
('Tua De 1','Anh 1','Tom Tat 1','20200101','Bai Viet 1',1,2,1,5),
('Tua De 2','Anh 2','Tom Tat 2','20200102','Bai Viet 2',2,2,1,5),
('Tua De 3','Anh 3','Tom Tat 3','20200103','Bai Viet 3',3,3,1,5),
('Tua De 4','Anh 4','Tom Tat 4','20200104','Bai Viet 4',4,4,1,5),
('Tua De 5','Anh 5','Tom Tat 5','20200105','Bai Viet 5',5,3,1,5),
('Tua De 6','Anh 6','Tom Tat 6','20200106','Bai Viet 6',6,2,1,5),
('Tua De 7','Anh 7','Tom Tat 7','20200107','Bai Viet 7',6,3,1,5),
('Tua De 8','Anh 8','Tom Tat 8','20200108','Bai Viet 8',7,4,1,5),
('Tua De 9','Anh 9','Tom Tat 9','20200109','Bai Viet 9',9,2,1,5),
('Tua De 10','Anh 10','Tom Tat 10','20200101','Bai Viet 10',10,1,1,5)

insert into TacGia(HoTen,ThongTin,MaTacGia,MaBaiBao) values
('Nguyen A','Thong Tin 1',2,1),
('Nguyen A','Thong Tin 2',2,2),
('Nguyen B','Thong Tin 3',3,3),
('Nguyen C','Thong Tin 4',4,4),
('Nguyen B','Thong Tin 5',3,5),
('Nguyen A','Thong Tin 6',2,6),
('Nguyen B','Thong Tin 7',3,7),
('Nguyen C','Thong Tin 8',4,8),
('Nguyen A','Thong Tin 9',2,9),
('Nguyen Z','Thong Tin 10',1,10)

insert into BinhLuan(NoiDung,LuotDanhGia,MaBaiBao) values
('Noi Dung 1',1,1),
('Noi Dung 2',2,1),
('Noi Dung 3',3,2),
('Noi Dung 4',4,2),
('Noi Dung 5',5,2),
('Noi Dung 6',6,4),
('Noi Dung 7',7,5),
('Noi Dung 8',8,7),
('Noi Dung 9',9,8),
('Noi Dung 10',10,10)

select * from BaiBao
select * from LoaiTaiKhoan
--trigger
--tạo trigger bai viết đăng lên phải có ảnh
create trigger trigger_DangBai
on BaiBao
after insert
as
if exists (select * from inserted where Anh is null or Anh = '')
	begin
		print 'Bai bao khong co anh. Yeu Cau them anh vao bai bao va dag bai lai.'
		rollback tran
	end

drop trigger trigger_DangBai

insert into BaiBao(TuaDe,TomTat,NgayDang,BaiViet,MaChuDe,NguoiDang,NguoiDuyet,LuotXem) values
('Tua De 12','Tom Tat 12','20200111','Bai Viet 12',1,2,1,5)

--stored procedures
--tao procedure them tai khoan 
create procedure sp_ThemTK @ttk varchar(20),@mk varchar(20), @ip varchar(10), @ltk int as --viết rõ tên biến
if @ltk between 1 and 3
	begin
		insert into TaiKhoan(TenTK,MatKhau,DiaChiIP,AnhDaiDien,LoaiTK) values (@ttk, @mk, @ip,'',@ltk)
	end
else
	print 'Sai loai tai khoan.'

exec sp_ThemTK @ttk = 'Ten TK 11', @mk = 'Mat Khau 11', @ip = 'Dia Chi IP 11',  @ltk = 1

--user defined function
--Tao ham lay Ho Ten tac gia bai bao
CREATE FUNCTION [dbo].[HoTenTG]
(
    @mabb int
)
RETURNS varchar(50)
AS
BEGIN

    RETURN (select HoTen from TacGia where MaBaiBao = @mabb)

END

--index 
create index idx_NgayDang on BaiBao(NgayDang) --Tim kiem theo ngay nhanh hon

--- Truy vấn dữ liệu trên một bảng
select * from QuangCao
select * from LoaiTaiKhoan
select * from TaiKhoan
select * from BaiBao
select * from TacGia
select * from BinhLuan

--- Truy vấn có sử dụng Order by
select * from BaiBao order by 4

--- Truy vấn dữ liệu từ nhiều bảng sử dụng Inner join
select * from BaiBao A inner join BinhLuan B on A.MaBaiBao = B.MaBaiBao


--- Truy vấn thống kê sử dụng Group by và Having
select MaBaiBao, avg(Luotxem) AVGLUOTXEM
from BaiBao
group by MaBaiBao
having avg(LuotXem) >=5
order by 1

--- Truy vấn sử dụng truy vấn con.
select * from BaiBao where MaChuDe = (select MaChuyenMuc from ChuyenMuc where MaChuyenMuc = 1)

--- Truy vấn sử dụng toán tử Like và các so sánh xâu ký tự.
select * from BaiBao where BaiViet like '%Viet%' and len(TomTat) >=10

--- Truy vấn liên quan tới điều kiện về thời gian
select * from BaiBao where NgayDang between '20200101' and '20200105'

--- Truy vấn sử dụng Self join, Outer join.
select * from BaiBao A full outer join TacGia B on A.MaBaiBao = B.MaBaiBao
select * from TaiKhoan A full outer join TacGia B on A.MaTaiKhoan = B.MaTacGia

select A.TuaDe, A.Anh, B.BaiViet+B.TomTat NoiDung from BaiBao A left join BaiBao B on A.MaBaiBao = B.MaBaiBao

--- Truy vấn sử dụng With.
with temptable as
(select A.TuaDe, A.Anh, B.BaiViet+B.TomTat NoiDung from BaiBao A left join BaiBao B on A.MaBaiBao = B.MaBaiBao) 
select * from temptable

--- Truy vấn sử dụng function (hàm) đã viết trong bước trước.
select *,dbo.HoTenTG(MaBaiBao) HoTen from BaiBao 

--transaction
--transaction thêm bài báo, và bình luận vào bài báo được đăng lên, sẽ gây lỗi vì chưa có bài, nên sẽ rollback lại
begin try
	begin tran
		insert into BaiBao(MaChuDe,Anh,TomTat,TuaDe,NgayDang,NguoiDang,NguoiDuyet,BaiViet,LuotXem) values
		(1,'Anh 12','Tom Tat 13','Tua De 13','20210506',2,1,'Bai Viet 14',7)
		insert into BinhLuan(NoiDung,LuotDanhGia,MaBaiBao) values
		('Noi Dung 14',12,20)
	commit tran
end try
begin catch
	rollback tran 
end catch

select * from BaiBao
select * from BinhLuan
