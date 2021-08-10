--------- I. CHỈ MỤC INDEX
--------- 1. CLUSTERED INDEX
create clustered index idx_cthd 
on CTHD(SOHD,MASP)

create clustered index idx_cthd2 
on CTHD(SL) --không tạo được index thứ 2

---- TẠO CLUSTERED INDEX CHO NHIỀU CỘT CÙNG LÚC


--------- 1. NON-CLUSTERED INDEX
create nonclustered index idx_sanpham 
on SANPHAM(MASP)

---- VÍ DỤ: 
---- 1. TẠO CLUSTERED INDEX CHO CỘT [STORE ID]
---- 2. TẠO NONCLUSTERED INDEX CHO CỘT [MÃ KHÁCH HÀNG]
---- 3. TẠO NONCLUSTERED INDEX CHO CỘT [SALE_MAN_ID]
---- NOTE: TRƯỚC VÀ KHI TẠO INDEX, PHẢI NOTE THỜI GIAN CHẠY CÂU TRUY VẤN SAU:
SELECT * FROM MCI_SQL..BANHANG
drop index idx_BanHangSID on MCI_SQL..BanHang
create clustered index idx_BanHangSID on MCI_SQL.dbo.BANHANG(STORE_ID)
drop index idx_BanHangMKH on MCI_SQL..BanHang
create nonclustered index idx_BanHangMKH on MCI_SQL..BANHANG(MA_KH)
drop index idx_BanHangSmID on MCI_SQL..BanHang
create nonclustered index idx_BanHangSmID on MCI_SQL..BANHANG(Saleman_ID)

---- MILLISECOND
declare @T0 datetime, @t1 datetime
set @t0 = getdate()

SELECT * FROM MCI_SQL..BANHANG
WHERE [Store_ID] = 'STORE 1'
AND [Saleman_ID] = '340-07-5323'
AND [Ma_KH] <> 'MKH804898'
set @t1 = getdate()
select datediff(MILLISECOND,@t0,@t1)

--- 888 MILLISECOND --- 480 MILLISECOND --- KHÔNG THAY ĐỔI NHIỀU --- 113 MILLISECOND
-------------------------------------


----- B. TRANSACTION
BEGIN TRANSACTION
----- 1. COMMIT

----- 2. ROLLBACK

----- 3. SAVE TRANSACTION