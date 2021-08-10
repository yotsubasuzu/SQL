--Dựa trên file deposit 201701.csv đã Upload lên SQL thực hiện các truy vấn dưới đây:
select top 5 * from Lesson1;

--Lấy danh sách hợp đồng có số tiền > 100 triệu
select RECID from Lesson1 where QUY_DOI > power(10,8);

--lấy danh sách hợp đồng có số tiền < 500 triệu
select RECID from Lesson1 where QUY_DOI < 5*power(10,8);

--lấy danh sách hợp đồng có companyid = VN0010549
select RECID from Lesson1 where CO_CODE = 'VN0010549';

--lấy danh sách hợp đồng có companyid = VN0010549 và có số tiền > 100 triệu
select RECID from Lesson1 where CO_CODE = 'VN0010549' and QUY_DOI > power(10,8);

--lấy danh sách hợp đồng có số tiền < 100 triệu hoặc > 500 triệu
select RECID from Lesson1 where QUY_DOI < power(10,8) or QUY_DOI > 5*power(10,8);

--lấy danh sách hợp đồng có companyid VN0010549 và có số tiền < 100 triệu hoặc > 500 triệu
select RECID from Lesson1 where CO_CODE = 'VN0010549' and (QUY_DOI < power(10,8) or QUY_DOI > 5*power(10,8));

--lấy danh sách hợp đồng có companyid VN0010549 có số tiền > 100 triệu và có kỳ hạn 24 tháng
select RECID from Lesson1 where CO_CODE = 'VN0010549' and QUY_DOI > power(10,8) and LOC_TERM = '24';

--Lấy 10 hợp đồng có số tiền lớn nhất và lớn hơn 1 tỷ
select top 10 RECID from Lesson1 where QUY_DOI > power(10,9) order by QUY_DOI desc;

--Lấy ra tổng số tiền
select sum(QUY_DOI) from Lesson1;

--Lấy ra bình quân số tiền
select avg(QUY_DOI) from Lesson1;

--Lấy ra hợp đồng có tiền nhỏ nhất
select RECID from Lesson1 where QUY_DOI = (select min(QUY_DOI) from Lesson1);

--Lấy ra hợp đồng có tiền lớn nhất
select RECID from Lesson1 where QUY_DOI = (select max(QUY_DOI) from Lesson1);

--Lấy ra danh sách các chi nhánh
select distinct CO_CODE from Lesson1;

--Lấy ra danh sách các sản phẩm
select distinct CATE_NAME from Lesson1;

--Lấy ra danh sách các chi nhánh và các kỳ hạn đi kèm
select distinct CO_CODE, LOC_TERM from Lesson1;

--Lấy ra danh sách các chi nhánh và các kỳ hạn đi kèm có số tiền > 1 tỷ
select distinct CO_CODE, LOC_TERM from Lesson1 where QUY_DOI > POWER(10,9);

--Lấy ra danh sách các hợp đồng có tên sản phẩm bắt đầu bằng ‘TK’
select RECID from Lesson1 where CATE_NAME like 'TK%';

--Lấy ra danh sách các hợp đồng có tên sản phẩm kết thúc bằng ‘Co Dinh’
select RECID from Lesson1 where CATE_NAME like '%Co Dinh';

--Lấy ra danh sách các hợp đồng có tên sản phẩm có từ ‘Lãi suất’
select RECID from Lesson1 where CATE_NAME like '%Lai suat%';

--Lấy ra danh sách các hợp đồng có tên sản phẩm có từ ‘Lãi suất’ và loại tiền là VND.
select RECID from Lesson1 where CATE_NAME like '%Lai suat%' and CURRENCY = 'VND';
