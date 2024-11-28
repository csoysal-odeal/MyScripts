SELECT * FROM odeal.Payback p 
LEFT JOIN odeal.CutDetail cd ON cd.fixedPaybackId
WHERE p.id = 44639010

SELECT bp.paybackId as PaybackID, SUM(bp.amount) as IslemTutar, COUNT(bp.id) as IslemAdet  FROM odeal.BasePayment bp WHERE bp.paybackId = 44639010
GROUP BY bp.paybackId

SELECT * FROM odeal.CutDetail cd WHERE cd.fixedPaybackId = 44639010

SELECT * FROM odeal.Cut c WHERE c.id = 15096

SELECT p.id, SUM(p.amount) as GeriOdemeTutar, KesintiDetay.KesintiTutar, Islem.Ciro, Islem.GeriOdemeyeEsasTutar, Islem.Komisyon FROM odeal.Payback p 
JOIN (SELECT bp.paybackId, SUM(bp.paybackAmount) as GeriOdemeyeEsasTutar, SUM(bp.amount) as Ciro, COUNT(bp.id) as IslemAdet, MAX(bp.appliedRate) as Komisyon FROM odeal.BasePayment bp 
LEFT JOIN odeal.Payback p2 ON bp.paybackId = p2.id
WHERE p2.dueDate >= "2024-03-01 00:00:00" AND p2.dueDate <= "2024-03-31 23:59:59"
GROUP BY bp.paybackId ) as Islem ON Islem.paybackId = p.id
LEFT JOIN (SELECT cd.cutId, cd.fixedPaybackId, SUM(cd.fixedAmount) as KesintiTutar FROM odeal.CutDetail cd
JOIN odeal.Cut c ON c.id = cd.cutId
GROUP BY cd.cutId, cd.fixedPaybackId) as KesintiDetay ON KesintiDetay.fixedPaybackId = p.id
WHERE p.organisationId = 301253991 AND p.id = 44609703
GROUP BY p.id, KesintiDetay.KesintiTutar

SELECT cd.cutId, cd.fixedPaybackId, SUM(cd.fixedAmount) as GeriOdemeTutar FROM odeal.CutDetail cd
JOIN odeal.Cut c ON c.id = cd.cutId WHERE cd.fixedPaybackId = 44639010
GROUP BY cd.cutId, cd.fixedPaybackId

SELECT bp.paybackId, SUM(bp.amount) as Ciro, COUNT(bp.id) as IslemAdet FROM odeal.BasePayment bp 
WHERE bp.paybackId = 44609703
GROUP BY bp.paybackId 

SELECT DATE_FORMAT(bp.signedDate,"%Y-%m-%d") as Ay, bp.serviceId, SUM(bp.amount) as Ciro, COUNT(bp.id) as IslemAdet FROM odeal.BasePayment bp 
WHERE bp.currentStatus = 6 AND bp.serviceId = 2 AND bp.signedDate >= DATE_FORMAT(DATE_SUB(CURDATE(), INTERVAL 1 MONTH),"%Y-%m-%d 00:00:00")
AND bp.signedDate <= DATE_FORMAT(DATE_SUB(CURDATE(), INTERVAL 1 DAY),"%Y-%m-%d 23:59:59")
GROUP BY DATE_FORMAT(bp.signedDate,"%Y-%m-%d")

SELECT DATE_FORMAT(DATE_SUB(CURDATE(), INTERVAL 1 MONTH),"%Y-%m-01 00:00:00")

SELECT DATE_FORMAT(DATE_SUB(CURDATE(), INTERVAL 4 DAY),"%Y-%m-%d 23:59:59")

