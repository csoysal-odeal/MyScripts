SELECT * FROM odeal.Organisation o
JOIN odeal.Terminal t ON t.organisation_id = o.id 
LEFT JOIN odeal.Merchant m ON m.organisationId = o.id AND m.role = 0
WHERE o.demo = 0

 -- Versiyon 1
SELECT o.id as UyeIsYeri, o.unvan, o.marka, IF(o.isActivated=1,"AKTİF","PASİF") as UyeDurum,
CONCAT(m.firstName," ",m.LastName) AS Musteri,
m.phone as TelNo,
m.email as Email,
Cihazlar.Terminal, Cihazlar.Hizmet
FROM odeal.Organisation o 
LEFT JOIN odeal.Merchant m ON m.organisationId = o.id
LEFT JOIN (
SELECT Uyeler.id, GROUP_CONCAT(Uyeler.Terminaller) as Terminal, GROUP_CONCAT(Uyeler.Hizmet) as Hizmet FROM (
SELECT o.id, GROUP_CONCAT(t.serial_no) as Terminaller,  GROUP_CONCAT(s2.name) AS Hizmet FROM odeal.Organisation o 
LEFT JOIN odeal.Terminal t ON t.organisation_id = o.id 
LEFT JOIN subscription.Subscription s ON s.id = t.subscription_id 
LEFT JOIN subscription.Plan p ON p.id = s.planId 
LEFT JOIN subscription.Service s2 ON s2.id = p.serviceId 
WHERE p.serviceId <> 3 AND s.id IN (
SELECT MAX(s.id) FROM odeal.Organisation o 
LEFT JOIN odeal.Terminal t on t.organisation_id = o.id 
LEFT JOIN subscription.Subscription s ON s.id = t.subscription_id 
LEFT JOIN subscription.Plan p ON p.id = s.planId 
LEFT JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE p.serviceId <> 3 AND o.demo = 0
GROUP BY o.id, t.serial_no)
GROUP BY o.id
UNION
SELECT o.id, "CeptePos" as MaliNo, GROUP_CONCAT(s2.name) as Hizmet FROM odeal.Organisation o 
LEFT JOIN subscription.Subscription s ON s.organisationId = o.id 
LEFT JOIN subscription.Plan p ON p.id = s.planId 
LEFT JOIN subscription.Service s2 ON s2.id = p.serviceId 
WHERE p.serviceId = 3 AND s.id IN (
SELECT MAX(s.id) FROM odeal.Organisation o 
LEFT JOIN subscription.Subscription s ON s.organisationId = o.id 
LEFT JOIN subscription.Plan p ON p.id = s.planId 
LEFT JOIN subscription.Service s2 ON s2.id = p.serviceId 
WHERE p.serviceId = 3 AND o.demo = 0
GROUP BY o.id)
GROUP BY o.id) as Uyeler 
GROUP BY Uyeler.id) as Cihazlar ON Cihazlar.id = o.id
WHERE o.demo = 0 AND m.`role` = 0


 SELECT o.id as UyeIsYeri, o.unvan, o.marka, IF(o.isActivated=1,"AKTİF","PASİF") as UyeDurum,
CONCAT(m.firstName," ",m.LastName) AS Musteri,
m.phone as TelNo,
m.email as Email,
Cihazlar.Hizmet
FROM odeal.Organisation o 
LEFT JOIN odeal.Merchant m ON m.organisationId = o.id
LEFT JOIN (
SELECT o.id, GROUP_CONCAT(s2.name) as Hizmet FROM odeal.Organisation o 
LEFT JOIN subscription.Subscription s ON s.organisationId = o.id 
LEFT JOIN subscription.Plan p ON p.id = s.planId 
LEFT JOIN subscription.Service s2 ON s2.id = p.serviceId 
WHERE p.serviceId = 3 AND s.id IN (
SELECT MAX(s.id) FROM odeal.Organisation o 
LEFT JOIN subscription.Subscription s ON s.organisationId = o.id 
LEFT JOIN subscription.Plan p ON p.id = s.planId 
LEFT JOIN subscription.Service s2 ON s2.id = p.serviceId 
WHERE p.serviceId = 3 AND o.demo = 0)
GROUP BY o.id) as Cihazlar ON Cihazlar.id = o.id
WHERE o.isActivated = 0

SELECT o.id FROM odeal.Organisation o 
WHERE o.activatedAt <= "2023-12-31 00:00:00" AND o.demo = 0

SELECT * FROM information_schema.COLUMNS c
WHERE c.COLUMN_NAME LIKE "%nationality%"

SELECT m.nationality, COUNT(*) FROM odeal.Merchant m 
WHERE m.nationality IS NOT NULL AND m.`_createdDate` <= "2023-12-31 23:59:59"
GROUP BY m.nationality 