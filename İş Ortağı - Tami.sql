SELECT o.id as UyeID, t.serial_no as MaliNo, c.name as Kanal, o.vergiNo as VKN, m.tckNo as TCKN, o.activatedAt as UyeAktivasyonTarihi, o.deActivatedAt as UyeIptalTarihi  FROM odeal.Organisation o
JOIN odeal.Terminal t ON t.organisation_id = o.id
JOIN odeal.Channel c ON c.id = t.channelId
LEFT JOIN odeal.Merchant m ON m.organisationId = o.id AND m.role = 0
WHERE t.channelId = 195 AND o.demo = 0


SELECT * FROM odeal.Channel c
WHERE c.name LIKE "%paratika%"

SELECT o.id as UyeID, t.serial_no as MaliNo, c.name as Kanal, o.vergiNo as VKN, m.tckNo as TCKN, IF(o.isActivated=1,"Aktif","Pasif") as UyeDurum,
       o.activatedAt as UyeAktivasyonTarihi, IF(o.deActivatedAt>o.activatedAt,o.deactivatedAt,NULL) as UyeIptalTarihi,
       DATE_FORMAT(bp.signedDate,"%Y-%m-%d") as Gun, SUM(bp.amount) as Ciro  FROM odeal.Organisation o
JOIN odeal.Terminal t ON t.organisation_id = o.id
JOIN odeal.Channel c ON c.id = t.channelId
LEFT JOIN odeal.Merchant m ON m.organisationId = o.id AND m.role = 0
JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.paymentType <> 4
WHERE t.channelId = 195 AND o.demo = 0
GROUP BY o.id, t.serial_no, c.name, o.vergiNo, m.tckNo, o.activatedAt, o.deActivatedAt, DATE_FORMAT(bp.signedDate,"%Y-%m-%d")