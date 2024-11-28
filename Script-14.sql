SELECT *FROM (
SELECT bp.organisationId, bp.id,
CASE
	WHEN bp.paymentType = 0 THEN "Kredi Kartı / Banka Kartı"
	WHEN bp.paymentType = 1 THEN "Kredi Kartı / Banka Kartı / Ceptepos"
	WHEN bp.paymentType = 2 THEN "Kredi Kartı / Banka Kartı / Terminal"
	WHEN bp.paymentType = 3 THEN "Kredi Kartı / Banka Kartı / 3D Ödeme"
	WHEN bp.paymentType = 4 THEN "Nakit"
	WHEN bp.paymentType = 5 THEN "BKM Express"
	WHEN bp.paymentType = 6 THEN "Tekrarlı Ödeme"
	WHEN bp.paymentType = 7 THEN "Kredi Kartı / Banka Kartı"
	WHEN bp.paymentType = 8 THEN "Kredi Kartı / Banka Kartı"
	WHEN bp.paymentType = 9 THEN "Istanbul Kart"
	WHEN bp.paymentType = 10 THEN "Hediye Kartı"
	WHEN bp.paymentType = 11 THEN "Senet"
	WHEN bp.paymentType = 12 THEN "Çek"
	WHEN bp.paymentType = 13 THEN "Açık Hesap"
	WHEN bp.paymentType = 14 THEN "Kredili"
	WHEN bp.paymentType = 15 THEN "Havale/Eft"
	WHEN bp.paymentType = 16 THEN "Yemek Kartı/Çeki"
	WHEN bp.paymentType = 17 THEN "Belediye Ulaşım Kartları, Yardım Kartları ve Çekleri"
END as PaymentTipi,
bp.posId, bp.signedDate, bp.appliedRate, bp.amount, bp.serviceId, Abonelik.id as AbonelikID,
bp.organisationId as SerialNo, "CeptePos" as Tedarikci, Abonelik.`_createdDate` as AktivasyonTarihi, p2.installment, IF(p2.installment>1,"Taksitli" , "Tek Çekim") as TaksitDurum, c2.name as Kanal, p.addonId as Cihaz,
p.name as Plan, p.commissionRates as PlanKomisyon
 FROM odeal.BasePayment bp
JOIN (SELECT * FROM subscription.Subscription s WHERE s.id IN (
SELECT MAX(s.id) FROM odeal.Organisation o 
JOIN subscription.Subscription s ON s.organisationId = o.id
JOIN subscription.Plan p ON p.id = s.planId AND p.serviceId = 3
GROUP BY o.id)) as Abonelik ON Abonelik.organisationId = bp.organisationId
JOIN subscription.Plan p ON p.id = Abonelik.planId
LEFT JOIN odeal.Payment p2 ON p2.id = bp.id
LEFT JOIN odeal.Channel c2 ON c2.id = Abonelik.channelId
WHERE bp.currentStatus = 6 AND bp.serviceId = 3 AND DATE_FORMAT(bp.signedDate,"%Y-%m-%d") >= DATE_FORMAT(CURDATE() - INTERVAL 1 MONTH, '%Y-%m-01') AND
bp.signedDate <= NOW()
UNION
SELECT bp.organisationId, bp.id,
CASE
	WHEN bp.paymentType = 0 THEN "Kredi Kartı / Banka Kartı"
	WHEN bp.paymentType = 1 THEN "Kredi Kartı / Banka Kartı / Ceptepos"
	WHEN bp.paymentType = 2 THEN "Kredi Kartı / Banka Kartı / Terminal"
	WHEN bp.paymentType = 3 THEN "Kredi Kartı / Banka Kartı / 3D Ödeme"
	WHEN bp.paymentType = 4 THEN "Nakit"
	WHEN bp.paymentType = 5 THEN "BKM Express"
	WHEN bp.paymentType = 6 THEN "Tekrarlı Ödeme"
	WHEN bp.paymentType = 7 THEN "Kredi Kartı / Banka Kartı"
	WHEN bp.paymentType = 8 THEN "Kredi Kartı / Banka Kartı"
	WHEN bp.paymentType = 9 THEN "Istanbul Kart"
	WHEN bp.paymentType = 10 THEN "Hediye Kartı"
	WHEN bp.paymentType = 11 THEN "Senet"
	WHEN bp.paymentType = 12 THEN "Çek"
	WHEN bp.paymentType = 13 THEN "Açık Hesap"
	WHEN bp.paymentType = 14 THEN "Kredili"
	WHEN bp.paymentType = 15 THEN "Havale/Eft"
	WHEN bp.paymentType = 16 THEN "Yemek Kartı/Çeki"
	WHEN bp.paymentType = 17 THEN "Belediye Ulaşım Kartları, Yardım Kartları ve Çekleri"
END as PaymentTipi,
bp.posId, bp.signedDate, bp.appliedRate, bp.amount, bp.serviceId, s.id as AbonelikID,
t.serial_no as SerialNo, t.supplier as Tedarikci,  t.firstActivationDate as AktivasyonTarihi, tp.installment, IF(tp.installment>1, "Taksitli" , "Tek Çekim") as TaksitDurum, c2.name as Kanal, p.addonId as Cihaz,
p.name as Plan, p.commissionRates as PlanKomisyon
 FROM odeal.BasePayment bp
JOIN odeal.TerminalPayment tp ON tp.id = bp.id
JOIN odeal.Terminal t ON t.id = tp.terminal_id
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN subscription.Plan p ON p.id = s.planId
LEFT JOIN odeal.Channel c2 ON c2.id = t.channelId
WHERE bp.currentStatus = 6 AND bp.serviceId <>3 AND p.serviceId <> 3 AND DATE_FORMAT(bp.signedDate,"%Y-%m-%d") >= DATE_FORMAT(CURDATE() - INTERVAL 1 MONTH, '%Y-%m-01') AND
bp.signedDate <= NOW()
) as Islemler


SELECT DISTINCT bp.organisationId, bp.id,
CASE
	WHEN bp.paymentType = 0 THEN "Kredi Kartı / Banka Kartı"
	WHEN bp.paymentType = 1 THEN "Kredi Kartı / Banka Kartı / Ceptepos"
	WHEN bp.paymentType = 2 THEN "Kredi Kartı / Banka Kartı / Terminal"
	WHEN bp.paymentType = 3 THEN "Kredi Kartı / Banka Kartı / 3D Ödeme"
	WHEN bp.paymentType = 4 THEN "Nakit"
	WHEN bp.paymentType = 5 THEN "BKM Express"
	WHEN bp.paymentType = 6 THEN "Tekrarlı Ödeme"
	WHEN bp.paymentType = 7 THEN "Kredi Kartı / Banka Kartı"
	WHEN bp.paymentType = 8 THEN "Kredi Kartı / Banka Kartı"
	WHEN bp.paymentType = 9 THEN "Istanbul Kart"
	WHEN bp.paymentType = 10 THEN "Hediye Kartı"
	WHEN bp.paymentType = 11 THEN "Senet"
	WHEN bp.paymentType = 12 THEN "Çek"
	WHEN bp.paymentType = 13 THEN "Açık Hesap"
	WHEN bp.paymentType = 14 THEN "Kredili"
	WHEN bp.paymentType = 15 THEN "Havale/Eft"
	WHEN bp.paymentType = 16 THEN "Yemek Kartı/Çeki"
	WHEN bp.paymentType = 17 THEN "Belediye Ulaşım Kartları, Yardım Kartları ve Çekleri"
END as PaymentTipi,
bp.posId, bp.signedDate, bp.appliedRate, bp.amount, bp.serviceId, Abonelik.id as AbonelikID,
bp.organisationId as SerialNo, "CeptePos" as Tedarikci, Abonelik.`_createdDate` as AktivasyonTarihi, p2.installment, IF(p2.installment>1,"Taksitli" , "Tek Çekim") as TaksitDurum, c2.name as Kanal, p.addonId as Cihaz,
p.name as Plan, p.commissionRates as PlanKomisyon
 FROM odeal.BasePayment bp
JOIN (SELECT * FROM subscription.Subscription s WHERE s.id IN (
SELECT MAX(s.id) FROM odeal.Organisation o 
JOIN subscription.Subscription s ON s.organisationId = o.id
JOIN subscription.Plan p ON p.id = s.planId AND p.serviceId = 3
GROUP BY o.id)) as Abonelik ON Abonelik.organisationId = bp.organisationId
JOIN subscription.Plan p ON p.id = Abonelik.planId
LEFT JOIN odeal.Payment p2 ON p2.id = bp.id
LEFT JOIN odeal.Channel c2 ON c2.id = Abonelik.channelId
WHERE bp.currentStatus = 6 AND bp.serviceId = 3  AND bp.signedDate >= "2024-02-05 00:00:00" AND bp.signedDate <= "2024-02-05 23:59:59"


SELECT * FROM odeal.BasePayment bp 
WHERE bp.currentStatus = 6 AND bp.serviceId = 3 AND bp.signedDate >= "2024-02-03 00:00:00" AND bp.signedDate <= "2024-02-03 23:59:59"
AND bp.id IN(491511284,
590958923,
600157361,
603237624,
631129949,
647586752,
660512024)

SELECT SUM(bp.amount) FROM odeal.Organisation o 
JOIN subscription.Subscription s ON s.organisationId = o.id AND s.status = 1
JOIN subscription.Plan p ON p.id = s.planId AND p.serviceId = 3
LEFT JOIN odeal.BasePayment bp ON bp.organisationId = o.id AND bp.currentStatus = 6
WHERE bp.serviceId = 3 AND bp.signedDate >= "2023-01-27 00:00:00" AND bp.signedDate <= "2023-01-27 23:59:59"

SELECT  
organisationId as 'Organizasyon Id',
serviceId as 'Servis Id',
signedDate,
id, amount 
FROM odeal.BasePayment bp
WHERE 
signedDate is not null 
and cancelDate is null
and amount>=1
and organisationId is not null
and currentStatus=6
AND serviceId = 7
AND bp.signedDate >= "2024-02-05 00:00:00" AND bp.signedDate <= "2024-02-05 23:59:59"

SELECT * FROM odeal.ExternalStockDetail esd 

SELECT * FROM odeal.TerminalHistory th 

SELECT  
organisationId as 'Organizasyon Id',
serviceId as 'Servis Id',
DATE_FORMAT(signedDate, '%Y-%m-%d') as 'İşlem Tarihi',
SUM(amount) as 'İşlem Tutarı',
COUNT(id) as 'İşlem Adedi'
FROM odeal.BasePayment bp
WHERE 
signedDate is not null 
and cancelDate is null
and amount>=1
and organisationId is not null
and currentStatus=6
AND serviceId = 3
and signedDate BETWEEN "2023-01-27 00:00:00" AND "2023-01-27 23:59:59"
GROUP BY organisationId,serviceId,DATE_FORMAT(signedDate, '%Y-%m-%d')

SELECT * FROM odeal.Organisation o WHERE o.id = 301067033


SELECT MAX(s.id) FROM odeal.BasePayment bp 
JOIN subscription.Subscription s ON s.organisationId = bp.organisationId 
JOIN subscription.Plan p ON p.id = s.planId AND p.serviceId = 3
GROUP BY bp.organisationId 

SELECT * FROM subscription.Subscription s WHERE s.id IN (
SELECT MAX(s.id) FROM odeal.Organisation o 
JOIN subscription.Subscription s ON s.organisationId = o.id AND s.status = 1
JOIN subscription.Plan p ON p.id = s.planId AND p.serviceId = 3
WHERE o.isActivated = 1
GROUP BY o.id)


SELECT 
id as 'Organizasyon Id',
organisationId as 'Organizasyon Id 2',
terminalSerialNo as 'Mali No',
terminal_id as 'Terminal Id',
serviceId  as 'Servis Id',
channel_id as 'Satış Kanalı Id',
planId as 'Plan Id',
plan_name as 'Plan Adı', 
isActivated as 'Organizasyonun Durumu',
status as 'Üyeliğin Durumu',
activationDate as 'Aktivasyon Tarihi'
FROM (
    SELECT o.id,o.organisationId,serviceId,Abonelik.channelId as channel_id,Abonelik.planId,pln.name as plan_name,Abonelik.status,isActivated ,
         o.activatedAt ,o.deActivatedAt,
       case 
            when serviceId=3 then null end as terminal_id,
       case 
            when serviceId=3 then null end as terminalSerialNo,
        case
            when date(o.activatedAt) > date(Abonelik.activationDate ) then date(o.activatedAt)
            else date(Abonelik.activationDate )
        end activationDate
        FROM  odeal.Organisation o
        JOIN  (SELECT * FROM subscription.Subscription s WHERE s.id IN (
SELECT MAX(s.id) FROM odeal.Organisation o 
JOIN subscription.Subscription s ON s.organisationId = o.id AND s.status = 1
JOIN subscription.Plan p ON p.id = s.planId AND p.serviceId = 3
WHERE o.isActivated = 1
GROUP BY o.id)) as Abonelik ON Abonelik.organisationId = o.id and Abonelik.status = 1
        JOIN  subscription.Plan pln ON pln.id = Abonelik.planId and( serviceId = 3 or serviceId=1)
        WHERE isActivated=1
    ) temp1


SELECT *FROM (
SELECT bp.organisationId, bp.id,
CASE
	WHEN bp.paymentType = 0 THEN "Kredi Kartı / Banka Kartı"
	WHEN bp.paymentType = 1 THEN "Kredi Kartı / Banka Kartı / Ceptepos"
	WHEN bp.paymentType = 2 THEN "Kredi Kartı / Banka Kartı / Terminal"
	WHEN bp.paymentType = 3 THEN "Kredi Kartı / Banka Kartı / 3D Ödeme"
	WHEN bp.paymentType = 4 THEN "Nakit"
	WHEN bp.paymentType = 5 THEN "BKM Express"
	WHEN bp.paymentType = 6 THEN "Tekrarlı Ödeme"
	WHEN bp.paymentType = 7 THEN "Kredi Kartı / Banka Kartı"
	WHEN bp.paymentType = 8 THEN "Kredi Kartı / Banka Kartı"
	WHEN bp.paymentType = 9 THEN "Istanbul Kart"
	WHEN bp.paymentType = 10 THEN "Hediye Kartı"
	WHEN bp.paymentType = 11 THEN "Senet"
	WHEN bp.paymentType = 12 THEN "Çek"
	WHEN bp.paymentType = 13 THEN "Açık Hesap"
	WHEN bp.paymentType = 14 THEN "Kredili"
	WHEN bp.paymentType = 15 THEN "Havale/Eft"
	WHEN bp.paymentType = 16 THEN "Yemek Kartı/Çeki"
	WHEN bp.paymentType = 17 THEN "Belediye Ulaşım Kartları, Yardım Kartları ve Çekleri"
END as PaymentTipi,
bp.posId, bp.signedDate, bp.appliedRate, bp.amount, bp.serviceId, s.id as AbonelikID,
bp.organisationId as SerialNo, "CeptePos" as Tedarikci, s.`_createdDate` as AktivasyonTarihi, p2.installment, IF(p2.installment>1,"Taksitli" , "Tek Çekim") as TaksitDurum, c2.name as Kanal, p.addonId as Cihaz,
p.name as Plan, p.commissionRates as PlanKomisyon
 FROM odeal.BasePayment bp
JOIN subscription.Subscription s ON s.organisationId = bp.organisationId
JOIN subscription.Plan p ON p.id = s.planId
JOIN odeal.Payment p2 ON p2.id = bp.id
LEFT JOIN odeal.Channel c2 ON c2.id = s.channelId
WHERE bp.currentStatus = 6 AND bp.serviceId = 3 AND p.serviceId = 3 AND DATE_FORMAT(bp.signedDate,"%Y-%m-%d") >= DATE_FORMAT(CURDATE() - INTERVAL 1 MONTH, '%Y-%m-01') AND
bp.signedDate <= NOW()
UNION
SELECT bp.organisationId, bp.id,
CASE
	WHEN bp.paymentType = 0 THEN "Kredi Kartı / Banka Kartı"
	WHEN bp.paymentType = 1 THEN "Kredi Kartı / Banka Kartı / Ceptepos"
	WHEN bp.paymentType = 2 THEN "Kredi Kartı / Banka Kartı / Terminal"
	WHEN bp.paymentType = 3 THEN "Kredi Kartı / Banka Kartı / 3D Ödeme"
	WHEN bp.paymentType = 4 THEN "Nakit"
	WHEN bp.paymentType = 5 THEN "BKM Express"
	WHEN bp.paymentType = 6 THEN "Tekrarlı Ödeme"
	WHEN bp.paymentType = 7 THEN "Kredi Kartı / Banka Kartı"
	WHEN bp.paymentType = 8 THEN "Kredi Kartı / Banka Kartı"
	WHEN bp.paymentType = 9 THEN "Istanbul Kart"
	WHEN bp.paymentType = 10 THEN "Hediye Kartı"
	WHEN bp.paymentType = 11 THEN "Senet"
	WHEN bp.paymentType = 12 THEN "Çek"
	WHEN bp.paymentType = 13 THEN "Açık Hesap"
	WHEN bp.paymentType = 14 THEN "Kredili"
	WHEN bp.paymentType = 15 THEN "Havale/Eft"
	WHEN bp.paymentType = 16 THEN "Yemek Kartı/Çeki"
	WHEN bp.paymentType = 17 THEN "Belediye Ulaşım Kartları, Yardım Kartları ve Çekleri"
END as PaymentTipi,
bp.posId, bp.signedDate, bp.appliedRate, bp.amount, bp.serviceId, s.id as AbonelikID,
t.serial_no as SerialNo, t.supplier as Tedarikci,  t.firstActivationDate as AktivasyonTarihi, tp.installment, IF(tp.installment>1, "Taksitli" , "Tek Çekim") as TaksitDurum, c2.name as Kanal, p.addonId as Cihaz,
p.name as Plan, p.commissionRates as PlanKomisyon
 FROM odeal.BasePayment bp
JOIN odeal.TerminalPayment tp ON tp.id = bp.id
JOIN odeal.Terminal t ON t.id = tp.terminal_id
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN subscription.Plan p ON p.id = s.planId
LEFT JOIN odeal.Channel c2 ON c2.id = t.channelId
WHERE bp.currentStatus = 6 AND bp.serviceId <>3 AND p.serviceId <> 3 AND DATE_FORMAT(bp.signedDate,"%Y-%m-%d") >= DATE_FORMAT(CURDATE() - INTERVAL 1 MONTH, '%Y-%m-01') AND
bp.signedDate <= NOW()
) as Islemler


-- Eskisi
SELECT 
id as 'Organizasyon Id',
organisationId as 'Organizasyon Id 2',
terminalSerialNo as 'Mali No',
terminal_id as 'Terminal Id',
serviceId  as 'Servis Id',
channel_id as 'Satış Kanalı Id',
planId as 'Plan Id',
plan_name as 'Plan Adı', 
isActivated as 'Organizasyonun Durumu',
status as 'Üyeliğin Durumu',
activationDate as 'Aktivasyon Tarihi'
FROM (
    SELECT o.id,o.organisationId,serviceId,sb.channelId as channel_id,sb.planId,pln.name as plan_name,sb.status,isActivated ,
         o.activatedAt ,o.deActivatedAt,
       case 
            when serviceId=3 then null end as terminal_id,
       case 
            when serviceId=3 then null end as terminalSerialNo,
        case
            when date(o.activatedAt) > date(sb.activationDate ) then date(o.activatedAt)
            else date(sb.activationDate )
        end activationDate

        FROM  odeal.Organisation o
        JOIN  subscription.Subscription sb ON sb.organisationId = o.id and sb.status = 1
        JOIN  subscription.Plan pln ON pln.id = sb.planId and( serviceId = 3 or serviceId=1)
        WHERE isActivated=1
    ) temp1
    
    
    SELECT*FROM(

SELECT
id as 'Organizasyon Id',
organisationId as 'Organizasyon Id 2',
terminalSerialNo as 'Mali No',
terminal_id as 'Terminal Id',
serviceId as 'Servis Id',
channel_id as 'Satış Kanalı Id',
planId as 'Plan Id',
plan_name as 'Plan Adı',
isActivated as 'Organizasyonun Durumu',
status as 'Üyeliğin Durumu',
activationDate as 'Aktivasyon Tarihi'
FROM (
SELECT o.id,o.organisationId,serviceId,Abonelik.channelId as channel_id,Abonelik.planId,pln.name as plan_name,Abonelik.status,isActivated ,
o.activatedAt ,o.deActivatedAt,
case
when serviceId=3 then null end as terminal_id,
case
when serviceId=3 then null end as terminalSerialNo,
case
when date(o.activatedAt) > date(Abonelik.activationDate ) then date(o.activatedAt)
else date(Abonelik.activationDate )
end activationDate
FROM odeal.Organisation o
JOIN (SELECT * FROM subscription.Subscription s WHERE s.id IN (
SELECT MAX(s.id) FROM odeal.Organisation o
JOIN subscription.Subscription s ON s.organisationId = o.id AND s.status = 1
JOIN subscription.Plan p ON p.id = s.planId AND p.serviceId = 3
WHERE o.isActivated = 1
GROUP BY o.id)) as Abonelik ON Abonelik.organisationId = o.id and Abonelik.status = 1
JOIN subscription.Plan pln ON pln.id = Abonelik.planId and( serviceId = 3 or serviceId=1)
WHERE isActivated=1
) temp1

UNION 

 SELECT 
id as 'Organizasyon Id',
organisationId as 'Organizasyon Id 2',
terminalSerialNo as 'Mali No',
terminal_id as 'Terminal Id',
serviceId  as 'Servis Id',
channel_id as 'Satış Kanalı Id', 
planId as 'Plan Id',
plan_name as 'Plan Adı', 
isActivated as 'Organizasyonun Durumu',
status as 'Üyeliğin Durumu',
activationDate as 'Aktivasyon Tarihi'

FROM (
    SELECT o.id, o.organisationId,t.id as terminal_id,t.serial_no as terminalSerialNo,serviceId,t.channelId as channel_id,sb.planId,pln.name as plan_name,sb.status,isActivated , o.activatedAt ,o.deActivatedAt,
            case
            when date(o.activatedAt) > date(t.firstActivationDate) and sb.status=1 then date(o.activatedAt)
            else date(t.firstActivationDate)
        end activationDate

        FROM odeal.Organisation o
        JOIN subscription.Subscription sb ON sb.organisationId = o.id 
        JOIN subscription.Plan pln ON pln.id = sb.planId and serviceId<>3 
        JOIN odeal.Terminal t
        ON t.subscription_id = sb.id 
   
    ) temp2 ) temp3
    
    SELECT tmmh.merchant_id as BankaUyeIsyeri, tmmh.serial_no, tmmh.version,
  GROUP_CONCAT(tmmh.acquiring_id) as BankaKod, GROUP_CONCAT(b.name) as BankaAd, t.terminalStatus as TDurum 
  FROM odeal.TerminalMerchantMappingHistory tmmh 
  JOIN odeal.Bank b ON b.bankCode = tmmh.acquiring_id
  JOIN odeal.Terminal t ON t.serial_no = tmmh.serial_no  
  WHERE tmmh.status = 'ACTIVE' AND tmmh.state = "ACTIVE"
  GROUP BY tmmh.merchant_id, tmmh.serial_no, tmmh.version, t.terminalStatus
  
  
SELECT bp.serviceId, COUNT(bp.id) as IslemAdet, SUM(bp.amount) as Ciro FROM odeal.BasePayment bp
LEFT JOIN odeal.TerminalPayment tp ON tp.id = bp.id
LEFT JOIN odeal.Terminal t ON t.id = tp.terminal_id
LEFT JOIN subscription.Subscription s ON s.id = t.subscription_id
LEFT JOIN subscription.Plan p ON p.id = s.planId
LEFT JOIN odeal.Channel c2 ON c2.id = t.channelId
WHERE bp.currentStatus = 6 AND bp.amount>=1 AND bp.signedDate >= "2024-02-05 00:00:00" AND bp.signedDate <= "2024-02-05 23:59:59"
GROUP BY bp.serviceId 

SELECT bp.serviceId, SUM(bp.amount) as Tutar, COUNT(bp.id) as IslemAdet FROM odeal.BasePayment bp WHERE signedDate is not null 
and bp.cancelDate is null
and bp.amount>=1
and bp.organisationId is not null
and bp.currentStatus=6
AND bp.signedDate >= "2024-02-05 00:00:00" AND bp.signedDate <= "2024-02-05 23:59:59"
GROUP BY bp.serviceId 



SELECT *FROM (
SELECT DISTINCT bp.organisationId, bp.id,
CASE
	WHEN bp.paymentType = 0 THEN "Kredi Kartı / Banka Kartı"
	WHEN bp.paymentType = 1 THEN "Kredi Kartı / Banka Kartı / Ceptepos"
	WHEN bp.paymentType = 2 THEN "Kredi Kartı / Banka Kartı / Terminal"
	WHEN bp.paymentType = 3 THEN "Kredi Kartı / Banka Kartı / 3D Ödeme"
	WHEN bp.paymentType = 4 THEN "Nakit"
	WHEN bp.paymentType = 5 THEN "BKM Express"
	WHEN bp.paymentType = 6 THEN "Tekrarlı Ödeme"
	WHEN bp.paymentType = 7 THEN "Kredi Kartı / Banka Kartı"
	WHEN bp.paymentType = 8 THEN "Kredi Kartı / Banka Kartı"
	WHEN bp.paymentType = 9 THEN "Istanbul Kart"
	WHEN bp.paymentType = 10 THEN "Hediye Kartı"
	WHEN bp.paymentType = 11 THEN "Senet"
	WHEN bp.paymentType = 12 THEN "Çek"
	WHEN bp.paymentType = 13 THEN "Açık Hesap"
	WHEN bp.paymentType = 14 THEN "Kredili"
	WHEN bp.paymentType = 15 THEN "Havale/Eft"
	WHEN bp.paymentType = 16 THEN "Yemek Kartı/Çeki"
	WHEN bp.paymentType = 17 THEN "Belediye Ulaşım Kartları, Yardım Kartları ve Çekleri"
END as PaymentTipi,
bp.posId, bp.signedDate, bp.appliedRate, bp.amount, bp.serviceId, Abonelik.id as AbonelikID,
bp.organisationId as SerialNo, "CeptePos" as Tedarikci, Abonelik.`_createdDate` as AktivasyonTarihi, p2.installment, IF(p2.installment>1,"Taksitli" , "Tek Çekim") as TaksitDurum, c2.name as Kanal, p.addonId as Cihaz,
p.name as Plan, p.commissionRates as PlanKomisyon
 FROM odeal.BasePayment bp
JOIN (SELECT * FROM subscription.Subscription s WHERE s.id IN (
SELECT MAX(s.id) FROM odeal.Organisation o 
JOIN subscription.Subscription s ON s.organisationId = o.id
JOIN subscription.Plan p ON p.id = s.planId AND p.serviceId = 3
GROUP BY o.id)) as Abonelik ON Abonelik.organisationId = bp.organisationId
JOIN subscription.Plan p ON p.id = Abonelik.planId
LEFT JOIN odeal.Payment p2 ON p2.id = bp.id
LEFT JOIN odeal.Channel c2 ON c2.id = Abonelik.channelId
WHERE bp.currentStatus = 6 AND bp.serviceId = 3 AND bp.amount >= 1 AND DATE_FORMAT(bp.signedDate,"%Y-%m-%d") >= DATE_FORMAT(CURDATE() - INTERVAL 1 MONTH, '%Y-%m-01') AND
bp.signedDate <= NOW()
UNION

SELECT DISTINCT bp.organisationId, bp.id,
CASE
	WHEN bp.paymentType = 0 THEN "Kredi Kartı / Banka Kartı"
	WHEN bp.paymentType = 1 THEN "Kredi Kartı / Banka Kartı / Ceptepos"
	WHEN bp.paymentType = 2 THEN "Kredi Kartı / Banka Kartı / Terminal"
	WHEN bp.paymentType = 3 THEN "Kredi Kartı / Banka Kartı / 3D Ödeme"
	WHEN bp.paymentType = 4 THEN "Nakit"
	WHEN bp.paymentType = 5 THEN "BKM Express"
	WHEN bp.paymentType = 6 THEN "Tekrarlı Ödeme"
	WHEN bp.paymentType = 7 THEN "Kredi Kartı / Banka Kartı"
	WHEN bp.paymentType = 8 THEN "Kredi Kartı / Banka Kartı"
	WHEN bp.paymentType = 9 THEN "Istanbul Kart"
	WHEN bp.paymentType = 10 THEN "Hediye Kartı"
	WHEN bp.paymentType = 11 THEN "Senet"
	WHEN bp.paymentType = 12 THEN "Çek"
	WHEN bp.paymentType = 13 THEN "Açık Hesap"
	WHEN bp.paymentType = 14 THEN "Kredili"
	WHEN bp.paymentType = 15 THEN "Havale/Eft"
	WHEN bp.paymentType = 16 THEN "Yemek Kartı/Çeki"
	WHEN bp.paymentType = 17 THEN "Belediye Ulaşım Kartları, Yardım Kartları ve Çekleri"
END as PaymentTipi,
bp.posId, bp.signedDate, bp.appliedRate, bp.amount, bp.serviceId, s.id as AbonelikID,
t.serial_no as SerialNo, t.supplier as Tedarikci,  t.firstActivationDate as AktivasyonTarihi, tp.installment, IF(tp.installment>1, "Taksitli" , "Tek Çekim") as TaksitDurum, c2.name as Kanal, p.addonId as Cihaz,
p.name as Plan, p.commissionRates as PlanKomisyon
 FROM odeal.BasePayment bp
LEFT JOIN odeal.TerminalPayment tp ON tp.id = bp.id
LEFT JOIN odeal.Terminal t ON t.id = tp.terminal_id
LEFT JOIN subscription.Subscription s ON s.id = t.subscription_id
LEFT JOIN subscription.Plan p ON p.id = s.planId
LEFT JOIN odeal.Channel c2 ON c2.id = t.channelId
LEFT JOIN (SELECT * FROM odeal.TerminalMerchantMappingHistory tmmh
  JOIN (
  SELECT tmmh.merchant_id as UyeID, tmmh.serial_no as MaliNo, MAX(tmmh.version) as versiyon
  FROM odeal.TerminalMerchantMappingHistory tmmh 
  JOIN odeal.Bank b ON b.bankCode = tmmh.acquiring_id
  JOIN odeal.Terminal t ON t.serial_no = tmmh.serial_no  
  WHERE tmmh.status = 'ACTIVE' AND tmmh.state = "ACTIVE"
  GROUP BY tmmh.merchant_id, tmmh.serial_no) as SonBanka ON SonBanka.UyeID = tmmh.merchant_id AND SonBanka.MaliNo = tmmh.serial_no AND SonBanka.versiyon = tmmh.version) as Banka ON Banka.serial_no = t.serial_no AND Banka.merchant_id = bp.organisationId
WHERE bp.currentStatus = 6 AND bp.serviceId <>3 AND bp.amount >= 1 AND DATE_FORMAT(bp.signedDate,"%Y-%m-%d") >= DATE_FORMAT(CURDATE() - INTERVAL 1 MONTH, '%Y-%m-01') AND
bp.signedDate <= NOW() AND bp.id = 666388530
) as Islemler



-- Banka Kurulumları
SELECT BankaKurulum.serial_no, BankaKurulum.version, COUNT(*) as Adet FROM (
SELECT tmmh.merchant_id as BankaUyeIsyeri,tmmh.state, tmmh.status, tmmh.serial_no, tmmh.version, GROUP_CONCAT(tmmh.acquiring_id) as BankaKod, GROUP_CONCAT(b.name) as BankaAd, t.terminalStatus as TDurum 
  FROM odeal.TerminalMerchantMappingHistory tmmh 
  JOIN odeal.Bank b ON b.bankCode = tmmh.acquiring_id
  JOIN odeal.Terminal t ON t.serial_no = tmmh.serial_no  
  WHERE tmmh.status = 'ACTIVE' AND tmmh.state = "ACTIVE"
  GROUP BY tmmh.merchant_id, tmmh.serial_no, tmmh.version, t.terminalStatus) as BankaKurulum
  GROUP BY BankaKurulum.serial_no, BankaKurulum.version HAVING COUNT(*)>1
  
  SELECT tmmh.merchant_id as BankaUyeIsyeri,tmmh.state, tmmh.status, tmmh.serial_no, tmmh.version, GROUP_CONCAT(tmmh.acquiring_id) as BankaKod, GROUP_CONCAT(b.name) as BankaAd, t.terminalStatus as TDurum  FROM odeal.TerminalMerchantMappingHistory tmmh
  JOIN (
  SELECT tmmh.merchant_id as UyeID, tmmh.serial_no as SeriNo, MAX(tmmh.version) as versiyon
  FROM odeal.TerminalMerchantMappingHistory tmmh 
  JOIN odeal.Bank b ON b.bankCode = tmmh.acquiring_id
  JOIN odeal.Terminal t ON t.serial_no = tmmh.serial_no  
  WHERE tmmh.status = 'ACTIVE' AND tmmh.state = "ACTIVE"
  GROUP BY tmmh.merchant_id, tmmh.serial_no) as SonBanka ON SonBanka.UyeID = tmmh.merchant_id AND SonBanka.SeriNo = tmmh.serial_no AND SonBanka.versiyon = tmmh.version  
    JOIN odeal.Bank b ON b.bankCode = tmmh.acquiring_id
  JOIN odeal.Terminal t ON t.serial_no = tmmh.serial_no  
  WHERE tmmh.status = 'ACTIVE' AND tmmh.state = "ACTIVE"
  GROUP BY tmmh.merchant_id, tmmh.serial_no, tmmh.version, t.terminalStatus
  
  
  SELECT BankaKurulum.merchant_id, BankaKurulum.serial_no, COUNT(*) as Adet FROM (
  SELECT tmmh.merchant_id, tmmh.serial_no, tmmh.version, COUNT(*) as Adet FROM odeal.TerminalMerchantMappingHistory tmmh WHERE tmmh.status = 'ACTIVE' AND tmmh.state = "ACTIVE"
  GROUP BY tmmh.merchant_id, tmmh.serial_no, tmmh.version) as BankaKurulum
  GROUP BY BankaKurulum.merchant_id, BankaKurulum.serial_no HAVING COUNT(*)>1
  
  SELECT * FROM odeal.TerminalMerchantMappingHistory tmmh WHERE tmmh.serial_no = "PAX710014038" 
  
  
  SELECT * FROM odeal.Organisation o
  JOIN subscription.Subscription s ON s.organisationId = o.id 
  JOIN subscription.Plan p ON p.