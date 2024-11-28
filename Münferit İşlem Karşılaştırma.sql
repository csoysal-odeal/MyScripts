 -- CEPTEPOS Banka Taksit İşlem Dağılım
SELECT @Hafta_0_bit := "2024-04-19 10:10:47", 
@Hafta_0_bas := "2024-04-12 10:41:03",
@Hafta_1_bit := "2024-04-12 09:43:50", 
@Hafta_1_bas := "2024-04-05 10:14:05", 
@Hafta_2_bit := "2024-04-05 10:09:51",
@Hafta_2_bas := "2024-03-29 10:13:41",
@Hafta_3_bit := "2024-03-29 10:12:13",
@Hafta_3_bas := "2024-03-22 10:17:16", 
@Hafta_4_bit := "2024-03-22 10:10:34",
@Hafta_4_bas := "2024-03-15 10:13:20",
@Hafta_5_bit := "2024-03-15 10:08:38",
@Hafta_5_bas := "2024-03-08 10:12:54",
@Hafta_6_bit := "2024-03-08 10:04:40",
@Hafta_6_bas := "2024-03-01 10:17:12"

SELECT IslemAdet.Hizmet, IslemAdet.Banka, IslemAdet.Taksit, 
SUM(CASE WHEN IslemAdet.Hafta = "Hafta 0" THEN IslemAdet.Adet ELSE 0 END) as Hafta0_Adet,
SUM(CASE WHEN IslemAdet.Hafta = "Hafta 1" THEN IslemAdet.Adet ELSE 0 END) as Hafta1_Adet,
SUM(CASE WHEN IslemAdet.Hafta = "Hafta 2" THEN IslemAdet.Adet ELSE 0 END) as Hafta2_Adet,
SUM(CASE WHEN IslemAdet.Hafta = "Hafta 3" THEN IslemAdet.Adet ELSE 0 END) as Hafta3_Adet,
SUM(CASE WHEN IslemAdet.Hafta = "Hafta 4" THEN IslemAdet.Adet ELSE 0 END) as Hafta4_Adet,
SUM(CASE WHEN IslemAdet.Hafta = "Hafta 5" THEN IslemAdet.Adet ELSE 0 END) as Hafta5_Adet,
SUM(CASE WHEN IslemAdet.Hafta = "Hafta 6" THEN IslemAdet.Adet ELSE 0 END) as Hafta6_Adet 
FROM(
SELECT s.name as Hizmet, p2.name as Banka, p.installment as Taksit, "Hafta 0" as Hafta, COUNT(*) as Adet FROM odeal.BasePayment bp
LEFT JOIN odeal.Payment p ON p.id = bp.id
LEFT JOIN odeal.POS p2 on p2.id = bp.posId
LEFT JOIN subscription.Service s ON s.id = bp.serviceId
WHERE bp.serviceId = 3 AND p2.name IS NOT NULL 
AND bp.signedDate >= @Hafta_0_bas AND bp.signedDate <= @Hafta_0_bit
GROUP BY s.name, p.installment, p2.name
UNION
SELECT s.name as Hizmet, p2.name as Banka, p.installment as Taksit, "Hafta 1" as Hafta, COUNT(*) as Adet FROM odeal.BasePayment bp
LEFT JOIN odeal.Payment p ON p.id = bp.id
LEFT JOIN odeal.POS p2 on p2.id = bp.posId
LEFT JOIN subscription.Service s ON s.id = bp.serviceId
WHERE bp.serviceId = 3 AND p2.name IS NOT NULL  
AND bp.signedDate >= @Hafta_1_bas AND bp.signedDate <= @Hafta_1_bit
GROUP BY s.name, p.installment, p2.name
UNION
SELECT s.name as Hizmet, p2.name as Banka, p.installment as Taksit, "Hafta 2" as Hafta, COUNT(*) as Adet FROM odeal.BasePayment bp
LEFT JOIN odeal.Payment p ON p.id = bp.id
LEFT JOIN odeal.POS p2 on p2.id = bp.posId
LEFT JOIN subscription.Service s ON s.id = bp.serviceId
WHERE bp.serviceId = 3 AND p2.name IS NOT NULL 
AND bp.signedDate >= @Hafta_2_bas AND bp.signedDate <= @Hafta_2_bit
GROUP BY s.name, p.installment, p2.name
UNION
SELECT s.name as Hizmet, p2.name as Banka, p.installment as Taksit, "Hafta 3" as Hafta, COUNT(*) as Adet FROM odeal.BasePayment bp
LEFT JOIN odeal.Payment p ON p.id = bp.id
LEFT JOIN odeal.POS p2 on p2.id = bp.posId
LEFT JOIN subscription.Service s ON s.id = bp.serviceId
WHERE bp.serviceId = 3 AND p2.name IS NOT NULL  
AND bp.signedDate >= @Hafta_3_bas AND bp.signedDate <= @Hafta_3_bit
GROUP BY s.name, p.installment, p2.name
UNION
SELECT s.name as Hizmet, p2.name as Banka, p.installment as Taksit, "Hafta 4" as Hafta, COUNT(*) as Adet FROM odeal.BasePayment bp
LEFT JOIN odeal.Payment p ON p.id = bp.id
LEFT JOIN odeal.POS p2 on p2.id = bp.posId
LEFT JOIN subscription.Service s ON s.id = bp.serviceId
WHERE bp.serviceId = 3 AND p2.name IS NOT NULL  
AND bp.signedDate >= @Hafta_4_bas AND bp.signedDate <= @Hafta_4_bit
GROUP BY s.name, p.installment, p2.name
UNION
SELECT s.name as Hizmet, p2.name as Banka, p.installment as Taksit, "Hafta 5" as Hafta, COUNT(*) as Adet FROM odeal.BasePayment bp
LEFT JOIN odeal.Payment p ON p.id = bp.id
LEFT JOIN odeal.POS p2 on p2.id = bp.posId
LEFT JOIN subscription.Service s ON s.id = bp.serviceId
WHERE bp.serviceId = 3 AND p2.name IS NOT NULL 
AND bp.signedDate >= @Hafta_5_bas AND bp.signedDate <= @Hafta_5_bit
GROUP BY s.name, p.installment, p2.name
UNION
SELECT s.name as Hizmet, p2.name as Banka, p.installment as Taksit, "Hafta 6" as Hafta, COUNT(*) as Adet FROM odeal.BasePayment bp
LEFT JOIN odeal.Payment p ON p.id = bp.id
LEFT JOIN odeal.POS p2 on p2.id = bp.posId
LEFT JOIN subscription.Service s ON s.id = bp.serviceId
WHERE bp.serviceId = 3 AND p2.name IS NOT NULL 
AND bp.signedDate >= @Hafta_6_bas AND bp.signedDate <= @Hafta_6_bit
GROUP BY s.name, p.installment, p2.name) IslemAdet
GROUP BY IslemAdet.Hizmet, IslemAdet.Banka, IslemAdet.Taksit




 -- FİZİKİ (OKC) Banka Taksit İşlem Dağılım
SELECT 
@02Hafta_0_bit := "2024-02-29 07:11:07", 
@02Hafta_0_bas := "2024-02-22 07:19:00",


@02Hafta_1_bit := "2024-05-08 15:19:00", 
@02Hafta_1_bas := "2024-05-01 15:23:22", 
@02Hafta_2_bit := "2024-05-01 15:17:00",
@02Hafta_2_bas := "2024-04-24 15:21:00",
@02Hafta_3_bit := "2024-04-24 15:20:29",
@02Hafta_3_bas := "2024-04-17 15:20:32", 
@02Hafta_4_bit := "2024-04-17 15:20:29",
@02Hafta_4_bas := "2024-04-10 15:20:46",
@02Hafta_5_bit := "2024-04-10 15:20:24",
@02Hafta_5_bas := "2024-04-03 15:20:32",
@02Hafta_6_bit := "2024-04-03 15:20:19",
@02Hafta_6_bas := "2024-03-27 15:20:33"

SELECT IslemAdet.Hizmet, IslemAdet.Banka, IslemAdet.Taksit, IslemAdet.posId,
SUM(CASE WHEN IslemAdet.Hafta = "Hafta 0" THEN IslemAdet.Adet ELSE 0 END) as Hafta0_Adet,
SUM(CASE WHEN IslemAdet.Hafta = "Hafta 1" THEN IslemAdet.Adet ELSE 0 END) as Hafta1_Adet,
SUM(CASE WHEN IslemAdet.Hafta = "Hafta 2" THEN IslemAdet.Adet ELSE 0 END) as Hafta2_Adet,
SUM(CASE WHEN IslemAdet.Hafta = "Hafta 3" THEN IslemAdet.Adet ELSE 0 END) as Hafta3_Adet,
SUM(CASE WHEN IslemAdet.Hafta = "Hafta 4" THEN IslemAdet.Adet ELSE 0 END) as Hafta4_Adet,
SUM(CASE WHEN IslemAdet.Hafta = "Hafta 5" THEN IslemAdet.Adet ELSE 0 END) as Hafta5_Adet,
SUM(CASE WHEN IslemAdet.Hafta = "Hafta 6" THEN IslemAdet.Adet ELSE 0 END) as Hafta6_Adet 
FROM(
SELECT s.name as Hizmet, p2.name as Banka,bp.posId, tp.installment as Taksit, "Hafta 0" as Hafta, COUNT(*) as Adet FROM odeal.BasePayment bp
LEFT JOIN odeal.TerminalPayment tp ON tp.id = bp.id
LEFT JOIN odeal.POS p2 on p2.id = bp.posId
LEFT JOIN subscription.Service s ON s.id = bp.serviceId
WHERE bp.serviceId = 2 AND p2.name IS NOT NULL AND tp.installment = 1 AND bp.posId = 129
AND bp.signedDate >= @02Hafta_0_bas AND bp.signedDate <= @02Hafta_0_bit
GROUP BY s.name, tp.installment, p2.name, bp.posId
UNION
SELECT s.name as Hizmet, p2.name as Banka,bp.posId, tp.installment as Taksit, "Hafta 1" as Hafta, COUNT(*) as Adet FROM odeal.BasePayment bp
LEFT JOIN odeal.TerminalPayment tp ON tp.id = bp.id
LEFT JOIN odeal.POS p2 on p2.id = bp.posId
LEFT JOIN subscription.Service s ON s.id = bp.serviceId
WHERE bp.serviceId = 2 AND p2.name IS NOT NULL AND tp.installment = 1 AND bp.posId = 129
AND bp.signedDate >= @02Hafta_1_bas AND bp.signedDate <= @02Hafta_1_bit
GROUP BY s.name, tp.installment, p2.name, bp.posId
UNION
SELECT s.name as Hizmet, p2.name as Banka,bp.posId, tp.installment as Taksit, "Hafta 2" as Hafta, COUNT(*) as Adet FROM odeal.BasePayment bp
LEFT JOIN odeal.TerminalPayment tp ON tp.id = bp.id
LEFT JOIN odeal.POS p2 on p2.id = bp.posId
LEFT JOIN subscription.Service s ON s.id = bp.serviceId
WHERE bp.serviceId = 2 AND p2.name IS NOT NULL AND tp.installment = 1 AND bp.posId = 129
AND bp.signedDate >= @02Hafta_2_bas AND bp.signedDate <= @02Hafta_2_bit
GROUP BY s.name, tp.installment, p2.name, bp.posId
UNION 
SELECT s.name as Hizmet, p2.name as Banka,bp.posId, tp.installment as Taksit, "Hafta 3" as Hafta, COUNT(*) as Adet FROM odeal.BasePayment bp
LEFT JOIN odeal.TerminalPayment tp ON tp.id = bp.id
LEFT JOIN odeal.POS p2 on p2.id = bp.posId
LEFT JOIN subscription.Service s ON s.id = bp.serviceId
WHERE bp.serviceId = 2 AND p2.name IS NOT NULL AND tp.installment = 1 AND bp.posId = 129
AND bp.signedDate >= @02Hafta_3_bas AND bp.signedDate <= @02Hafta_3_bit
GROUP BY s.name, tp.installment, p2.name, bp.posId
UNION
SELECT s.name as Hizmet, p2.name as Banka, bp.posId,tp.installment as Taksit, "Hafta 4" as Hafta, COUNT(*) as Adet FROM odeal.BasePayment bp
LEFT JOIN odeal.TerminalPayment tp ON tp.id = bp.id
LEFT JOIN odeal.POS p2 on p2.id = bp.posId
LEFT JOIN subscription.Service s ON s.id = bp.serviceId
WHERE bp.serviceId = 2 AND p2.name IS NOT NULL AND tp.installment = 1 AND bp.posId = 129
AND bp.signedDate >= @02Hafta_4_bas AND bp.signedDate <= @02Hafta_4_bit
GROUP BY s.name, tp.installment, p2.name, bp.posId
UNION 
SELECT s.name as Hizmet, p2.name as Banka,bp.posId, tp.installment as Taksit, "Hafta 5" as Hafta, COUNT(*) as Adet FROM odeal.BasePayment bp
LEFT JOIN odeal.TerminalPayment tp ON tp.id = bp.id
LEFT JOIN odeal.POS p2 on p2.id = bp.posId
LEFT JOIN subscription.Service s ON s.id = bp.serviceId
WHERE bp.serviceId = 2 AND p2.name IS NOT NULL AND tp.installment = 1 AND bp.posId = 129
AND bp.signedDate >= @02Hafta_5_bas AND bp.signedDate <= @02Hafta_5_bit
GROUP BY s.name, tp.installment, p2.name, bp.posId
UNION 
SELECT s.name as Hizmet, p2.name as Banka, bp.posId, tp.installment as Taksit, "Hafta 6" as Hafta, COUNT(*) as Adet FROM odeal.BasePayment bp
LEFT JOIN odeal.TerminalPayment tp ON tp.id = bp.id
LEFT JOIN odeal.POS p2 on p2.id = bp.posId
LEFT JOIN subscription.Service s ON s.id = bp.serviceId
WHERE bp.serviceId = 2 AND p2.name IS NOT NULL AND tp.installment = 1 AND bp.posId = 129
AND bp.signedDate >= @02Hafta_6_bas AND bp.signedDate <= @02Hafta_6_bit
GROUP BY s.name, tp.installment, p2.name, bp.posId) IslemAdet
GROUP BY IslemAdet.Hizmet, IslemAdet.Banka, IslemAdet.Taksit, IslemAdet.posId

SELECT * FROM (
SELECT bp.organisationId as UyeID, SUM(bp.amount) as Ciro, COUNT(bp.id) as Adet,
bp.organisationId as SerialNo
 FROM odeal.BasePayment bp
JOIN (SELECT * FROM subscription.Subscription s WHERE s.id IN (
SELECT MAX(s.id) FROM odeal.Organisation o 
JOIN subscription.Subscription s ON s.organisationId = o.id
JOIN subscription.Plan p ON p.id = s.planId AND p.serviceId = 3
GROUP BY o.id)) as Abonelik ON Abonelik.organisationId = bp.organisationId
JOIN subscription.Plan p ON p.id = Abonelik.planId
LEFT JOIN odeal.Payment p2 ON p2.id = bp.id
LEFT JOIN odeal.Channel c2 ON c2.id = Abonelik.channelId
WHERE bp.currentStatus = 6 AND bp.paymentType <> 4 AND bp.serviceId = 3 AND bp.signedDate >= "2023-01-01 00:00:00" AND
bp.signedDate <= "2023-01-31 23:59:59"
UNION
SELECT bp.organisationId as UyeID, SUM(bp.amount) as Ciro, COUNT(bp.id) as Adet,
t.serial_no as SerialNo
 FROM odeal.BasePayment bp
LEFT JOIN odeal.TerminalPayment tp ON tp.id = bp.id
LEFT JOIN odeal.Terminal t ON t.id = tp.terminal_id
LEFT JOIN subscription.Subscription s ON s.id = t.subscription_id
LEFT JOIN subscription.Plan p ON p.id = s.planId
LEFT JOIN odeal.Channel c2 ON c2.id = t.channelId
WHERE bp.currentStatus = 6 AND bp.paymentType <> 4 AND bp.serviceId <>3 AND bp.signedDate >= "2023-01-01 00:00:00" AND
bp.signedDate <= "2023-01-31 23:59:59"
) as Islemler
GROUP BY Islemler.UyeID, Islemler.SerialNo

SELECT DATE(OdealKart.firstActivationDate) AS TerminalAktivasyonGun, 
DATE(OdealKart.activationDate) AS AbonelikAktivasyonGun, 
DATE(OdealKart.cancelledAt) AS AbonelikCancelGun, 
IF(OdealKart.terminalStatus=1,"Aktif","Pasif") AS TerminalDurum,
OdealKart.status AS KartStatu,
OdealKart.merchant_id,
OdealKart.serial_no,
OdealKart.GeriOdemeTipi,
OdealKart.iban,
MAX(OdealKart.IslemAdet) AS IslemAdet,
MAX(OdealKart.Ciro) AS Ciro
FROM (
SELECT s.status, s.merchant_id, t.serial_no, t.terminalStatus, t.firstActivationDate, bi.TYPE AS GeriOdemeTipi, bi.iban, sub.activationDate, sub.cancelledAt, SUM(bp.amount) AS Ciro, COUNT(bp.id) AS IslemAdet FROM payout_source.source s
JOIN odeal.Terminal t ON t.id = s.terminal_id
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.amount > 1 AND bp.paymentType <> 4 
AND bp.signedDate >= DATE_SUB(CURDATE(), INTERVAL 1 MONTH)
AND bp.signedDate < NOW()
JOIN subscription.Subscription sub ON sub.id = t.subscription_id
JOIN odeal.BankInfo bi ON bi.id = t.bankInfoId
GROUP BY s.status, s.merchant_id, t.serial_no, t.terminalStatus, t.firstActivationDate, bi.TYPE, bi.iban, sub.activationDate, sub.cancelledAt
) AS OdealKart
WHERE DATE(OdealKart.firstActivationDate) = "2024-05-13"
GROUP BY DATE(OdealKart.firstActivationDate), DATE(OdealKart.activationDate), 
DATE(OdealKart.cancelledAt), IF(OdealKart.terminalStatus=1,"Aktif","Pasif"), OdealKart.merchant_id, OdealKart.status, OdealKart.serial_no, OdealKart.GeriOdemeTipi, OdealKart.iban
ORDER BY DATE(OdealKart.firstActivationDate) DESC

SELECT t.id, t.serial_no, bi.iban, bi.`type` FROM odeal.Terminal t 
JOIN odeal.BankInfo bi ON bi.id = t.bankInfoId
WHERE t.serial_no = "2C15735389"



SELECT o.id, o.marka, o.unvan, s.* FROM payout_source.source s 
LEFT JOIN odeal.Organisation o ON o.id = s.merchant_id AND o.demo = 0
WHERE s.`type` = "FIBACARD"

SELECT * FROM payout_source.source_history sh
WHERE sh.record_id = "2j0l78lw66pmoi00";

SELECT * FROM subscription.Subscription s

SELECT DISTINCT o.id AS UyeID, IF(o.isActivated=1,"Aktif","Pasif") AS UyeDurum, COUNT(bp.id) AS IslemAdet, SUM(bp.amount) AS Ciro, MAX(bp.signedDate) AS SonIslemTarihi  FROM odeal.Organisation o 
JOIN subscription.Subscription s ON s.organisationId = o.id AND s.status = 1
JOIN subscription.Plan p ON p.id = s.planId 
LEFT JOIN odeal.BasePayment bp ON bp.organisationId = o.id AND bp.currentStatus = 6 AND bp.serviceId = 3
WHERE p.serviceId = 3 AND o.isActivated = 1 AND o.demo = 0
GROUP BY o.id

SELECT bp.organisationId, bp.id, bp.signedDate, bp.paymentType, bp.amount, bp.serviceId, p.name, t.serial_no FROM odeal.BasePayment bp 
LEFT JOIN odeal.POS p ON p.id = bp.posId
LEFT JOIN odeal.TerminalPayment tp ON tp.id = bp.id
LEFT JOIN odeal.Terminal t ON t.id = tp.terminal_id
WHERE bp.currentStatus = 6 AND bp.serviceId = 2 AND bp.organisationId = 301260432;

SELECT * FROM odeal.TerminalPayment tp WHERE tp.id IN (688732494,
688735282,
688745272,
688745471,688930428,688951316)

SELECT o.id, t.serial_no FROM odeal.Organisation o 
LEFT JOIN odeal.Terminal t ON t.organisation_id = o.id WHERE o.id = 301260432

SELECT o.id, c2.name AS UyeKanal, t.serial_no, c.name AS TerminalKanal, SUM(bp.amount) AS Ciro, 
COUNT(bp.id) AS IslemAdet, MIN(bp.signedDate) AS IlkIslemTarihi,
MAX(bp.signedDate) AS SonIslemTarihi FROM odeal.Organisation o
JOIN odeal.Terminal t ON t.organisation_id = o.id
LEFT JOIN odeal.Channel c ON c.id = t.channelId 
LEFT JOIN odeal.Channel c2 ON c2.id = o.channelId
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id 
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6
WHERE o.id IN (301241093,301263800,301263787,301231920,301234506,301234509,301234512,301235330,301211523,
301263789,301226670,301238090,301242821,301232205,301231893,301263375,301237802,301031339,301227702)
GROUP BY o.id, c2.name, t.serial_no, c.name;

   SELECT bp.paymentId AS 'Ödeme Id', 
t.serial_no AS 'Mali No', 
o.unvan AS 'Üye İşYeri', 
o.id AS 'Üye İşyeri Id', 
CONCAT(m.firstName,' ',m.LastName) AS 'İlgili Kişi', 
bp.amount AS 'Miktar', 
bp.appliedRate AS 'Komisyon Oranı', 
bp.signedDate AS 'İşlem Tarihi', 
p.paybackId AS 'Geri Ödeme Id',
bp.paybackAmount AS 'Geri Ödeme Miktarı', 
(CASE 
WHEN p.status=0 THEN 'Ödendi'
END) AS 'Geri Ödeme Durumu', 
p.dueDate AS 'Geri ödeme Tarihi',
tp.installment AS 'Taksit', 
(CASE 
WHEN bp.currentStatus=6 THEN 'Başarılı'
END) AS 'Durumu',
'Terminal Ödemesi' AS 'Ödeme Tipi',
cc.bank AS 'Kart Bankası',
bp.cardNumber AS 'Kart Numarası'
FROM odeal.BasePayment bp
JOIN odeal.TerminalPayment tp on tp.id = bp.id
JOIN odeal.Terminal t on t.id = tp.terminal_id
JOIN odeal.Organisation o ON o.id = bp.organisationId
JOIN odeal.Payback p ON p.id = bp.paybackId
JOIN odeal.Merchant m ON m.organisationId = o.id
JOIN odeal.CreditCard cc ON cc.id = bp.cardId 
WHERE t.channelId = 313
AND bp.signedDate > DATE(DATE_SUB(now(), INTERVAL 1 DAY)) 
AND bp.currentStatus = 6
AND m.`role` = 0
ORDER BY bp.id DESC;

SELECT bp.paybackId, SUM(bp.amount) FROM odeal.BasePayment bp WHERE bp.paybackId = 46535458

SELECT * FROM odeal.Payback p WHERE p.paybackId = "86782394395"

SELECT * FROM odeal.Payback p WHERE p.id = 46535458

SELECT t.serial_no, c.name, c2.name FROM odeal.Terminal t 
JOIN odeal.Organisation o ON o.id = t.organisation_id
LEFT JOIN odeal.Channel c ON c.id = t.channelId 
LEFT JOIN odeal.Channel c2 ON c2.id = o.channelId
WHERE t.serial_no = "PAX710051359"

SELECT * FROM subscription.Subscription s 

SELECT o.id, t.serial_no, t.terminalStatus, t.`_lastModifiedDate`, s.`_lastModifiedDate`, t.usageStatus,s.id, 
CASE WHEN s.status = 0 THEN "PASİF"
WHEN s.status = 1 THEN "AKTİF"
WHEN s.status = 2 THEN "ARŞİVLENDİ"
WHEN s.status = 3 THEN "DONDURULDU"
WHEN s.status = 4 THEN "İPTAL"
WHEN s.status = 5 THEN "KAPATILDI"
WHEN s.status = 6 THEN "UZATILDI"
WHEN s.status = 7 THEN "SİLİNDİ" END AS AbonelikDurum
FROM odeal.Organisation o 
JOIN odeal.Terminal t ON t.organisation_id = o.id
LEFT JOIN subscription.Subscription s ON s.id = t.subscription_id
WHERE t.usageStatus = 0 AND o.demo = 0 AND s.status = 0

SELECT bp.organisationId, COUNT(bp.id) AS IslemAdet, SUM(bp.amount) AS Ciro FROM odeal.BasePayment bp WHERE bp.organisationId = 301132665
AND bp.currentStatus = 6 AND bp.signedDate >= "2024-04-01 00:00:00" AND bp.signedDate <= "2024-04-30 23:59:59";


SELECT tmmh.merchant_id, tmmh.serial_no, CONCAT(tmmh.mid,"-",tmmh.tid,"-",CONVERT(tmmh.acquiring_id, UNSIGNED)) AS BankId, tmmh.physical_serial_no, b.name FROM odeal.TerminalMerchantMappingHistory tmmh 
JOIN odeal.Bank b ON b.bankCode = tmmh.acquiring_id 
WHERE tmmh.id IN (
SELECT MAX(tmmh.id) FROM odeal.TerminalMerchantMappingHistory tmmh 
JOIN odeal.Bank b ON b.bankCode = tmmh.acquiring_id
WHERE tmmh.state = "ACTIVE" AND tmmh.status = "ACTIVE"
GROUP BY tmmh.merchant_id, tmmh.serial_no, tmmh.mid, tmmh.tid, tmmh.acquiring_id, tmmh.physical_serial_no) AND tmmh.merchant_id = 301041702 AND tmmh.serial_no = "BCJ00018980" ;

SELECT br.transaction_date, br.installment, br.gross_amount, br.bank_commission_rate, CONCAT(br.bank_merchant_id,"-", br.pos_merchant_id,"-", CONVERT(br.holder_bank_code, UNSIGNED)) AS BankID, br.unique_key
FROM paymatch.bank_report br WHERE br.transaction_date > "2024-05-27 00:00:00" AND br.unique_key = "20240527:4943:7864:970527:14500" ;

-- Karşılaştırma
SELECT t.serial_no, bp.organisationId, bp.posId, p.name AS Bank, tp.installment,bp.id, bp.signedDate, bp.uniqueKey, p.bank_id, bp.amount, BankReport.transaction_date, BankReport.valor_date, BankReport.created_date, BankReport.gross_amount, 
BankReport.bank_merchant_id, BankReport.pos_merchant_id, BankReport.installment, BankReport.BankID, Cihaz.mid, Cihaz.tid, Cihaz.BankId
FROM odeal.BasePayment bp 
JOIN odeal.TerminalPayment tp ON tp.id = bp.id 
JOIN odeal.Terminal t ON t.id = tp.terminal_id
JOIN odeal.POS p ON p.id = bp.posId
LEFT JOIN (SELECT br.transaction_date, br.valor_date, br.created_date, br.installment, br.gross_amount, br.bank_commission_rate, br.bank_merchant_id,br.pos_merchant_id,CONVERT(br.holder_bank_code, UNSIGNED) AS BankID, br.unique_key
FROM paymatch.bank_report br 
WHERE br.valor_date >= DATE_FORMAT(DATE_SUB(CURDATE(),INTERVAL 1 WEEK),"%Y-%m-%d 00:00:00") + INTERVAL 1 DAY
AND br.valor_date <= DATE_FORMAT(DATE_SUB(CURDATE(),INTERVAL 1 WEEK),"%Y-%m-%d 23:59:59") + INTERVAL 3 DAY) AS BankReport 
ON BankReport.unique_key = bp.uniqueKey
LEFT JOIN (SELECT tmmh.merchant_id, tmmh.serial_no, tmmh.mid,tmmh.tid, CONVERT(tmmh.acquiring_id, UNSIGNED) AS BankId, tmmh.physical_serial_no, b.name FROM odeal.TerminalMerchantMappingHistory tmmh 
JOIN odeal.Bank b ON b.bankCode = tmmh.acquiring_id 
WHERE tmmh.id IN (
SELECT MAX(tmmh.id) FROM odeal.TerminalMerchantMappingHistory tmmh 
JOIN odeal.Bank b ON b.bankCode = tmmh.acquiring_id
WHERE tmmh.state = "ACTIVE" AND tmmh.status = "ACTIVE"
GROUP BY tmmh.merchant_id, tmmh.serial_no, tmmh.mid, tmmh.tid, tmmh.acquiring_id, tmmh.physical_serial_no)) AS Cihaz 
ON Cihaz.mid = BankReport.bank_merchant_id AND Cihaz.tid = BankReport.pos_merchant_id AND Cihaz.BankId = BankReport.BankID
WHERE bp.signedDate >= DATE_FORMAT(DATE_SUB(CURDATE(),INTERVAL 1 WEEK),"%Y-%m-%d 00:00:00") AND bp.signedDate <= DATE_FORMAT(DATE_SUB(CURDATE(),INTERVAL 1 WEEK),"%Y-%m-%d 23:59:59") AND bp.organisationId = 301198616;


SELECT bp.id, bp.signedDate, bp.organisationId, bp.uniqueKey, bp.amount, br.id FROM odeal.BasePayment bp 
LEFT JOIN paymatch.bank_report br ON br.unique_key = bp.uniqueKey
WHERE bp.currentStatus = 6 AND bp.paymentType IN (0,1,2,3,7,8) AND bp.signedDate >= DATE_SUB(CURDATE(),INTERVAL 1 DAY) AND bp.signedDate < CURDATE()

SELECT br.id, br.transaction_date, br.created_date, br.valor_date, bp.id,bp.signedDate, bp.organisationId, bp.uniqueKey, br.unique_key FROM paymatch.bank_report br
JOIN odeal.BasePayment bp ON bp.uniqueKey = br.unique_key
WHERE br.unique_key = "20240516:5549:0050:856388:2220000";

000000002135606-01174999-12 - 000000002135606-01174999-12

301187024	PAX710013089	983100139490000	PS108541	0135	6M563888

20240527:4943:7864:970527:14500



SELECT DATE_FORMAT(DATE_SUB(CURDATE(),INTERVAL 12 DAY),"%Y-%m-%d 23:59:59");

SELECT @setTarihBit := "2024-05-24 23:59:59";

SELECT @setTarihBit + INTERVAL 3 DAY;

SELECT @setTarihBit + INTERVAL 1 DAY;


SELECT * FROM odeal.BasePayment bp 
WHERE bp.organisationId = 301187024

SELECT tmmh.mid, tmmh.tid, tmmh.acquiring_id  FROM odeal.TerminalMerchantMappingHistory tmmh 
WHERE tmmh.merchant_id = 301262723 AND tmmh.state = "ACTIVE" AND tmmh.status = "ACTIVE"

SELECT * FROM odeal.BankInfo bi

SELECT p.name, p.commissionRates, COUNT(*) FROM subscription.Plan p 
GROUP BY p.name, p.commissionRates

SELECT * FROM subscription.Subscription s 
JOIN subscription.Plan p ON p.id = s.planId WHERE s.id = 910650

SELECT * FROM odeal.InstallmentRule ir WHERE ir.organisationId = 301262723

SELECT DATE(OdealKart.firstActivationDate) AS TerminalAktivasyonGun,
DATE(OdealKart.activationDate) AS AbonelikAktivasyonGun,
DATE(OdealKart.cancelledAt) AS AbonelikCancelGun,
IF(OdealKart.terminalStatus=1,"Aktif","Pasif") AS TerminalDurum,
OdealKart.status AS KartStatu,
OdealKart.merchant_id,
OdealKart.serial_no,
OdealKart.GeriOdemeTipi,
OdealKart.iban,
OdealKart.bank,
MAX(OdealKart.IslemAdet) AS IslemAdet,
MAX(OdealKart.Ciro) AS Ciro
FROM (
SELECT s.status, s.merchant_id, t.serial_no, t.terminalStatus, t.firstActivationDate, bi.TYPE AS GeriOdemeTipi, bi.iban, bi.bank ,sub.activationDate, sub.cancelledAt, SUM(bp.amount) AS Ciro, COUNT(bp.id) AS IslemAdet FROM payout_source.source s
JOIN odeal.Terminal t ON t.id = s.terminal_id
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.amount > 1 AND bp.paymentType <> 4
AND bp.signedDate >= DATE_SUB(CURDATE(), INTERVAL 1 MONTH)
AND bp.signedDate <= NOW()
JOIN subscription.Subscription sub ON sub.id = t.subscription_id
JOIN odeal.BankInfo bi ON bi.id = t.bankInfoId
GROUP BY s.status, s.merchant_id, t.serial_no, t.terminalStatus, t.firstActivationDate, bi.TYPE, bi.iban, bi.bank, sub.activationDate, sub.cancelledAt
) AS OdealKart
WHERE DATE(OdealKart.firstActivationDate) >= "2024-05-01" AND OdealKart.status = "ACTIVATED"
GROUP BY DATE(OdealKart.firstActivationDate), DATE(OdealKart.activationDate),
DATE(OdealKart.cancelledAt), IF(OdealKart.terminalStatus=1,"Aktif","Pasif"), OdealKart.merchant_id, OdealKart.status, OdealKart.serial_no, OdealKart.GeriOdemeTipi, OdealKart.iban, OdealKart.bank
ORDER BY DATE(OdealKart.firstActivationDate) DESC
