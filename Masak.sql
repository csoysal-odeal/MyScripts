
# Aynı Gün aynı kart ile farklı şehir 10K üzeri işlem yapılan üye işyerleri
SELECT * FROM (
SELECT *,
       COUNT(Islemler4.Sehir) over (PARTITION BY Islemler4.cardNumber, Islemler4.Sehir ORDER BY Islemler4.Gun) AS SehirAdet
FROM (
SELECT *,
       IF(Islemler3.Gun=Islemler3.OncekiGun,"Aynı Gün","Farklı Gün") as Durum,
       COUNT(Islemler3.Gun) OVER (PARTITION BY Islemler3.cardNumber, Islemler3.Gun) AS Adet
       FROM (
SELECT * FROM (
SELECT *,
        LAG(Islemler.Gun) OVER (PARTITION BY Islemler.cardNumber ORDER BY DATE(Islemler.Gun)) as OncekiGun FROM (
SELECT o.id, o.marka, o.unvan, sec.sector_name as Sektor, c.name as Sehir, o.activatedAt, bp.cardNumber, DATE(bp.signedDate) as Gun,
       SUM(bp.amount) as Ciro,
        ROW_NUMBER() over (partition by bp.cardNumber, DATE(bp.signedDate) ORDER BY DATE(bp.signedDate)) as Sira
FROM odeal.Terminal t
JOIN odeal.Organisation o ON o.id = t.organisation_id
JOIN odeal.Sector sec ON sec.id = o.sectorId
JOIN odeal.City c ON c.id = o.cityId
JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
JOIN odeal.BasePayment bp ON bp.id = tp.id
WHERE bp.signedDate >= "2024-01-01 00:00:00" AND bp.amount > 10000
AND bp.paymentType <> 4 AND bp.currentStatus = 6 AND bp.cardNumber IS NOT NULL
GROUP BY bp.cardNumber, o.id, DATE(bp.signedDate)
) as Islemler) as Islemler2) as Islemler3) as Islemler4 WHERE Islemler4.Adet > 1) as Islemler5 WHERE Islemler5.SehirAdet = 1;

SELECT *,
       TIMESTAMPDIFF(MINUTE, Islemler2.OncekiIslemTarihi, Islemler2.IslemTarihi) as FarkDakika FROM (
SELECT *,
       LAG(Islemler.IslemTarihi) OVER (PARTITION BY Islemler.id, Islemler.Gun ORDER BY Islemler.IslemTarihi) as OncekiIslemTarihi
       FROM (
SELECT o.id, o.unvan, o.marka, t.serial_no, bp.cardNumber, DATE(bp.signedDate) as Gun, bp.signedDate as IslemTarihi, bp.amount as Ciro,
       IF((bp.amount MOD 1)=0,"Küsuratsız","Küsurlu") as IslemDurum,
       COUNT(DATE(bp.signedDate)) OVER (PARTITION BY o.id, DATE(bp.signedDate)) AS Adet
FROM odeal.Terminal t
JOIN odeal.Organisation o ON o.id = t.organisation_id
JOIN odeal.Sector s ON s.id = o.sectorId
JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
JOIN odeal.BasePayment bp ON bp.id = tp.id
WHERE bp.signedDate >= "2023-01-01 00:00:00" AND bp.amount > 10000
AND bp.paymentType <> 4 AND bp.currentStatus = 6 AND bp.cardNumber IS NOT NULL
AND IF((bp.amount MOD 1)=0,"Küsuratsız","Küsurlu") = "Küsuratsız"
ORDER BY o.id, bp.signedDate) as Islemler WHERE Islemler.Adet > 2) as Islemler2

SELECT bp.organisationId, MIN(bp.signedDate), MAX(bp.signedDate),  SUM(bp.amount) as Ciro, IF((bp.amount MOD 1)=0,"Küsuratsız","Küsurlu") FROM odeal.BasePayment bp
WHERE bp.signedDate >= "2023-01-01 00:00:00" AND bp.currentStatus = 6 AND bp.paymentType <> 4 AND bp.organisationId = 301152938
GROUP BY bp.organisationId, IF((bp.amount MOD 1)=0,"Küsuratsız","Küsurlu");


SELECT * FROM silinecek_ilkay i;


       WHERE  IF(Islemler3.Gun=Islemler3.OncekiGun,"Aynı Gün","Farklı Gün") = "Aynı Gün"
       AND bp.cardNumber = "404308******4012"




SELECT o.id as UyeIsyeriID, o.marka as UyeMarka, ilce.name as Ilce, il.name as Il, o.unvan as UyeUnvan,
       CASE
WHEN o.businessType=0 THEN "Bireysel"
WHEN o.businessType=1 THEN "Şahıs"
WHEN o.businessType=2 THEN "Tüzel"
WHEN o.businessType=3 THEN "Dernek vb"
ELSE "Bilinmeyen"
END as IsyeriTipi,
       o.activatedAt as UyeAktivasyonTarihi, IF(o.isActivated=1,"Aktif","Pasif") as UyeDurum, sec.sector_name as Sektor,
       o.vergiNo as VergiNo, m.tckNo as TckNo, CONCAT(m.firstName," ",m.LastName) as Yetkili, t.serial_no as MaliNo, ser.name as Hizmet,
       t.firstActivationDate as HizmetAktivasyonTarihi,
       IF(t.terminalStatus=1,"Aktif","Pasif") as HizmetDurum, bp.id as IslemID, CASE
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
    WHEN bp.paymentType = 18 THEN "Kart'tan IBAN'a Transfer"
END as IslemTipi, bp.signedDate as IslemTarihi, bp.appliedRate as Komisyon, bp.cardNumber as KartNo, tp.installment as Taksit, bp.amount as IslemTutar
       FROM odeal.Organisation o
JOIN odeal.Sector sec ON sec.id = o.sectorId
LEFT JOIN odeal.Merchant m ON m.organisationId = o.id AND m.role = 0
JOIN odeal.Terminal t ON t.organisation_id = o.id
JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
JOIN odeal.BasePayment bp ON bp.id = tp.id
LEFT JOIN subscription.Subscription s ON s.id = t.subscription_id
LEFT JOIN subscription.Plan p ON p.id = s.planId AND p.serviceId <> 3
LEFT JOIN subscription.Service ser ON ser.id = p.serviceId
LEFT JOIN odeal.Town ilce ON ilce.id = o.townId
LEFT JOIN odeal.City il ON il.id = o.cityId
WHERE bp.currentStatus = 6 AND bp.paymentType <> 4 AND bp.serviceId <> 3
AND bp.signedDate >= "2023-01-01 00:00:00"
AND bp.signedDate <= "2023-01-31 23:59:59";

SELECT bpd.id, bpd.paymentMethod FROM odeal.BasePaymentDetails bpd





SELECT
SELECT o.id as UyeIsyeriID, o.marka as UyeMarka, o.unvan as UyeUnvan,
       CASE
WHEN o.businessType=0 THEN "Bireysel"
WHEN o.businessType=1 THEN "Şahıs"
WHEN o.businessType=2 THEN "Tüzel"
WHEN o.businessType=3 THEN "Dernek vb"
ELSE "Bilinmeyen"
END as IsyeriTipi,
       o.activatedAt as UyeAktivasyonTarihi, IF(o.isActivated=1,"Aktif","Pasif") as UyeDurum, sec.sector_name as Sektor,
       o.vergiNo as VergiNo, m.tckNo as TckNo, CONCAT(m.firstName," ",m.LastName) as Yetkili, "CeptePos" as MaliNo, ser.name as Hizmet,
       s.activationDate as HizmetAktivasyonTarihi,
       IF(s.status=1,"Aktif","Pasif") as HizmetDurum, bp.id as IslemID, CASE
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
    WHEN bp.paymentType = 18 THEN "Kart'tan IBAN'a Transfer"
END as IslemTipi, bp.signedDate as IslemTarihi, bp.appliedRate as Komisyon, bp.cardNumber as KartNo, pay.installment as Taksit, bp.amount as IslemTutar FROM odeal.Organisation o
LEFT JOIN odeal.Merchant m ON m.organisationId = o.id AND m.role = 0
LEFT JOIN odeal.Sector sec ON sec.id = o.sectorId
JOIN subscription.Subscription s ON s.organisationId = o.id
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service ser ON ser.id = p.serviceId AND p.serviceId = 3
JOIN odeal.BasePayment bp ON bp.organisationId = o.id
JOIN odeal.Payment pay ON pay.id = bp.id
WHERE bp.currentStatus = 6 AND bp.serviceId = 3
AND bp.signedDate >= "2023-01-01 00:00:00"
AND bp.signedDate <= "2023-01-31 23:59:59" AND bp.paymentType <> 4 AND s.id IN (
SELECT MAX(s.id) FROM odeal.Organisation o
JOIN subscription.Subscription s ON s.organisationId = o.id
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service ser ON ser.id = p.serviceId AND p.serviceId = 3
GROUP BY o.id);

JOIN odeal.Terminal t ON t.organisation_id = o.id
JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
JOIN odeal.BasePayment bp ON bp.id = tp.id
WHERE bp.currentStatus = 6
AND bp.signedDate >= "2023-01-01 00:00:00"
AND bp.signedDate <= "2023-12-31 23:59:59") as Islem