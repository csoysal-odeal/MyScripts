SELECT p.name, COUNT(*) FROM odeal.Product p
GROUP BY p.name;

SELECT Urunler.UyeIsyeriID, Urunler.MaliNo, Urunler.basketId, Urunler.Ciro, Urunler.Adet, Urunler.UrunAdi,
       SUM(Urunler.Fiyat) as BrutFiyat, SUM(Urunler.NetFiyat) as NetFiyat, Urunler.KDV, SUM(Urunler.KDVTutar) as KDVTutar
FROM (
SELECT t.organisation_id as UyeIsyeriID,
       t.serial_no as MaliNo,
       bp.basketId,
       SUM(bp.amount) as Ciro,
       COUNT(bp.id) as Adet,
       bi.product_name as UrunAdi,
       bi.gross_price*bi.product_quantity as Fiyat,
       bi.net_price*bi.product_quantity as NetFiyat,
       bi.vat_ratio as KDV,
       bi.vat_price*bi.product_quantity as KDVTutar
FROM odeal.Terminal t
JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
JOIN odeal.BasePayment bp ON bp.id = tp.id
JOIN retail.basket basket ON basket.id = bp.basketId
JOIN retail.basket_item bi ON bi.basket_id = basket.id
WHERE bp.currentStatus = 6 AND bp.serviceId = 7 AND bp.signedDate >= "2024-01-01 00:00:00" AND bp.paymentType IN (0,1,2,3,6,7,8) AND t.organisation_id = 301000494 AND t.serial_no = "PAX710056452"
GROUP BY t.organisation_id, t.serial_no, bp.basketId, bi.product_name,
         bi.gross_price*bi.product_quantity, bi.net_price*bi.product_quantity, bi.vat_ratio, bi.vat_price*bi.product_quantity) as Urunler
GROUP BY Urunler.UyeIsyeriID, Urunler.MaliNo, Urunler.basketId, Urunler.Ciro, Urunler.Adet, Urunler.UrunAdi, Urunler.KDV;

SELECT * FROM (
SELECT t.organisation_id as UyeIsyeriID,
       t.id as TerminalID,
       t.serial_no as MaliNo,
       bp.amount as Ciro,
       COUNT(basket.id) as BasketAdet,
       GROUP_CONCAT(bi.product_name,";") as UrunAdi,
       GROUP_CONCAT(bi.vat_ratio) as KDV,
       pmd.mobile_client_version as Version
FROM odeal.Terminal t
JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
JOIN odeal.BasePayment bp ON bp.id = tp.id
LEFT JOIN odeal.PaymentMetaData pmd ON pmd.payment_id = bp.id
JOIN retail.basket basket ON basket.id = bp.basketId
JOIN retail.basket_item bi ON bi.basket_id = basket.id
WHERE bp.currentStatus = 6 AND bp.serviceId = 7 AND bp.signedDate >= DATE_SUB(CURDATE(),INTERVAL 2 WEEK)
GROUP BY t.id, t.organisation_id, t.serial_no, bp.amount, pmd.mobile_client_version) as Islemler;

AND d.device NOT IN ("A910S","A920Pro","A910","A8700")

SELECT t.id FROM odeal.Terminal t
JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
JOIN odeal.BasePayment bp ON bp.id = tp.id
JOIN odeal.PaymentMetaData pmd ON pmd.payment_id = bp.id
WHERE pmd.mobile_client_version <> "1.1.14 (1114)" AND bp.signedDate >= "2024-10-01 00:00:00";

AND pmd.mobile_client_version <> "1.1.14 (1114)"

SELECT *, rb.product_quantity*rb.gross_price FROM retail.basket_item rb WHERE rb.basket_id = 22099293;

SELECT * FROM odeal.BasePayment bp WHERE bp.basketId = 20868905;

SELECT rb.id, rb.device_id, d.device, rb.status, rb.gross_price, rb.vat_ratio, rb.net_price, SUM(bi.gross_price*bi.product_quantity), SUM(bi.net_price*bi.product_quantity),GROUP_CONCAT(bi.product_name), GROUP_CONCAT(bi.vat_ratio) FROM retail.basket rb
JOIN retail.basket_item bi ON bi.basket_id = rb.id
JOIN odeal.Device d ON d.id = rb.device_id
WHERE rb.id = 22099293
GROUP BY rb.id, rb.device_id, rb.status, rb.gross_price, rb.vat_ratio, rb.net_price


SELECT * FROM odeal.Device d;

SELECT bi.product_name FROM retail.basket_item bi
GROUP BY bi.product_name

SET @sql = NULL;

-- Dinamik sütun başlıklarını oluştur
SELECT
    GROUP_CONCAT(
        DISTINCT
        CONCAT(
            'SUM(CASE WHEN bi.product_name = ''', bi.product_name, ''' THEN bp.amount ELSE 0 END) AS "', bi.product_name, '_Ciro", ',
            'COUNT(CASE WHEN bi.product_name = ''', bi.product_name, ''' THEN bp.id ELSE NULL END) AS "', bi.product_name, '_Adet"'
        )
    ) INTO @sql
FROM retail.basket_item bi
JOIN retail.basket b ON b.id = bi.basket_id
JOIN odeal.BasePayment bp ON bp.basketId = b.id
WHERE bp.currentStatus = 6 AND bp.serviceId = 7 AND bp.signedDate >= '2024-10-16 00:00:00' AND bp.paymentType IN (0,1,2,3,6,7,8) AND bi.product_name IS NOT NULL;

-- Dinamik pivot sorgusunu oluştur
SET @sql = CONCAT('SELECT t.organisation_id, t.serial_no, ',@sql, ' FROM odeal.Terminal t
JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
JOIN odeal.BasePayment bp ON bp.id = tp.id
JOIN retail.basket basket ON basket.id = bp.basketId
JOIN retail.basket_item bi ON bi.basket_id = basket.id
WHERE bp.currentStatus = 6 AND bp.serviceId = 7 AND bp.signedDate >= "2024-10-01 00:00:00"
AND bp.paymentType IN (0,1,2,3,6,7,8)
GROUP BY t.organisation_id, t.serial_no');

SELECT @sql;

-- Sorguyu çalıştır
PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;


SELECT * FROM (
SELECT *,ROW_NUMBER() over (PARTITION BY th.serialNo ORDER BY th._createdDate DESC) as Sira
       FROM odeal.TerminalHistory th WHERE th.serialNo LIKE "PAX%"
                                       ORDER BY th.serialNo) as TerminalHistory WHERE TerminalHistory.Sira = 1

SELECT * FROM (
SELECT *,ROW_NUMBER() over (PARTITION BY th.physicalSerialId ORDER BY th._createdDate DESC) as Sira
       FROM odeal.TerminalHistory th WHERE th.serialNo LIKE "PAX%"
                                       ORDER BY th.physicalSerialId) as TerminalHistory WHERE TerminalHistory.Sira = 1

SELECT t.organisation_id as UyeIsyeriID,
       IF(o.isActivated=1,"Aktif","Pasif") as UyeDurum,
       t.serial_no as MaliNo,
       IF(t.terminalStatus=0,"Pasif","Aktif") as TerminalDurum,
       t.firstActivationDate as IlkAktivasyonTarihi,
       bp.appliedRate as Komisyon,
       bp.signedDate as IslemTarihi,
       bp.amount as IslemTutar,
       CAST(SUM(bp.amount) OVER (PARTITION BY t.serial_no, DATE_FORMAT(bp.signedDate, "%Y-%m") ORDER BY bp.signedDate, bp.id) AS DECIMAL(10,2)) AS KumulatifTutar,
       bp.id
FROM odeal.Terminal t
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
JOIN odeal.BasePayment bp ON bp.id = tp.id
                                      AND bp.currentStatus = 6
                                      AND bp.appliedRate > 1.99 -- 1.99 ÜZERİ BÜTÜN KOMİSYONLAR 1.99 OLARAK MÜŞTERİYE YANSITILACAKTIR.
                                      AND tp.installment IN (0,1)
                                      AND bp.paymentType IN (0,1,2,3,6,7,8)
                                      AND bp.signedDate > t.firstActivationDate
WHERE o.activatedAt >= "2024-10-01 00:00:00" AND o.id IN (SELECT Terminaller.id FROM (
SELECT o.id, t.serial_no, t.firstActivationDate, ROW_NUMBER() over (PARTITION BY o.id ORDER BY t.firstActivationDate ASC) as Sira FROM odeal.Organisation o
JOIN odeal.Terminal t ON t.organisation_id = o.id WHERE t.firstActivationDate IS NOT NULL) as Terminaller
WHERE Terminaller.Sira = 1 AND Terminaller.firstActivationDate >= "2024-10-01 00:00:00")