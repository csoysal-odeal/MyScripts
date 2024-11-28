
SELECT o.id as UyeIsyeriID,
       c2.name as UyeKanal,
       IF(o.isActivated=1,"Aktif","Pasif") as UyeDurum,
       s.id as AbonelikID,
       s.activationDate as AktivasyonTarihi,
       p.name as Plan,
       ser.name as Hizmet,
       c.name as Kanal,
       (SELECT COUNT(bp.id) FROM odeal.BasePayment bp
        WHERE bp.currentStatus = 6 AND bp.serviceId = 3 AND bp.organisationId = o.id GROUP BY bp.organisationId) as IslemAdet,
       (SELECT SUM(bp.amount) FROM odeal.BasePayment bp
        WHERE bp.currentStatus = 6 AND bp.serviceId = 3 AND bp.organisationId = o.id GROUP BY bp.organisationId) as Ciro
FROM odeal.Organisation o
JOIN subscription.Subscription s ON s.organisationId = o.id
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service ser ON ser.id = p.serviceId
JOIN odeal.Channel c ON c.id = s.channelId
JOIN odeal.Channel c2 ON c2.id = o.channelId
WHERE p.serviceId = 3 AND c.name <> "ÖDEAL" AND o.demo = 0 AND
      s.id IN (SELECT MAX(s.id) FROM odeal.Organisation o
JOIN subscription.Subscription s ON s.organisationId = o.id
JOIN subscription.Plan p ON p.id = s.planId
WHERE p.serviceId = 3 AND s.status = 1 AND o.isActivated = 1
GROUP BY o.id)

SELECT EmlakKatilim.Durum, GROUP_CONCAT(EmlakKatilim.Islem),  COUNT(*) FROM (
SELECT Islemler.UyeID, Islemler.serial_no, MAX(Islemler.IslemID) as Islem, IF(Islemler.KanalTip=Islemler.TerminalTip AND Islemler.KanalIban = Islemler.TerminalIban, "AYNI", "FARKLI") as Durum  FROM (
SELECT o.id as UyeID, t.serial_no, c.name, bp.id as IslemID, bp.signedDate, bp.appliedRate, bp.amount as IslemTutar, p.id as GeriOdemeID, p.amount as GeriOdeme, p.paidDate, p.dueDate, bi.type as KanalTip, bi.iban as KanalIban,
       bi2.type as TerminalTip, bi2.iban as TerminalIban FROM odeal.Organisation o
JOIN odeal.Terminal t ON t.organisation_id = o.id
JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
JOIN odeal.Channel c ON c.id = t.channelId
JOIN odeal.BasePayment bp ON bp.id = tp.id
LEFT JOIN odeal.Payback p ON p.id = bp.paybackId
LEFT JOIN odeal.BankInfo bi ON bi.id = c.bankInfoId
LEFT JOIN odeal.BankInfo bi2 ON bi2.id = t.bankInfoId
WHERE bp.currentStatus = 6 AND bp.signedDate >= DATE_FORMAT(DATE_SUB(CURDATE(), INTERVAL 1 DAY),"%Y-%m-%d 00:00:00")
AND c.id = 136) as Islemler GROUP BY Islemler.UyeID, Islemler.serial_no, IF(Islemler.KanalTip=Islemler.TerminalTip AND Islemler.KanalIban = Islemler.TerminalIban, "AYNI", "FARKLI")) as EmlakKatilim
GROUP BY EmlakKatilim.Durum

SELECT * FROM odeal.Channel c WHERE c.name LIKE "%emlak%"

SELECT * FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN subscription.Plan p ON p.id = s.planId AND p.serviceId = 7

SELECT bp.organisationId, t.serial_no, bi.iban, bi.type, bi.bank, bi.owner, bp.signedDate, bp.amount, p.id, p.bankInfoId, p.amount FROM odeal.BasePayment bp
LEFT JOIN odeal.Payback p ON p.id = bp.paybackId
LEFT JOIN odeal.TerminalPayment tp ON tp.id = bp.id
LEFT JOIN odeal.Terminal t ON t.id = tp.terminal_id
LEFT JOIN odeal.BankInfo bi ON bi.id = t.bankInfoId
WHERE bp.id = 739737310

SELECT * FROM odeal.BankInfo bi WHERE bi.id = 333440

SELECT SUM(bp.amount) FROM odeal.BasePayment bp
WHERE bp.currentStatus = 6 AND bp.serviceId = 3 AND bp.organisationId = o.id

SELECT DATE_FORMAT(DATE_SUB(CURDATE(),INTERVAL 1 MONTH),"%Y-%m-01 00:00:00");

SELECT * FROM payout_source.source s WHERE s.merchant_id = 301273979

SELECT bp.id, bp.signedDate, bp.amount, p.id, p.amount,p.dueDate, p.paidDate, c.name FROM odeal.BasePayment bp
JOIN odeal.TerminalPayment tp ON tp.id = bp.id
JOIN odeal.Terminal t ON t.id = tp.terminal_id
JOIN odeal.Channel c ON c.id = t.channelId
JOIN odeal.Payback p ON p.id = bp.paybackId
WHERE bp.currentStatus = 6 AND bp.organisationId = 301273979 AND bp.signedDate >= "2024-11-01 00:00:00"

SELECT * FROM payout_source.card_transaction ct WHERE ct.card_number = 1201242460005826705