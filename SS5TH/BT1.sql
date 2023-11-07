drop database if exists demo;
create database demo;
use demo;
create table if not exists Products (
id int primary key auto_increment,
productCode varchar(255) not null,
productName varbinary(255) not null,
productPrice float,
productDescription text,
productStatus bit(1)
);
insert into Products (productCode, productName, productPrice, productDescription, productStatus)
values
('P00001', 'Ti Vi', 100, 'china', 1),
('P00002', 'Tủ Lạnh', 200, 'japan', 1),
('P00003', 'Máy hút bụi', 300, 'USA', 1),
('P00004', 'Máy Giặt', 150, 'Viet Nam', 1);
create index index_product_code on Products (productCode);
# drop index index_product_code on Products;
create index index_product_name_price on Products (productName, productPrice);
# drop index index_product_name_price on Products;
select * from Products where productCode = 'P00003';
explain select * from Products where productCode = 'P00003';
# tạo view
create view vw_code_name_price_status as
select productCode, productName, productPrice, productStatus from Products;
# cập nhật view
create or replace view vw_code_name_price_status as
select productCode, productName, productPrice, productDescription, productStatus from Products;
# xóa view
drop view vw_code_name_price_status;
# tạo procedure lấy tất cả các thông tin của tất cả các sản phẩm trong bảng Products
delimiter //
create procedure proc_getAll()
begin
select * from Products;
end; //
delimiter ;
# tạo procedure thêm một sản phẩm mới
delimiter //
create procedure proc_insertNewProduct(IN pCode varchar(255), IN pName varchar(255), IN pPrice float, IN pDescription text, IN pStatus bit(1))
begin
insert into Products (productCode, productName, productPrice, productDescription, productStatus)
values
(pCode, pName, pPrice, pDescription, pStatus);
end; //
delimiter ;
# tạo procedure sửa thông tin sản phẩm theo id
delimiter //
create procedure proc_updateProduct(IN pID int, IN pCode varchar(255), IN pName varchar(255), IN pPrice float, IN pDescription text, IN pStatus bit(1))
begin
update Products
set productCode = pCode, productName = pName, productPrice = pPrice, productDescription = pDescription, productStatus = pStatus
where id = pID;
end; //
delimiter ;
# tạo procedure xóa sản phẩm theo id
delimiter //
create procedure proc_deleteProduct(IN pID int)
begin
delete from Products
where id = pID;
end; //
delimiter ;