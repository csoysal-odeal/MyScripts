SELECT * FROM (
SELECT o.id, EXTRACT(YEAR_MONTH FROM bp.signedDate) as Ay, SUM(bp.amount) as Toplam,
ROW_NUMBER() OVER (PARTITION BY EXTRACT(YEAR_MONTH FROM bp.signedDate) ORDER BY SUM(bp.amount) DESC) as Sira FROM odeal.Organisation o 
JOIN odeal.BasePayment bp ON bp.organisationId = o.id
WHERE o.demo = 0 AND o.isActivated = 1 AND bp.currentStatus = 6 AND bp.signedDate >= DATE_SUB(CURDATE(), INTERVAL 3 MONTH) AND bp.signedDate < NOW()
GROUP BY o.id, EXTRACT(YEAR_MONTH FROM bp.signedDate)) as Top400 WHERE Sira <= 400