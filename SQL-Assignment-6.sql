create table NguoiDung(
	ID int primary key identity(1,1),
	Ten nvarchar(100) not null,
	DiaChi nvarchar(255),
	NgaySinh date check(NgaySinh <= getdate())
);

create table DanhBa(
	ID int primary key identity(1,1),
	SoDT varchar(20) not null unique check(len(SoDT) >= 9 and len(SoDT) <=12),
	NguoiDungID int foreign key references NguoiDung(ID)
);


-- Câu 3

-- A
insert into NguoiDung(Ten,DiaChi,NgaySinh) values (N'Nguyễn Văn An',N'111 Nguyễn Trãi, Thanh Xuân, Hà Nội','1987/11/18');
-- B
insert into DanhBa(SoDT,NguoiDungID) values('987654321',1),('098734525',1),('098323235',1),('094343430',1);

drop table DanhBa;

-- Câu 4

-- A
select*from NguoiDung;
-- B
select*from DanhBa;

-- Câu 5

-- A
select*from NguoiDung order by Ten asc;
-- B
select DanhBa.SoDT from DanhBa where NguoiDungID = (select ID from NguoiDung where Ten like N'Nguyễn Văn An');
-- C
select * from NguoiDung where NgaySinh = '2009/12/12';
-- select *from NguoiDung where NgaySinh like '1987/11/18'; like không dùng được

-- Câu 6

-- A
select NguoiDungID, count(NguoiDungID) as soluong from DanhBa group by NguoiDungID;

-- B
select count(ID) as slsinhthang12 from NguoiDung where NgaySinh like '%12%';

-- C
select NguoiDung.ID, NguoiDung.Ten, NguoiDung.NgaySinh, NguoiDung.DiaChi, DanhBa.SoDT from NguoiDung inner join DanhBa on NguoiDung.ID = DanhBa.NguoiDungID;

-- D
select NguoiDung.ID, NguoiDung.Ten, NguoiDung.NgaySinh, NguoiDung.DiaChi from NguoiDung where ID = (select NguoiDungID from DanhBa where SoDT like '123456789');

-- Câu 7 

-- A
alter table NguoiDung drop constraint CK__NguoiDung__NgayS__108B795B;
alter table NguoiDung add constraint check_ngaysinh check(NgaySinh <= getdate());

-- B
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


-- C
alter table NguoiDung add NgayBatDauLienLac date;


-- Câu 8

-- A chưa làm


-- B
-- Ý 1
create view View_SoDienThoai as select NguoiDung.Ten, DanhBa.SoDT from NguoiDung inner join DanhBa on NguoiDung.ID = DanhBa.NguoiDungID;
select*from View_SoDienThoai;

-- Ý 2
create view View_SinhNhat as select NguoiDung.Ten, NguoiDung.NgaySinh, DanhBa.SoDT from NguoiDung left join DanhBa on NguoiDung.ID = DanhBa.NguoiDungID  
where NgaySinh like '%11%';


-- C
-- Ý 1
create procedure SP_Them_DanhBa @id int, @ten nvarchar(100), @diachi nvarchar(255), @ngaysinh date  
as insert into NguoiDung(ID,Ten,DiaChi,NgaySinh) values(@id,@ten,@diachi,@ngaysinh);

-- Ý 2
create procedure SP_Tim_DanhBa @ten nvarchar(100) as select*from NguoiDung where Ten like @ten;
exec SP_Tim_DanhBa @ten = N'Nguyễn Văn An';
