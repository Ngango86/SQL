create table NhaCungCap(
	MaNhaCC varchar(50) primary key,
	TenNhaCC nvarchar(100) not null,
	DiaChi varchar(100),
	SoDT varchar(20),
	MaSoThue varchar(50) not null unique
);

create table LoaiDichVu(
	MaLoaiDV varchar(30) primary key,
	TenLoaiDV ntext not null
);

create table MucPhi(
	MaMP varchar(30) primary key,
	DonGia decimal(14,3) not null check(DonGia >= 0) default 0,
	MoTa nvarchar(255),
);

create table DongXe(
	DongXe nvarchar(100) primary key,
	HangXe nvarchar(100) not null,
	SoChoNgoi int not null check(SoChoNgoi >= 1),
);

create table DangKyCungCap(
	MaDKCC varchar(30) primary key,
	MaNhaCC varchar(50) not null foreign key references NhaCungCap(MaNhaCC),
	MaLoaiDV varchar(30) not null foreign key references LoaiDichVu(MaLoaiDV),
	DongXe nvarchar(100) not null foreign key references DongXe(DongXe),
	MaMP varchar(30) not null foreign key references MucPhi(MaMP),
	NgayBatDauCungCap date not null default getdate(),
	NgayKetThucCungCap date,
	SoLuongXeDangKy int
);

drop table DangKyCungCap;

drop table LoaiDichVu;

-- ﻿-- CRUD - create read update delete  -- DATABASE MANAGEMENT

--read
select * from NhaCungCap;
select * from LoaiDichVu;
select * from MucPhi;
select * from DongXe;
select * from DangKyCungCap;


-- creat

insert into NhaCungCap(MaNhaCC,TenNhaCC,DiaChi,SoDT,MaSoThue) 
values('NCC001',N'Cty TNHH Toàn Pháp','Hai Chau','05113999888','568941'),
('NCC002',N'Cty Cổ phần Đông Du','Lien Chau','05113999889','456789'),
('NCC003',N'Ông Nguyễn Văn A','Hòa Thuận','05113999890','321456'),
('NCC004',N'Cty Cổ phần Toàn Cầu Xanh','Hai Chau','05113658945','513364'),
('NCC005',N'Cty TNHH AMA','Thanh Khe','05113875466','546546'),
('NCC006',N'Bà Trần Thị Bích Vân','Lien Chau','05113587469','524545'),
('NCC007',N'Cty TNHH Phan Thánh','Thanh Khe','05113987456','113021'),
('NCC008',N'Ông Phan Đình Nam','Hoa Thuan','05113532456','121230'),
('NCC009',N'Tập đoàn Đông Nam Á','Lien Chieu','05113987121','533654'),
('NCC010',N'Cty Cổ phần Rạng Đông','Lien Chau','05113569654','187864');

insert into LoaiDichVu(MaLoaiDV,TenLoaiDV)
values('DV01',N'Dịch vụ xe taxi'),
('DV02',N'Dịch vụ xe buýt công cộng theo tuyến cố định'),
('DV03',N'Dịch vụ xe cho thuê theo hợp đồng');

insert into MucPhi(MaMP,DonGia,MoTa)
values('MP01',10000,N'Áp dụng từ 1/2015'),
('MP02',15000,N'Áp dụng từ 2/2015'),
('MP03',20000,N'Áp dụng từ 1/2010'),
('MP04',25000,N'Áp dụng từ 2/2011');

insert into DongXe(DongXe,HangXe,SoChoNgoi)
values('Hiace','Toyota',16),
('Vios','Toyota',5),
('Escape','Ford',5),
('Cerato','KIA',7),
('Forte','KIA',5),
('Starex','Huyndai',7),
('Grand-i10','Huyndai',7);

insert into DangKyCungCap(MaDKCC,MaNhaCC,MaLoaiDV,DongXe,MaMP,NgayBatDauCungCap,NgayKetThucCungCap,SoLuongXeDangKy)
values('DK001','NCC001','DV01','Hiace','MP01','2015/11/20','2016/11/20',4),
('DK002','NCC002','DV02','Vios','MP02','2015/11/20','2017/11/20',3),
('DK003','NCC003','DV03','Escape','MP03','2017/11/20','2018/11/20',5),
('DK004','NCC005','DV01','Cerato','MP04','2015/11/20','2019/11/20',7),
('DK005','NCC002','DV02','Forte','MP03','2019/11/20','2020/11/20',1),
('DK006','NCC004','DV03','Starex','MP04','2016/11/10','2021/11/20',2),
('DK007','NCC005','DV01','Cerato','MP03','2015/11/30','2016/01/25',8),
('DK008','NCC006','DV01','Vios','MP02','2016/02/28','2016/08/15',9),
('DK009','NCC005','DV03','Grand-i10','MP02','2016/04/27','2017/04/30',10),
('DK010','NCC006','DV01','Forte','MP02','2015/11/21','2016/02/22',4),
('DK011','NCC007','DV01','Forte','MP01','2016/12/25','2017/02/20',5),
('DK012','NCC007','DV03','Cerato','MP01','2016/04/14','2017/12/20',6),
('DK013','NCC003','DV02','Cerato','MP01','2015/12/21','2016/12/21',8),
('DK014','NCC008','DV02','Cerato','MP01','2016/05/20','2016/12/30',1),
('DK015','NCC003','DV01','Hiace','MP02','2018/04/24','2019/11/20',6),
('DK016','NCC001','DV03','Grand-i10','MP02','2016/06/22','2016/12/21',8),
('DK017','NCC002','DV03','Cerato','MP03','2016/09/30','2019/09/30',4),
('DK018','NCC008','DV03','Escape','MP04','2017/12/13','2018/09/30',2),
('DK019','NCC003','DV03','Escape','MP03','2016/01/24','2016/12/30',8),
('DK020','NCC002','DV03','Cerato','MP04','2016/05/03','2017/10/21',7),
('DK021','NCC006','DV01','Forte','MP02','2011/01/30','2016/12/30',9),
('DK022','NCC002','DV02','Cerato','MP04','2016/07/25','2017/12/30',6),
('DK023','NCC002','DV01','Forte','MP03','2017/11/30','2018/05/20',5),
('DK024','NCC003','DV03','Forte','MP04','2017/12/23','2019/11/30',8),
('DK025','NCC003','DV03','Hiace','MP02','2016/08/24','2017/10/25',1);



-- Câu 3: liệt kê những dòng xe có số chỗ ngồi trên 5 chỗ

select*from DongXe where SoChoNgoi > 5;

-- Câu 4: Liệt kê thông tin của các nhà cung cấp đã từng đăng ký cung cấp những dòng xe thuộc hãng xe “Toyota” với mức phí có đơn giá là 15.000 VNĐ/km hoặc những
		-- dòng xe thuộc hãng xe “KIA” với mức phí có đơn giá là 20.000 VNĐ/km
select*from NhaCungCap where 
MaNhaCC in (select MaNhaCC from DangKyCungCap where DongXe in (select DongXe from DongXe where HangXe = 'Toyota') and MaMP in (select MaMP from MucPhi where DonGia = 15000))
or MaNhaCC in (select MaNhaCC from DangKyCungCap where DongXe in (select DongXe from DongXe where HangXe = 'KIA') and MaMP in (select MaMP from MucPhi where DonGia = 20000))





--select*from DangKyCungCap where DongXe in ('Hiace','Vios')  and MaMP = 'MP02'; --làm lại
--select*from DangKyCungCap where DongXe in ('Cerato','Forte')  and MaMP = 'MP02';  --làm lại

-- Câu 5: Liệt kê thông tin toàn bộ nhà cung cấp được sắp xếp tăng dần theo tên
			-- nhà cung
			-- cấp và giảm dần theo mã số thuế

select*from NhaCungCap order by TenNhaCC asc, MaSoThue desc;


-- Câu 6: Đếm số lần đăng ký cung cấp phương tiện tương ứng cho từng nhà cung cấp với
		-- yêu cầu chỉ đếm cho những nhà cung cấp thực hiện đăng ký cung cấp có ngày bắt đầu
		-- cung cấp là “20/11/2015”

 select MaDKCC, count(MaDKCC) as soluong  from DangKyCungCap where NgayBatDauCungCap = '2015/11/20' group by MaDKCC;


 -- Câu 7: Liệt kê tên của toàn bộ các hãng xe có trong cơ sở dữ liệu với yêu cầu mỗi hãng xe chỉ được liệt kê một lần
 select distinct HangXe from DongXe;  -- loại bỏ trùng nhau (distinct)


 -- câu 8 (nối bảng): Liệt kê MaDKCC, MaNhaCC, TenNhaCC, DiaChi, MaSoThue, TenLoaiDV, DonGia, HangXe, NgayBatDauCC, NgayKetThucCC của tất cả các lần đăng ký cung cấp
			-- phương tiện với yêu cầu những nhà cung cấp nào chưa từng thực hiện đăng ký cung cấp
			-- phương tiện thì cũng liệt kê thông tin những nhà cung cấp đó ra

select DangKyCungCap.MaDKCC, NhaCungCap.MaNhaCC, NhaCungCap.TenNhaCC, NhaCungCap.DiaChi, NhaCungCap.MaSoThue, LoaiDichVu.TenLoaiDV, MucPhi.DonGia, DongXe.HangXe, DangKyCungCap.NgayBatDauCungCap, DangKyCungCap.NgayKetThucCungCap
from NhaCungCap 
left join DangKyCungCap on NhaCungCap.MaNhaCC = DangKyCungCap.MaNhaCC 
left join LoaiDichVu on DangKyCungCap.MaLoaiDv = LoaiDichVu.MaLoaiDv
left join DongXe on DangKyCungCap.DongXe = DongXe.DongXe
left join MucPhi on DangKyCungCap.MaMP = MucPhi.MaMP;


 -- câu 9 truy vấn từ DongXe -> DangKyCungCap -> NhaCungCap
 -- Câu 9: Liệt kê thông tin của các nhà cung cấp đã từng đăng ký cung cấp phương tiện thuộc dòng xe “Hiace” hoặc từng đăng ký cung cấp phương tiện thuộc dòng xe “Cerato”
 select*from NhaCungCap where MaNhaCC in( select MaNhaCC from DangKyCungCap where DongXe in ('Hiace','Cerato'));


 -- Câu 10, nối bảng xong right join
 -- Câu 10: Liệt kê thông tin của các nhà cung cấp chưa từng thực hiện đăng ký cung cấp phương tiện lần nào cả.

 select*from NhaCungCap where MaNhaCC not in (select MaNhaCC from DangKyCungCap);