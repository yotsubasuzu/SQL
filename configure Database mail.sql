----- BUOC 1: CREATE PROFILE AND ACCOUNT -----
----- THỰC HIỆN TẠO PROFILE VÀ ACCOUNT TẠI KHUNG OBJECT EXPLORER

----- BUOC 2: CONFIGURE MAIL -----
sp_CONFIGURE 'show advanced', 1
GO
RECONFIGURE
GO
sp_CONFIGURE 'Database Mail XPs', 1
GO
RECONFIGURE

----- BUOC 3: SEND MAIL -----
USE MSDB

DECLARE @tableHTML  NVARCHAR(MAX);
SET @tableHTML =  
    N'<H1>Contract Summary</H1>' +  
    N'<table border="1">' +  
    N'<tr><th>SOHD</th><th>MASP</th>' +  
    N'<th>SL</th></tr>' +  
    CAST((SELECT td = SOHD, '',
				 td = MASP, '',
				 td = SL 
				 FROM qlbh_..CTHD
				 FOR XML PATH ('tr'), TYPE) AS NVARCHAR(MAX)) +  
    N'</table>';

EXEC SP_SEND_DBMAIL @profile_name = 'SQL30',
@recipients = 'test2dbmail@gmail.com',
@subject = N'Xin chào! Tôi là học viên lớp SQL30',
--@body = N'Tôi tên là Minh',
@body = @tableHTML,
@body_format = 'HTML',
@query = 'SELECT sohd, masp, sl FROM QLBH_..CTHD',
@attach_query_result_as_file = 1,
@query_attachment_filename = 'cthd.txt',
@query_result_separator = '|',
@query_result_header = 1

---------- CHECK CONFIG SEND MAIL TREN SQL ----------
EXEC msdb.dbo.sysmail_help_configure_sp;  ---- THÔNG TIN THAM SỐ CẤU HÌNH
EXEC msdb.dbo.sysmail_help_account_sp;  ---- THÔNG TIN ACCOUNT
EXEC msdb.dbo.sysmail_help_profile_sp;  ---- THÔNG TIN PROFILE
EXEC msdb.dbo.sysmail_help_profileaccount_sp; ---- THÔNG TIN PROFILE VÀ ACCOUNT TƯƠNG ỨNG
EXEC msdb.dbo.sysmail_help_principalprofile_sp; ---- THÔNG TIN PRINCIPAL

---------- CHECK PROFILE MAIL ----------
SELECT * FROM msdb.dbo.sysmail_profile  ---- THÔNG TIN KHỞI TẠO PROFILE
SELECT * FROM msdb.dbo.sysmail_account  ---- THÔNG TIN KHỞI TẠO ACCOUNT
SELECT * FROM msdb.dbo.sysmail_allitems ---- THÔNG TIN CÁC EVENT GỬI MAIL
SELECT * FROM msdb.dbo.sysmail_sentitems ---- THÔNG TIN MAIL GỬI ĐI, SENT_STATUS = 'SENT'
SELECT * FROM msdb.dbo.sysmail_faileditems ---- THÔNG TIN NHỮNG ACTION FAILED

SELECT * FROM msdb..sysmail_mailitems ---- THÔNG TIN CÁC EMAILS, SENT_STATUS = 1
SELECT * FROM msdb..sysmail_log ---- THÔNG TIN LOG


---- BUỔI 1: STORED PROCEDURE
CREATE PROCEDURE [PROC_NAME] ([VARIABLE NAME] [VARIABLE TYPE])
AS
BEGIN
	[PROCEDURE DEFINITION] ---- ALL COMMANDS IN SQL SERVER
END

---- BUỔI 2: 
---- FUNCTION -> SCALAR VALUE FUNCTION, TABLE VALUE FUNCTION
---- 1. SCALAR
CREATE FUNCTION [FUNC_NAME] ([VARIABLE NAME] [VARIABLE TYPE])
RETURNS [OUTPUT TYPE]
AS
BEGIN
	
	RETURN
END

--- 2. TABLE-VALUED FUNCTION 
CREATE FUNCTION [FUNC_NAME] ([VARIABLE NAME] [VARIABLE TYPE])
RETURNS TABLE
AS
RETURN
(
	[QUERY]
)

CREATE FUNCTION [FUNC_NAME] ([VARIABLE NAME] [VARIABLE TYPE])
RETURNS @BIEN_KIEU_BANG TABLE
(
	[COLUMN_NAME] [COLUMN TYPE]
)
AS
BEGIN
	
	INSERT INTO @BIEN_KIEU_BANG([COLUMN_NAME] [COLUMN TYPE])
	
	RETURN
END

---- VÒNG LẶP
---- WHILE [CONDITION] --- ĐIỀU KIỆN DỪNG VÒNG LẶP
---- 1. BIẾN CON TRỎ CURSOR
---- 2. ĐÁNH STT CHO TỪNG GIÁ TRỊ TRONG DANH SÁCH LẶP

---- INDEX ---- GÁN CHO CỘT -> TĂNG TỐC ĐỘ CÂU QUERY SELECT
---- TRANSACTION ---- TẠO MÔI TRƯỜNG TEST ĐỂ TEST THAY ĐỔI DỮ LIỆU

---- TRIGGER --- ACTION A (UPDATEDELETE/INSERT) -> KÍCH HOẠT TRIGGER -> TRIGGER THỰC HIỆN ACTION B
			---- BẢNG INSERTED, DELETED
			---- KẾT HỢP VÒNG LẶP KHI TÁC ĐỘNG LÊN NHIỀU DÒNG DỮ LIỆU
			---- TEST LOGIC TRIGGER -> SỬ DỤNG TRANSACTION

---- DYNAMIC SQL(SQL ĐỘNG) ---- TÍNH CHẤT: CÂU LỆNH SQL SERVER ĐẶT TRONG DẤU ''
						----ƯU ĐIỂM: GIẢI QUYẾT CÁC BÀI TOÁN THỰC HIỆN VÒNG LOOP CHO TÊN BẢNG HOẶC TÊN CỘT
---- PIVOT TABLE/UNPIVOT: XOAY CHIỀU DỮ LIỆU (DỌC <-> NGANG)
---- ĐẶT LỊCH TỰ ĐỘNG VÀ CẤU HÌNH MAIL
