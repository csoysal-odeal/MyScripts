 SELECT DISTINCT t.organisation_id as UyeID, t.id as TerminalID, DATE(bp.signedDate) as IslemTarih, bp.appliedRate, CASE WHEN bp.appliedRate = 0 THEN '0 Komisyonlu Ciro' ELSE 'Diğer Ciro' END as KomisyonDurum,
                COUNT(bp.id) as IslemAdedi, SUM(bp.amount) as Ciro, bi.type as GeriOdeme, A.SonrakiTarih, s.request_date as FibaBasvuruTarihi, A.PlanName
FROM (SELECT *, IFNULL(LEAD(SH.OlusmaTarihi) OVER (PARTITION BY SH.terminalId ORDER BY SH.OlusmaTarihi),NOW()) as SonrakiTarih, p.name as PlanName
      FROM (
SELECT sh.terminalId,
       sh.subscriptionId,
       MIN(sh._createdDate) as OlusmaTarihi,
       MIN(sh.planId) as PlanID
FROM subscription.SubscriptionHistory sh
WHERE sh._createdDate >= '2024-05-01 00:00:00'
GROUP BY sh.terminalId, sh.subscriptionId, sh.planId) as SH
LEFT JOIN subscription.Plan p ON p.id = SH.PlanID) as A
JOIN odeal.Terminal t ON t.id = A.terminalId
LEFT JOIN payout_source.source s ON s.terminal_id = t.id AND s.type = 'FIBACARD'
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.paymentType IN (0,1,2,3,6,7,8)
AND bp.signedDate >= s.request_date AND bp.signedDate <= A.SonrakiTarih -- AND bp.amount > 1
LEFT JOIN odeal.Payback pay ON pay.id = bp.paybackId
LEFT JOIN odeal.BankInfo bi ON bi.id = pay.bankInfoId
WHERE bp.appliedRate IS NOT NULL AND A.terminalId IN (SELECT DISTINCT Kart.terminal_id FROM (
SELECT s.terminal_id, COUNT(*) FROM payout_source.source s
WHERE s.terminal_id IS NOT NULL AND s.type = 'FIBACARD'
GROUP BY s.terminal_id) as Kart) AND (bi.type = 'FIBACARD' OR bi.type = 'SEKERCARD' OR bi.type = 'IBAN')
  AND (A.PlanName LIKE '%FIBA%' OR A.PlanName LIKE '%OdealKart%') AND t.organisation_id = 301186049 AND t.id = 205113
GROUP BY t.organisation_id, t.id, bp.appliedRate, bi.type, DATE(bp.signedDate),
         CASE WHEN bp.appliedRate = 0 THEN '0 Komisyonlu Ciro' ELSE 'Diğer Ciro' END, A.SonrakiTarih, s.request_date, A.PlanName


SELECT o.id, t.serial_no, s.id, p.name FROM odeal.Organisation o
JOIN odeal.Terminal t ON t.organisation_id = o.id
LEFT JOIN subscription.Subscription s ON s.id = t.subscription_id
LEFT JOIN subscription.Plan p ON p.id = s.planId
WHERE t.id = 205113

SELECT sh.terminalId, sh.planId FROM subscription.SubscriptionHistory sh
                                LEFT JOIN subscription.Plan p ON p.id = sh.planId
                                WHERE sh.terminalId = 205113

SELECT t.organisation_id, m.tckNo as tc_no, o.vergiNo as tax_no, GROUP_CONCAT(t.id,":",t.serial_no) as terminals  FROM odeal.Terminal t
LEFT JOIN odeal.Merchant m ON m.organisationId = t.organisation_id AND m.role = 0
LEFT JOIN odeal.Organisation o ON o.id = t.organisation_id
WHERE t.supplier = "INGENICO" and t.terminalStatus = 1
GROUP BY t.organisation_id, m.tckNo, o.vergiNo