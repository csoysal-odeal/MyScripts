SELECT o.id as UyeID, IF(o.isActivated=1,"Aktif","Pasif") AS UyeDurum, o.activatedAt as UyeAktivasyonTarihi, t.serial_no as MaliNo, t.id as TerminalID, t.firstActivationDate as TerminalAktivasyonTarihi, 
IF(t.terminalStatus=1,"Aktif","Pasif") AS TerminalDurum, s2.name AS Hizmet, s.id as AbonelikID, s.activationDate as AbonelikAktivasyonTarihi, s.cancelledAt as AbonelikIptalTarihi,
p.id as PlanID, p.name as Plan,
IF(ISNULL(TerminalOzelKomisyon.TekCekimTerminalKomisyon) = FALSE, TerminalOzelKomisyon.TekCekimTerminalKomisyon,
	IF (ISNULL(UyeOzelKomisyon.TekCekimUyeKomisyon) = FALSE, UyeOzelKomisyon.TekCekimUyeKomisyon,
		IF (ISNULL(p.commissionRates) = FALSE, JSON_UNQUOTE(JSON_EXTRACT(p.commissionRates, '$."1"')), BazKomisyon.TekCekimBazKomisyon))) as TekCekimKomisyon,
	IF(ISNULL(TerminalOzelKomisyon.OlusmaTarihi) = FALSE, TerminalOzelKomisyon.OlusmaTarihi,
	IF (ISNULL(UyeOzelKomisyon.OlusmaTarihi) = FALSE, UyeOzelKomisyon.OlusmaTarihi,
		IF (ISNULL(p._createdDate) = FALSE, p._createdDate, BazKomisyon.OlusmaTarihi))) as OlusmaTarihi,
		COALESCE(BazKomisyon.SonlanmaTarihi,
		TerminalOzelKomisyon.SonlanmaTarihi,
		UyeOzelKomisyon.SonlanmaTarihi) as SonlanmaTarihi,
p.commissionRates as PlanKomisyon,
UyeOzelKomisyon.UyeOzelKomisyon, 
TerminalOzelKomisyon.TerminalKomisyon, 
BazKomisyon.BazKomisyon
FROM odeal.Organisation o 
JOIN odeal.Terminal t ON t.organisation_id = o.id -- AND t.terminalStatus = 1
JOIN subscription.Subscription s ON s.id = t.subscription_id -- AND s.status = 1
JOIN subscription.Plan p ON p.id = s.planId 
JOIN subscription.Service s2 ON s2.id = p.serviceId
	LEFT JOIN (SELECT ir.organisationId as UyeIsyeriID,MAX(ir._createdDate) as OlusmaTarihi, MAX(ir.expiryDate) as SonlanmaTarihi,
(SELECT Tekil1.UyeKomisyon FROM (
SELECT *, ROW_NUMBER() OVER (PARTITION BY Tekil.organisationId ORDER BY Tekil.name) as Sira
FROM (
SELECT T1.UyeKomisyon, T1.organisationId, T1.name FROM (
SELECT ir2.id, s2.name, ir2.installment, ir2.status, ir2.comission as UyeKomisyon, ir2.organisationId,
ROW_NUMBER() OVER (PARTITION BY ir2.organisationId, ir2.installment, ir2.comission, ir2.serviceId ORDER BY ir2.id) as Sira
FROM odeal.InstallmentRule ir2
LEFT JOIN subscription.Service s2 ON s2.id = ir2.serviceId 
WHERE ir2.organisationId IS NOT NULL AND ir2.brandId = 27 AND ir2.status = 2 AND s2.id <> 3 AND ir2.cardBinType = "LOCAL" AND ir2.installment = 1) as T1
WHERE T1.Sira = 1) as Tekil) AS Tekil1 WHERE Tekil1.Sira = 1 AND Tekil1.organisationId = ir.organisationId) as TekCekimUyeKomisyon,
GROUP_CONCAT("Hizmet : ",s.name," / Taksit : ",ir.installment," / Komisyon Oran : ",ir.comission) as UyeOzelKomisyon, IF(ir.status=2,"Aktif","Pasif") as Durum FROM odeal.InstallmentRule ir 
LEFT JOIN subscription.Service s ON s.id = ir.serviceId
LEFT JOIN subscription.Plan p ON p.id = ir.planId
LEFT JOIN odeal.Terminal t ON t.id = ir.terminalId 
LEFT JOIN odeal.Organisation o ON o.id = ir.organisationId 
WHERE ir.organisationId IS NOT NULL AND ir.brandId = 27 AND ir.status = 2 AND ir.cardBinType = "LOCAL" AND ir.serviceId <> 3
GROUP BY ir.organisationId, o.marka) as UyeOzelKomisyon ON UyeOzelKomisyon.UyeIsyeriID = o.id
	LEFT JOIN (SELECT t.organisation_id as UyeIsyeriID, t.serial_no as MaliNo, t.id, ir.terminalId as TerminalID, MAX(ir._createdDate) as OlusmaTarihi, MAX(ir.expiryDate) as SonlanmaTarihi,
(SELECT TekilKomisyon.Komisyon1 FROM (
SELECT ir2.terminalId, ir2.comission as Komisyon1, ir2.id,
ROW_NUMBER() OVER (PARTITION BY ir2.terminalId, ir2.comission ORDER BY ir2.id) as Sira
FROM odeal.InstallmentRule ir2 
WHERE ir2.terminalId IS NOT NULL AND ir2.brandId = 27 AND ir2.cardBinType = "LOCAL" AND ir2.status = 2 AND ir2.installment = 1) as TekilKomisyon
WHERE TekilKomisyon.Sira = 1 AND TekilKomisyon.terminalId = ir.terminalId) as TekCekimTerminalKomisyon,
GROUP_CONCAT(" Taksit : ",ir.installment," / Komisyon Oran : ",ir.comission) as TerminalKomisyon FROM odeal.InstallmentRule ir
LEFT JOIN subscription.Service s ON s.id = ir.serviceId
LEFT JOIN subscription.Plan p ON p.id = ir.planId
LEFT JOIN odeal.Terminal t ON t.id = ir.terminalId
LEFT JOIN odeal.Organisation o ON o.id = t.organisation_id
WHERE ir.terminalId IS NOT NULL AND ir.brandId = 27 AND ir.status = 2 AND ir.cardBinType = "LOCAL"
GROUP BY t.organisation_id, t.serial_no, ir.terminalId) as TerminalOzelKomisyon ON TerminalOzelKomisyon.TerminalID = t.id
LEFT JOIN (SELECT s.id as ServisID, s.name as Servis, MAX(ir._createdDate) as OlusmaTarihi, MAX(ir.expiryDate) as SonlanmaTarihi,
(SELECT ir2.comission as TekCekimKomisyon  FROM odeal.InstallmentRule ir2 
WHERE ir2.sectorId IS NULL AND ir2.cardBinType = "LOCAL"
AND ir2.planId IS NULL AND ir2.organisationId IS NULL AND ir2.installment = 1
AND ir2.serviceId IS NOT NULL AND ir2.status = 2 AND ir2.serviceId = ir.serviceId) as TekCekimBazKomisyon,
GROUP_CONCAT(" Taksit : ",ir.installment," / Komisyon Oran :  ",ir.comission) as BazKomisyon 
FROM odeal.InstallmentRule ir 
LEFT JOIN subscription.Service s ON s.id = ir.serviceId 
LEFT JOIN subscription.Plan p ON p.id = ir.planId
LEFT JOIN odeal.Terminal t ON t.id = ir.terminalId 
LEFT JOIN odeal.Organisation o ON o.id = ir.organisationId 
WHERE ir.sectorId IS NULL AND ir.planId IS NULL AND ir.organisationId IS NULL AND ir.cardBinType = "LOCAL" AND ir.serviceId IS NOT NULL AND ir.status = 2
GROUP BY s.id, s.name, ir.serviceId) as BazKomisyon ON BazKomisyon.ServisID = s2.id
WHERE o.isActivated = 1 AND o.demo = 0

SELECT o.id, t.id, t.serial_no FROM odeal.Organisation o 
JOIN odeal.Terminal t ON t.organisation_id = o.id
WHERE o.id = 301080355 AND t.serial_no = "BCJ00025790";

SELECT * FROM odeal.InstallmentRule ir WHERE ir.terminalId = 161253

SELECT * FROM odeal.InstallmentRule ir WHERE ir.organisationId = 301027493

SELECT * FROM odeal.InstallmentRule ir WHERE ir.serviceId = 5

SELECT JSON_UNQUOTE(JSON_EXTRACT(p.commissionRates, '$."1"')) as Komisyon
FROM subscription.Plan p 
WHERE p.id = 19124;

SELECT * FROM odeal.POS pos


SELECT o.id, GROUP_CONCAT(t.serial_no," - ") FROM odeal.Organisation o 
JOIN odeal.Terminal t ON t.organisation_id = o.id
GROUP BY o.id

SELECT * FROM odeal.InstallmentRule ir WHERE ir.terminalId = 93438 AND ir.installment = 1

SELECT History.terminalId, History.planId, History.subscriptionId, History.activationDate as GecerlilikBaslangic,
LEAD(History.activationDate, 1,0) OVER (PARTITION BY History.terminalId ORDER BY History.activationDate) as Sonraki 
FROM (
SELECT sh.terminalId, sh.planId, p.commissionRate, p.commissionRates, sh.subscriptionId, MAX(sh.activationDate) as activationDate FROM subscription.SubscriptionHistory sh
JOIN subscription.Plan p ON p.id = sh.planId
WHERE sh.terminalId IS NOT NULL
GROUP BY sh.terminalId, sh.planId, p.commissionRate, p.commissionRates, sh.subscriptionId) as History;


SELECT t.organisation_id as UyeIsyeriID, t.serial_no as MaliNo, t.id, ir.terminalId as TerminalID, MAX(ir._createdDate) as OlusmaTarihi, MAX(ir.expiryDate) as SonlanmaTarihi,
(SELECT TekilKomisyon.Komisyon1 FROM (
SELECT ir2.terminalId, ir2.comission as Komisyon1, ir2.id,
ROW_NUMBER() OVER (PARTITION BY ir2.terminalId, ir2.comission ORDER BY ir2.id) as Sira
FROM odeal.InstallmentRule ir2
WHERE ir2.terminalId IS NOT NULL AND ir2.brandId = 27 AND ir2.cardBinType = "LOCAL" AND ir2.status = 2 AND ir2.installment = 1) as TekilKomisyon
WHERE TekilKomisyon.Sira = 1 AND TekilKomisyon.terminalId = ir.terminalId) as TekCekimTerminalKomisyon,
GROUP_CONCAT(" Taksit : ",ir.installment," / Komisyon Oran : ",ir.comission) as TerminalKomisyon FROM odeal.InstallmentRule ir
LEFT JOIN subscription.Service s ON s.id = ir.serviceId
LEFT JOIN subscription.Plan p ON p.id = ir.planId
LEFT JOIN odeal.Terminal t ON t.id = ir.terminalId
LEFT JOIN odeal.Organisation o ON o.id = t.organisation_id
WHERE ir.terminalId IS NOT NULL AND ir.brandId = 27 AND ir.status = 2 AND ir.cardBinType = "LOCAL" AND ir.terminalId = 93438
GROUP BY t.organisation_id, t.serial_no, ir.terminalId


-- CeptePos Özel Komisyon
SELECT * FROM (
  SELECT o.id as UyeID, IF(o.isActivated=1,"Aktif","Pasif") AS UyeDurum, o.activatedAt as UyeAktivasyonTarihi,
 s2.name AS Hizmet, s.id as AbonelikID, s.activationDate as AbonelikAktivasyonTarihi, s.cancelledAt as AbonelikIptalTarihi,
p.id as PlanID, p.name as Plan,
    IF (ISNULL(UyeOzelKomisyon.TekCekimUyeKomisyon) = FALSE, UyeOzelKomisyon.TekCekimUyeKomisyon,
        IF (ISNULL(p.commissionRates) = FALSE, JSON_UNQUOTE(JSON_EXTRACT(p.commissionRates, '$."1"')), BazKomisyon.TekCekimBazKomisyon)) as TekCekimKomisyon,
    IF (ISNULL(s.activationDate) = FALSE, s.activationDate,
        IF (ISNULL(UyeOzelKomisyon.OlusmaTarihi) = FALSE, UyeOzelKomisyon.OlusmaTarihi, BazKomisyon.OlusmaTarihi)) as OlusmaTarihi,
        COALESCE(BazKomisyon.SonlanmaTarihi,
        UyeOzelKomisyon.SonlanmaTarihi) as SonlanmaTarihi,
p.commissionRates as PlanKomisyon,
UyeOzelKomisyon.UyeOzelKomisyon,
BazKomisyon.BazKomisyon,
ROW_NUMBER() OVER (PARTITION BY o.id ORDER BY s.activationDate DESC) as Sira
FROM odeal.Organisation o
JOIN subscription.Subscription s ON s.organisationId = o.id AND s.status = 1
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
    LEFT JOIN (SELECT ir.organisationId as UyeIsyeriID,MAX(ir._createdDate) as OlusmaTarihi, MAX(ir.expiryDate) as SonlanmaTarihi,
(SELECT Tekil1.UyeKomisyon FROM (
SELECT *, ROW_NUMBER() OVER (PARTITION BY Tekil.organisationId ORDER BY Tekil.name) as Sira
FROM (
SELECT T1.UyeKomisyon, T1.organisationId, T1.name FROM (
SELECT ir2.id, s2.name, ir2.installment, ir2.status, ir2.comission as UyeKomisyon, ir2.organisationId,
ROW_NUMBER() OVER (PARTITION BY ir2.organisationId, ir2.installment, ir2.comission, ir2.serviceId ORDER BY ir2.id) as Sira
FROM odeal.InstallmentRule ir2
LEFT JOIN subscription.Service s2 ON s2.id = ir2.serviceId
WHERE ir2.organisationId IS NOT NULL AND ir2.brandId = 27 AND ir2.status = 2 AND s2.id = 3 AND ir2.cardBinType = "LOCAL" AND ir2.installment = 1) as T1
WHERE T1.Sira = 1) as Tekil) AS Tekil1 WHERE Tekil1.Sira = 1 AND Tekil1.organisationId = ir.organisationId) as TekCekimUyeKomisyon,
GROUP_CONCAT("Hizmet : ",s.name," / Taksit : ",ir.installment," / Komisyon Oran : ",ir.comission) as UyeOzelKomisyon, IF(ir.status=2,"Aktif","Pasif") as Durum
FROM odeal.InstallmentRule ir
LEFT JOIN subscription.Service s ON s.id = ir.serviceId
LEFT JOIN subscription.Plan p ON p.id = ir.planId
LEFT JOIN odeal.Organisation o ON o.id = ir.organisationId
WHERE ir.organisationId IS NOT NULL AND ir.brandId = 27 AND ir.status = 2 AND ir.cardBinType = "LOCAL" AND ir.serviceId = 3
GROUP BY ir.organisationId, o.marka) as UyeOzelKomisyon ON UyeOzelKomisyon.UyeIsyeriID = o.id
LEFT JOIN (SELECT s.id as ServisID, s.name as Servis, MAX(ir._createdDate) as OlusmaTarihi, MAX(ir.expiryDate) as SonlanmaTarihi,
(SELECT ir2.comission as TekCekimKomisyon  FROM odeal.InstallmentRule ir2
WHERE ir2.sectorId IS NULL
AND ir2.planId IS NULL AND ir2.organisationId IS NULL AND ir2.installment = 1 AND ir2.serviceId = 3
AND ir2.serviceId IS NOT NULL AND ir2.status = 2 AND ir2.serviceId = ir.serviceId) as TekCekimBazKomisyon,
GROUP_CONCAT(" Taksit : ",ir.installment," / Komisyon Oran :  ",ir.comission) as BazKomisyon
FROM odeal.InstallmentRule ir
LEFT JOIN subscription.Service s ON s.id = ir.serviceId
LEFT JOIN subscription.Plan p ON p.id = ir.planId
LEFT JOIN odeal.Organisation o ON o.id = ir.organisationId
WHERE ir.sectorId IS NULL AND ir.planId IS NULL AND ir.organisationId IS NULL AND ir.serviceId IS NOT NULL AND ir.status = 2 AND ir.serviceId = 3
GROUP BY s.id, s.name, ir.serviceId) as BazKomisyon ON BazKomisyon.ServisID = s2.id
WHERE o.isActivated = 1 AND o.demo = 0 AND s2.id = 3 AND s.id IN (
SELECT MAX(s.id)
FROM odeal.Organisation o
JOIN subscription.Subscription s ON s.organisationId = o.id AND s.status = 1
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE s2.id = 3
GROUP BY o.id)) as CepteposKomisyon


-- Fiziki Tek Çekim Özel Komisyon
SELECT * FROM (
  SELECT o.id as UyeID, IF(o.isActivated=1,"Aktif","Pasif") AS UyeDurum,
         o.activatedAt as UyeAktivasyonTarihi, t.serial_no as MaliNo,
         t.id as TerminalID, t.firstActivationDate as TerminalAktivasyonTarihi,
IF(t.terminalStatus=1,"Aktif","Pasif") AS TerminalDurum,
s2.name AS Hizmet, s.id as AbonelikID,
s.activationDate as AbonelikAktivasyonTarihi, s.cancelledAt as AbonelikIptalTarihi,
p.id as PlanID, p.name as Plan,
IF(ISNULL(TerminalOzelKomisyon.TekCekimTerminalKomisyon) = FALSE, TerminalOzelKomisyon.TekCekimTerminalKomisyon,
    IF (ISNULL(UyeOzelKomisyon.TekCekimUyeKomisyon) = FALSE, UyeOzelKomisyon.TekCekimUyeKomisyon,
        IF (ISNULL(p.commissionRates) = FALSE, JSON_UNQUOTE(JSON_EXTRACT(p.commissionRates, '$."1"')), BazKomisyon.TekCekimBazKomisyon))) as TekCekimKomisyon,
    IF(ISNULL(TerminalOzelKomisyon.OlusmaTarihi) = FALSE, TerminalOzelKomisyon.OlusmaTarihi,
    IF (ISNULL(s.activationDate) = FALSE, s.activationDate,
        IF (ISNULL(UyeOzelKomisyon.OlusmaTarihi) = FALSE, UyeOzelKomisyon.OlusmaTarihi, BazKomisyon.OlusmaTarihi))) as OlusmaTarihi,
        COALESCE(BazKomisyon.SonlanmaTarihi,
        TerminalOzelKomisyon.SonlanmaTarihi,
        UyeOzelKomisyon.SonlanmaTarihi) as SonlanmaTarihi,
p.commissionRates as PlanKomisyon,
UyeOzelKomisyon.UyeOzelKomisyon,
TerminalOzelKomisyon.TerminalKomisyon,
BazKomisyon.BazKomisyon, ROW_NUMBER() OVER (PARTITION BY o.id, t.serial_no ORDER BY s.activationDate DESC) as Sira
FROM odeal.Organisation o
JOIN odeal.Terminal t ON t.organisation_id = o.id -- AND t.terminalStatus = 1
JOIN subscription.Subscription s ON s.id = t.subscription_id -- AND s.status = 1
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
    LEFT JOIN (SELECT ir.organisationId as UyeIsyeriID,MAX(ir._createdDate) as OlusmaTarihi, MAX(ir.expiryDate) as SonlanmaTarihi,
(SELECT Tekil1.UyeKomisyon FROM (
SELECT *, ROW_NUMBER() OVER (PARTITION BY Tekil.organisationId ORDER BY Tekil.name) as Sira
FROM (
SELECT T1.UyeKomisyon, T1.organisationId, T1.name FROM (
SELECT ir2.id, s2.name, ir2.installment, ir2.status, ir2.comission as UyeKomisyon, ir2.organisationId,
ROW_NUMBER() OVER (PARTITION BY ir2.organisationId, ir2.installment, ir2.comission, ir2.serviceId ORDER BY ir2.id) as Sira
FROM odeal.InstallmentRule ir2
LEFT JOIN subscription.Service s2 ON s2.id = ir2.serviceId
WHERE ir2.organisationId IS NOT NULL AND ir2.brandId = 27 AND ir2.status = 2 AND s2.id <> 3 AND ir2.cardBinType = "LOCAL" AND ir2.installment = 1) as T1
WHERE T1.Sira = 1) as Tekil) AS Tekil1 WHERE Tekil1.Sira = 1 AND Tekil1.organisationId = ir.organisationId) as TekCekimUyeKomisyon,
GROUP_CONCAT("Hizmet : ",s.name," / Taksit : ",ir.installment," / Komisyon Oran : ",ir.comission) as UyeOzelKomisyon, IF(ir.status=2,"Aktif","Pasif") as Durum FROM odeal.InstallmentRule ir
LEFT JOIN subscription.Service s ON s.id = ir.serviceId
LEFT JOIN subscription.Plan p ON p.id = ir.planId
LEFT JOIN odeal.Terminal t ON t.id = ir.terminalId
LEFT JOIN odeal.Organisation o ON o.id = ir.organisationId
WHERE ir.organisationId IS NOT NULL AND ir.brandId = 27 AND ir.status = 2 AND ir.cardBinType = "LOCAL" AND ir.serviceId <> 3
GROUP BY ir.organisationId, o.marka) as UyeOzelKomisyon ON UyeOzelKomisyon.UyeIsyeriID = o.id
    LEFT JOIN (SELECT t.organisation_id as UyeIsyeriID, t.serial_no as MaliNo, t.id, ir.terminalId as TerminalID, MAX(ir._createdDate) as OlusmaTarihi, MAX(ir.expiryDate) as SonlanmaTarihi,
(SELECT TekilKomisyon.Komisyon1 FROM (
SELECT ir2.terminalId, ir2.comission as Komisyon1, ir2.id,
ROW_NUMBER() OVER (PARTITION BY ir2.terminalId, ir2.comission ORDER BY ir2.id) as Sira
FROM odeal.InstallmentRule ir2
WHERE ir2.terminalId IS NOT NULL AND ir2.brandId = 27 AND ir2.cardBinType = "LOCAL" AND ir2.status = 2 AND ir2.installment = 1) as TekilKomisyon
WHERE TekilKomisyon.Sira = 1 AND TekilKomisyon.terminalId = ir.terminalId) as TekCekimTerminalKomisyon,
GROUP_CONCAT(" Taksit : ",ir.installment," / Komisyon Oran : ",ir.comission) as TerminalKomisyon FROM odeal.InstallmentRule ir
LEFT JOIN subscription.Service s ON s.id = ir.serviceId
LEFT JOIN subscription.Plan p ON p.id = ir.planId
LEFT JOIN odeal.Terminal t ON t.id = ir.terminalId
LEFT JOIN odeal.Organisation o ON o.id = t.organisation_id
WHERE ir.terminalId IS NOT NULL AND ir.brandId = 27 AND ir.status = 2 AND ir.cardBinType = "LOCAL"
GROUP BY t.organisation_id, t.serial_no, ir.terminalId) as TerminalOzelKomisyon ON TerminalOzelKomisyon.TerminalID = t.id
LEFT JOIN (SELECT s.id as ServisID, s.name as Servis, MAX(ir._createdDate) as OlusmaTarihi, MAX(ir.expiryDate) as SonlanmaTarihi,
(SELECT ir2.comission as TekCekimKomisyon  FROM odeal.InstallmentRule ir2
WHERE ir2.sectorId IS NULL AND ir2.cardBinType = "LOCAL"
AND ir2.planId IS NULL AND ir2.organisationId IS NULL AND ir2.installment = 1
AND ir2.serviceId IS NOT NULL AND ir2.status = 2 AND ir2.serviceId = ir.serviceId) as TekCekimBazKomisyon,
GROUP_CONCAT(" Taksit : ",ir.installment," / Komisyon Oran :  ",ir.comission) as BazKomisyon
FROM odeal.InstallmentRule ir
LEFT JOIN subscription.Service s ON s.id = ir.serviceId
LEFT JOIN subscription.Plan p ON p.id = ir.planId
LEFT JOIN odeal.Terminal t ON t.id = ir.terminalId
LEFT JOIN odeal.Organisation o ON o.id = ir.organisationId
WHERE ir.sectorId IS NULL AND ir.planId IS NULL AND ir.organisationId IS NULL AND ir.cardBinType = "LOCAL" AND ir.serviceId IS NOT NULL AND ir.status = 2
GROUP BY s.id, s.name, ir.serviceId) as BazKomisyon ON BazKomisyon.ServisID = s2.id
WHERE o.isActivated = 1 AND o.demo = 0) as FizikiKomisyon WHERE FizikiKomisyon.Sira = 1;

SELECT * FROM subscription.InvoiceItem

SELECT s.id,p.id, p.name, p.commissionRates, p.commissionRate, p._createdDate, s.activationDate FROM subscription.Subscription s
JOIN subscription.Plan p ON p.id = s.planId WHERE s.id = 616323;

SELECT fp.provider, fp.installment, fp.installmentBrand, COUNT(*) FROM odeal.FailedPayment fp
JOIN odeal.BasePayment bp ON bp.id = fp.id
GROUP BY fp.provider, fp.installment, fp.installmentBrand;

SELECT * FROM odeal.FailedPayment fp ORDER BY fp.failedAt DESC LIMIT 10

SELECT bp.id as IslemId,
       bp.cardNumber,
       bp.organisationId as UyeIsyeriID,
       bp.signedDate as IslemTarihi,
       bp.paymentId as PaymentID,
       bp.amount as Tutar,
       bp.serviceId as Hizmet,
       bp.transactionId as TransactionId,
       fd.id as BasarisizIslemId,
       fd.failedAt as BasarisizIslemTarihi,
       fd.amount as BasarisizIslemTutar,
       fd.provider as BasarisizIslemBank,
       fd.reason as BasarisizIslemNedeni,
       IF(ISNULL(bi.id)=TRUE,"YABANCI","YERLİ") as KartDurum,
       bi.brand, bi.cardType, bi.bankName,
       fd.reasonCode, bpd.basePaymentId, bpd.paymentMethod, bpd.paymentGateway, bpd.paymentChannel,
       bpd.paymentDescription, bpd.createdDate
FROM odeal.BasePayment bp
JOIN odeal.FailedPayment fd ON fd.paymentId = bp.paymentId
LEFT JOIN odeal.BinInfo bi ON bi.bin = SUBSTR(bp.cardNumber,1,6)
LEFT JOIN odeal.BasePaymentDetails bpd ON bpd.basePaymentId = bp.id WHERE bp.serviceId IN (3,8)


SELECT bi.organisationId, bi.type, bi.bank, bi.iban, COUNT(*) FROM odeal.BankInfo bi
                                                              WHERE bi.status = 1 AND bi.type = "IBAN"
GROUP BY bi.organisationId, bi.type, bi.bank, bi.iban HAVING COUNT(*)>1

SELECT *, t.serial_no FROM odeal.BankInfo bi
         JOIN odeal.Terminal t ON t.bankInfoId = bi.id AND t.organisation_id = bi.organisationId AND t.terminalStatus = 1
         WHERE bi.organisationId = 301103289;

SELECT t.serial_no, t.bankInfoId, t.organisation_id FROM odeal.Terminal t WHERE t.organisation_id = 301103289 AND t.terminalStatus = 1


SELECT * FROM (
SELECT o.id as UyeIsyeriID, o.marka as Marka, o.unvan as Unvan, o.activatedAt as UyeAktivasyonTarihi, t.serial_no as MaliNo, t.firstActivationDate as IlkKurulumTarihi, ser.name as Hizmet FROM odeal.Organisation o
JOIN odeal.Terminal t ON t.organisation_id = o.id
JOIN subscription.Subscription s ON s.id = t.subscription_id AND s.status = 1
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service ser ON ser.id = p.serviceId
WHERE p.serviceId <> 3 AND t.terminalStatus = 1 AND o.isActivated = 1 AND t.firstActivationDate <= "2024-06-30 23:59:59"
UNION
SELECT o.id as UyeIsyeriId, o.marka as Marka, o.unvan as Unvan, o.activatedAt as UyeAktivasyonTarihi, o.id as MaliNo, s.activationDate as IlkKurulumTarihi, ser.name as Hizmet FROM odeal.Organisation o
JOIN subscription.Subscription s ON s.organisationId = o.id AND s.status = 1
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service ser ON ser.id = p.serviceId
WHERE p.serviceId = 3 AND s.id IN (
SELECT MAX(s.id) FROM odeal.Organisation o
JOIN subscription.Subscription s ON s.organisationId = o.id AND s.status = 1
JOIN subscription.Plan p ON p.id = s.planId
WHERE p.serviceId = 3
GROUP BY o.id)) as Uyeler ORDER BY Uyeler.UyeIsyeriID



SELECT bp.id, bp.organisationId, bp.appliedRate, bp.amount, bp.signedDate
FROM odeal.BasePayment bp WHERE bp.organisationId = 301000376 AND bp.currentStatus = 6 AND bp.serviceId = 3
ORDER BY bp.signedDate DESC

-- Son 1 Haftalık İşlem Komisyonları
SELECT 
IslemKomisyon.organisationId, 
IslemKomisyon.SeriNo, 
IslemKomisyon.HizmetID, 
IslemKomisyon.Hizmet, 
GROUP_CONCAT(IslemKomisyon.installment," - ",IslemKomisyon.Komisyon) as SonIslemTaksitKomisyon  
FROM (SELECT bp.organisationId AS UyeID, t.serial_no AS SeriNo, tp.installment AS SonIslemTaksit, bp.appliedRate AS SonIslemKomisyon, bp.signedDate AS SonIslemTarih, bp.amount AS SonIslemTutar FROM odeal.BasePayment bp
JOIN odeal.TerminalPayment tp ON tp.id = bp.id 
JOIN odeal.Terminal t ON t.id = tp.terminal_id
WHERE bp.currentStatus = 6 
AND bp.paymentType IN (0,1,2,3,7,8)
AND bp.signedDate >= DATE_SUB(NOW(),INTERVAL 1 DAY) AND bp.signedDate <= NOW() AND bp.id IN (SELECT MAX(bp.id)
FROM odeal.BasePayment bp
JOIN odeal.TerminalPayment tp ON tp.id = bp.id
JOIN odeal.Terminal t ON t.id = tp.terminal_id
JOIN subscription.Service s ON s.id = bp.serviceId
WHERE bp.currentStatus = 6 
AND bp.paymentType IN (0,1,2,3,7,8)
AND bp.signedDate >= DATE_SUB(NOW(),INTERVAL 1 DAY) AND bp.signedDate <= NOW()
GROUP BY bp.organisationId, t.serial_no, s.id, tp.installment, bp.appliedRate)



SELECT bp.organisationId, s.id AS SeriNo, s2.id AS HizmetID, s2.name AS Hizmet, p.installment, MAX(bp.appliedRate) as Komisyon FROM odeal.BasePayment bp
JOIN odeal.Payment p ON p.id = bp.id
JOIN subscription.Subscription s ON s.organisationId
JOIN subscription.Service s2 ON s.id = bp.serviceId
WHERE bp.currentStatus = 6 AND bp.signedDate >= DATE_SUB(NOW(),INTERVAL 1 DAY) AND bp.signedDate <= NOW() AND s.id IN (SELECT MAX(s.id) FROM odeal.Organisation o 
JOIN subscription.Subscription s ON s.organisationId = o.id 
JOIN subscription.Plan p2 ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p2.serviceId 
WHERE s2.id = 3
GROUP BY o.id)
GROUP BY bp.organisationId, s.id, s2.id, s2.name, p.installment


SELECT DATE_SUB(NOW(),INTERVAL 1 HOUR)

SELECT bp.organisationId, bp.signedDate, bp.appliedRate, bp.amount FROM odeal.BasePayment bp WHERE bp.id IN (
SELECT MAX(bp.id) FROM odeal.BasePayment bp
WHERE bp.currentStatus = 6 AND bp.signedDate >= "2024-05-20 00:00:00"
GROUP BY bp.organisationId, bp.appliedRate)


-- Üye Özel Komisyon

SELECT * FROM (
SELECT *, ROW_NUMBER() OVER (PARTITION BY T2.UyeIsyeriID ORDER BY T2.id) as Sira FROM (
SELECT ir.organisationId as UyeIsyeriID, 
(SELECT T1.UyeKomisyon, T1.organisationId, T1.name FROM (
SELECT ir2.id, s2.name, ir2.installment, ir2.status, ir2.comission as UyeKomisyon, ir2.organisationId,
ROW_NUMBER() OVER (PARTITION BY ir2.organisationId, ir2.installment, ir2.comission, ir2.serviceId ORDER BY ir2.id) as Sira
FROM odeal.InstallmentRule ir2
LEFT JOIN subscription.Service s2 ON s2.id = ir2.serviceId 
WHERE ir2.organisationId IS NOT NULL AND ir2.brandId = 27 AND ir2.status = 2 AND ir2.cardBinType = "LOCAL" AND ir2.installment = 1 AND s2.id <>3) as T1
WHERE T1.Sira = 1 -- AND T1.organisationId = ir.organisationId) as TekCekimUyeKomisyon,
GROUP_CONCAT("Hizmet : ",s.name," / Taksit : ",ir.installment," / Komisyon Oran : ",ir.comission) as UyeOzelKomisyon, IF(ir.status=2,"Aktif","Pasif") as Durum 
FROM odeal.InstallmentRule ir 
LEFT JOIN subscription.Service s ON s.id = ir.serviceId
LEFT JOIN subscription.Plan p ON p.id = ir.planId
LEFT JOIN odeal.Terminal t ON t.id = ir.terminalId 
LEFT JOIN odeal.Organisation o ON o.id = ir.organisationId 
WHERE ir.organisationId IS NOT NULL AND ir.brandId = 27 AND ir.status = 2 AND ir.cardBinType = "LOCAL"
GROUP BY ir.organisationId, o.marka) as T2) AS T3 WHERE T3.Sira = 1

-- Terminal Komisyon
SELECT t.organisation_id as UyeIsyeriID, t.serial_no as MaliNo, t.id, ir.terminalId as TerminalID, 
(SELECT TekilKomisyon.Komisyon1 FROM (
SELECT ir2.terminalId, ir2.comission as Komisyon1, ir2.id,
ROW_NUMBER() OVER (PARTITION BY ir2.terminalId, ir2.comission ORDER BY ir2.id) as Sira
FROM odeal.InstallmentRule ir2 
WHERE ir2.terminalId IS NOT NULL AND ir2.brandId = 27 AND ir2.cardBinType = "LOCAL" AND ir2.status = 2 AND ir2.installment = 1) as TekilKomisyon
WHERE TekilKomisyon.Sira = 1 AND TekilKomisyon.terminalId = ir.terminalId) as TekCekimTerminalKomisyon,
GROUP_CONCAT(" Taksit : ",ir.installment," / Komisyon Oran : ",ir.comission) as TerminalKomisyon FROM odeal.InstallmentRule ir
LEFT JOIN subscription.Service s ON s.id = ir.serviceId
LEFT JOIN subscription.Plan p ON p.id = ir.planId
LEFT JOIN odeal.Terminal t ON t.id = ir.terminalId
LEFT JOIN odeal.Organisation o ON o.id = t.organisation_id
WHERE ir.terminalId IS NOT NULL AND ir.brandId = 27 AND ir.status = 2 AND ir.cardBinType = "LOCAL"
GROUP BY t.organisation_id, t.serial_no, ir.terminalId


SELECT * FROM (
SELECT ir2.terminalId, ir2.comission as Komisyon1, ir2.id,
ROW_NUMBER() OVER (PARTITION BY ir2.terminalId, ir2.comission ORDER BY ir2.id) as Sira
FROM odeal.InstallmentRule ir2 
WHERE ir2.terminalId IS NOT NULL AND ir2.brandId = 27 AND ir2.cardBinType = "LOCAL" AND ir2.status = 2 AND ir2.installment = 1 AND ir2.terminalId = ir.terminalId) as TekilKomisyon
WHERE TekilKomisyon.Sira = 1



SELECT * FROM (
SELECT *, ROW_NUMBER() OVER (PARTITION BY Tekil.organisationId ORDER BY Tekil.name) as Sira
FROM (
SELECT T1.UyeKomisyon, T1.organisationId, T1.name FROM (
SELECT ir2.id, s2.name, ir2.installment, ir2.status, ir2.comission as UyeKomisyon, ir2.organisationId,
ROW_NUMBER() OVER (PARTITION BY ir2.organisationId, ir2.installment, ir2.comission, ir2.serviceId ORDER BY ir2.id) as Sira
FROM odeal.InstallmentRule ir2
LEFT JOIN subscription.Service s2 ON s2.id = ir2.serviceId 
WHERE ir2.organisationId IS NOT NULL AND ir2.brandId = 27 AND ir2.status = 2 AND s2.id <> 3 AND ir2.cardBinType = "LOCAL" AND ir2.installment = 1) as T1
WHERE T1.Sira = 1) as Tekil) AS Tekil1 WHERE Tekil1.Sira = 1;


301011862, 301001738

SELECT * FROM (
SELECT ir2.id, s2.name, ir2.installment, ir2.status, ir2.comission as UyeKomisyon, ir2.organisationId,
ROW_NUMBER() OVER (PARTITION BY ir2.organisationId, ir2.installment, ir2.comission, ir2.serviceId ORDER BY ir2.id) as Sira
FROM odeal.InstallmentRule ir2
LEFT JOIN subscription.Service s2 ON s2.id = ir2.serviceId 
WHERE ir2.organisationId IS NOT NULL AND ir2.brandId = 27 AND ir2.status = 2 AND ir2.cardBinType = "LOCAL" AND ir2.installment = 1) as T1
WHERE T1.Sira = 1

-- Plan Komisyon
SELECT s.id as ServisID, s.name as Servis, 
(SELECT ir2.comission as TekCekimKomisyon  FROM odeal.InstallmentRule ir2 
WHERE ir2.sectorId IS NULL AND ir2.cardBinType = "LOCAL"
AND ir2.planId IS NULL AND ir2.organisationId IS NULL AND ir2.installment = 1
AND ir2.serviceId IS NOT NULL AND ir2.status = 2 AND ir2.serviceId = ir.serviceId) as TekCekimBazKomisyon,
GROUP_CONCAT(" Taksit : ",ir.installment," / Komisyon Oran :  ",ir.comission) as BazKomisyon 
FROM odeal.InstallmentRule ir 
LEFT JOIN subscription.Service s ON s.id = ir.serviceId 
LEFT JOIN subscription.Plan p ON p.id = ir.planId
LEFT JOIN odeal.Terminal t ON t.id = ir.terminalId 
LEFT JOIN odeal.Organisation o ON o.id = ir.organisationId 
WHERE ir.sectorId IS NULL AND ir.planId IS NULL AND ir.organisationId IS NULL AND ir.cardBinType = "LOCAL" AND ir.serviceId IS NOT NULL AND ir.status = 2
GROUP BY s.id, s.name, ir.serviceId

SELECT * FROM subscription.PlanHistory ph 

SELECT T1.terminalId, COUNT(*) FROM (
SELECT ir2.terminalId, ir2.comission as Komisyon1 
FROM odeal.InstallmentRule ir2 
WHERE ir2.terminalId IS NOT NULL AND ir2.brandId = 27 AND ir2.cardBinType = "LOCAL" AND ir2.status = 2 AND ir2.installment = 1) AS T1
GROUP BY T1.terminalId HAVING COUNT(*)>1


SELECT t.organisation_id, t.serial_no, ir2.id, ir2.status, ir2.`_createdDate`, ir2.terminalId, ir2.comission as Komisyon1 
FROM odeal.InstallmentRule ir2 
LEFT JOIN odeal.Terminal t ON t.id = ir2.terminalId
WHERE ir2.terminalId IS NOT NULL AND ir2.brandId = 27 AND ir2.cardBinType = "LOCAL" AND ir2.status = 2 AND ir2.installment = 1 AND ir2.terminalId IN (27704,
72686,
94644,
130001,
208785,
218356,
231825)


SELECT t.channelId, SUM(bp.amount) FROM odeal.BasePayment bp 
JOIN odeal.TerminalPayment tp ON tp.id = bp.id 
JOIN odeal.Terminal t ON t.id = tp.terminal_id 
JOIN odeal.Organisation o ON o.id = t.organisation_id
WHERE bp.currentStatus = 6 AND bp.signedDate >= "2024-05-01 00:00:00" AND bp.signedDate <= "2024-05-31 23:59:59"
AND t.channelId = 267;

SELECT * FROM odeal.InstallmentRule ir WHERE ir.serviceId = 2 AND ir.organisationId IS NULL AND ir.planId IS NULL AND ir.status = 2

SELECT * FROM odeal.
SELECT MAX(s.id) FROM odeal.Organisation o 
JOIN subscription.Subscription s ON s.organisationId = o.id
JOIN subscription.Plan p ON p.id = s.planId AND p.serviceId = 3
GROUP BY o.id


