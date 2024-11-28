-- 00 - 08 saatleri arası Pazar
SELECT DAYOFWEEK(bp.signedDate)=1 as PazarGunuIsareti,
DATE_FORMAT(bp.signedDate,"%H") as PazarGunu,
MIN(DATE_FORMAT(bp.signedDate,"%Y-%m-%d %H:%i")) as Baslangic,
MAX(DATE_FORMAT(bp.signedDate,"%Y-%m-%d %H:%i")) as Bitis, 
COUNT(bp.id) as IslemAdet, SUM(bp.amount) as IslemTutar  FROM odeal.BasePayment bp 
WHERE DAYOFWEEK(bp.signedDate)=1 
AND bp.signedDate >= "2023-11-01 00:00:00" 
AND bp.signedDate <= "2024-02-01 23:59:59"
AND HOUR(bp.signedDate) >= "00" AND HOUR(bp.signedDate)<= "07"
GROUP BY DAYOFWEEK(bp.signedDate)=1, DATE_FORMAT(bp.signedDate,"%H")

-- Gün Boyu Pazar
SELECT DAYOFWEEK(bp.signedDate)=1 as PazarGunuIsareti,
DATE_FORMAT(bp.signedDate,"%Y-%m-%d") as PazarGunu,
MIN(DATE_FORMAT(bp.signedDate,"%Y-%m-%d %H:%i")) as Baslangic,
MAX(DATE_FORMAT(bp.signedDate,"%Y-%m-%d %H:%i")) as Bitis, 
COUNT(bp.id) as IslemAdet, SUM(bp.amount) as IslemTutar  FROM odeal.BasePayment bp 
WHERE DAYOFWEEK(bp.signedDate)=1 
AND bp.signedDate >= "2023-11-01 00:00:00" 
AND bp.signedDate <= "2024-02-01 23:59:59"
AND HOUR(bp.signedDate) >= "00" AND HOUR(bp.signedDate)<= "23"
GROUP BY DAYOFWEEK(bp.signedDate)=1, DATE_FORMAT(bp.signedDate,"%Y-%m-%d")
