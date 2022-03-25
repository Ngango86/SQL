create table LoaiSP(
	TenLoai nvarchar(255) not null unique,
	MaLoaiSP varchar(30) primary key
);

create table NguoiCTN(
	Ten nvarchar(50) not null,
	MaNguoiCTN varchar(30) primary key
);

create table SanPham(
	MaSP varchar(50) primary key,
	NgaySX date not null default getdate(),
	MaLoaiSP varchar(30) foreign key references LoaiSP(MaLoaiSP),
	MaNguoiCTN varchar(30) foreign key references NguoiCTN(MaNguoiCTN)
);

-- ﻿-- CRUD - create read update delete  -- DATABASE MANAGEMENT



-- Creat
-- Câu 3: Viết các câu lệnh để thêm dữ liệu vào các bảng Chèn thêm dữ liệu vào các bảng đã thiết kế

insert into LoaiSP(TenLoai,MaLoaiSP) values (N'Máy tính sách tay Z37','Z37E');
insert into LoaiSP(TenLoai,MaLoaiSP) values (N'Máy tính sách tay Z38','Z38E');
insert into NguoiCTN(Ten,MaNguoiCTN) Values (N'Nguyễn Văn An','987688');
insert into SanPham(MaSP,NgaySX,MaLoaiSP,MaNguoiCTN) values ('Z37 111111','2009/12/12','Z37E','987688');
insert into SanPham(MaSP,NgaySX,MaLoaiSP,MaNguoiCTN) values ('Z38 111112','2010/12/30','Z37E','987688');
insert into SanPham(MaSP,NgaySX,MaLoaiSP,MaNguoiCTN) values ('Z39 111113','2010/12/29','Z38E','987688');

-- Câu 4: Viết các câu lênh truy vấn để
		-- a) Liệt kê danh sách loại sản phẩm của công ty.
		-- b) Liệt kê danh sách sản phẩm của công ty.
		-- c) Liệt kê danh sách người chịu trách nhiệm của công ty.
-- Read
select*from LoaiSP;
select*from NguoiCTN;
select*from SanPham;

-- Câu 5: Viết các câu lệnh truy vấn để lấy
		-- a) Liệt kê danh sách loại sản phẩm của công ty theo thứ tự tăng dần của tên
		-- b) Liệt kê danh sách người chịu trách nhiệm của công ty theo thứ tự tăng dần của tên.
		-- c) Liệt kê các sản phẩm của loại sản phẩm có mã số là Z37E.
		-- d) Liệt kê các sản phẩm Nguyễn Văn An chịu trách nhiệm theo thứ tự giảm đần của mã.

select*from LoaiSP order by TenLoai asc;
select*from NguoiCTN order by Ten asc;
select*from SanPham where MaLoaiSP like 'Z37E';
select*from SanPham where MaNguoiCTN like (select MaNguoiCTN from NguoiCTN where Ten like N'Nguyễn Văn An') order by MaNguoiCTN desc;
 
 -- Câu 6: Viết các câu lệnh truy vấn để
		-- a) Số sản phẩm của từng loại sản phẩm.
		-- b) Số loại sản phẩm trung bình theo loại sản phẩm.
		-- c) Hiển thị toàn bộ thông tin về sản phẩm và loại sản phẩm.
		-- d) Hiển thị toàn bộ thông tin về người chịu trách nhiêm, loại sản phẩm và sản phẩm.
-- a
select MaLoaiSP, count(MaLoaiSP) as sosanpham from SanPham group by MaLoaiSP;
-- select MaLoaiSP, avg(MaLoaiSP) as trungbinh from LoaiSP group by MaLoaiSP;

--b chưa làm


--c
select SanPham.MaSP, SanPham.NgaySX, SanPham.MaNguoiCTN, LoaiSP.TenLoai, LoaiSP.MaLoaiSP from SanPham inner join LoaiSP on SanPham.MaLoaiSP = LoaiSP.MaLoaiSP;

--d
select SanPham.MaSP,SanPham.NgaySX,SanPham.MaLoaiSP,SanPham.MaNguoiCTN,NguoiCTN.Ten,LoaiSP.TenLoai from  SanPham 
inner join LoaiSP on SanPham.MaLoaiSP = LoaiSP.MaLoaiSP
inner join NguoiCTN on SanPham.MaNguoiCTN = NguoiCTN.MaNguoiCTN ;

-- Câu 7: Thay đổi những thư sau từ cơ sở dữ liệu
		-- a) Viết câu lệnh để thay đổi trường ngày sản xuất là trước hoặc bằng ngày hiện tại.
		-- b) Viết câu lệnh để xác định các trường khóa chính và khóa ngoại của các bảng.
		-- c) Viết câu lệnh để thêm trường phiên bản của sản phẩm.
--a
alter table SanPham add constraint check_ngay_sx check(NgaySX <= getdate());

--b
SELECT 
	-- obj.name AS FK_NAME,
	-- sch.name AS [schema_name],
    tab1.name AS [table],
    col1.name AS [column],
    tab2.name AS [referenced_table],
    col2.name AS [referenced_column]
FROM sys.foreign_key_columns fkc
INNER JOIN sys.objects obj
    ON obj.object_id = fkc.constraint_object_id
INNER JOIN sys.tables tab1
    ON tab1.object_id = fkc.parent_object_id
INNER JOIN sys.schemas sch
    ON tab1.schema_id = sch.schema_id
INNER JOIN sys.columns col1
    ON col1.column_id = parent_column_id AND col1.object_id = tab1.object_id
INNER JOIN sys.tables tab2
    ON tab2.object_id = fkc.referenced_object_id
INNER JOIN sys.columns col2
    ON col2.column_id = referenced_column_id AND col2.object_id = tab2.object_id

--c
alter table SanPham add PhienBanSP varchar(100);


-- Câu 8

-- A chưa làm


--B
-- Ý 1
create view View_SanPham as 
select SanPham.MaLoaiSP, SanPham.NgaySX, LoaiSP.TenLoai from SanPham inner join LoaiSP on SanPham.MaLoaiSP = LoaiSP.MaLoaiSP;

-- Ý 2
create view View_SanPham_NCTN as select SanPham.MaSP, SanPham.NgaySX, NguoiCTN.Ten, NguoiCTN.MaNguoiCTN from SanPham inner join NguoiCTN on SanPham.MaNguoiCTN = NguoiCTN.MaNguoiCTN;
select*from View_SanPham_NCTN;

-- Ý 3
create view View_Top_SanPham as
select top 5* from SanPham order by NgaySX desc;

-- C

-- Ý 1
create procedure SP_Them_LoaiSP @tenloai nvarchar(255),@maloai varchar(30) as
insert into LoaiSP(TenLoai,MaLoaiSP) values (@tenloai,@maloai);

exec SP_Them_LoaiSP @tenloai = N'Máy tính sách tay Z39',@maloai = 'Z39E';

-- Ý 2
create procedure SP_Them_NCTN @ten nvarchar(50), @manguoictn varchar(30) as
insert into NguoiCTN(Ten,MaNguoiCTN) values (@ten,@manguoictn);

exec SP_Them_NCTN @ten = N'Bùi Anh Tuấn', @manguoictn = '987699';

-- Ý 3
create procedure SP_Them_SanPham @masp varchar(50), @ngaysx date, @maloaisp varchar(30), @manguoictn varchar(30) as
insert into SanPham(MaSP,NgaySX,MaLoaiSP,MaNguoiCTN) values (@masp,@ngaysx,@maloaisp,@manguoictn);

exec SP_Them_SanPham @masp = 'Z40 111145', @ngaysx = '2015/11/1', @maloaisp = 'Z39E', @manguoictn = '987699';

-- Ý 4
create procedure SP_Xoa_SanPham @masp varchar(50) as
delete from SP_Xoa_SanPham where MaSP like @masp;


-- Ý 5
create procedure SP_Xoa_SanPham_TheoLoai @maloaisp varchar(30) as
delete from SP_Xoa_SanPham_TheoLoai where MaLoaiSP like @maloaisp;

