SELECT Islemler.organisationId, Islemler.Durum, 
CASE WHEN DAYNAME(Islemler.Tarih)="Saturday" THEN "Haftasonu"
WHEN DAYNAME(Islemler.Tarih)="Sunday" THEN "Haftasonu" 
ELSE "Haftaiçi" END as Gun, 
SUM(Islemler.ToplamTutar) as IslemTutar, SUM(Islemler.IslemAdet) as IslemAdet FROM (
SELECT  bp.organisationId, IF((CASE WHEN HOUR(bp.signedDate) >= 21 AND HOUR(bp.signedDate) <= 23 THEN 1
WHEN HOUR(bp.signedDate) >= 0 AND HOUR(bp.signedDate) <= 6 THEN 1 ELSE 0 END)=1,"GECE","GUNDUZ") as Durum,
STR_TO_DATE(CONCAT(YEAR(bp.signedDate),"-",MONTH(bp.signedDate),"-",DAY(bp.signedDate)," ",HOUR(bp.signedDate)),"%Y-%m-%d %H:%i:%s") as Tarih, YEAR(bp.signedDate) as Yil, MONTH(bp.signedDate) as Ay, DAY(bp.signedDate) as Gun, 
HOUR(bp.signedDate) as Saat, SUM(bp.amount) as ToplamTutar, COUNT(bp.id) as IslemAdet FROM odeal.BasePayment bp 
WHERE bp.currentStatus = 6 AND bp.paymentType <> 4 AND bp.signedDate >= "2024-04-08 00:00:00" AND bp.signedDate < "2024-04-22 00:00:00" AND bp.organisationId IS NOT NULL AND bp.organisationId = 301000177
GROUP BY bp.organisationId, IF((CASE WHEN HOUR(bp.signedDate) >= 21 AND HOUR(bp.signedDate) <= 23 THEN 1
WHEN HOUR(bp.signedDate) >= 0 AND HOUR(bp.signedDate) <= 6 THEN 1 ELSE 0 END)=1,"GECE","GUNDUZ"), 
STR_TO_DATE(CONCAT(YEAR(bp.signedDate),"-",MONTH(bp.signedDate),"-",DAY(bp.signedDate)," ",HOUR(bp.signedDate)),"%Y-%m-%d %H:%i:%s"), YEAR(bp.signedDate), MONTH(bp.signedDate), DAY(bp.signedDate), HOUR(bp.signedDate)) as Islemler
GROUP BY Islemler.organisationId, CASE WHEN DAYNAME(Islemler.Tarih)="Saturday" THEN "Haftasonu"
WHEN DAYNAME(Islemler.Tarih)="Sunday" THEN "Haftasonu" 
ELSE "Haftaiçi" END, Islemler.Durum

SELECT Islemler.organisationId, Islemler.50TLKATLARI, Islemler.Diger, Islemler.Toplam, (Islemler.50TLKATLARI/Islemler.Toplam) as Oran FROM (
SELECT Katlar.organisationId, SUM(Katlar.amount) as Toplam, SUM(CASE WHEN Katlar.IslemTur = "DİĞER" THEN Katlar.amount END) as Diger, SUM(CASE WHEN Katlar.IslemTur = "50 TL KATLARI" THEN Katlar.amount END) as 50TLKATLARI  FROM (
SELECT bp.organisationId, IF(MOD(bp.amount,50)=0,"50 TL KATLARI","DİĞER") as IslemTur, bp.amount FROM odeal.BasePayment bp 
WHERE bp.currentStatus = 6 AND bp.signedDate >= "2024-03-01 00:00:00" AND bp.signedDate < NOW()) as Katlar
GROUP BY Katlar.organisationId) as Islemler
WHERE Islemler.organisationId = 301176419

SELECT * FROM odeal.Merchant m 

SELECT o.id, bi.bank, bi.status, bi.iban FROM odeal.Organisation o 
LEFT JOIN odeal.BankInfo bi ON bi.organisationId = o.id
WHERE o.id = 301000019

SELECT o.id, bi.bank, bi.status, bi.iban FROM odeal.Organisation o 
LEFT JOIN odeal.Terminal t ON t.organisation_id = o.id
LEFT JOIN odeal.BankInfo bi ON bi.id = t.bankInfoId
WHERE o.id = 301000019


SELECT o.id, p.serviceId,  FROM odeal.Organisation o 
JOIN subscription.Subscription s ON s.organisationId = o.id AND s.status = 1
JOIN subscription.Plan p ON p.id = s.planId
WHERE o.id = 301000019

SELECT * FROM odeal.Terminal t 
WHERE t.organisation_id = 301000019

SELECT * FROM information_schema.COLUMNS c
WHERE c.COLUMN_NAME LIKE "%mernis%"

SELECT Iban.organisationId, Iban.`type`, Seker.organisationId, Seker.`type` FROM
(SELECT bi.organisationId, bi.`type`FROM odeal.BankInfo bi WHERE bi.`type` = "IBAN" AND bi.status = 1) as Iban
LEFT JOIN (SELECT * FROM odeal.BankInfo bi WHERE bi.`type` = "SEKERCARD" AND bi.status = 1) as Seker ON Seker.organisationId = Iban.organisationId

SELECT * FROM odeal.Payback p 

SELECT * FROM odeal.BankInfo bi WHERE bi.`type` = "IBAN" AND bi.status = 1 AND bi.id IN (
SELECT bi.id FROM odeal.BankInfo bi WHERE bi.`type` = "SEKERCARD" AND bi.status = 1)

SELECT * FROM odeal.BankInfo bi WHERE bi.`type` = "SEKERCARD" AND bi.status = 1 AND bi.id IN (SELECT bi.id FROM odeal.BankInfo bi WHERE bi.`type` = "IBAN" AND bi.status = 1)


-- İşlemlerinin % 75 i haftasonu gerçekleşen işletmeler
SELECT DISTINCT UyeIsyeri.UyeIsyeriID, FORMAT(((UyeIsyeri.ToplamHaftaSonu/UyeIsyeri.ToplamIslemAdet)-1)*-1,2) as Yuzdelik FROM (
SELECT *, 
COUNT(CASE WHEN Islemler.Gunduz_Gece = "Gündüz" THEN Islemler.id END) OVER (PARTITION BY Islemler.UyeIsyeriID) as ToplamGunduz,
COUNT(CASE WHEN Islemler.Gunduz_Gece = "Gece" THEN Islemler.id END) OVER (PARTITION BY Islemler.UyeIsyeriID) as ToplamGece,
COUNT(CASE WHEN Islemler.Haftaici_Haftasonu = "Hafta Sonu" THEN Islemler.id END) OVER (PARTITION BY Islemler.UyeIsyeriID) as ToplamHaftaSonu,
COUNT(CASE WHEN Islemler.Haftaici_Haftasonu = "Hafta İçi" THEN Islemler.id END) OVER (PARTITION BY Islemler.UyeIsyeriID) as ToplamHaftaIci,
COUNT(Islemler.id) OVER (PARTITION BY Islemler.UyeIsyeriID) as ToplamIslemAdet
FROM (
 SELECT o.id as UyeIsyeriID,
       o.marka as Marka,
       bp.id,
       bp.signedDate as IslemTarihi,
       bp.amount as IslemTutar,
       CASE WHEN EXTRACT(HOUR FROM bp.signedDate) BETWEEN 6 AND 20 AND EXTRACT(MINUTE FROM bp.signedDate) BETWEEN 0 AND 59 THEN "Gündüz" ELSE "Gece" END as Gunduz_Gece,
       CASE WHEN DAYOFWEEK(bp.signedDate) IN (1,7) THEN "Hafta Sonu" ELSE "Hafta İçi" END as Haftaici_Haftasonu
FROM odeal.Organisation o
LEFT JOIN odeal.BasePayment bp ON bp.organisationId = o.id
WHERE bp.signedDate >= DATE_FORMAT(DATE_SUB(CURDATE(), INTERVAL 1 MONTH ), "%Y-%m-01") AND bp.signedDate < NOW() AND bp.currentStatus = 6 and bp.paymentType <> 4 AND o.demo = 0
AND o.id IN (301001251,301001297,301003078,301004346)) as Islemler) as UyeIsyeri
