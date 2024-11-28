SELECT o.id as UyeIsyeriID, IF(o.isActivated=1,"Aktif","Pasif") as UyeDurum,
t.serial_no as MaliNo, IF(t.terminalStatus=1,"Aktif","Pasif") as TerminalDurum,
c.name as Kanal, 
SUM(CASE WHEN DATE_FORMAT(bp.signedDate,"%Y") = "2023" THEN bp.amount END) as 2023_Ciro,
SUM(CASE WHEN DATE_FORMAT(bp.signedDate,"%Y") = "2024" THEN bp.amount END) as 2024_Ciro
FROM odeal.Organisation o
 LEFT JOIN odeal.Terminal t ON t.organisation_id = o.id
 JOIN odeal.Channel c ON c.id = t.channelId 
 LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id 
 LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id
WHERE c.id = 213 AND bp.currentStatus = 6
GROUP BY o.id, t.serial_no, t.terminalStatus


SELECT * FROM odeal.Channel c 