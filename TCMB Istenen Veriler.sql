SELECT o.id, o.vergiNo, s.sector_name, IF(bp.serviceId=3,"CEPPOS","FİZİKİPOS") as Urun,
SUM(CASE WHEN bp.currentStatus = 6 AND bp.serviceId = 3 THEN bp.amount END) as BasariliCepposCiro,
COUNT(CASE WHEN bp.currentStatus = 6 AND bp.serviceId = 3 THEN bp.id END) as BasariliCepposIslem,
SUM(CASE WHEN bp.currentStatus = 9 AND bp.serviceId = 3 THEN bp.amount END) as IadeCepposCiro,
COUNT(CASE WHEN bp.currentStatus = 9 AND bp.serviceId = 3 THEN bp.id END) as IadeCepposIslem,
SUM(CASE WHEN bp.currentStatus = 6 AND bp.serviceId <> 3 THEN bp.amount END) as BasariliFizikiCiro,
COUNT(CASE WHEN bp.currentStatus = 6 AND bp.serviceId <> 3 THEN bp.id END) as BasariliFizikiIslem,
SUM(CASE WHEN bp.currentStatus = 9 AND bp.serviceId <> 3 THEN bp.amount END) as IadeFizikiCiro,
COUNT(CASE WHEN bp.currentStatus = 9 AND bp.serviceId <> 3 THEN bp.id END) as IadeFizikiIslem,
SUM(CASE WHEN bp.currentStatus = 6 AND bp.serviceId = 3 THEN bp.paybackAmount END) as BasariliCepposGelir,
SUM(CASE WHEN bp.currentStatus = 9 AND bp.serviceId = 3 THEN bp.paybackAmount END) as IadeCepposGelir,
SUM(CASE WHEN bp.currentStatus = 6 AND bp.serviceId <> 3 THEN bp.paybackAmount END) as BasariliFizikiGelir,
SUM(CASE WHEN bp.currentStatus = 9 AND bp.serviceId <> 3 THEN bp.paybackAmount END) as IadeFizikiGelir,
SUM(bp.amount) as GenelToplamCiro, SUM(bp.paybackAmount) as GenelToplamGelir, COUNT(bp.id) as GenelToplamIslem
FROM odeal.BasePayment bp  
JOIN odeal.Organisation o ON o.id = bp.organisationId
JOIN odeal.Sector s ON s.id = o.sectorId
WHERE bp.signedDate >= "2023-01-01 00:00:00" AND  bp.signedDate <= "2023-12-31 23:59:59"
AND bp.currentStatus IN (6,9) AND bp.paymentType IN (0,1,2,3,7,8)
GROUP BY o.id, IF(bp.serviceId=3,"CEPPOS","FİZİKİPOS");

SELECT s2.name, DATE_FORMAT(bp.signedDate, "%Y") as Yil,
SUM(CASE WHEN bp.currentStatus = 6 AND bp.serviceId = 3 THEN bp.amount END) as Ceppos_Ciro,
COUNT(CASE WHEN bp.currentStatus = 6 AND bp.serviceId = 3 THEN bp.id END) as Ceppos_Islem,
SUM(CASE WHEN bp.currentStatus = 6 AND bp.serviceId = 3 THEN bp.paybackAmount END) as Ceppos_UyeGelir,
SUM(CASE WHEN bp.currentStatus = 6 AND bp.serviceId = 3 THEN (bp.amount - bp.paybackAmount) END) as Ceppos_OdealGelir,
SUM(CASE WHEN bp.currentStatus = 6 AND bp.serviceId = 2 THEN bp.amount END) as OKC_Ciro,
COUNT(CASE WHEN bp.currentStatus = 6 AND bp.serviceId = 2 THEN bp.id END) as OKC_Islem,
SUM(CASE WHEN bp.currentStatus = 6 AND bp.serviceId = 2 THEN bp.paybackAmount END) as OKC_UyeGelir,
SUM(CASE WHEN bp.currentStatus = 6 AND bp.serviceId = 2 THEN (bp.amount - bp.paybackAmount) END) as OKC_Odeal_Gelir,
SUM(CASE WHEN bp.currentStatus = 6 AND bp.serviceId = 5 THEN bp.amount END) as SadePos_Ciro,
COUNT(CASE WHEN bp.currentStatus = 6 AND bp.serviceId = 5 THEN bp.id END) as SadePos_Islem,
SUM(CASE WHEN bp.currentStatus = 6 AND bp.serviceId = 5 THEN bp.paybackAmount END) as SadePos_UyeGelir,
SUM(CASE WHEN bp.currentStatus = 6 AND bp.serviceId = 5 THEN (bp.amount - bp.paybackAmount) END) as SadePos_Odeal_Gelir,
SUM(CASE WHEN bp.currentStatus = 6 AND bp.serviceId = 7 THEN bp.amount END) as EfaturaPos_Ciro,
COUNT(CASE WHEN bp.currentStatus = 6 AND bp.serviceId = 7 THEN bp.id END) as EfaturaPos_Islem,
SUM(CASE WHEN bp.currentStatus = 6 AND bp.serviceId = 7 THEN bp.paybackAmount END) as EfaturaPos_UyeGelir,
SUM(CASE WHEN bp.currentStatus = 6 AND bp.serviceId = 7 THEN (bp.amount - bp.paybackAmount) END) as EfaturaPos_Odeal_Gelir,
SUM(bp.amount) as GenelToplamCiro, SUM(bp.paybackAmount) as GenelToplam_UyeGelir, COUNT(bp.id)  as GenelToplamIslem, SUM(bp.amount) - SUM(bp.paybackAmount) as GenelToplam_OdealGelir
FROM odeal.BasePayment bp  
JOIN subscription.Service s2 ON s2.id = bp.serviceId
WHERE bp.signedDate >= "2013-01-01 00:00:00" AND  bp.signedDate <= "2024-12-31 23:59:59"
AND bp.currentStatus = 6
AND bp.paymentType IN (0,1,2,3,7,8)
GROUP BY s2.name, DATE_FORMAT(bp.signedDate, "%Y")


SELECT * FROM odeal.BasePayment bp 
WHERE DATE_FORMAT(bp.signedDate,"%Y-%m-%d") >= "2023-01-01" AND  DATE_FORMAT(bp.signedDate,"%Y-%m-%d") <= "2023-06-30"
AND bp.currentStatus = 6 AND bp.organisationId = 301000041

SELECT DISTINCT o.id, o.marka, t.serial_no, IslemGecen.Ay, IslemGecen.Ciro, IslemGecen.IslemAdet FROM odeal.Organisation o 
JOIN odeal.Terminal t ON t.organisation_id = o.id
LEFT JOIN (SELECT o.id, o.marka, t.serial_no, DATE_FORMAT(bp.signedDate,"%Y-%m") as Ay, SUM(bp.amount) as Ciro, COUNT(bp.id) as IslemAdet FROM odeal.Organisation o 
JOIN odeal.Terminal t ON t.organisation_id = o.id 
JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id 
JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.signedDate >= "2024-01-01 00:00:00" AND bp.signedDate <= NOW()
WHERE o.demo = 0 AND t.channelId = 213
GROUP BY o.id, o.marka, t.serial_no, DATE_FORMAT(bp.signedDate,"%Y-%m")) as IslemGecen ON IslemGecen.id = o.id AND IslemGecen.serial_no = t.serial_no


SELECT o.id as UyeIsyeriID, o.marka as Marka, o.unvan as Unvan, t.serial_no as MaliNo, 
SUM(CASE WHEN DATE_FORMAT(bp.signedDate, "%Y-%m") = "2024-01" THEN bp.amount END) as 2024_01,
SUM(CASE WHEN DATE_FORMAT(bp.signedDate, "%Y-%m") = "2024-02" THEN bp.amount END) as 2024_02,
SUM(CASE WHEN DATE_FORMAT(bp.signedDate, "%Y-%m") = "2024-03" THEN bp.amount END) as 2024_03,
SUM(CASE WHEN DATE_FORMAT(bp.signedDate, "%Y-%m") = "2024-04" THEN bp.amount END) as 2024_04,
SUM(CASE WHEN DATE_FORMAT(bp.signedDate, "%Y-%m") = "2024-05" THEN bp.amount END) as 2024_05,
SUM(CASE WHEN DATE_FORMAT(bp.signedDate, "%Y-%m") = "2024-06" THEN bp.amount END) as 2024_06,
SUM(CASE WHEN DATE_FORMAT(bp.signedDate, "%Y-%m") = "2024-07" THEN bp.amount END) as 2024_07,
SUM(CASE WHEN DATE_FORMAT(bp.signedDate, "%Y-%m") = "2024-08" THEN bp.amount END) as 2024_08,
SUM(CASE WHEN DATE_FORMAT(bp.signedDate, "%Y-%m") = "2024-09" THEN bp.amount END) as 2024_09,
SUM(CASE WHEN DATE_FORMAT(bp.signedDate, "%Y-%m") = "2024-10" THEN bp.amount END) as 2024_10,
SUM(CASE WHEN DATE_FORMAT(bp.signedDate, "%Y-%m") = "2024-11" THEN bp.amount END) as 2024_11,
SUM(CASE WHEN DATE_FORMAT(bp.signedDate, "%Y-%m") = "2024-12" THEN bp.amount END) as 2024_12,
SUM(bp.amount) as Genel_Toplam
FROM odeal.Organisation o 
JOIN odeal.Terminal t ON t.organisation_id = o.id 
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id 
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.signedDate >= "2024-01-01 00:00:00" AND bp.signedDate <= NOW()
WHERE o.demo = 0 AND t.channelId = 213 AND o.id = 301088093
GROUP BY o.id, o.marka, o.unvan, t.serial_no

SELECT o.id as UyeIsyeriID, o.unvan as Unvan, o.marka as Marka, o.address as Adres, t.name as Ilce, c.name as Sehir, 
IF(o.isActivated=1,"AKTİF","PASİF") as UyeDurum, CONCAT(m.firstName," ",m.LastName) as Yetkili, m.phone as YetkiliTelefon, m.email as Email FROM odeal.Organisation o
JOIN odeal.Merchant m ON m.organisationId = o.id AND m.`role` = 0
JOIN odeal.Town t ON t.id = o.townId
JOIN odeal.City c ON c.id = o.cityId 
WHERE o.demo = 0

SELECT m.organisationId, CONCAT(m.firstName," ",m.LastName) as Yetkili, m.tckNo FROM odeal.Merchant m 
WHERE m.role = 0 AND m.tckNo = "19429894534"

SELECT bp.organisationId, bp.currentStatus, SUM(bp.amount), COUNT(bp.id) FROM odeal.BasePayment bp 
WHERE bp.organisationId = 301000060 AND bp.signedDate >= "2022-01-01"
GROUP BY bp.currentStatus

SELECT * FROM odeal.PaymentMetaData pmd LIMIT 10

SELECT * FROM odeal.Channel c WHERE c.name LIKE "İş%"

SELECT o.id as UyeID, o.address, th.id, th.serialNo, th.physicalSerialId, th.historyStatus, t.serial_no, th._createdDate as HistoryTarih,
IF(t.terminalStatus=0,"Pasif","Aktif") as TerminalDurum, IF(o.isActivated=1,"Aktif","Pasif") as UyeDurum, 
s.id as AbonelikID, s.activationDate as AbonelikAktivasyonTarihi, IF(s.status=1,"Aktif","Pasif") as AbonelikDurum, s2.name as Hizmet
FROM odeal.TerminalHistory th 
LEFT JOIN odeal.Terminal t ON t.serial_no = CONVERT(th.serialNo USING utf8)
LEFT JOIN subscription.Subscription s ON s.id = t.subscription_id 
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
LEFT JOIN odeal.Organisation o ON o.id = t.organisation_id
WHERE o.demo = 0 AND th.id IN (
SELECT MAX(th.id) FROM odeal.TerminalHistory th
GROUP BY th.physicalSerialId) AND th.physicalSerialId = "6K370239"

SELECT o.id as UyeIsyeriID,
       o.unvan as Unvan,
       o.marka as Marka,
       IF(o.isActivated=1,"Aktif","Pasif") as OrganizasyonStatusu,
       t.serial_no as MaliNo,
       THistory.historyStatus as TerminalTarihiDurum,
       IF(t.terminalStatus=1,"Aktif","Pasif") as TerminalStatusu,
       THistory.physicalSerialId as FizikiSeriNo, THistory.`_createdDate`, THistory.id
FROM odeal.Organisation o
JOIN odeal.Terminal t ON t.organisation_id = o.id
JOIN (SELECT * FROM (
SELECT *, ROW_NUMBER() OVER (PARTITION BY History.physicalSerialId ORDER BY History.`_createdDate` DESC) as Sira2 FROM (
SELECT *, 
ROW_NUMBER() OVER (PARTITION BY th.serialNo ORDER BY th.`_createdDate` DESC) as Sira
FROM odeal.TerminalHistory th) as History 
WHERE History.Sira = 1) as History2 WHERE History2.Sira2 = 1) as THistory ON CONVERT(THistory.serialNo USING utf8) = t.serial_no
WHERE o.demo = 0 AND t.serial_no LIKE "PAX%" AND THistory.physicalSerialId = "6K370239";


SELECT * FROM odeal.TerminalHistory th WHERE th.physicalSerialId = "6K370239"

SELECT * FROM odeal.TerminalHistory th 
WHERE th.physicalSerialId = "6K370239"

SELECT * FROM odeal.TerminalHistory th WHERE th.serialNo = "PAX710052909"


SELECT * FROM odeal.BasePayment bp
JOIN odeal.TerminalPayment tp ON tp.id = bp.id 
JOIN odeal.Terminal t ON t.id = tp.terminal_id
WHERE t.serial_no = "PAX710049410"





SELECT 
*
FROM (
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
bp.posId, bp.signedDate, DATE_FORMAT(bp.signedDate, "%m %Y") as YilAy, bp.appliedRate, bp.amount, bp.serviceId, Abonelik.id as AbonelikID,
Abonelik.id as SerialNo, "CeptePos" as Tedarikci, Abonelik.`_createdDate` as AktivasyonTarihi, p2.installment, IF(p2.installment>1,"Taksitli" , "Tek Çekim") as TaksitDurum, c2.name as Kanal, p.addonId as Cihaz,
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
WHERE bp.currentStatus = 6 AND bp.paymentType IN (0,1,2,3,6,7,8) AND bp.serviceId = 3 AND bp.signedDate >= DATE_FORMAT(DATE_SUB(CURDATE(), INTERVAL 2 MONTH), "%Y-%m-01") AND
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
bp.posId, bp.signedDate, DATE_FORMAT(bp.signedDate, "%m %Y") as YilAy, bp.appliedRate, bp.amount, bp.serviceId, s.id as AbonelikID,
t.serial_no as SerialNo, t.supplier as Tedarikci,  t.firstActivationDate as AktivasyonTarihi, 
tp.installment, IF(tp.installment>1, "Taksitli" , "Tek Çekim") as TaksitDurum, c2.name as Kanal, p.addonId as Cihaz,
p.name as Plan, p.commissionRates as PlanKomisyon
 FROM odeal.BasePayment bp
LEFT JOIN odeal.TerminalPayment tp ON tp.id = bp.id
LEFT JOIN odeal.Terminal t ON t.id = tp.terminal_id
LEFT JOIN subscription.Subscription s ON s.id = t.subscription_id
LEFT JOIN subscription.Plan p ON p.id = s.planId
LEFT JOIN odeal.Channel c2 ON c2.id = t.channelId
WHERE bp.currentStatus = 6 AND bp.paymentType IN (0,1,2,3,6,7,8) AND bp.serviceId <>3 AND bp.signedDate >= DATE_FORMAT(DATE_SUB(CURDATE(), INTERVAL 2 MONTH), "%Y-%m-01") AND
bp.signedDate <= NOW()
) as Islemler

SELECT *, SonIslemler.Ciro, SonIslemler.IslemAdet FROM (
SELECT o.id as UyeIsyeriId, o.marka as Marka, o.unvan as Unvan, o.activatedAt as AktivasyonTarihi, IF(isActivated=1,'Aktif','Pasif') as UyeDurum, o.deActivatedAt as DeaktivasyonTarihi,
       o.vergiNo as VKN, c.name as Sehir, t2.name as Ilce, s.sector_name as Sektör, o.sector, CONCAT(m.firstName," ",m.LastName) as Yetkili, m.phone as TelNo, m.email as Email,
       m.tckNo, t.serial_no as MaliNo, o.address as Adres
FROM odeal.Organisation o
JOIN odeal.Merchant m ON m.organisationId  = o.id
JOIN odeal.Terminal t ON t.organisation_id = o.id
JOIN odeal.Sector s ON s.id = o.sectorId
JOIN odeal.City c ON c.id = o.cityId
JOIN odeal.Town as t2 ON t2.id = o.townId
WHERE o.demo = 0 AND m.role = 0
UNION
SELECT o.id as UyeIsyeriId,o.marka as Marka,o.unvan as Unvan,o.activatedAt as AktivasyonTarihi,IF(isActivated=1,'Aktif','Pasif') as UyeDurum, o.deActivatedAt as DeaktivasyonTarihi, o.vergiNo as VKN,
       c.name as Sehir, t2.name as Ilce, s2.sector_name as Sektör, o.sector,CONCAT(m.firstName," ",m.LastName) as Yetkili, m.phone as TelNo, m.email as Email, m.tckNo, s.id as MaliNo, o.address as Adres
FROM odeal.Organisation o
JOIN odeal.Merchant m ON m.organisationId  = o.id
JOIN odeal.Sector s2 ON s2.id = o.sectorId
JOIN odeal.City c ON c.id = o.cityId
JOIN odeal.Town as t2 ON t2.id = o.townId
JOIN subscription.Subscription s ON s.organisationId = o.id
JOIN subscription.Plan p ON p.id = s.planId AND p.serviceId = 3
WHERE s.id IN (SELECT MAX(s.id) FROM odeal.Organisation o
JOIN subscription.Subscription s ON s.organisationId = o.id
JOIN subscription.Plan p ON p.id = s.planId AND p.serviceId = 3
WHERE o.demo = 0
GROUP BY o.id) AND m.role = 0) as Uye
LEFT JOIN (SELECT 
Islemler.organisationId, Islemler.SerialNo, SUM(Islemler.amount) as Ciro, COUNT(Islemler.id) as IslemAdet
FROM (
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
bp.posId, bp.signedDate, DATE_FORMAT(bp.signedDate, "%m %Y") as YilAy, bp.appliedRate, bp.amount, bp.serviceId, Abonelik.id as AbonelikID,
Abonelik.id as SerialNo, "CeptePos" as Tedarikci, Abonelik.`_createdDate` as AktivasyonTarihi, p2.installment, IF(p2.installment>1,"Taksitli" , "Tek Çekim") as TaksitDurum, c2.name as Kanal, p.addonId as Cihaz,
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
WHERE bp.currentStatus = 6 AND bp.paymentType IN (0,1,2,3,6,7,8) AND bp.serviceId = 3 AND bp.signedDate >= DATE_FORMAT(DATE_SUB(CURDATE(), INTERVAL 2 DAY), "%Y-%m-%d") AND
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
bp.posId, bp.signedDate, DATE_FORMAT(bp.signedDate, "%m %Y") as YilAy, bp.appliedRate, bp.amount, bp.serviceId, s.id as AbonelikID,
t.serial_no as SerialNo, t.supplier as Tedarikci,  t.firstActivationDate as AktivasyonTarihi, 
tp.installment, IF(tp.installment>1, "Taksitli" , "Tek Çekim") as TaksitDurum, c2.name as Kanal, p.addonId as Cihaz,
p.name as Plan, p.commissionRates as PlanKomisyon
 FROM odeal.BasePayment bp
LEFT JOIN odeal.TerminalPayment tp ON tp.id = bp.id
LEFT JOIN odeal.Terminal t ON t.id = tp.terminal_id
LEFT JOIN subscription.Subscription s ON s.id = t.subscription_id
LEFT JOIN subscription.Plan p ON p.id = s.planId
LEFT JOIN odeal.Channel c2 ON c2.id = t.channelId
WHERE bp.currentStatus = 6 AND bp.paymentType IN (0,1,2,3,6,7,8) AND bp.serviceId <>3 AND bp.signedDate >= DATE_FORMAT(DATE_SUB(CURDATE(), INTERVAL 2 DAY), "%Y-%m-%d") AND
bp.signedDate <= NOW()
) as Islemler
GROUP BY Islemler.organisationId, Islemler.SerialNo) as SonIslemler ON SonIslemler.organisationId = Uye.UyeIsyeriId AND SonIslemler.SerialNo = Uye.MaliNo
WHERE SonIslemler.organisationId = 301000042

SELECT @baslangicTarih := "2013-01-01 00:00:00", @bitisTarih := "2024-12-31 23:59:59"

SELECT o.id, IF(o.isActivated=1,"Aktif","Pasif") as UyeDurum, s2.name as Hizmet, SUM(bp.amount) as Ciro, COUNT(bp.id) as IslemAdet, SUM(bp.paybackAmount) as UyeGelir, SUM(bp.amount)-SUM(bp.paybackAmount) as KomisyonGelir 
FROM odeal.Organisation o 
JOIN subscription.Subscription s ON s.organisationId = o.id
JOIN subscription.Plan p ON p.id = s.planId AND p.serviceId = 3
JOIN subscription.Service s2 ON s2.id = p.serviceId
LEFT JOIN odeal.BasePayment bp ON bp.organisationId = o.id 
LEFT JOIN odeal.Payment p2 ON p2.id = bp.id 
WHERE bp.currentStatus = 6 AND bp.paymentType IN (0,1,2,3,7,8) AND bp.serviceId = 3 AND bp.signedDate >= @baslangicTarih AND
bp.signedDate <= @bitisTarih AND s.id IN (
SELECT MAX(s.id) FROM odeal.Organisation o 
JOIN subscription.Subscription s ON s.organisationId = o.id
JOIN subscription.Plan p ON p.id = s.planId AND p.serviceId = 3
JOIN subscription.Service s2 ON s2.id = p.serviceId
GROUP BY o.id)
GROUP BY o.id, IF(o.isActivated=1,"Aktif","Pasif"), s2.name

SELECT bp.organisationId, SUM(bp.amount) as Ciro, COUNT(bp.id) as IslemAdet, MAX(bp.signedDate) as SonIslemTarih
FROM odeal.BasePayment bp 
WHERE bp.currentStatus = 6 AND bp.paymentType IN (0,1,2,3,6,7,8)
GROUP BY bp.organisationId


SELECT COUNT(bp.id) as KullaniciIptalIslemAdet FROM odeal.BasePayment bp
JOIN odeal.TerminalPayment tp ON tp.id = bp.id
                                     WHERE tp.terminal_id = t.id
                                      AND bp.currentStatus = 9 AND bp.serviceId <> 3
                                      AND bp.paymentType <> 4
                                      AND bp.signedDate >= @Baslangic
                                      AND bp.signedDate <= @Bitis

SELECT @Baslangic:="2024-09-01 00:00:00",
       @Bitis:="2024-09-30 23:59:59";

-- 1 00:00:00 - 10 23:59:59
-- 11 00:00:00 - 20 23:59:59
-- 21 00:00:00 - 31 23:59:59

SELECT * FROM (
SELECT o.id as UyeIsyeriId,
       o.marka as Marka,
       o.unvan as Unvan,
       o.activatedAt as AktivasyonTarihi,
       IF(isActivated=1,'Aktif','Pasif') as UyeDurum,
       o.deActivatedAt as DeaktivasyonTarihi,
       o.vergiNo as VKN,
       t.serial_no as MaliNo,
       ser.name as Hizmet,
       IF(t.terminalStatus=1,"Aktif","Pasif") as HizmetDurum,
       o.address as Adres,
       COUNT(CASE WHEN bp.currentStatus = 9 THEN bp.id END) as KullaniciIptalAdet,
       SUM(CASE WHEN bp.currentStatus = 9 THEN bp.amount END) as KullaniciIptalTutar,
       COUNT(CASE WHEN bp.currentStatus = 13 THEN bp.id END) as IadeAdet,
       SUM(CASE WHEN bp.currentStatus = 13 THEN bp.amount END) as IadeTutar,
       COUNT(CASE WHEN bp.currentStatus = 6 THEN bp.id END) as IslemAdet,
       SUM(CASE WHEN bp.currentStatus = 6 THEN bp.amount END) as IslemTutar,
       SUM(CASE WHEN bp.currentStatus = 6 THEN bp.paybackAmount END) as GeriOdemeTutar
FROM odeal.Organisation o
JOIN odeal.Terminal t ON t.organisation_id = o.id
JOIN subscription.Subscription s2 ON s2.id = t.subscription_id
JOIN subscription.Plan p ON p.id = s2.planId AND p.serviceId <> 3
JOIN subscription.Service ser ON ser.id = p.serviceId
JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
JOIN odeal.BasePayment bp ON bp.id = tp.id
WHERE o.demo = 0  AND bp.currentStatus IN (6,9,13) AND bp.serviceId <> 3
                                      AND bp.paymentType <> 4
                                      AND bp.signedDate >= @Baslangic
                                      AND bp.signedDate <= @Bitis
GROUP BY o.id, o.marka,
                                         o.unvan, o.activatedAt,
                                         IF(isActivated=1,'Aktif','Pasif'),
                                         o.deActivatedAt, o.vergiNo, t.serial_no,
                                         ser.name, IF(t.terminalStatus=1,"Aktif","Pasif"), o.address
UNION
SELECT o.id as UyeIsyeriId,
       o.marka as Marka,
       o.unvan as Unvan,
       o.activatedAt as AktivasyonTarihi,
       IF(isActivated=1,'Aktif','Pasif') as UyeDurum,
       o.deActivatedAt as DeaktivasyonTarihi,
       o.vergiNo as VKN,
       o.id as MaliNo,
       ser.name as Hizmet,
       IF(s.status=1,"Aktif","Pasif") as HizmetDurum,
       o.address as Adres,
       COUNT(CASE WHEN bp.currentStatus = 9 THEN bp.id END) as KullaniciIptalAdet,
       SUM(CASE WHEN bp.currentStatus = 9 THEN bp.amount END) as KullaniciIptalTutar,
       COUNT(CASE WHEN bp.currentStatus = 13 THEN bp.id END) as IadeAdet,
       SUM(CASE WHEN bp.currentStatus = 13 THEN bp.amount END) as IadeTutar,
       COUNT(CASE WHEN bp.currentStatus = 6 THEN bp.id END) as IslemAdet,
       SUM(CASE WHEN bp.currentStatus = 6 THEN bp.amount END) as IslemTutar,
       SUM(CASE WHEN bp.currentStatus = 6 THEN bp.paybackAmount END) as GeriOdemeTutar
FROM odeal.Organisation o
JOIN subscription.Subscription s ON s.organisationId = o.id
JOIN subscription.Plan p ON p.id = s.planId AND p.serviceId = 3
JOIN subscription.Service ser ON ser.id = p.serviceId
JOIN odeal.BasePayment bp ON bp.organisationId = o.id
JOIN odeal.Payment pay ON pay.id = bp.id
WHERE  s.id IN (SELECT MAX(s.id) FROM odeal.Organisation o
JOIN subscription.Subscription s ON s.organisationId = o.id
JOIN subscription.Plan p ON p.id = s.planId AND p.serviceId = 3
WHERE o.demo = 0
GROUP BY o.id)  AND bp.currentStatus IN (6,9,13) AND bp.serviceId = 3
                                      AND bp.paymentType <> 4
                                      AND bp.signedDate >= @Baslangic
                                      AND bp.signedDate <= @Bitis
GROUP BY o.id, o.marka,
         o.unvan, o.activatedAt,
         IF(isActivated=1,'Aktif','Pasif'), o.deActivatedAt,
         o.vergiNo, o.id, ser.name,
         IF(s.status=1,"Aktif","Pasif"), o.address) as Uye;


SELECT o.id, s.status FROM odeal.Organisation o 
JOIN subscription.Subscription s ON s.organisationId = o.id 
WHERE s.id IN
(SELECT MAX(s.id) FROM odeal.Organisation o
JOIN subscription.Subscription s ON s.organisationId = o.id
JOIN subscription.Plan p ON p.id = s.planId AND p.serviceId = 3
WHERE o.demo = 0
GROUP BY o.id)
SELECT bp.organisationId, bp.id, bp.signedDate, bp.appliedRate, bp.amount, bp.paybackAmount, (bp.amount-bp.paybackAmount) as OdealGelir FROM odeal.BasePayment bp WHERE bp.signedDate >= CURDATE()


SELECT @Baslangic:="2024-01-01 00:00:00",
       @Bitis:="2024-03-31 23:59:59";


SELECT o.id as UyeIsyeriId, o.marka, o.unvan, o.vergiNo, m.tckNo,
       COUNT(CASE WHEN bp.currentStatus = 9 THEN bp.id END) as KullaniciIptalAdet,
       SUM(CASE WHEN bp.currentStatus = 9 THEN bp.amount END) as KullaniciIptalTutar,
       COUNT(CASE WHEN bp.currentStatus = 13 THEN bp.id END) as IadeAdet,
        SUM(CASE WHEN bp.currentStatus = 13 THEN bp.amount END) as IadeTutar
FROM odeal.Organisation o
LEFT JOIN odeal.Merchant m ON m.organisationId = o.id AND m.role = 0
JOIN odeal.BasePayment bp ON bp.organisationId = o.id
WHERE o.demo = 0  AND bp.currentStatus IN (9,13) AND bp.serviceId <> 3
                                      AND bp.paymentType <> 4
                                      AND bp.signedDate >= @Baslangic
                                      AND bp.signedDate <= @Bitis
GROUP BY o.id, m.tckNo;


UNION
SELECT o.id as UyeIsyeriId,
       o.marka as Marka,
       o.unvan as Unvan,
       o.activatedAt as AktivasyonTarihi,
       IF(isActivated=1,'Aktif','Pasif') as UyeDurum,
       o.deActivatedAt as DeaktivasyonTarihi,
       o.vergiNo as VKN,
       o.id as MaliNo,
       ser.name as Hizmet,
       IF(s.status=1,"Aktif","Pasif") as HizmetDurum,
       o.address as Adres,
       COUNT(CASE WHEN bp.currentStatus = 9 THEN bp.id END) as KullaniciIptalAdet,
       SUM(CASE WHEN bp.currentStatus = 9 THEN bp.amount END) as KullaniciIptalTutar,
       COUNT(CASE WHEN bp.currentStatus = 13 THEN bp.id END) as IadeAdet,
       SUM(CASE WHEN bp.currentStatus = 13 THEN bp.amount END) as IadeTutar
       -- COUNT(bp.id) as IslemAdet,
       -- SUM(bp.amount) as IslemTutar,
       -- SUM(bp.paybackAmount) as GeriOdemeTutar
FROM odeal.Organisation o
JOIN subscription.Subscription s ON s.organisationId = o.id
JOIN subscription.Plan p ON p.id = s.planId AND p.serviceId = 3
JOIN subscription.Service ser ON ser.id = p.serviceId
JOIN odeal.BasePayment bp ON bp.organisationId = o.id
JOIN odeal.Payment pay ON pay.id = bp.id
WHERE  s.id IN (SELECT MAX(s.id) FROM odeal.Organisation o
JOIN subscription.Subscription s ON s.organisationId = o.id
JOIN subscription.Plan p ON p.id = s.planId AND p.serviceId = 3
WHERE o.demo = 0
GROUP BY o.id)  AND bp.currentStatus IN (9,13) AND bp.serviceId = 3
                                      AND bp.paymentType <> 4
                                      AND bp.signedDate >= @Baslangic
                                      AND bp.signedDate <= @Bitis
GROUP BY o.id, o.marka,
         o.unvan, o.activatedAt,
         IF(isActivated=1,'Aktif','Pasif'), o.deActivatedAt,
         o.vergiNo, o.id, ser.name,
         IF(s.status=1,"Aktif","Pasif"), o.address) as Uye;