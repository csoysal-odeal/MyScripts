SELECT COUNT(bp.id) as IslemAdet, SUM(bp.amount) as IslemHacmi FROM odeal.BasePayment bp
WHERE bp.signedDate >= "2023-01-01 00:00:00" AND bp.signedDate <= "2023-12-31 23:59:59" AND bp.currentStatus = 6 AND bp.paymentType <> 4

SELECT * FROM information_schema.COLUMNS c
WHERE c.COLUMN_NAME LIKE "%mcc%"

SELECT m.nationality, COUNT(*) FROM odeal.Merchant m 
GROUP BY m.nationality 

SELECT o.id, o.marka, o.unvan, m.firstName, m.LastName, m.nationality FROM odeal.Organisation o 
LEFT JOIN odeal.Merchant m ON m.organisationId = o.id AND m.`role` = 0
WHERE o.id = 301179836

SELECT o.id, m.nationality, COUNT(bp.id) as IslemAdet, SUM(bp.amount) as IslemHacmi FROM odeal.Organisation o 
LEFT JOIN odeal.Merchant m ON m.organisationId = o.id AND m.role = 0
JOIN odeal.BasePayment bp ON bp.organisationId = o.id 
WHERE bp.signedDate >= "2023-01-01 00:00:00" AND bp.signedDate <= "2023-12-31 23:59:59" AND bp.currentStatus = 6 AND bp.paymentType <> 4 AND
m.nationality = "İRAN İSLAM CUMHURİYETİ"
GROUP BY o.id, m.nationality 


SELECT o.id, m.nationality, COUNT(bp.id) as IslemAdet, SUM(bp.amount) as IslemHacmi FROM odeal.Organisation o 
LEFT JOIN odeal.Merchant m ON m.organisationId = o.id AND m.role = 0
JOIN odeal.BasePayment bp ON bp.organisationId = o.id 
WHERE bp.signedDate >= "2023-01-01 00:00:00" AND bp.signedDate <= "2023-12-31 23:59:59" AND bp.currentStatus = 6 AND bp.paymentType <> 4 AND
m.nationality IN ("İRAN İSLAM CUMHURİYETİ",
"AFGANİSTAN İSLAM CUMHURİYETİ","PAKİSTAN İSLAM CUMHURİYETİ","IRAK CUMHURİYETİ","TÜRKMENİSTAN","AZERBAYCAN CUMHURİYETİ",
"RUSYA FEDERASYONU","KORE CUMHURİYETİ","ÇİN HALK CUMHURİYETİ","ÜRDÜN HAŞİMİ KRALLIĞI","FAS KRALLIĞI","SURİYE ARAP CUMHURİYETİ",
"YEMEN CUMHURİYETİ","SOMALİ FEDERAL CUMHURİYETİ","JAPONYA","BİRLEŞİK ARAP EMİRLİKLERİ","LİBYA DEVLETİ","KONGO DEMOKRATİK CUMHURİYETİ")
GROUP BY o.id, m.nationality 


SELECT o.id, IF(o.businessType=2,"Tüzel Kişi","Şahıs") as IsyeriTipi, m.nationality, COUNT(bp.id) as IslemAdet, SUM(bp.amount) as IslemHacmi FROM odeal.Organisation o 
LEFT JOIN odeal.Merchant m ON m.organisationId = o.id AND m.role = 0
JOIN odeal.BasePayment bp ON bp.organisationId = o.id 
WHERE bp.signedDate >= "2023-01-01 00:00:00" AND bp.signedDate <= "2023-12-31 23:59:59" AND bp.currentStatus = 6 AND bp.paymentType <> 4 AND
m.nationality IN ("İRAN İSLAM CUMHURİYETİ",
"AFGANİSTAN İSLAM CUMHURİYETİ","PAKİSTAN İSLAM CUMHURİYETİ","IRAK CUMHURİYETİ","TÜRKMENİSTAN","AZERBAYCAN CUMHURİYETİ",
"RUSYA FEDERASYONU","KORE CUMHURİYETİ","ÇİN HALK CUMHURİYETİ","ÜRDÜN HAŞİMİ KRALLIĞI","FAS KRALLIĞI","SURİYE ARAP CUMHURİYETİ",
"YEMEN CUMHURİYETİ","SOMALİ FEDERAL CUMHURİYETİ","JAPONYA","BİRLEŞİK ARAP EMİRLİKLERİ","LİBYA DEVLETİ","KONGO DEMOKRATİK CUMHURİYETİ")
AND o.businessType = 2
GROUP BY o.id, m.nationality 


SELECT o.id, c.name as Sehir, COUNT(bp.id) as IslemAdet, SUM(bp.amount) as IslemTutar FROM odeal.Organisation o 
JOIN odeal.BasePayment bp ON bp.organisationId = o.id 
LEFT JOIN odeal.City c ON c.id = o.cityId 
WHERE bp.signedDate >= "2023-01-01 00:00:00" AND bp.signedDate <= "2023-12-31 23:59:59" AND bp.currentStatus = 6 AND bp.paymentType <> 4
AND c.name IN ("Hatay", "Kilis", "Gaziantep", "Şanlıurfa", "Mardin", "Şırnak", "Hakkâri", "Van", "Ağrı", "Iğdır")
GROUP BY o.id

SELECT * FROM odeal.BasePayment bp
WHERE bp.currentStatus = 6 AND bp.signedDate >= DATE_FORMAT(DATE_SUB(CURDATE(),INTERVAL 2 MONTH),"%Y-%m-01 00:00:00")  

Kuzey Kore, Myanmar, İran, Irak, Türkmenistan, Afganistan, 
Pakistan, Ermenistan, Azerbaycan, Rusya, Güney Kore, Çin, 
Arnavutluk, Barbados, Burkina Faso, Kamboçya, Cayman Adaları, 
Haiti, Jamaika, Ürdün, Mali, Malta, Fas, Myanmar, Nikaragua, 
Panama, Filipinler, Senegal, Güney Sudan, Suriye, Uganda, Yemen, Zimbabve, Somali, 
Singapur, Tayland, Şili, Japonya, Hong Kong ve Birleşik Arap Emirlikleri, Erite, Libya, Kongo Demokratik Cumhuriyeti.


Hatay, Kilis, Gaziantep, Şanlıurfa, Mardin, Şırnak, Hakkâri, Van, Ağrı, Iğdır