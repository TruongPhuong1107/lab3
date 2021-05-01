/*----------------------------------------------------------
MASV:44.01.104.177
HO TEN:Trương Thị Phương
LAB: 03
NGAY:27/04/2021
----------------------------------------------------------*/
create database QLSV2
use QLSV2
go
drop table SINHVIEN
create table SINHVIEN(
MASV NVARCHAR(20),
HOTEN NVARCHAR(100),
NGAYSINH DATETIME,
DIACHI NVARCHAR(200),
MALOP VARCHAR(20),
TENDN NVARCHAR(100),
MATKHAU VARBINARY(MAX)
 constraint pk_sinhvien primary key (MASV),
 constraint fk_sinhvien foreign key(MALOP) references LOP(MALOP)
)
go 
create table NHANVIEN(
MANV VARCHAR(20),
HOTEN NVARCHAR(100),
EMAIL VARCHAR(20),
LUONG VARBINARY(max),
TENDN NVARCHAR(100),
MATKHAU VARBINARY(max)
constraint pk_nhanvien primary key(MANV),
)
drop table LOP
create table LOP(
MALOP VARCHAR(20),
TENLOP NVARCHAR(200),
MANV VARCHAR(20)
constraint pk_lop primary key(MALOP),
constraint fk_lop foreign key(MANV) references NHANVIEN(MANV)
)
go
drop procedure SP_INS_SINHVIEN
--Mã hóa MD5
create procedure SP_INS_SINHVIEN
@masv nvarchar(20),
@hoten nvarchar(100),
@ngaysinh date,
@diachi nvarchar(20),
@malop varchar(20),
@tendn nvarchar(100),
@matkhau varchar(50)
as 
begin
insert into SINHVIEN(MASV,HOTEN,NGAYSINH,DIACHI,MALOP,TENDN,MATKHAU)
values(@masv, @hoten,@ngaysinh,@diachi,@malop,@tendn,HASHBYTES('MD5',@matkhau));
end

EXEC SP_INS_SINHVIEN 'SV01', 'NGUYEN VAN A', '1/1/1990', '280 AN DUONG VUONG', 'CNTT-K35', 'NVA','123456'
select * from SINHVIEN
--Mã hóa AES-256

CREATE SYMMETRIC KEY SK_4401104177
WITH  
    ALGORITHM = AES_256  
    ENCRYPTION BY PASSWORD = 'abcdefghijklmnopqrstuvwxyzasdefb';
create procedure SP_INS_NHANVIEN
@manv varchar(20),
@hoten nvarchar(50),
@email nvarchar(50),
@luong varchar(100),
@tendn varchar(50),
@matkhau varchar(20)
as 
begin
SET NOCOUNT ON;  
OPEN SYMMETRIC KEY SK_4401104177 DECRYPTION BY PASSWORD='abcdefghijklmnopqrstuvwxyzasdefb'
insert into NHANVIEN (MANV, HOTEN,EMAIL,LUONG,TENDN,MATKHAU)
values (@manv,@hoten,@email,ENCRYPTBYKEY(Key_GUID('SK_4401104177'),CONVERT(VARBINARY(max),@luong)),@tendn,hashbytes('SHA1',@matkhau))
CLOSE SYMMETRIC KEY SK_4401104177;
END  

drop procedure SP_INS_NHANVIEN
EXEC SP_INS_NHANVIEN 'NV06', 'NGUYEN VAN A', 'NVA@', '3000000',
'NVA', 'abcd12'

delete from NHANVIEN where MANV='NV04'
--giải mã
OPEN SYMMETRIC KEY SK_4401104177 DECRYPTION BY PASSWORD='abcdefghijklmnopqrstuvwxyzasdefb'  
SELECT   
    [MANV], [HOTEN], [EMAIL], 
    CONVERT(varchar(MAX), DECRYPTBYKEY([LUONG]))as LUONG
FROM  
    NHANVIEN
CLOSE SYMMETRIC KEY SK_4401104177;
--thêm lớp
insert into LOP values('CNTT-K35','CNTT-C','NV05')