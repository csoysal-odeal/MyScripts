SELECT bp.organisationId, SUM(bp.amount) as Ciro FROM odeal.BasePayment bp 
WHERE bp.currentStatus = 6 AND bp.paymentType <> 4 AND bp.signedDate >="2021-01-01 00:00:00" AND bp.organisationId IN (SELECT o.id FROM odeal.Organisation o 
WHERE o.activatedAt <= "2023-11-30" AND (o.deActivatedAt IS NULL OR o.deActivatedAt > "2023-11-30 23:59:59"))
GROUP BY bp.organisationId 


-- ESKİ
SELECT * FROM odeal.Organisation o 
WHERE o.activatedAt < "2023-12-01 00:00:00" AND (o.deActivatedAt IS NULL OR o.deActivatedAt > "2023-11-30 23:59:59")

-- YENİ
SELECT * FROM odeal.Organisation o 
WHERE o.activatedAt >= "2023-11-01 00:00:00" AND (o.deActivatedAt IS NULL OR o.deActivatedAt > "2023-11-30 23:59:59")



60,637
2,300