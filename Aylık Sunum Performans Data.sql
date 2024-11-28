SELECT SUM(bp.amount) as Ciro FROM odeal.Terminal t 
JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id 
JOIN odeal.BasePayment bp ON bp.id = tp.id
WHERE DATE_FORMAT((bp.signedDate),"%Y-%m-%d") >= "2023-07-01" AND DATE_FORMAT((bp.signedDate),"%Y-%m-%d") <= "2023-07-31"
AND bp.currentStatus = 6

SELECT DATE_FORMAT((bp.signedDate),"%Y-%m") as CiroTarih, SUM(bp.amount) as Ciro FROM odeal.BasePayment bp 
WHERE bp.currentStatus = 6 
AND DATE_FORMAT((bp.signedDate),"%Y-%m-%d") >= "2021-01-01" AND DATE_FORMAT((bp.signedDate),"%Y-%m-%d") <=  DATE_FORMAT(CURDATE(),"%Y-%m-%d") 
GROUP BY DATE_FORMAT((bp.signedDate),"%Y-%m")

SELECT COUNT(*) FROM odeal.Organisation o 
JOIN subscription.Subscription s ON o.id = s.organisationId
JOIN subscription.Plan p ON p.id = s.planId
WHERE s.status = 1 AND p.serviceId = 3

SELECT SUM(i.totalAmount) as Tahsilat FROM subscription.Invoice i
WHERE i.invoiceStatus = 1 AND DATE_FORMAT((i.createdAt),"%Y-%m-%d") >= "2023-07-01" AND DATE_FORMAT((i.createdAt),"%Y-%m-%d") <= "2023-07-31"

SELECT * FROM odeal.BinInfo bi 


-- Belirli Tarihe Kadar Kurulan Terminal Adet
SELECT COUNT(*) FROM odeal.Terminal t 
WHERE DATE_FORMAT(t.firstActivationDate,"%Y-%m-%d") <= "2023-07-31"

SELECT DATE_FORMAT(t.firstActivationDate,"%Y-%m") as FizikiTarih, COUNT(*)
FROM odeal.Terminal t 
WHERE DATE_FORMAT(t.firstActivationDate,"%Y-%m-%d") <= DATE_FORMAT(CURDATE() , "%Y-%m-%d")  AND t.terminalStatus = 1
GROUP BY DATE_FORMAT(t.firstActivationDate,"%Y-%m")

SET @kumulatifToplam:=0

-- Toplam Aktif Terminal Baz
SELECT
   AylikTerminalAdet.Ay,
   AylikTerminalAdet.Adet,
   (@kumulatifToplam := @kumulatifToplam + AylikTerminalAdet.Adet) AS KumulatifToplam
FROM
   (SELECT
       DATE_FORMAT(t.firstActivationDate,'%Y-%m') AS Ay,
       COUNT(*) AS Adet
    FROM  odeal.Terminal t
    JOIN odeal.Organisation o ON o.id = t.organisation_id
    WHERE o.demo = 0 AND t.firstActivationDate is not null
    GROUP  BY Ay
    ) AS AylikTerminalAdet
    JOIN (SELECT @kumulatifToplam:=0) r
    ORDER  BY Ay
    
-- Toplam CeptePos Adet
SELECT
   AylikTerminalAdet.Ay,
   AylikTerminalAdet.Adet,
   (@kumulatifToplam := @kumulatifToplam + AylikTerminalAdet.Adet) AS KumulatifToplam
FROM
   (SELECT DATE_FORMAT((s.activationDate),"%Y-%m") as Ay, COUNT(*) as Adet FROM odeal.Organisation o 
JOIN subscription.Subscription s ON s.organisationId = o.id 
JOIN subscription.Plan p ON p.id = s.planId 
WHERE p.serviceId = 3 AND o.demo=0 AND DATE_FORMAT((s.activationDate),"%Y-%m-%d") <= DATE_FORMAT(CURDATE(),"%Y-%m-%d") AND o.isActivated = 1 AND o.id NOT IN (SELECT DISTINCT o.id FROM odeal.Organisation o 
JOIN subscription.Subscription s ON s.organisationId = o.id 
JOIN subscription.Plan p ON p.id = s.planId 
WHERE p.serviceId = 3 AND DATE_FORMAT((s.activationDate),"%Y-%m-%d") <= DATE_FORMAT(CURDATE(),"%Y-%m-%d") AND o.isActivated = 1
GROUP BY o.id HAVING COUNT(*)>1)
GROUP BY DATE_FORMAT((s.activationDate),"%Y-%m")
    ) AS AylikTerminalAdet
    JOIN (SELECT @kumulatifToplam:=0) r
    ORDER  BY Ay
    
    
    -- CEPTEPOS Adet
SELECT COUNT(*) as Adet FROM odeal.Organisation o 
JOIN subscription.Subscription s ON s.organisationId = o.id 
JOIN subscription.Plan p ON p.id = s.planId 
WHERE p.serviceId = 3 AND o.demo=0 AND DATE_FORMAT((s.activationDate),"%Y-%m-%d") <= DATE_FORMAT(CURDATE(),"%Y-%m-%d") AND o.isActivated = 1 AND o.id NOT IN (SELECT DISTINCT o.id FROM odeal.Organisation o 
JOIN subscription.Subscription s ON s.organisationId = o.id 
JOIN subscription.Plan p ON p.id = s.planId 
WHERE p.serviceId = 3 AND DATE_FORMAT((s.activationDate),"%Y-%m-%d") <= DATE_FORMAT(CURDATE(),"%Y-%m-%d") AND o.isActivated = 1
GROUP BY o.id HAVING COUNT(*)>1) AND s.activationDate <= "2023-07-31" AND s.status = 1
UNION
SELECT COUNT(*) as Adet FROM odeal.Organisation o 
JOIN subscription.Subscription s ON s.organisationId = o.id 
JOIN subscription.Plan p ON p.id = s.planId 
WHERE p.serviceId = 3 AND o.demo=0 AND DATE_FORMAT((s.activationDate),"%Y-%m-%d") <= DATE_FORMAT(CURDATE(),"%Y-%m-%d") AND o.isActivated = 1 AND o.id NOT IN (SELECT DISTINCT o.id FROM odeal.Organisation o 
JOIN subscription.Subscription s ON s.organisationId = o.id 
JOIN subscription.Plan p ON p.id = s.planId 
WHERE p.serviceId = 3 AND DATE_FORMAT((s.activationDate),"%Y-%m-%d") <= DATE_FORMAT(CURDATE(),"%Y-%m-%d")
GROUP BY o.id HAVING COUNT(*)>1) AND s.activationDate <= "2023-07-31" AND s.cancelledAt > "2023-07-31"

SELECT
   AylikTerminalAdet.Ay,
   AylikTerminalAdet.Adet,
   (@kumulatifToplam := @kumulatifToplam + AylikTerminalAdet.Adet) AS KumulatifToplam
FROM
   (SELECT DATE_FORMAT((s.activationDate),"%Y-%m") as Ay, COUNT(*) as Adet FROM odeal.Organisation o 
JOIN subscription.Subscription s ON s.organisationId = o.id 
JOIN subscription.Plan p ON p.id = s.planId 
WHERE p.serviceId = 3 AND o.demo=0 AND DATE_FORMAT((s.activationDate),"%Y-%m-%d") <= DATE_FORMAT(CURDATE(),"%Y-%m-%d") AND o.isActivated = 1 AND s.status = 1 AND o.id NOT IN (SELECT DISTINCT o.id FROM odeal.Organisation o 
JOIN subscription.Subscription s ON s.organisationId = o.id 
JOIN subscription.Plan p ON p.id = s.planId 
WHERE p.serviceId = 3 AND DATE_FORMAT((s.activationDate),"%Y-%m-%d") <= DATE_FORMAT(CURDATE(),"%Y-%m-%d") AND o.isActivated = 1
GROUP BY o.id HAVING COUNT(*)>1)
GROUP BY DATE_FORMAT((s.activationDate),"%Y-%m")
    ) AS AylikTerminalAdet
    JOIN (SELECT @kumulatifToplam:=0) r
    ORDER  BY Ay
    


-- Birden Fazla CeptePos Aboneliği Olan Organizasyonlar    
SELECT DISTINCT o.id as OrgID,
CASE WHEN s.status = 1 THEN COUNT(*) END as BirdenFazlaAktiflik,
GROUP_CONCAT(s.status) as AbonelikDurumlari, GROUP_CONCAT("AbonelikID : ",s.id," ","Abonelik Tarihi : ",s.activationDate) as Abonelikler FROM odeal.Organisation o 
JOIN subscription.Subscription s ON s.organisationId = o.id
JOIN subscription.Plan p ON p.id = s.planId 
WHERE p.serviceId = 3 AND o.demo = 0 AND o.isActivated = 1
GROUP BY o.id, s.status HAVING CASE WHEN s.status = 1 THEN COUNT(*) END > 1
ORDER BY o.id
    
SELECT * FROM odeal.TerminalHistory th
WHERE th.serialNo LIKE "J%"

SELECT o.id, s.id FROM odeal.Organisation o 
JOIN subscription.Subscription s ON s.organisationId = o.id 
JOIN subscription.Plan p ON p.id = s.planId
WHERE p.serviceId = 3 AND o.demo = 0 AND s.status = 1 AND o.isActivated = 1

SELECT * FROM odeal.TerminalHistory th
WHERE th.serialNo = "PAX710000008"

SELECT * FROM subscription.Stock s 
WHERE s.serialNo = "JI20037449"


SELECT * FROM odeal.Terminal t 

select s.id, p.name from subscription.Subscription s 
JOIN subscription.Plan p ON p.id = s.planId 
WHERE s.id = 478446

SELECT * FROM odeal.TerminalHistory th WHERE th.id IN (SELECT MAX(th.id) as THID FROM odeal.TerminalHistory th 
GROUP BY th.organisationId, th.serialNo)

SELECT o.id, o.unvan, o.marka, o.demo, IF(o.demo=0,"NORMAL","DEMO") as DemoFlag FROM odeal.Organisation o 
WHERE o.id IN (301037008,301000024)

SELECT * FROM odeal.BasePayment bp 
JOIN odeal.TerminalPayment tp ON tp.id = bp.id 
JOIN odeal.Terminal t ON t.id = tp.terminal_id 
WHERE t.serial_no = "FT30041741"

    
SELECT o.id, SUM(bp.amount) as Ciro FROM odeal.Organisation o 
JOIN odeal.BasePayment bp ON bp.organisationId = o.id 
WHERE bp.currentStatus = 6 AND bp.signedDate >= "2023-11-01 00:00:00" AND bp.signedDate <= "2023-11-30 23:59:59"
GROUP BY o.id


    -- Fiziki 
    -- Aktiflik Oranı 1 TL > Ciro Geçen Aktif Terminal / Ay Sonu Aktif Terminal
    -- Ciro / 1 TL >  Geçen Aktif Terminal = Cihaz Bin TL
    -- Churn >= İptal Adet / (Ay Başı Aktif Terminal + Ay Sonu Aktif Terminal)/2 = Churn Oranı
    
-- Aylık Ciro
SELECT
   AylikCiro.Ay,
   AylikCiro.Ciro,
   (@KumulatifCiro := @KumulatifCiro + AylikCiro.Ciro) AS KumulatifToplam
FROM
   (SELECT
       DATE_FORMAT(bp.signedDate,'%Y-%m') AS Ay,
       SUM(bp.amount) AS Ciro
    FROM  odeal.BasePayment bp 
    JOIN odeal.Organisation o ON o.id = bp.organisationId AND o.demo = 0
    WHERE bp.currentStatus = 6 AND DATE_FORMAT(bp.signedDate,"%Y-%m-%d") >= "2024-01-01" AND DATE_FORMAT(bp.signedDate,"%Y-%m-%d") <= DATE_FORMAT(CURDATE() , "%Y-%m-%d")
    GROUP  BY Ay
    ) AS AylikCiro
    JOIN (SELECT @KumulatifCiro:=0) r
    ORDER  BY Ay
    
    SELECT DATE_FORMAT(bp.signedDate,"%Y-%m") as YilAy, SUM(bp.amount) as Ciro, COUNT(bp.id) as IslemAdet FROM odeal.BasePayment bp 
    JOIN odeal.Organisation o ON o.id = bp.organisationId AND o.demo = 0
    WHERE bp.currentStatus = 6 AND bp.paymentType IN (0,1,2,3,7,8) AND bp.signedDate >= "2024-01-01 00:00:00" AND bp.signedDate <= "2024-01-31 23:59:59"
    GROUP BY DATE_FORMAT(bp.signedDate,"%Y-%m");
    
    Summary
    
    Tarih   Tip                  Değer
    2024-01 Ciro                 1.700
    2024-01 IslemAdet              474
    2024-01 Fiziki Terminal Adet 47500
    
    IslemCiro
    
    2024-01	1700719810.86	4713372
    2024-02 2435353    4353453
    
    
    -- EKİM 2023 Ciro - 1873289764.49 + 479871133
    SELECT SUM(bp.amount) FROM odeal.BasePayment bp 
    WHERE bp.currentStatus = 6 AND bp.signedDate >= "2023-10-01 00:00:00" AND bp.signedDate <= "2023-10-31 23:59:59"
    
SELECT
   AylikCiro.Ay,
   AylikCiro.Ciro,
   (@KumulatifCiro := @KumulatifCiro + AylikCiro.Ciro) AS KumulatifToplam
FROM
   (SELECT
       DATE_FORMAT(bp.signedDate,'%Y-%m') AS Ay,
       SUM(bp.amount) AS Ciro
    FROM  odeal.BasePayment bp 
    WHERE  bp.currentStatus = 6
    GROUP  BY Ay
    ) AS AylikCiro
    JOIN (SELECT @KumulatifCiro:=0) r
    ORDER  BY Ay

SELECT DISTINCT COUNT(t.serial_no) as Adet FROM odeal.BasePayment bp 
JOIN odeal.TerminalPayment tp ON tp.id = bp.id 
JOIN odeal.Terminal t ON t.id = tp.terminal_id
WHERE bp.currentStatus = 6 AND bp.amount > 1 
AND DATE_FORMAT(t.firstActivationDate,'%Y-%m-%d') >= "2023-08-01" 
AND DATE_FORMAT(t.firstActivationDate,'%Y-%m-%d') <= DATE_FORMAT(CURDATE(),"%Y-%m-%d") 


SELECT "2023-06" as Ay, COUNT(*) as Adet FROM 
(SELECT t.firstActivationDate, t.serial_no FROM odeal.Terminal t 
JOIN subscription.Subscription s ON s.id = t.subscription_id
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id
WHERE t.firstActivationDate >= "2023-06-01 00:00:00" AND t.firstActivationDate <= "2023-06-30 23:59:59" AND s.cancelledAt > "2023-06-30"
UNION
SELECT t.firstActivationDate, t.serial_no FROM odeal.Terminal t 
JOIN subscription.Subscription s ON s.id = t.subscription_id AND s.status = 1
WHERE t.firstActivationDate >= "2023-06-01 00:00:00" AND t.firstActivationDate <= "2023-06-30 23:59:59" AND t.terminalStatus = 1) as Haziran
UNION
SELECT "2023-07" as Ay, COUNT(*) as Adet FROM (SELECT t.firstActivationDate, t.serial_no FROM odeal.Terminal t 
JOIN subscription.Subscription s ON s.id = t.subscription_id
WHERE t.firstActivationDate >= "2023-07-01 00:00:00" AND t.firstActivationDate <= "2023-07-31 23:59:59" AND s.cancelledAt > "2023-07-31"
UNION

-- Ağustos
SELECT COUNT(*) FROM odeal.Terminal t -- Aktivasyon (İptal Dahil) Adetleri
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
WHERE t.firstActivationDate >= "2023-08-01 00:00:00" AND t.firstActivationDate <= "2023-08-31 23:59:59") as Ağustos


-- Fiziksel Pos Ağustos -- İlgili ay Sonuna kadar aktif olmuş ve Ağustos ayında ve daha sonraki aylarda iptal olmuşlar
SELECT COUNT(*) FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
WHERE t.firstActivationDate <= "2023-08-31 23:59:59" AND (s.cancelledAt IS NULL OR s.cancelledAt > "2023-07-31 23:59:59")

-- Fiziksel Pos Ağustos -- İlgili ay Sonuna kadar aktif olmuş ve daha sonraki aylarda iptal olmuşlar END of PERIOD
SELECT p.serviceId, COUNT(*) FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN subscription.Plan p ON p.id = s.planId
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
WHERE t.firstActivationDate <= "2023-08-31 23:59:59" AND (s.cancelledAt IS NULL OR s.cancelledAt > "2023-08-31 23:59:59")
GROUP BY p.serviceId 

-- AĞUSTOS 2023 - Fiziki Terminal Adet  40612 - Aynı Ay içinde İptaller Dahil
-- AĞUSTOS 2023 - Fiziki Terminal Adet  38575 - End Of Period - Aynı Ay içinde İptaller Dahil Değil
-- AĞUSTOS 2023 - TaksidePos Adet - 20553

SELECT 24667 + 8912 + 4996

-- Fiziksel Pos Eylül -- İlgili ay Sonuna kadar aktif olmuş ve Eylül ayında ve daha sonraki aylarda iptal olmuşlar
SELECT "2023-09"  as Ay, COUNT(*) as Adet FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
WHERE t.firstActivationDate <= "2023-09-30 23:59:59" AND (s.cancelledAt IS NULL OR s.cancelledAt > "2023-08-31 23:59:59")

-- Fiziksel Pos Eylül -- İlgili ay Sonuna kadar aktif olmuş ve daha sonraki aylarda iptal olmuşlar END of PERIOD
SELECT "2023-09"  as Ay, p.serviceId, COUNT(*) FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN subscription.Plan p ON p.id = s.planId
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
WHERE t.firstActivationDate <= "2023-09-30 23:59:59" AND (s.cancelledAt IS NULL OR s.cancelledAt > "2023-09-30 23:59:59")
GROUP BY p.serviceId 

-- EYLÜL 2023 - Fiziki Terminal Adet 42540 - Aynı Ay içinde İptaller Dahil
-- EYLÜL 2023 - Fiziki Terminal Adet 40618 - End Of Period - Aynı Ay içinde İptaller Dahil Değil
-- EYLÜL 2023 - TaksidePos Adet - 21170

SELECT 42540+21170+52367

SELECT 25130+9659+5829

-- Fiziksel Pos Ekim -- İlgili ay Sonuna kadar aktif olmuş ve Ekim ayında ve daha sonraki aylarda iptal olmuşlar
SELECT "2023-10"  as Ay, COUNT(*) as Adet FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
WHERE t.firstActivationDate <= "2023-10-31 23:59:59" AND (s.cancelledAt IS NULL OR s.cancelledAt > "2023-09-30 23:59:59")

-- Fiziksel Pos Ekim -- İlgili ay Sonuna kadar aktif olmuş ve daha sonraki aylarda iptal olmuşlar END of PERIOD
SELECT "2023-10"  as Ay, p.serviceId, COUNT(*) FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN subscription.Plan p ON p.id = s.planId
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
WHERE t.firstActivationDate <= "2023-10-31 23:59:59" AND (s.cancelledAt IS NULL OR s.cancelledAt > "2023-10-31 23:59:59")
GROUP BY p.serviceId 

-- EKİM 2023 - Fiziki Terminal Adet 44505 - Aynı Ay içinde İptaller Dahil
-- EKİM 2023 - Fiziki Terminal Adet 42062 - End Of Period - Aynı Ay içinde İptaller Dahil Değil
-- EKİM 2023 - TaksidePos Adet - 22514

SELECT 44505 + 52350 + 22514

SELECT 25174 + 10288 + 6629

SELECT "2023-09"  as Ay, COUNT(*) as Adet FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id 
JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.amount > 0 AND bp.signedDate > "2023-08-31 23:59:59" AND bp.signedDate <= "2023-09-30 23:59:59"
WHERE t.firstActivationDate <= "2023-09-30 23:59:59" AND (s.cancelledAt IS NULL OR s.cancelledAt > "2023-08-31 23:59:59")


SELECT "2023-09"  as Ay, COUNT(t.serial_no) as Adet FROM odeal.Terminal t 
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
WHERE t.firstActivationDate <= "2023-09-30 23:59:59" AND (s.cancelledAt IS NULL OR s.cancelledAt > "2023-08-31 23:59:59") 

-- AĞUSTOS - İşlem Geçen Terminal - 28522
SELECT "2023-08"  as Ay, COUNT(IslemGecen.serial_no) as Adet FROM (SELECT t.serial_no, SUM(bp.amount) FROM odeal.BasePayment bp 
JOIN odeal.TerminalPayment tp ON tp.id = bp.id 
JOIN odeal.Terminal t ON t.id = tp.terminal_id 
WHERE bp.currentStatus = 6 AND bp.signedDate >= "2023-08-01 00:00:00" AND bp.signedDate <= "2023-08-31 23:59:59"
GROUP BY t.serial_no) as IslemGecen

-- EYLÜL - İşlem Geçen Terminal - 29205
SELECT "2023-09"  as Ay, COUNT(IslemGecen.serial_no) as Adet FROM (SELECT t.serial_no, SUM(bp.amount) FROM odeal.BasePayment bp 
JOIN odeal.TerminalPayment tp ON tp.id = bp.id 
JOIN odeal.Terminal t ON t.id = tp.terminal_id 
WHERE bp.currentStatus = 6 AND bp.signedDate >= "2023-09-01 00:00:00" AND bp.signedDate <= "2023-09-30 23:59:59"
GROUP BY t.serial_no) as IslemGecen

-- EKİM - İşlem Geçen Terminal - 29836


-- İşlem Geçen Terminaller
SELECT "2023-01"  as Ay, COUNT(IslemGecen.serial_no) as Adet FROM (SELECT t.serial_no, SUM(bp.amount) FROM odeal.BasePayment bp 
JOIN odeal.TerminalPayment tp ON tp.id = bp.id 
JOIN odeal.Terminal t ON t.id = tp.terminal_id 
WHERE bp.currentStatus = 6 AND bp.signedDate >= "2023-01-01 00:00:00" AND bp.signedDate <= "2023-01-31 23:59:59"
GROUP BY t.serial_no) as IslemGecen
UNION
SELECT "2023-02"  as Ay, COUNT(IslemGecen.serial_no) as Adet FROM (SELECT t.serial_no, SUM(bp.amount) FROM odeal.BasePayment bp 
JOIN odeal.TerminalPayment tp ON tp.id = bp.id 
JOIN odeal.Terminal t ON t.id = tp.terminal_id 
WHERE bp.currentStatus = 6 AND bp.signedDate >= "2023-02-01 00:00:00" AND bp.signedDate <= "2023-02-28 23:59:59"
GROUP BY t.serial_no) as IslemGecen
UNION
SELECT "2023-03"  as Ay, COUNT(IslemGecen.serial_no) as Adet FROM (SELECT t.serial_no, SUM(bp.amount) FROM odeal.BasePayment bp 
JOIN odeal.TerminalPayment tp ON tp.id = bp.id 
JOIN odeal.Terminal t ON t.id = tp.terminal_id 
WHERE bp.currentStatus = 6 AND bp.signedDate >= "2023-03-01 00:00:00" AND bp.signedDate <= "2023-03-31 23:59:59"
GROUP BY t.serial_no) as IslemGecen
UNION
SELECT "2023-04"  as Ay, COUNT(IslemGecen.serial_no) as Adet FROM (SELECT t.serial_no, SUM(bp.amount) FROM odeal.BasePayment bp 
JOIN odeal.TerminalPayment tp ON tp.id = bp.id 
JOIN odeal.Terminal t ON t.id = tp.terminal_id 
WHERE bp.currentStatus = 6 AND bp.signedDate >= "2023-04-01 00:00:00" AND bp.signedDate <= "2023-04-30 23:59:59"
GROUP BY t.serial_no) as IslemGecen
UNION
SELECT "2023-05"  as Ay, COUNT(IslemGecen.serial_no) as Adet FROM (SELECT t.serial_no, SUM(bp.amount) FROM odeal.BasePayment bp 
JOIN odeal.TerminalPayment tp ON tp.id = bp.id 
JOIN odeal.Terminal t ON t.id = tp.terminal_id 
WHERE bp.currentStatus = 6 AND bp.signedDate >= "2023-05-01 00:00:00" AND bp.signedDate <= "2023-05-31 23:59:59"
GROUP BY t.serial_no) as IslemGecen
UNION
SELECT "2023-06"  as Ay, COUNT(IslemGecen.serial_no) as Adet FROM (SELECT t.serial_no, SUM(bp.amount) FROM odeal.BasePayment bp 
JOIN odeal.TerminalPayment tp ON tp.id = bp.id 
JOIN odeal.Terminal t ON t.id = tp.terminal_id 
WHERE bp.currentStatus = 6 AND bp.signedDate >= "2023-06-01 00:00:00" AND bp.signedDate <= "2023-06-30 23:59:59"
GROUP BY t.serial_no) as IslemGecen
UNION
SELECT "2023-07"  as Ay, COUNT(IslemGecen.serial_no) as Adet FROM (SELECT t.serial_no, SUM(bp.amount) as Ciro FROM odeal.BasePayment bp 
JOIN odeal.TerminalPayment tp ON tp.id = bp.id 
JOIN odeal.Terminal t ON t.id = tp.terminal_id 
WHERE bp.currentStatus = 6 AND bp.signedDate >= "2023-07-01 00:00:00" AND bp.signedDate <= "2023-07-31 23:59:59"
GROUP BY t.serial_no) as IslemGecen
UNION
SELECT "2023-08"  as Ay, COUNT(IslemGecen.serial_no) as Adet, SUM(IslemGecen.Ciro) as Ciro FROM (SELECT t.serial_no, SUM(bp.amount) as Ciro FROM odeal.BasePayment bp 
JOIN odeal.TerminalPayment tp ON tp.id = bp.id 
JOIN odeal.Terminal t ON t.id = tp.terminal_id 
WHERE bp.currentStatus = 6 AND bp.amount > 1 AND bp.signedDate >= "2023-08-01 00:00:00" AND bp.signedDate <= "2023-08-31 23:59:59"
GROUP BY t.serial_no) as IslemGecen
UNION
SELECT "2023-09"  as Ay, COUNT(IslemGecen.serial_no) as Adet, SUM(IslemGecen.Ciro) as Ciro FROM (SELECT t.serial_no, SUM(bp.amount) as Ciro FROM odeal.BasePayment bp 
JOIN odeal.TerminalPayment tp ON tp.id = bp.id 
JOIN odeal.Terminal t ON t.id = tp.terminal_id 
WHERE bp.currentStatus = 6 AND bp.amount > 1 AND bp.signedDate >= "2023-09-01 00:00:00" AND bp.signedDate <= "2023-09-30 23:59:59"
GROUP BY t.serial_no) as IslemGecen
UNION
SELECT "2023-10"  as Ay, COUNT(IslemGecen.serial_no) as Adet, SUM(IslemGecen.Ciro) as Ciro FROM (SELECT t.serial_no, SUM(bp.amount) as Ciro FROM odeal.BasePayment bp 
JOIN odeal.TerminalPayment tp ON tp.id = bp.id 
JOIN odeal.Terminal t ON t.id = tp.terminal_id 
WHERE bp.currentStatus = 6 AND bp.amount > 1 AND bp.signedDate >= "2023-10-01 00:00:00" AND bp.signedDate <= "2023-10-31 23:59:59"
GROUP BY t.serial_no) as IslemGecen


SELECT DATE_FORMAT(bp.signedDate, "%Y-%m") as Ay, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t 
JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id 
JOIN odeal.BasePayment bp ON bp.id = tp.id 
WHERE bp.currentStatus = 6 AND bp.signedDate >= "2023-01-01 00:00:00" AND DATE_FORMAT(bp.signedDate, "%Y-%m-%d") <=  DATE_FORMAT(CURDATE(), "%Y-%m-%d")
GROUP BY DATE_FORMAT(bp.signedDate, "%Y-%m")

SELECT t.serial_no, tp.* FROM odeal.Terminal t 
JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id

SELECT bp.organisationId, t.serial_no, bp.signedDate, bp.id, bp.isExternallyGenerated, bp.paybackId, bp.amount as Ciro FROM odeal.BasePayment bp 
LEFT JOIN odeal.TerminalPayment tp ON tp.id = bp.id 
LEFT JOIN odeal.Payment p ON p.id = bp.id
LEFT JOIN odeal.Terminal t ON t.id = tp.terminal_id
WHERE bp.currentStatus = 6 AND bp.signedDate >= "2023-10-01 00:00:00" AND bp.signedDate <= "2023-10-31 23:59:59" AND bp.organisationId IS NULL


-- Islem Gecen Uye Isyeri
SELECT COUNT(*) FROM (SELECT bp.organisationId, SUM(bp.amount) as Ciro FROM odeal.BasePayment bp 
WHERE bp.currentStatus = 6 AND bp.signedDate <= "2023-10-31 23:59:59" AND bp.organisationId IS NOT NULL 
GROUP BY bp.organisationId) as IslemGecenOrg 

SELECT COUNT(*) FROM (SELECT o.id, COUNT(o.id) FROM odeal.Organisation o 
JOIN odeal.Terminal t ON t.organisation_id = o.id
WHERE o.demo = 0 AND o.isActivated = 1 AND o.activatedAt <= "2023-10-31 23:59:59"
GROUP BY o.id) as AktifUyeIsyeri

SELECT bp.id, bp.signedDate, tp.id, p.id, t.serial_no, bp.organisationId, bp.amount FROM odeal.BasePayment bp 
LEFT JOIN odeal.TerminalPayment tp ON tp.id = bp.id 
LEFT JOIN odeal.Payment p ON p.id = bp.id
LEFT JOIN odeal.Terminal t ON t.id = tp.terminal_id 
WHERE bp.currentStatus = 6 AND bp.signedDate <= "2023-10-31 23:59:59" AND bp.organisationId IS NULL 

SELECT DATE_FORMAT(bp.signedDate,"%Y-%m") as Ay, t.serial_no, t.supplier, SUM(bp.amount) FROM odeal.BasePayment bp 
JOIN odeal.TerminalPayment tp ON tp.id = bp.id 
JOIN odeal.Terminal t ON t.id = tp.terminal_id 
WHERE bp.currentStatus = 6 AND bp.signedDate >= "2023-08-01 00:00:00" AND t.supplier = "HUGIN"
GROUP BY DATE_FORMAT(bp.signedDate, "%Y-%m"), t.serial_no, t.supplier 

SELECT bp.id as IslemID, bp.organisationId as UyeIsyeriID, bp.amount as Tutar, bp.signedDate as IslemTarihi, IF(bp.currentStatus=6,"Başarılı","Diğer") as IslemDurum,
IF(bp.isExternallyGenerated=0,"Cihazdan","Bankadan") as Kaynak, bp.cardNumber as KartNo, bp.posId as PosID, p.name as PosAd, s.name as Hizmet, IF(bp.paymentType=6,"Tekrarlı Ödeme","Diğer") as IslemTipi 
FROM odeal.BasePayment bp 
LEFT JOIN odeal.POS p ON p.id = bp.posId
LEFT JOIN subscription.Service s ON s.id = bp.serviceId
WHERE bp.currentStatus = 6 AND bp.signedDate >= "2023-10-01" AND bp.organisationId IS NULL

SELECT * FROM odeal.BasePayment bp 



SELECT 29204 / 40597

SELECT 59698 + 40597

SELECT 61194 + 42530 + 617

-- Fiziksel Pos Eylül -- İlgili ay Sonuna kadar aktif olmuş ve Eylül ayında ve daha sonraki aylarda iptal olmuşlar
SELECT p.serviceId, COUNT(*) FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN subscription.Plan p ON p.id = s.planId
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
WHERE t.firstActivationDate <= "2023-06-30 23:59:59" AND (s.cancelledAt IS NULL OR s.cancelledAt > "2023-07-24 13:40:59")
GROUP BY p.serviceId 

38537

SELECT 24666 + 8911 + 4985

-- CeptePos
SELECT COUNT(o.id) as CeptePosAdet FROM odeal.Organisation o 
JOIN subscription.Subscription s ON s.organisationId = o.id AND o.demo = 0
JOIN subscription.Plan p ON p.id = s.planId 
WHERE p.serviceId = 3 AND s.activationDate <= "2023-09-30 23:59:59" AND  (s.cancelledAt IS NULL OR s.cancelledAt > "2023-09-30 23:59:59")

-- CeptePos
SELECT COUNT(o.id) as CeptePosAdet FROM odeal.Organisation o 
JOIN subscription.Subscription s ON s.organisationId = o.id AND o.demo = 0
JOIN subscription.Plan p ON p.id = s.planId 
WHERE p.serviceId = 3 AND s.activationDate <= "2023-09-30 23:59:59" AND  (s.cancelledAt IS NULL OR s.cancelledAt > "2023-09-30 23:59:59")

SELECT t.serial_no FROM odeal.Terminal t
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
WHERE bp.currentStatus = 6 AND bp.signedDate <= "2023-08-31 23:59:59" AND t.firstActivationDate <= "2023-09-30 23:59:59" AND (s.cancelledAt IS NULL OR s.cancelledAt > "2023-08-31 23:59:59")
GROUP BY t.serial_no HAVING SUM(bp.amount) > 1

-- 27923 TerminalAdet

-- Ciro / Cİro Geçen Cihaz

-- Ceptepos Taksidepos

-- AĞUSTOS 2023 - CEPTEPOS Adet 52281
-- AĞUSTOS 2023 - CEPTEPOS Adet 52382 - End Of Period
SELECT COUNT(*) FROM (SELECT o.id, COUNT(o.id) as CeptePosAdet FROM odeal.Organisation o 
JOIN subscription.Subscription s ON s.organisationId = o.id AND o.demo = 0
JOIN subscription.Plan p ON p.id = s.planId 
WHERE p.serviceId = 3 AND s.activationDate <= "2023-08-31 23:59:59" AND  (s.cancelledAt IS NULL OR s.cancelledAt > "2023-08-31 23:59:59")
GROUP BY o.id) as CeptePosAbonelik

-- EYLÜL 2023 - CEPTEPOS Adet 52367
-- EYLÜL 2023 - CEPTEPOS Adet 52449 - End Of Period
SELECT COUNT(*) FROM (SELECT o.id, COUNT(o.id) as CeptePosAdet FROM odeal.Organisation o 
JOIN subscription.Subscription s ON s.organisationId = o.id AND o.demo = 0
JOIN subscription.Plan p ON p.id = s.planId 
WHERE p.serviceId = 3 AND s.activationDate <= "2023-09-30 23:59:59" AND  (s.cancelledAt IS NULL OR s.cancelledAt > "2023-09-30 23:59:59")
GROUP BY o.id) as CeptePosAbonelik

-- EKİM 2023 - CEPTEPOS Adet 52350
-- EKİM 2023 - CEPTEPOS Adet 52543 - End Of Period
SELECT COUNT(*) FROM (SELECT o.id, COUNT(o.id) as CeptePosAdet FROM odeal.Organisation o 
JOIN subscription.Subscription s ON s.organisationId = o.id AND o.demo = 0
JOIN subscription.Plan p ON p.id = s.planId 
WHERE p.serviceId = 3 AND s.activationDate <= "2023-10-31 23:59:59" AND  (s.cancelledAt IS NULL OR s.cancelledAt > "2023-10-31 23:59:59")
GROUP BY o.id) as CeptePosAbonelik

SELECT COUNT(o.id) as CeptePosAdet FROM odeal.Organisation o 
JOIN subscription.Subscription s ON s.organisationId = o.id AND o.demo = 0
JOIN subscription.Plan p ON p.id = s.planId 
WHERE p.serviceId = 3 AND s.activationDate <= "2023-09-30 23:59:59" AND  (s.cancelledAt IS NULL OR s.cancelledAt > "2023-09-30 23:59:59")


SELECT "2023-10" as Ay, SUM(bp.amount) as Ciro FROM odeal.BasePayment bp 
WHERE bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= "2023-10-01 00:00:00" AND bp.signedDate <= "2023-10-31 23:59:59"
UNION
SELECT "2023-10" as Ay, SUM(bp.amount) as Ciro FROM odeal.BasePayment bp 
WHERE bp.currentStatus = 6 AND bp.serviceId = 3 AND bp.signedDate >= "2023-10-01 00:00:00" AND bp.signedDate <= "2023-10-31 23:59:59"

SELECT "2023-09" as Ay, SUM(bp.amount) as Ciro FROM odeal.BasePayment bp 
WHERE bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= "2023-09-01 00:00:00" AND bp.signedDate <= "2023-09-30 23:59:59"
UNION
SELECT "2023-09" as Ay, SUM(bp.amount) as Ciro FROM odeal.BasePayment bp 
WHERE bp.currentStatus = 6 AND bp.serviceId = 3 AND bp.signedDate >= "2023-09-01 00:00:00" AND bp.signedDate <= "2023-09-30 23:59:59"

2023-10	1733054417.68
2023-10	134210898.16

SELECT 479871133 + 1733054417.68 + 134210898.16 = 2347136448.84

1611038110.99
142184786.19

SELECT 466349549 + 1611038110.99 + 142184786.19 = 2219572446.18

142190535.19


SELECT SUM(br.gross_amount) as Ciro FROM paymatch.bank_report br 
JOIN odeal.BasePayment bp ON bp.uniqueKey = br.unique_key
WHERE bp.currentStatus = 6 AND bp.serviceId = 3 AND bp.signedDate >= "2023-09-01 00:00:00" AND bp.signedDate <= "2023-09-30 23:59:59"

SELECT SUM(br.gross_amount) as Ciro FROM paymatch.bank_report br 
JOIN odeal.BasePayment bp ON bp.uniqueKey = br.unique_key
WHERE bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= "2023-05-01 00:00:00" AND bp.signedDate <= "2023-05-31 23:59:59"

MAYIS 2023 - 896192703.5771471
EYLÜL 2023 - 1596273911.0468569

SELECT bp.id, bp.organisationId, bp.signedDate, bp.amount, br.id, br.transaction_date, br.gross_amount, CONCAT(bp.organisationId,"-",bp.amount) FROM odeal.BasePayment bp 
LEFT JOIN paymatch.bank_report br ON br.unique_key = bp.uniqueKey 
WHERE bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= "2023-05-01 00:00:00" AND bp.signedDate <= "2023-05-31 23:59:59"




SELECT "2023-06" as Ay, COUNT(*) as Adet FROM 
(SELECT t.firstActivationDate, t.serial_no, bp.id, bp.amount FROM odeal.Terminal t 
JOIN subscription.Subscription s ON s.id = t.subscription_id
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id
WHERE t.firstActivationDate <= "2023-06-30" AND s.cancelledAt > "2023-06-30"
UNION
SELECT t.firstActivationDate, t.serial_no FROM odeal.Terminal t 
JOIN subscription.Subscription s ON s.id = t.subscription_id AND s.status = 1
WHERE t.firstActivationDate <= "2023-06-30" AND t.terminalStatus = 1) as Haziran
UNION
SELECT "2023-07" as Ay, COUNT(*) as Adet FROM (SELECT t.firstActivationDate, t.serial_no FROM odeal.Terminal t 
JOIN subscription.Subscription s ON s.id = t.subscription_id
WHERE t.firstActivationDate <= "2023-07-31" AND s.cancelledAt > "2023-07-31"
UNION
SELECT t.firstActivationDate, t.serial_no FROM odeal.Terminal t 
JOIN subscription.Subscription s ON s.id = t.subscription_id AND s.status = 1
WHERE t.firstActivationDate <= "2023-07-31" AND t.terminalStatus = 1) as Temmuz
UNION
SELECT "2023-08" as Ay, COUNT(*) as Adet FROM (SELECT t.serial_no FROM odeal.Terminal t 
JOIN subscription.Subscription s ON s.id = t.subscription_id
WHERE t.firstActivationDate <= "2023-08-31" AND s.cancelledAt > "2023-08-31"
UNION
SELECT t.serial_no FROM odeal.Terminal t 
JOIN subscription.Subscription s ON s.id = t.subscription_id AND s.status = 1
WHERE t.firstActivationDate <= "2023-08-31" AND t.terminalStatus = 1) as Agustos
UNION
SELECT "2023-09" as Ay, COUNT(*) as Adet FROM (SELECT t.serial_no FROM odeal.Terminal t 
JOIN subscription.Subscription s ON s.id = t.subscription_id
WHERE t.firstActivationDate <= "2023-09-30" AND s.cancelledAt > "2023-09-30"
UNION
SELECT t.serial_no FROM odeal.Terminal t 
JOIN subscription.Subscription s ON s.id = t.subscription_id
WHERE t.firstActivationDate <= "2023-09-30" AND t.terminalStatus = 1) as Eylul

SELECT DATE_FORMAT(Islemler.signedDate,"%Y-%m") as Ay, SUM(Islemler.amount) as Ciro, COUNT(Islemler.serial_no) as Terminal  FROM (SELECT t.serial_no, bp.id, bp.signedDate, bp.amount FROM odeal.BasePayment bp 
JOIN odeal.TerminalPayment tp ON tp.id = bp.id 
JOIN odeal.Terminal t ON t.id = tp.terminal_id
WHERE bp.signedDate >= "2023-06-01 00:00:00" AND bp.signedDate <= "2023-09-30 23:59:59" AND bp.currentStatus = 6) as Islemler
GROUP BY DATE_FORMAT(Islemler.signedDate,"%Y-%m")

SELECT o.id, t.serial_no, t.firstActivationDate, t.terminalStatus, s.cancelledAt FROM odeal.Terminal t
LEFT JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id
WHERE s.cancelledAt > "2023-08-31"
UNION
SELECT o.id, t.serial_no, t.firstActivationDate, t.terminalStatus, s.cancelledAt FROM odeal.Terminal t
LEFT JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id
WHERE t.firstActivationDate <= "2023-08-31 23:59:59"



-- İptal Adet
SELECT t.serial_no, t.firstActivationDate, s.cancelledAt FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
WHERE DATE_FORMAT(s.cancelledAt,"%Y-%m-%d") <= DATE_FORMAT(CURDATE(),"%Y-%m-%d") AND t.terminalStatus = 0

-- Belirli Tarihe CeptePos hizmeti satın alan Üye İşyeri Adet
SELECT DATE_FORMAT((s.activationDate),"%Y-%m") as Ay, COUNT(*) as Adet FROM odeal.Organisation o 
JOIN subscription.Subscription s ON s.organisationId = o.id 
JOIN subscription.Plan p ON p.id = s.planId 
WHERE p.serviceId = 3 AND DATE_FORMAT((s.activationDate),"%Y-%m-%d") <= DATE_FORMAT(CURDATE(),"%Y-%m-%d") AND o.isActivated = 1 AND o.id NOT IN (SELECT DISTINCT o.id FROM odeal.Organisation o 
JOIN subscription.Subscription s ON s.organisationId = o.id 
JOIN subscription.Plan p ON p.id = s.planId 
WHERE p.serviceId = 3 AND DATE_FORMAT((s.activationDate),"%Y-%m-%d") <= DATE_FORMAT(CURDATE(),"%Y-%m-%d") AND o.isActivated = 1
GROUP BY o.id HAVING COUNT(*)>1)
GROUP BY DATE_FORMAT((s.activationDate),"%Y-%m")

SELECT DISTINCT o.id FROM odeal.Organisation o 
JOIN subscription.Subscription s ON s.organisationId = o.id 
JOIN subscription.Plan p ON p.id = s.planId 
WHERE p.serviceId = 3 AND DATE_FORMAT((s.activationDate),"%Y-%m-%d") <= DATE_FORMAT(CURDATE(),"%Y-%m-%d") AND o.isActivated = 1
GROUP BY o.id HAVING COUNT(*)>1

SELECT * FROM odeal.Terminal t 
WHERE t.serial_no = "2C23880068"



SELECT DATE_FORMAT(bp.signedDate,"%Y-%m") as Ay,  bp.organisationId, t.serial_no, COUNT(bp.id) as ToplamIslemAdet, SUM(bp.amount) as Tutar FROM odeal.BasePayment bp 
JOIN odeal.TerminalPayment tp ON tp.id = bp.id
JOIN odeal.Terminal t ON t.id = tp.terminal_id AND t.terminalStatus = 1
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
WHERE bp.currentStatus = 6 AND bp.signedDate >= "2023-07-01 00:00:00"
GROUP BY DATE_FORMAT(bp.signedDate,"%Y-%m"), bp.organisationId, t.serial_no


SELECT DATE_FORMAT(bp.signedDate,"%Y-%m") as Ay, t.serial_no, COUNT(bp.id) as IslemAdet FROM odeal.BasePayment bp
JOIN odeal.TerminalPayment tp ON tp.id = bp.id 
JOIN odeal.Terminal t ON t.id = tp.terminal_id
WHERE bp.currentStatus = 6 AND DATE_FORMAT(bp.signedDate,"%Y-%m-%d") >= "2023-07-01" AND DATE_FORMAT(bp.signedDate, "%Y-%m-%d") <= DATE_FORMAT(CURDATE(),"%Y-%m-%d") 
GROUP BY DATE_FORMAT(bp.signedDate,"%Y-%m"), t.serial_no 

-- END OF PERIOD - Terminal Adetleri
SELECT EndOfPeriodTerminalAdet.Ay, EndOfPeriodTerminalAdet.Adet as EODTerminalAdet, TerminalAdet.TerminalAdet FROM (
SELECT "2024-04"  as Ay, COUNT(*) as Adet FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
WHERE t.firstActivationDate <= "2024-04-30 23:59:59" AND (s.cancelledAt IS NULL OR s.cancelledAt > "2024-04-30 23:59:59")
UNION
SELECT "2024-05"  as Ay, COUNT(*) as Adet FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
WHERE t.firstActivationDate <= "2024-05-31 23:59:59" AND (s.cancelledAt IS NULL OR s.cancelledAt > "2024-05-31 23:59:59")
UNION
SELECT "2024-06"  as Ay, COUNT(*) as Adet FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
WHERE t.firstActivationDate <= "2024-06-30 23:59:59" AND (s.cancelledAt IS NULL OR s.cancelledAt > "2024-06-30 23:59:59")
UNION
SELECT "2024-06"  as Ay, COUNT(*) as Adet FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
WHERE t.firstActivationDate <= "2024-06-30 23:59:59" AND (s.cancelledAt IS NULL OR s.cancelledAt > "2024-06-30 23:59:59")
UNION
SELECT "2024-07"  as Ay, COUNT(*) as Adet FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
WHERE t.firstActivationDate <= "2024-07-31 23:59:59" AND (s.cancelledAt IS NULL OR s.cancelledAt > "2024-07-31 23:59:59")
UNION
SELECT "2024-08"  as Ay, COUNT(*) as Adet FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
WHERE t.firstActivationDate <= "2024-08-31 23:59:59" AND (s.cancelledAt IS NULL OR s.cancelledAt > "2024-08-31 23:59:59")
UNION
SELECT "2024-09"  as Ay, COUNT(*) as Adet FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
WHERE t.firstActivationDate <= "2024-09-30 23:59:59" AND (s.cancelledAt IS NULL OR s.cancelledAt > "2024-09-30 23:59:59")
) as EndOfPeriodTerminalAdet
LEFT JOIN (SELECT TerminalAdet.Ay, TerminalAdet.Adet as TerminalAdet FROM (
SELECT "2024-04"  as Ay, COUNT(*) as Adet FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
WHERE t.firstActivationDate <= "2024-04-30 23:59:59" AND (s.cancelledAt IS NULL OR s.cancelledAt > "2024-03-31 23:59:59")
UNION
SELECT "2024-05"  as Ay, COUNT(*) as Adet FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
WHERE t.firstActivationDate <= "2024-05-31 23:59:59" AND (s.cancelledAt IS NULL OR s.cancelledAt > "2024-04-30 23:59:59")
UNION
SELECT "2024-06"  as Ay, COUNT(*) as Adet FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
WHERE t.firstActivationDate <= "2024-06-30 23:59:59" AND (s.cancelledAt IS NULL OR s.cancelledAt > "2024-05-31 23:59:59")
UNION
SELECT "2024-07"  as Ay, COUNT(*) as Adet FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
WHERE t.firstActivationDate <= "2024-07-31 23:59:59" AND (s.cancelledAt IS NULL OR s.cancelledAt > "2024-06-30 23:59:59")
UNION
SELECT "2024-08"  as Ay, COUNT(*) as Adet FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
WHERE t.firstActivationDate <= "2024-08-31 23:59:59" AND (s.cancelledAt IS NULL OR s.cancelledAt > "2024-07-31 23:59:59")
UNION
SELECT "2024-09"  as Ay, COUNT(*) as Adet FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
WHERE t.firstActivationDate <= "2024-09-30 23:59:59" AND (s.cancelledAt IS NULL OR s.cancelledAt > "2024-08-31 23:59:59")
) as TerminalAdet) as TerminalAdet ON TerminalAdet.Ay = EndOfPeriodTerminalAdet.Ay;

-- Aylık Aktivasyonlar
SELECT "2024-04"  as Ay, COUNT(*) as Adet FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
WHERE t.firstActivationDate >= "2024-04-01 00:00:00" AND t.firstActivationDate <= "2024-04-30 23:59:59" AND (s.cancelledAt IS NULL OR s.cancelledAt > "2024-03-31 23:59:59")
UNION
SELECT "2024-05"  as Ay, COUNT(*) as Adet FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
WHERE t.firstActivationDate >= "2024-05-01 00:00:00" AND t.firstActivationDate <= "2024-05-31 23:59:59" AND (s.cancelledAt IS NULL OR s.cancelledAt > "2024-04-30 23:59:59")
UNION
SELECT "2024-06"  as Ay, COUNT(*) as Adet FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
WHERE t.firstActivationDate >= "2024-06-01 00:00:00" AND t.firstActivationDate <= "2024-06-30 23:59:59" AND (s.cancelledAt IS NULL OR s.cancelledAt > "2024-05-31 23:59:59")
UNION
SELECT "2024-07"  as Ay, COUNT(*) as Adet FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
WHERE t.firstActivationDate >= "2024-07-01 00:00:00" AND t.firstActivationDate <= "2024-07-31 23:59:59" AND (s.cancelledAt IS NULL OR s.cancelledAt > "2024-06-30 23:59:59")
UNION
SELECT "2024-08"  as Ay, COUNT(*) as Adet FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
WHERE t.firstActivationDate >= "2024-08-01 00:00:00" AND t.firstActivationDate <= "2024-08-31 23:59:59" AND (s.cancelledAt IS NULL OR s.cancelledAt > "2024-07-31 23:59:59")
UNION
SELECT "2024-09"  as Ay, COUNT(*) as Adet FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
WHERE t.firstActivationDate >= "2024-09-01 00:00:00" AND t.firstActivationDate <= "2024-09-30 23:59:59" AND (s.cancelledAt IS NULL OR s.cancelledAt > "2024-08-31 23:59:59")



-- CeptePos Adetler

SELECT "2024-07" as Ay, CeptePos.AdetEOP, CepteposAyniAy.Adet FROM (
SELECT "2024-07" as Ay, COUNT(*) as AdetEOP FROM (SELECT o.id, COUNT(o.id) as CeptePosAdet FROM odeal.Organisation o
JOIN subscription.Subscription s ON s.organisationId = o.id AND o.demo = 0
JOIN subscription.Plan p ON p.id = s.planId
WHERE p.serviceId = 3 AND s.activationDate <= "2024-07-31 23:59:59" AND  (s.cancelledAt IS NULL OR s.cancelledAt > "2024-07-31 23:59:59")
GROUP BY o.id) as T1) as CeptePos
LEFT JOIN (SELECT "2024-07" as Ay, COUNT(*) as Adet FROM (SELECT o.id, COUNT(o.id) as CeptePosAdet FROM odeal.Organisation o
JOIN subscription.Subscription s ON s.organisationId = o.id AND o.demo = 0
JOIN subscription.Plan p ON p.id = s.planId
WHERE p.serviceId = 3 AND s.activationDate <= "2024-07-31 23:59:59" AND  (s.cancelledAt IS NULL OR s.cancelledAt > "2024-06-30 23:59:59")
GROUP BY o.id) as CeptePosAbonelik) as CepteposAyniAy ON CepteposAyniAy.Ay = CeptePos.Ay
UNION
SELECT "2024-08" as Ay, CeptePos.AdetEOP, CepteposAyniAy.Adet FROM (
SELECT "2024-08" as Ay, COUNT(*) as AdetEOP FROM (SELECT o.id, COUNT(o.id) as CeptePosAdet FROM odeal.Organisation o
JOIN subscription.Subscription s ON s.organisationId = o.id AND o.demo = 0
JOIN subscription.Plan p ON p.id = s.planId
WHERE p.serviceId = 3 AND s.activationDate <= "2024-08-31 23:59:59" AND  (s.cancelledAt IS NULL OR s.cancelledAt > "2024-08-31 23:59:59")
GROUP BY o.id) as T1) as CeptePos
LEFT JOIN (SELECT "2024-08" as Ay, COUNT(*) as Adet FROM (SELECT o.id, COUNT(o.id) as CeptePosAdet FROM odeal.Organisation o
JOIN subscription.Subscription s ON s.organisationId = o.id AND o.demo = 0
JOIN subscription.Plan p ON p.id = s.planId
WHERE p.serviceId = 3 AND s.activationDate <= "2024-08-31 23:59:59" AND  (s.cancelledAt IS NULL OR s.cancelledAt > "2024-07-31 23:59:59")
GROUP BY o.id) as CeptePosAbonelik) as CepteposAyniAy ON CepteposAyniAy.Ay = CeptePos.Ay
UNION
SELECT "2024-09" as Ay, CeptePos.AdetEOP, CepteposAyniAy.Adet FROM (
SELECT "2024-09" as Ay, COUNT(*) as AdetEOP FROM (SELECT o.id, COUNT(o.id) as CeptePosAdet FROM odeal.Organisation o
JOIN subscription.Subscription s ON s.organisationId = o.id AND o.demo = 0
JOIN subscription.Plan p ON p.id = s.planId
WHERE p.serviceId = 3 AND s.activationDate <= "2024-09-30 23:59:59" AND  (s.cancelledAt IS NULL OR s.cancelledAt > "2024-09-30 23:59:59")
GROUP BY o.id) as T1) as CeptePos
LEFT JOIN (SELECT "2024-09" as Ay, COUNT(*) as Adet FROM (SELECT o.id, COUNT(o.id) as CeptePosAdet FROM odeal.Organisation o
JOIN subscription.Subscription s ON s.organisationId = o.id AND o.demo = 0
JOIN subscription.Plan p ON p.id = s.planId
WHERE p.serviceId = 3 AND s.activationDate <= "2024-09-30 23:59:59" AND  (s.cancelledAt IS NULL OR s.cancelledAt > "2024-08-31 23:59:59")
GROUP BY o.id) as CeptePosAbonelik) as CepteposAyniAy ON CepteposAyniAy.Ay = CeptePos.Ay
UNION
SELECT "2024-10" as Ay, CeptePos.AdetEOP, CepteposAyniAy.Adet FROM (
SELECT "2024-10" as Ay, COUNT(*) as AdetEOP FROM (SELECT o.id, COUNT(o.id) as CeptePosAdet FROM odeal.Organisation o
JOIN subscription.Subscription s ON s.organisationId = o.id AND o.demo = 0
JOIN subscription.Plan p ON p.id = s.planId
WHERE p.serviceId = 3 AND s.activationDate <= "2024-10-31 23:59:59" AND  (s.cancelledAt IS NULL OR s.cancelledAt > "2024-10-31 23:59:59")
GROUP BY o.id) as T1) as CeptePos
LEFT JOIN (SELECT "2024-10" as Ay, COUNT(*) as Adet FROM (SELECT o.id, COUNT(o.id) as CeptePosAdet FROM odeal.Organisation o
JOIN subscription.Subscription s ON s.organisationId = o.id AND o.demo = 0
JOIN subscription.Plan p ON p.id = s.planId
WHERE p.serviceId = 3 AND s.activationDate <= "2024-10-31 23:59:59" AND  (s.cancelledAt IS NULL OR s.cancelledAt > "2024-09-30 23:59:59")
GROUP BY o.id) as CeptePosAbonelik) as CepteposAyniAy ON CepteposAyniAy.Ay = CeptePos.Ay




-- Terminal Adetleri
SELECT "2023-01"  as Ay, COUNT(*) as Adet FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
WHERE t.firstActivationDate >= "2023-01-01 00:00:00" AND t.firstActivationDate <= "2023-01-31 23:59:59" AND (s.cancelledAt IS NULL OR s.cancelledAt > "2022-12-31 23:59:59")
UNION
SELECT "2023-02"  as Ay, COUNT(*) as Adet FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
WHERE t.firstActivationDate >= "2023-02-01 00:00:00" AND t.firstActivationDate <= "2023-02-28 23:59:59" AND (s.cancelledAt IS NULL OR s.cancelledAt > "2023-01-31 23:59:59")
UNION
SELECT "2023-03"  as Ay, COUNT(*) as Adet FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
WHERE t.firstActivationDate >= "2023-03-01 00:00:00" AND t.firstActivationDate <= "2023-03-31 23:59:59" AND (s.cancelledAt IS NULL OR s.cancelledAt > "2023-02-28 23:59:59")
UNION
SELECT "2023-04"  as Ay, COUNT(*) as Adet FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
WHERE t.firstActivationDate >= "2023-04-01 00:00:00" AND t.firstActivationDate <= "2023-04-30 23:59:59" AND (s.cancelledAt IS NULL OR s.cancelledAt > "2023-03-31 23:59:59")
UNION
SELECT "2023-05"  as Ay, COUNT(*) as Adet FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
WHERE t.firstActivationDate >= "2023-05-01 00:00:00" AND t.firstActivationDate <= "2023-05-31 23:59:59" AND (s.cancelledAt IS NULL OR s.cancelledAt > "2023-04-30 23:59:59")
UNION
SELECT "2023-06"  as Ay, COUNT(*) as Adet FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
WHERE t.firstActivationDate >= "2023-06-01 00:00:00" AND t.firstActivationDate <= "2023-06-30 23:59:59" AND (s.cancelledAt IS NULL OR s.cancelledAt > "2023-05-31 23:59:59")
UNION
SELECT "2023-07"  as Ay, COUNT(*) as Adet FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
WHERE t.firstActivationDate >= "2023-07-01 00:00:00" AND t.firstActivationDate <= "2023-07-31 23:59:59" AND (s.cancelledAt IS NULL OR s.cancelledAt > "2023-06-30 23:59:59")
UNION
SELECT "2023-08"  as Ay, COUNT(*) as Adet FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
WHERE t.firstActivationDate >= "2023-08-01 00:00:00" AND t.firstActivationDate <= "2023-08-31 23:59:59" AND (s.cancelledAt IS NULL OR s.cancelledAt > "2023-07-31 23:59:59")
UNION
SELECT "2023-09"  as Ay, COUNT(*) as Adet FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
WHERE t.firstActivationDate >= "2023-09-01 00:00:00" AND t.firstActivationDate <= "2023-09-30 23:59:59" AND (s.cancelledAt IS NULL OR s.cancelledAt > "2023-08-31 23:59:59")
UNION
SELECT "2023-10"  as Ay, COUNT(*) as Adet FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
WHERE t.firstActivationDate >= "2023-10-01 00:00:00" AND t.firstActivationDate <= "2023-10-31 23:59:59" AND (s.cancelledAt IS NULL OR s.cancelledAt > "2023-09-30 23:59:59")
UNION
SELECT "2023-11"  as Ay, COUNT(*) as Adet FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
WHERE t.firstActivationDate >= "2023-11-01 00:00:00" AND t.firstActivationDate <= "2023-11-30 23:59:59" AND (s.cancelledAt IS NULL OR s.cancelledAt > "2023-10-31 23:59:59")
UNION
SELECT "2023-12"  as Ay, COUNT(*) as Adet FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
WHERE t.firstActivationDate >= "2023-12-01 00:00:00" AND t.firstActivationDate <= "2023-12-31 23:59:59" AND (s.cancelledAt IS NULL OR s.cancelledAt > "2023-11-30 23:59:59")
 UNION
SELECT "2024-01"  as Ay, COUNT(*) as Adet FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
WHERE t.firstActivationDate >= "2024-01-01 00:00:00" AND t.firstActivationDate <= "2024-01-31 23:59:59" AND (s.cancelledAt IS NULL OR s.cancelledAt > "2023-12-31 23:59:59")
UNION
SELECT "2024-02"  as Ay, COUNT(*) as Adet FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
WHERE t.firstActivationDate >= "2024-02-01 00:00:00" AND t.firstActivationDate <= "2024-02-29 23:59:59" AND (s.cancelledAt IS NULL OR s.cancelledAt > "2024-01-31 23:59:59")
UNION
SELECT "2024-03"  as Ay, COUNT(*) as Adet FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
WHERE t.firstActivationDate >= "2024-03-01 00:00:00" AND t.firstActivationDate <= "2024-03-31 23:59:59" AND (s.cancelledAt IS NULL OR s.cancelledAt > "2024-02-29 23:59:59")
UNION
SELECT "2024-04"  as Ay, COUNT(*) as Adet FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
WHERE t.firstActivationDate >= "2024-04-01 00:00:00" AND t.firstActivationDate <= "2024-04-30 23:59:59" AND (s.cancelledAt IS NULL OR s.cancelledAt > "2024-03-31 23:59:59")
UNION
SELECT "2024-05"  as Ay, COUNT(*) as Adet FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
WHERE t.firstActivationDate >= "2024-05-01 00:00:00" AND t.firstActivationDate <= "2024-05-31 23:59:59" AND (s.cancelledAt IS NULL OR s.cancelledAt > "2024-04-30 23:59:59")
UNION
SELECT "2024-06"  as Ay, COUNT(*) as Adet FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
WHERE t.firstActivationDate >= "2024-06-01 00:00:00" AND t.firstActivationDate <= "2024-06-30 23:59:59" AND (s.cancelledAt IS NULL OR s.cancelledAt > "2024-05-31 23:59:59")


-- EOP Aktif
SELECT EndOfPeriodTerminalAdet.Ay, EndOfPeriodTerminalAdet.Adet as EODTerminalAdet, TerminalAdet.TerminalAdet FROM (
SELECT "2023-01"  as Ay, COUNT(*) as Adet FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
WHERE t.firstActivationDate <= "2023-01-31 23:59:59" AND (s.cancelledAt IS NULL OR s.cancelledAt > "2023-01-31 23:59:59")
UNION
SELECT "2023-02"  as Ay, COUNT(*) as Adet FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
WHERE t.firstActivationDate <= "2023-02-28 23:59:59" AND (s.cancelledAt IS NULL OR s.cancelledAt > "2023-02-28 23:59:59")
UNION
SELECT "2023-03"  as Ay, COUNT(*) as Adet FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
WHERE t.firstActivationDate <= "2023-03-31 23:59:59" AND (s.cancelledAt IS NULL OR s.cancelledAt > "2023-03-31 23:59:59")
UNION
SELECT "2023-04"  as Ay, COUNT(*) as Adet FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
WHERE t.firstActivationDate <= "2023-04-30 23:59:59" AND (s.cancelledAt IS NULL OR s.cancelledAt > "2023-04-30 23:59:59")
UNION
SELECT "2023-05"  as Ay, COUNT(*) as Adet FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
WHERE t.firstActivationDate <= "2023-05-31 23:59:59" AND (s.cancelledAt IS NULL OR s.cancelledAt > "2023-05-31 23:59:59")
UNION
SELECT "2023-06"  as Ay, COUNT(*) as Adet FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
WHERE t.firstActivationDate <= "2023-06-30 23:59:59" AND (s.cancelledAt IS NULL OR s.cancelledAt > "2023-06-30 23:59:59")
UNION
SELECT "2023-07"  as Ay, COUNT(*) as Adet FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
WHERE t.firstActivationDate <= "2023-07-31 23:59:59" AND (s.cancelledAt IS NULL OR s.cancelledAt > "2023-07-31 23:59:59")
UNION
SELECT "2023-08"  as Ay, COUNT(*) as Adet FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
WHERE t.firstActivationDate <= "2023-08-31 23:59:59" AND (s.cancelledAt IS NULL OR s.cancelledAt > "2023-08-31 23:59:59")
UNION
SELECT "2023-09"  as Ay, COUNT(*) as Adet FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
WHERE t.firstActivationDate <= "2023-09-30 23:59:59" AND (s.cancelledAt IS NULL OR s.cancelledAt > "2023-09-30 23:59:59")
UNION
SELECT "2023-10"  as Ay, COUNT(*) as Adet FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
WHERE t.firstActivationDate <= "2023-10-31 23:59:59" AND (s.cancelledAt IS NULL OR s.cancelledAt > "2023-10-31 23:59:59")
UNION
SELECT "2023-11"  as Ay, COUNT(*) as Adet FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
WHERE t.firstActivationDate <= "2023-11-30 23:59:59" AND (s.cancelledAt IS NULL OR s.cancelledAt > "2023-11-30 23:59:59")
UNION
SELECT "2023-12"  as Ay, COUNT(*) as Adet FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
WHERE t.firstActivationDate <= "2023-12-31 23:59:59" AND (s.cancelledAt IS NULL OR s.cancelledAt > "2023-12-31 23:59:59")
UNION
SELECT "2024-01"  as Ay, COUNT(*) as Adet FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
WHERE t.firstActivationDate <= "2024-01-31 23:59:59" AND (s.cancelledAt IS NULL OR s.cancelledAt > "2024-01-31 23:59:59")
UNION
SELECT "2024-02"  as Ay, COUNT(*) as Adet FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
WHERE t.firstActivationDate <= "2024-02-29 23:59:59" AND (s.cancelledAt IS NULL OR s.cancelledAt > "2024-02-29 23:59:59")
UNION
SELECT "2024-03"  as Ay, COUNT(*) as Adet FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
WHERE t.firstActivationDate <= "2024-03-31 23:59:59" AND (s.cancelledAt IS NULL OR s.cancelledAt > "2024-03-31 23:59:59")
UNION
SELECT "2024-04"  as Ay, COUNT(*) as Adet FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
WHERE t.firstActivationDate <= "2024-04-30 23:59:59" AND (s.cancelledAt IS NULL OR s.cancelledAt > "2024-04-30 23:59:59")
UNION
SELECT "2024-05"  as Ay, COUNT(*) as Adet FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
WHERE t.firstActivationDate <= "2024-05-31 23:59:59" AND (s.cancelledAt IS NULL OR s.cancelledAt > "2024-05-31 23:59:59")
UNION
SELECT "2024-06"  as Ay, COUNT(*) as Adet FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
WHERE t.firstActivationDate <= "2024-06-30 23:59:59" AND (s.cancelledAt IS NULL OR s.cancelledAt > "2024-06-30 23:59:59")
) as EndOfPeriodTerminalAdet
LEFT JOIN (SELECT TerminalAdet.Ay, TerminalAdet.Adet as TerminalAdet FROM (
SELECT "2023-01"  as Ay, COUNT(*) as Adet FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
WHERE t.firstActivationDate <= "2023-01-31 23:59:59" AND (s.cancelledAt IS NULL OR s.cancelledAt > "2022-12-31 23:59:59")
UNION
SELECT "2023-02"  as Ay, COUNT(*) as Adet FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
WHERE t.firstActivationDate <= "2023-02-28 23:59:59" AND (s.cancelledAt IS NULL OR s.cancelledAt > "2023-01-31 23:59:59")
UNION
SELECT "2023-03"  as Ay, COUNT(*) as Adet FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
WHERE t.firstActivationDate <= "2023-03-31 23:59:59" AND (s.cancelledAt IS NULL OR s.cancelledAt > "2023-02-28 23:59:59")
UNION
SELECT "2023-04"  as Ay, COUNT(*) as Adet FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
WHERE t.firstActivationDate <= "2023-04-30 23:59:59" AND (s.cancelledAt IS NULL OR s.cancelledAt > "2023-03-31 23:59:59")
UNION
SELECT "2023-05"  as Ay, COUNT(*) as Adet FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
WHERE t.firstActivationDate <= "2023-05-31 23:59:59" AND (s.cancelledAt IS NULL OR s.cancelledAt > "2023-04-30 23:59:59")
UNION
SELECT "2023-06"  as Ay, COUNT(*) as Adet FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
WHERE t.firstActivationDate <= "2023-06-30 23:59:59" AND (s.cancelledAt IS NULL OR s.cancelledAt > "2023-05-31 23:59:59")
UNION
SELECT "2023-07"  as Ay, COUNT(*) as Adet FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
WHERE t.firstActivationDate <= "2023-07-31 23:59:59" AND (s.cancelledAt IS NULL OR s.cancelledAt > "2023-06-30 23:59:59")
UNION
SELECT "2023-08"  as Ay, COUNT(*) as Adet FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
WHERE t.firstActivationDate <= "2023-08-31 23:59:59" AND (s.cancelledAt IS NULL OR s.cancelledAt > "2023-07-31 23:59:59")
UNION
SELECT "2023-09"  as Ay, COUNT(*) as Adet FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
WHERE t.firstActivationDate <= "2023-09-30 23:59:59" AND (s.cancelledAt IS NULL OR s.cancelledAt > "2023-08-30 23:59:59")
UNION
SELECT "2023-10"  as Ay, COUNT(*) as Adet FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
WHERE t.firstActivationDate <= "2023-10-31 23:59:59" AND (s.cancelledAt IS NULL OR s.cancelledAt > "2023-09-30 23:59:59")
UNION
SELECT "2023-11"  as Ay, COUNT(*) as Adet FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
WHERE t.firstActivationDate <= "2023-11-30 23:59:59" AND (s.cancelledAt IS NULL OR s.cancelledAt > "2023-10-31 23:59:59")
UNION
SELECT "2023-12"  as Ay, COUNT(*) as Adet FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
WHERE t.firstActivationDate <= "2023-12-31 23:59:59" AND (s.cancelledAt IS NULL OR s.cancelledAt > "2023-11-30 23:59:59")
UNION
SELECT "2024-01"  as Ay, COUNT(*) as Adet FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
WHERE t.firstActivationDate <= "2024-01-31 23:59:59" AND (s.cancelledAt IS NULL OR s.cancelledAt > "2023-12-31 23:59:59")
UNION
SELECT "2024-02"  as Ay, COUNT(*) as Adet FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
WHERE t.firstActivationDate <= "2024-02-29 23:59:59" AND (s.cancelledAt IS NULL OR s.cancelledAt > "2024-01-31 23:59:59")
UNION
SELECT "2024-03"  as Ay, COUNT(*) as Adet FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
WHERE t.firstActivationDate <= "2024-03-31 23:59:59" AND (s.cancelledAt IS NULL OR s.cancelledAt > "2024-02-29 23:59:59")
UNION
SELECT "2024-04"  as Ay, COUNT(*) as Adet FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
WHERE t.firstActivationDate <= "2024-04-30 23:59:59" AND (s.cancelledAt IS NULL OR s.cancelledAt > "2024-03-31 23:59:59")
UNION
SELECT "2024-05"  as Ay, COUNT(*) as Adet FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
WHERE t.firstActivationDate <= "2024-05-31 23:59:59" AND (s.cancelledAt IS NULL OR s.cancelledAt > "2024-04-30 23:59:59")
UNION
SELECT "2024-06"  as Ay, COUNT(*) as Adet FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
WHERE t.firstActivationDate <= "2024-06-30 23:59:59" AND (s.cancelledAt IS NULL OR s.cancelledAt > "2024-05-31 23:59:59")
) as TerminalAdet) as TerminalAdet ON TerminalAdet.Ay = EndOfPeriodTerminalAdet.Ay

SELECT EndOfPeriodTerminalAdet.Ay, EndOfPeriodTerminalAdet.Adet as EODTerminalAdet, TerminalAdet.TerminalAdet FROM (
SELECT "2024-08"  as Ay, COUNT(*) as Adet FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
WHERE t.firstActivationDate <= "2024-08-31 23:59:59" AND (s.cancelledAt IS NULL OR s.cancelledAt > "2024-08-31 23:59:59")
UNION
SELECT "2024-09"  as Ay, COUNT(*) as Adet FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
WHERE t.firstActivationDate <= "2024-09-30 23:59:59" AND (s.cancelledAt IS NULL OR s.cancelledAt > "2024-09-30 23:59:59")
UNION
SELECT "2024-10"  as Ay, COUNT(*) as Adet FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
WHERE t.firstActivationDate <= "2024-10-31 23:59:59" AND (s.cancelledAt IS NULL OR s.cancelledAt > "2024-10-31 23:59:59")
) as EndOfPeriodTerminalAdet
LEFT JOIN (SELECT TerminalAdet.Ay, TerminalAdet.Adet as TerminalAdet FROM (
SELECT "2024-08"  as Ay, COUNT(*) as Adet FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
WHERE t.firstActivationDate <= "2024-08-31 23:59:59" AND (s.cancelledAt IS NULL OR s.cancelledAt > "2024-07-31 23:59:59")
UNION
SELECT "2024-09"  as Ay, COUNT(*) as Adet FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
WHERE t.firstActivationDate <= "2024-09-30 23:59:59" AND (s.cancelledAt IS NULL OR s.cancelledAt > "2024-08-31 23:59:59")
UNION
SELECT "2024-10"  as Ay, COUNT(*) as Adet FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
WHERE t.firstActivationDate <= "2024-10-31 23:59:59" AND (s.cancelledAt IS NULL OR s.cancelledAt > "2024-09-30 23:59:59")
) as TerminalAdet) as TerminalAdet ON TerminalAdet.Ay = EndOfPeriodTerminalAdet.Ay



-- Fiziki İptal
SELECT "2024-04" as Ay, COUNT(t.id) as FizikiIptal FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN subscription.Plan p ON p.id = s.planId AND p.serviceId <> 3
WHERE t.firstActivationDate <= "2024-04-30 23:59:59" AND s.status <>1 AND t.terminalStatus = 0 AND (s.cancelledAt >= "2024-04-01 00:00:00" AND s.cancelledAt <="2024-04-30 23:59:59")
UNION
SELECT "2024-05" as Ay, COUNT(t.id) as FizikiIptal FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN subscription.Plan p ON p.id = s.planId AND p.serviceId <> 3
WHERE t.firstActivationDate <= "2024-05-31 23:59:59" AND s.status <>1 AND t.terminalStatus = 0 AND (s.cancelledAt >= "2024-05-01 00:00:00" AND s.cancelledAt <="2024-05-31 23:59:59")
UNION
SELECT "2024-06" as Ay, COUNT(t.id) as FizikiIptal FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN subscription.Plan p ON p.id = s.planId AND p.serviceId <> 3
WHERE t.firstActivationDate <= "2024-06-30 23:59:59" AND s.status <>1 AND t.terminalStatus = 0 AND (s.cancelledAt >= "2024-06-01 00:00:00" AND s.cancelledAt <="2024-06-30 23:59:59")
UNION
SELECT "2024-07" as Ay, COUNT(t.id) as FizikiIptal FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN subscription.Plan p ON p.id = s.planId AND p.serviceId <> 3
WHERE t.firstActivationDate <= "2024-07-31 23:59:59" AND s.status <>1 AND t.terminalStatus = 0 AND (s.cancelledAt >= "2024-07-01 00:00:00" AND s.cancelledAt <="2024-07-31 23:59:59")
UNION
SELECT "2024-08" as Ay, COUNT(t.id) as FizikiIptal FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN subscription.Plan p ON p.id = s.planId AND p.serviceId <> 3
WHERE t.firstActivationDate <= "2024-08-31 23:59:59" AND s.status <>1
  AND t.terminalStatus = 0 AND (s.cancelledAt >= "2024-08-01 00:00:00" AND s.cancelledAt <="2024-08-31 23:59:59")
UNION
SELECT "2024-09" as Ay, COUNT(t.id) as FizikiIptal FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN subscription.Plan p ON p.id = s.planId AND p.serviceId <> 3
WHERE t.firstActivationDate <= "2024-09-30 23:59:59" AND s.status <>1
  AND t.terminalStatus = 0 AND (s.cancelledAt >= "2024-09-01 00:00:00" AND s.cancelledAt <="2024-09-30 23:59:59")



-- İşlem Geçen Fiziki Terminal
SELECT "2024-04"  as Ay, COUNT(IslemGecen.serial_no) as Adet, SUM(IslemGecen.Ciro) as Ciro FROM (SELECT t.serial_no, SUM(bp.amount) as Ciro FROM odeal.BasePayment bp
JOIN odeal.TerminalPayment tp ON tp.id = bp.id
JOIN odeal.Terminal t ON t.id = tp.terminal_id
WHERE bp.currentStatus = 6 AND bp.amount > 1 AND bp.signedDate >= "2024-04-01 00:00:00" AND bp.signedDate <= "2024-04-30 23:59:59"
GROUP BY t.serial_no) as IslemGecen
UNION
SELECT "2024-05"  as Ay, COUNT(IslemGecen.serial_no) as Adet, SUM(IslemGecen.Ciro) as Ciro FROM (SELECT t.serial_no, SUM(bp.amount) as Ciro FROM odeal.BasePayment bp
JOIN odeal.TerminalPayment tp ON tp.id = bp.id
JOIN odeal.Terminal t ON t.id = tp.terminal_id
WHERE bp.currentStatus = 6 AND bp.amount > 1 AND bp.signedDate >= "2024-05-01 00:00:00" AND bp.signedDate <= "2024-05-31 23:59:59"
GROUP BY t.serial_no) as IslemGecen
UNION
SELECT "2024-06"  as Ay, COUNT(IslemGecen.serial_no) as Adet, SUM(IslemGecen.Ciro) as Ciro FROM (SELECT t.serial_no, SUM(bp.amount) as Ciro FROM odeal.BasePayment bp
JOIN odeal.TerminalPayment tp ON tp.id = bp.id
JOIN odeal.Terminal t ON t.id = tp.terminal_id
WHERE bp.currentStatus = 6 AND bp.amount > 1 AND bp.signedDate >= "2024-06-01 00:00:00" AND bp.signedDate <= "2024-06-30 23:59:59"
GROUP BY t.serial_no) as IslemGecen
UNION
SELECT "2024-07"  as Ay, COUNT(IslemGecen.serial_no) as Adet, SUM(IslemGecen.Ciro) as Ciro FROM (SELECT t.serial_no, SUM(bp.amount) as Ciro FROM odeal.BasePayment bp
JOIN odeal.TerminalPayment tp ON tp.id = bp.id
JOIN odeal.Terminal t ON t.id = tp.terminal_id
WHERE bp.currentStatus = 6 AND bp.amount > 1 AND bp.signedDate >= "2024-07-01 00:00:00" AND bp.signedDate <= "2024-07-31 23:59:59"
GROUP BY t.serial_no) as IslemGecen
UNION
SELECT "2024-08"  as Ay, COUNT(IslemGecen.serial_no) as Adet, SUM(IslemGecen.Ciro) as Ciro FROM (SELECT t.serial_no, SUM(bp.amount) as Ciro FROM odeal.BasePayment bp
JOIN odeal.TerminalPayment tp ON tp.id = bp.id
JOIN odeal.Terminal t ON t.id = tp.terminal_id
WHERE bp.currentStatus = 6 AND bp.amount > 1 AND bp.signedDate >= "2024-08-01 00:00:00" AND bp.signedDate <= "2024-08-31 23:59:59"
GROUP BY t.serial_no) as IslemGecen
UNION
SELECT "2024-09"  as Ay, COUNT(IslemGecen.serial_no) as Adet, SUM(IslemGecen.Ciro) as Ciro FROM (SELECT t.serial_no, SUM(bp.amount) as Ciro FROM odeal.BasePayment bp
JOIN odeal.TerminalPayment tp ON tp.id = bp.id
JOIN odeal.Terminal t ON t.id = tp.terminal_id
WHERE bp.currentStatus = 6 AND bp.amount > 1 AND bp.signedDate >= "2024-09-01 00:00:00" AND bp.signedDate <= "2024-09-30 23:59:59"
GROUP BY t.serial_no) as IslemGecen;


SELECT
   AylikTerminalAdet.Ay,
   AylikTerminalAdet.Adet,
   (@kumulatifToplam := @kumulatifToplam + AylikTerminalAdet.Adet) AS KumulatifToplam
FROM
   (SELECT
       DATE_FORMAT(t.firstActivationDate,'%Y-%m') AS Ay,
       COUNT(*) AS Adet
    FROM  odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
WHERE t.firstActivationDate <= LAST_DAY(CURDATE()- INTERVAL 1 MONTH) AND (s.cancelledAt IS NULL OR LAST_DAY(s.cancelledAt - INTERVAL 1 MONTH))
    GROUP  BY Ay
    ) AS AylikTerminalAdet
    JOIN (SELECT @kumulatifToplam:=0) r
    ORDER  BY Ay
    
    SELECT
   AylikCiro.Ay,
   AylikCiro.Ciro,
   (@KumulatifCiro := @KumulatifCiro + AylikCiro.Ciro) AS KumulatifToplam
FROM
   (SELECT
       DATE_FORMAT(bp.signedDate,'%Y-%m') AS Ay,
       SUM(bp.amount) AS Ciro
    FROM  odeal.BasePayment bp 
    JOIN odeal.Organisation o ON o.id = bp.organisationId AND o.demo = 0
    WHERE bp.currentStatus = 6 AND DATE_FORMAT(bp.signedDate,"%Y-%m-%d") <= DATE_FORMAT(CURDATE() , "%Y-%m-%d")
    GROUP  BY Ay
    ) AS AylikCiro
    JOIN (SELECT @KumulatifCiro:=0) r
    ORDER  BY Ay

SELECT "2023-08"  as Ay, COUNT(IslemGecen.serial_no) as Adet, SUM(IslemGecen.Ciro) as Ciro FROM (SELECT t.serial_no, SUM(bp.amount) as Ciro FROM odeal.BasePayment bp 
JOIN odeal.TerminalPayment tp ON tp.id = bp.id 
JOIN odeal.Terminal t ON t.id = tp.terminal_id 
WHERE bp.currentStatus = 6 AND bp.amount > 1 AND bp.signedDate >= "2023-08-01 00:00:00" AND bp.signedDate <= "2023-08-31 23:59:59"
GROUP BY t.serial_no) as IslemGecen
UNION
SELECT "2023-09"  as Ay, COUNT(IslemGecen.serial_no) as Adet, SUM(IslemGecen.Ciro) as Ciro FROM (SELECT t.serial_no, SUM(bp.amount) as Ciro FROM odeal.BasePayment bp 
JOIN odeal.TerminalPayment tp ON tp.id = bp.id 
JOIN odeal.Terminal t ON t.id = tp.terminal_id 
WHERE bp.currentStatus = 6 AND bp.amount > 1 AND bp.signedDate >= "2023-09-01 00:00:00" AND bp.signedDate <= "2023-09-30 23:59:59"
GROUP BY t.serial_no) as IslemGecen
UNION
SELECT "2023-10"  as Ay, COUNT(IslemGecen.serial_no) as Adet, SUM(IslemGecen.Ciro) as Ciro FROM (SELECT t.serial_no, SUM(bp.amount) as Ciro FROM odeal.BasePayment bp 
JOIN odeal.TerminalPayment tp ON tp.id = bp.id 
JOIN odeal.Terminal t ON t.id = tp.terminal_id 
WHERE bp.currentStatus = 6 AND bp.amount > 1 AND bp.signedDate >= "2023-10-01 00:00:00" AND bp.signedDate <= "2023-10-31 23:59:59"
GROUP BY t.serial_no) as IslemGecen
UNION
SELECT "2023-11"  as Ay, COUNT(IslemGecen.serial_no) as Adet, SUM(IslemGecen.Ciro) as Ciro FROM (SELECT t.serial_no, SUM(bp.amount) as Ciro FROM odeal.BasePayment bp 
JOIN odeal.TerminalPayment tp ON tp.id = bp.id 
JOIN odeal.Terminal t ON t.id = tp.terminal_id 
WHERE bp.currentStatus = 6 AND bp.amount > 1 AND bp.signedDate >= "2023-11-01 00:00:00" AND bp.signedDate <= "2023-11-30 23:59:59"
GROUP BY t.serial_no) as IslemGecen
UNION
SELECT "2023-12"  as Ay, COUNT(IslemGecen.serial_no) as Adet, SUM(IslemGecen.Ciro) as Ciro FROM (SELECT t.serial_no, SUM(bp.amount) as Ciro FROM odeal.BasePayment bp 
JOIN odeal.TerminalPayment tp ON tp.id = bp.id 
JOIN odeal.Terminal t ON t.id = tp.terminal_id 
WHERE bp.currentStatus = 6 AND bp.amount > 1 AND bp.signedDate >= "2023-12-01 00:00:00" AND bp.signedDate <= "2023-12-31 23:59:59"
GROUP BY t.serial_no) as IslemGecen
UNION
SELECT "2024-01"  as Ay, COUNT(IslemGecen.serial_no) as Adet, SUM(IslemGecen.Ciro) as Ciro FROM (SELECT t.serial_no, SUM(bp.amount) as Ciro FROM odeal.BasePayment bp 
JOIN odeal.TerminalPayment tp ON tp.id = bp.id 
JOIN odeal.Terminal t ON t.id = tp.terminal_id 
WHERE bp.currentStatus = 6 AND bp.amount > 1 AND bp.signedDate >= "2024-01-01 00:00:00" AND bp.signedDate <= "2024-01-31 23:59:59"
GROUP BY t.serial_no) as IslemGecen
    
UNION
SELECT "2024-04"  as Ay, COUNT(*) as Adet FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
WHERE t.firstActivationDate >= "2024-04-01 23:59:59" AND t.firstActivationDate <= "2024-04-30 23:59:59" AND (s.cancelledAt IS NULL OR s.cancelledAt > "2024-03-31 23:59:59")

SELECT COUNT(*) FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
WHERE t.firstActivationDate <= "2024-01-31 23:59:59" AND (s.cancelledAt IS NULL OR s.cancelledAt >= "2024-01-01 00:00:00") -- END OF PERIOD

SELECT COUNT(*) FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
WHERE t.firstActivationDate <= "2024-01-31 23:59:59" AND (s.cancelledAt IS NULL OR s.cancelledAt > "2024-01-31 23:59:59") -- NORMAL


SELECT s2.name as Hizmet, COUNT(t.id) as TerminalAdet FROM odeal.Terminal t 
JOIN subscription.Subscription s ON s.id = t.subscription_id 
JOIN subscription.Plan p ON p.id = s.planId 
JOIN subscription.Service s2 ON s2.id = p.serviceId 
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
WHERE t.terminalStatus = 1
GROUP BY s2.name

SELECT "2024-04"  as Ay, COUNT(*) as Adet FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
WHERE t.firstActivationDate <= "2024-04-30 23:59:59" AND t.terminalStatus = 1

SELECT s.merchant_id,
       s.terminal_id,
       t.serial_no,
       MAX(bp.appliedRate) as SonKomisyon,
       MAX(bp.signedDate) as SonIslemTarih,
       MAX(bp.id) as SonIslemID
FROM payout_source.source s
JOIN odeal.TerminalPayment tp ON tp.terminal_id = s.terminal_id
JOIN odeal.BasePayment bp ON bp.id = tp.id
JOIN odeal.Terminal t ON t.id = s.terminal_id
WHERE bp.currentStatus = 6 AND bp.signedDate >= DATE_FORMAT(DATE_SUB(s.request_date,INTERVAL 1 MONTH),"%Y-%m-01 00:00:00") AND bp.signedDate <= NOW()
GROUP BY s.merchant_id, s.terminal_id, t.serial_no;

SELECT m.phone as Telefon, CONCAT(m.firstName," ",m.LastName) as Yetkili, o.id as UyeID FROM odeal.Merchant m
JOIN odeal.Organisation o ON o.id = m.organisationId AND m.role = 0 AND o.demo = 0

SELECT DISTINCT t.organisation_id as UyeID, t.id as TerminalID, DATE(bp.signedDate) as IslemTarih, bp.appliedRate, CASE WHEN bp.appliedRate = 0 THEN '0 Komisyonlu Ciro' ELSE 'Diğer Ciro' END as KomisyonDurum,
                COUNT(bp.id) as IslemAdedi, SUM(bp.amount) as Ciro, bi.type as GeriOdeme, A.SonrakiTarih, s.request_date as FibaBasvuruTarihi, A.PlanName
FROM (SELECT *, IFNULL(LEAD(SH.OlusmaTarihi) OVER (PARTITION BY SH.terminalId ORDER BY SH.OlusmaTarihi),NOW()) as SonrakiTarih, p.name as PlanName
      FROM (
SELECT sh.terminalId,
       MIN(sh._createdDate) as OlusmaTarihi,
       MIN(sh.planId) as PlanID
FROM subscription.SubscriptionHistory sh
WHERE sh._createdDate >= '2024-05-01 00:00:00'
GROUP BY sh.terminalId, sh.planId) as SH
LEFT JOIN subscription.Plan p ON p.id = SH.PlanID) as A
JOIN odeal.Terminal t ON t.id = A.terminalId
LEFT JOIN payout_source.source s ON s.terminal_id = t.id AND s.type = 'FIBACARD'
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.paymentType IN (0,1,2,3,6,7,8)
AND bp.signedDate >= s.request_date AND bp.signedDate <= A.SonrakiTarih AND (bp.signedDate BETWEEN A.OlusmaTarihi AND A.SonrakiTarih)
LEFT JOIN odeal.Payback pay ON pay.id = bp.paybackId
LEFT JOIN odeal.BankInfo bi ON bi.id = pay.bankInfoId
WHERE bp.appliedRate IS NOT NULL AND A.terminalId IN (SELECT DISTINCT Kart.terminal_id FROM (
SELECT s.terminal_id, COUNT(*) FROM payout_source.source s
WHERE s.terminal_id IS NOT NULL AND s.type = 'FIBACARD'
GROUP BY s.terminal_id) as Kart) AND (bi.type = 'FIBACARD' OR bi.type = 'SEKERCARD' OR bi.type = 'IBAN')
GROUP BY t.organisation_id, t.id, bp.appliedRate, bi.type,
         DATE(bp.signedDate),
         CASE WHEN bp.appliedRate = 0 THEN '0 Komisyonlu Ciro' ELSE 'Diğer Ciro' END, A.SonrakiTarih, s.request_date, A.PlanName