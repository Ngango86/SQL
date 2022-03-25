
create table Hang_SP(
	MaSoHang varchar(30) primary key,
	TenHang varchar(255) not null unique,
	DiaChi nvarchar(100),
	SoDienThoai varchar(20) check(len(SoDienThoai)>=5 and len(SoDienThoai)<=11)
);
create table SanPham(
	ID int primary key,
	TenSP nvarchar(100) not null unique,
	SoLuong int not null check(SoLuong>=0),
	Gia decimal(12,4) not null check(Gia>=0),
	MoTa nvarchar(255),
	DonVi nvarchar(100) not null,
	MS_Hang varchar(30) not null foreign key references Hang_SP(MaSoHang)
);



-- Câu 3
insert into Hang_SP(MaSoHang,TenHang,DiaChi,SoDienThoai) values('123','Asus','USA','983232');
insert into SanPham(ID,TenSP,SoLuong,Gia,MoTa,DonVi,MS_Hang) values
(1,N'Máy Tính T450',10,1000,N'Máy nhập cũ',N'Chiếc','123'),
(2,N'Điện Thoại Nokia5670',200,200,N'Điện thoại đang hot',N'Chiếc','123'),
(3,N'Máy In Samsung 450',10,100,N'Máy in đang loại bình',N'Chiếc','123');

-- Câu 4
select*from Hang_SP;
select*from SanPham;

-- Câu 5
select*from Hang_SP order by TenHang desc;
select*from SanPham order by Gia desc;
select*from Hang_SP where TenHang like 'Asus';
select*from SanPham where SoLuong < 11;
select*from SanPham where MS_Hang in (select MaSoHang from Hang_SP where TenHang like 'Asus');

-- Câu 6
select count(MaSoHang) as so_hang from Hang_SP;
select count(ID) as so_san_pham from SanPham;
select MS_Hang, count(ID) as so_SP_moi_hang from SanPham group by MS_Hang;
select sum(SoLuong) as so_dau_SP from SanPham;

-- Câu 7

alter table SanPham add constraint check_gia check(Gia>=0);
alter table Hang_SP add constraint check_sdt check(SoDienThoai like '0%');

-- c
EXEC sp_fkeys 'SanPham';
exec sp_help 'SanPham';

SELECT 
	obj.name AS FK_NAME,
	sch.name AS [schema_name],
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

-- Câu 8
-- a chưa làm

-- b
-- Ý 1
create view View_SanPham as select SanPham.ID, SanPham.TenSP, SanPham.Gia from SanPham;
select*from View_SanPham;

-- Ý 2
create view View_SanPham_Hang as select SanPham.ID, SanPham.TenSP, Hang_SP.TenHang from SanPham left join Hang_SP on SanPham.MS_Hang = Hang_SP.MaSoHang;
select*from View_SanPham_Hang;

-- c
-- Ý 1
create procedure SP_SanPham_TenHang @ten_hang varchar(255) as select*from SanPham where MS_Hang in(select MaSoHang from Hang_SP where TenHang = @ten_hang);
exec SP_SanPham_TenHang @ten_hang = 'Asus';

-- Ý 2
create procedure SP_SanPham_Gia @gia_ban decimal(12,4) as select*from SanPham where Gia >= @gia_ban;
exec SP_SanPham_Gia @gia_ban = 300;

-- Ý 3
create procedure SP_SanPham_HetHang @so_luong int as select TenSP from SanPham where SoLuong = @so_luong;
exec SP_SanPham_HetHang @so_luong = 0;



-- d chưa làm

