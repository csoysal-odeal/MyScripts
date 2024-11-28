SELECT t.organisation_id as UyeID, o.marka, o.unvan, IF(o.isActivated=1,"Aktif","Pasif") as UyeDurum,  o.activatedAt as UyeAktivasyon, 
o.deActivatedAt as UyeDeaktivasyonTarihi, s2.sector_name as Sektor, t.serial_no as MaliNo, c.name as Kanal, t.firstActivationDate as TerminalAktivasyonTarihi,
IF(t.terminalStatus=1,"Aktif","Pasif") as TerminalDurum, IF(p.taksitli=1,"Taksitli","Tek Çekim") as TaksitDurum, p.name as Plan, s.id as Abonelik, s.activationDate as AbonelikAktivasyonTarihi, s3.name as Hizmet, a.name as Model, 
m.id as ContactKey, UCASE(CONCAT(m.firstName," ",m.LastName)) as ContactName, m.phone as Iletisim,
s.cancelledAt as AbonelikIptalTarihi FROM odeal.Terminal t 
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
JOIN subscription.Subscription s ON s.id = t.subscription_id 
JOIN subscription.Plan p ON p.id = s.planId
LEFT JOIN odeal.Channel c ON c.id = t.channelId 
JOIN odeal.Sector s2 ON s2.id = o.sectorId
JOIN subscription.Service s3 ON s3.id = p.serviceId
LEFT JOIN subscription.Addon a ON a.id = p.addonId
JOIN odeal.Merchant m ON m.organisationId = o.id AND m.`role` = 0

SELECT o.id as UyeID, COUNT(*) FROM odeal.Terminal t 
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
JOIN subscription.Subscription s ON s.id = t.subscription_id 
JOIN subscription.Plan p ON p.id = s.planId
LEFT JOIN odeal.Channel c ON c.id = t.channelId 
JOIN odeal.Sector s2 ON s2.id = o.sectorId
JOIN subscription.Service s3 ON s3.id = p.serviceId
LEFT JOIN subscription.Addon a ON a.id = p.addonId
JOIN odeal.Merchant m ON m.organisationId = o.id AND m.`role` = 0
GROUP BY o.id

SELECT t.organisation_id, t.serial_no, bp.id, bp.`_createdDate`, bp.signedDate, bp.paybackId FROM odeal.Terminal t 
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id 
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id 
WHERE bp.currentStatus = 6 AND t.serial_no = "PAX710040545" AND bp.signedDate >= "2024-04-24 00:00:00"
GROUP BY t.organisation_id, t.serial_no,bp.id, bp.`_createdDate` , bp.signedDate ,bp.paybackId

SELECT * FROM odeal.Terminal t WHERE t.serial_no = "BCJ00005920"

SELECT o.id as UyeIsyeriID, IF(o.isActivated=1,"Aktif","Pasif") as UyeDurum, t.id as TerminalID, t.serial_no as MaliNo, 
m.id as ContactKey, UCASE(CONCAT(m.firstName," ",m.LastName)) as ContactName, m.phone as Iletisim FROM odeal.Organisation o 
JOIN odeal.Terminal t ON t.organisation_id = o.id 
JOIN odeal.Merchant m ON m.organisationId = o.id 
WHERE m.`role` = 0 AND o.demo = 0

SELECT * FROM odeal.Merchant m 
WHERE m.role = 0

SELECT o.id FROM odeal.Organisation o 
WHERE o.channelId = 24

SELECT * FROM odeal.TerminalHistory th WHERE th.id IN (
SELECT MAX(th.id) FROM odeal.TerminalHistory th
GROUP BY th.serialNo)

SELECT c.name, SUM(bp.amount), COUNT(bp.id) FROM odeal.BasePayment bp 
JOIN odeal.Organisation o ON o.id = bp.organisationId 
JOIN odeal.Channel c ON c.id = o.channelId 
WHERE bp.currentStatus = 6 AND bp.signedDate >= "2024-03-01 00:00:00" AND bp.signedDate <= "2024-03-31 23:59:59" AND c.id = 298
GROUP BY c.name

SELECT c.name as TerminalKanal, c2.name as UyeKanal, SUM(bp.amount), COUNT(bp.id) FROM odeal.BasePayment bp 
LEFT JOIN odeal.TerminalPayment tp ON tp.id = bp.id 
LEFT JOIN odeal.Terminal t ON t.id = tp.terminal_id 
LEFT JOIN odeal.Organisation o ON o.id = t.organisation_id
LEFT JOIN odeal.Channel c ON c.id = t.channelId 
LEFT JOIN odeal.Channel c2 ON c2.id = o.channelId
WHERE bp.currentStatus = 6 AND bp.signedDate >= "2024-03-01 00:00:00" AND bp.signedDate <= "2024-03-31 23:59:59" AND c.id = 298
GROUP BY c.name, c2.name

SELECT t.organisation_id, t.serial_no, bp.id, bp.signedDate, bp.amount, bp.serviceId FROM odeal.BasePayment bp
LEFT JOIN odeal.TerminalPayment tp ON tp.id = bp.id
LEFT JOIN odeal.Terminal t ON t.id = tp.terminal_id
WHERE bp.id = 683063700


SELECT o.id, CONCAT(m.firstName," ",m.LastName) AS AdSoyad, m.phone, m.id AS ContactKey FROM odeal.Organisation o 
LEFT JOIN odeal.Merchant m ON m.organisationId = o.id AND m.`role` = 0
WHERE o.id IN (301029425 , 
301070605 , 
301070741 , 
301070789 , 
301070869 , 
301070981 , 
301071009 , 
301071029 , 
301071069 , 
301071073 , 
301071157 , 
301071161 , 
301071197 , 
301071221 , 
301071349 , 
301071357 , 
301071377 , 
301071385 , 
301071421 , 
301071425 , 
301071445 , 
301071449 , 
301071481 , 
301071489 , 
301071525 , 
301071533 , 
301071545 , 
301071637 , 
301071661 , 
301071681 , 
301071689 , 
301071693 , 
301071713 , 
301071741 , 
301071745 , 
301071749 , 
301071753 , 
301071765 , 
301071769 , 
301071773 , 
301071785 , 
301071789 , 
301071877 , 
301071977 , 
301072009 , 
301072121 , 
301072141 , 
301072149 , 
301072185 , 
301072209 , 
301072225 , 
301072237 , 
301072305 , 
301072353 , 
301072381 , 
301072385 , 
301072413 , 
301072481 , 
301072529 , 
301072585 , 
301072605 , 
301072877 , 
301072905 , 
301073065 , 
301073081 , 
301073101 , 
301073273 , 
301073493 , 
301073581 , 
301073861 , 
301074145 , 
301074149 , 
301074169 , 
301074197 , 
301074233 , 
301074297 , 
301074465 , 
301074485 , 
301074553 , 
301074565 , 
301074577 , 
301074589 , 
301074693 , 
301074845 , 
301074877 , 
301074925 , 
301075069 , 
301075073 , 
301075077 , 
301075105 , 
301075117 , 
301075129 , 
301075185 , 
301075213 , 
301075333 , 
301075365 , 
301075401 , 
301075589 , 
301075641 , 
301076041 , 
301076049 , 
301076073 , 
301076801 , 
301076961 , 
301077389 , 
301077393 , 
301077401 , 
301077561 , 
301077621 , 
301077673 , 
301077793 , 
301077930 , 
301077950 , 
301077962 , 
301078018 , 
301078034 , 
301078038 , 
301078042 , 
301078046 , 
301078110 , 
301078138 , 
301078230 , 
301078430 , 
301078526 , 
301078674 , 
301078730 , 
301078734 , 
301078754 , 
301078786 , 
301078854 , 
301078918 , 
301078938 , 
301079146 , 
301079392 , 
301079434 , 
301079458 , 
301079941 , 
301079947 , 
301079974 , 
301080214 , 
301080256 , 
301080502 , 
301080517 , 
301080748 , 
301080994 , 
301081030 , 
301081072 , 
301081207 , 
301081420 , 
301081492 , 
301081543 , 
301081546 , 
301081552 , 
301081762 , 
301081783 , 
301082005 , 
301082074 , 
301082185 , 
301082377 , 
301082515 , 
301082566 , 
301082620 , 
301082740 , 
301082866 , 
301082935 , 
301082965 , 
301082977 , 
301083064 , 
301083181 , 
301083301 , 
301083388 , 
301083454 , 
301083457 , 
301083475 , 
301083499 , 
301083625 , 
301083652 , 
301083853 , 
301084105 , 
301084141 , 
301084201 , 
301084309 , 
301084360 , 
301084459 , 
301084570 , 
301084600 , 
301084645 , 
301084717 , 
301084837 , 
301084855 , 
301085031 , 
301085049 , 
301085089 , 
301085091 , 
301085095 , 
301085101 , 
301085141 , 
301085221 , 
301085261 , 
301085338 , 
301085404 , 
301085755 , 
301086028 , 
301086379 , 
301086391 , 
301086829 , 
301086916 , 
301087102 , 
301087156 , 
301087294 , 
301087411 , 
301087423 , 
301087504 , 
301087540 , 
301087624 , 
301087727 , 
301088306 , 
301088318 , 
301088522 , 
301088639 , 
301088795 , 
301088846 , 
301089023 , 
301089401 , 
301089617 , 
301089863 , 
301089866 , 
301090226 , 
301090352 , 
301090916 , 
301091387 , 
301091474 , 
301091534 , 
301091675 , 
301091954 , 
301091972 , 
301092011 , 
301092068 , 
301092074 , 
301092098 , 
301092212 , 
301092224 , 
301092230 , 
301092233 , 
301092287 , 
301092365 , 
301092500 , 
301092653 , 
301092659 , 
301093220 , 
301093445 , 
301093553 , 
301094069 , 
301094225 , 
301094537 , 
301094714 , 
301094891 , 
301095023 , 
301095044 , 
301095113 , 
301095152 , 
301095326 , 
301095416 , 
301095434 , 
301095629 , 
301095686 , 
301095773 , 
301095932 , 
301095938 , 
301095983 , 
301095998 , 
301096088 , 
301096160 , 
301096199 , 
301096487 , 
301096730 , 
301096775 , 
301096841 , 
301096885 , 
301096891 , 
301096906 , 
301097088 , 
301097199 , 
301097289 , 
301097529 , 
301097571 , 
301097586 , 
301097643 , 
301097658 , 
301097661 , 
301097691 , 
301097763 , 
301097790 , 
301097796 , 
301097811 , 
301097835 , 
301097862 , 
301097889 , 
301097922 , 
301097934 , 
301097988 , 
301097994 , 
301098009 , 
301098051 , 
301098075 , 
301098120 , 
301098150 , 
301098168 , 
301098183 , 
301098204 , 
301098393 , 
301098405 , 
301098501 , 
301098519 , 
301098567 , 
301098612 , 
301098633 , 
301098687 , 
301098780 , 
301098822 , 
301098972 , 
301099254 , 
301099467 , 
301099524 , 
301099536 , 
301099671 , 
301100283 , 
301100451 , 
301100676 , 
301100691 , 
301100952 , 
301100964 , 
301101111 , 
301101168 , 
301101369 , 
301101381 , 
301101516 , 
301101714 , 
301101828 , 
301102026 , 
301102299 , 
301102344 , 
301102707 , 
301102713 , 
301102839 , 
301102947 , 
301102989 , 
301103196 , 
301103406 , 
301104021 , 
301104102 , 
301104336 , 
301104456 , 
301104846 , 
301104894 , 
301105017 , 
301105200 , 
301105353 , 
301105476 , 
301105542 , 
301105626 , 
301105686 , 
301105710 , 
301106130 , 
301106271 , 
301106427 , 
301106565 , 
301107264 , 
301107342 , 
301107788 , 
301108027 , 
301108192 , 
301108597 , 
301108987 , 
301109086 , 
301109107 , 
301109143 , 
301109317 , 
301109356 , 
301109731 , 
301109848 , 
301109851 , 
301109899 , 
301109905 , 
301109974 , 
301110067 , 
301110163 , 
301110190 , 
301110283 , 
301110319 , 
301110535 , 
301110685 , 
301111048 , 
301111198 , 
301111201 , 
301112053 , 
301112401 , 
301112479 , 
301112599 , 
301112836 , 
301112884 , 
301113058 , 
301113238 , 
301113421 , 
301113784 , 
301113916 , 
301114003 , 
301114012 , 
301114087 , 
301114774 , 
301114900 , 
301114975 , 
301115404 , 
301115407 , 
301115437 , 
301115593 , 
301115947 , 
301115998 , 
301116076 , 
301116130 , 
301116181 , 
301116241 , 
301116994 , 
301117276 , 
301117363 , 
301117708 , 
301117717 , 
301117846 , 
301118245 , 
301118383 , 
301118671 , 
301118692 , 
301118719 , 
301118893 , 
301119130 , 
301119307 , 
301119310 , 
301119841 , 
301120042 , 
301120240 , 
301120276 , 
301120414 , 
301120695 , 
301121535 , 
301122030 , 
301122108 , 
301122327 , 
301122459 , 
301122474 , 
301122516 , 
301122588 , 
301122594 , 
301122804 , 
301123029 , 
301123572 , 
301123668 , 
301123674 , 
301123719 , 
301123722 , 
301123728 , 
301123992 , 
301124418 , 
301124772 , 
301125240 , 
301125252 , 
301125429 , 
301125498 , 
301125696 , 
301126290 , 
301126296 , 
301126509 , 
301126620 , 
301126707 , 
301126842 , 
301127136 , 
301127433 , 
301127607 , 
301127685 , 
301127718 , 
301127913 , 
301128132 , 
301128354 , 
301128750 , 
301129485 , 
301129803 , 
301130094 , 
301130361 , 
301130433 , 
301130511 , 
301130727 , 
301130982 , 
301131039 , 
301131189 , 
301131324 , 
301131765 , 
301132254 , 
301132905 , 
301132977 , 
301133241 , 
301133367 , 
301133712 , 
301133955 , 
301134213 , 
301134273 , 
301134890 , 
301135364 , 
301135373 , 
301136126 , 
301136531 , 
301136534 , 
301136657 , 
301136924 , 
301137287 , 
301137317 , 
301137389 , 
301137935 , 
301138283 , 
301138649 , 
301138676 , 
301139129 , 
301139132 , 
301139573 , 
301140089 , 
301140398 , 
301140935 , 
301141088 , 
301141112 , 
301141688 , 
301141712 , 
301142564 , 
301143232 , 
301143506 , 
301144106 , 
301144144 , 
301144334 , 
301144418 , 
301144852 , 
301145000 , 
301145016 , 
301145962 , 
301146574 , 
301147354 , 
301147748 , 
301147936 , 
301148206 , 
301148332 , 
301148484 , 
301148526 , 
301148844 , 
301149530 , 
301150170 , 
301150670 , 
301151748 , 
301151854 , 
301152438 , 
301152620 , 
301152768 , 
301152930 , 
301152940 , 
301153094 , 
301153176 , 
301153318 , 
301153512 , 
301154136 , 
301154208 , 
301154774 , 
301154804 , 
301154810 , 
301154900 , 
301155036 , 
301155078 , 
301155162 , 
301156200 , 
301156308 , 
301156556 , 
301156560 , 
301156682 , 
301156892 , 
301156924 , 
301156930 , 
301156958 , 
301157210 , 
301157548 , 
301158000 , 
301158086 , 
301158130 , 
301158518 , 
301158592 , 
301158606 , 
301158764 , 
301158922 , 
301159546 , 
301159582 , 
301160016 , 
301160348 , 
301160372 , 
301160742 , 
301161156 , 
301161258 , 
301161644 , 
301161748 , 
301161876 , 
301161878 , 
301162080 , 
301162154 , 
301162306 , 
301162332 , 
301162532 , 
301162566 , 
301162776 , 
301162784 , 
301162800 , 
301162812 , 
301162900 , 
301162976 , 
301162986 , 
301163016 , 
301163394 , 
301163450 , 
301163682 , 
301163792 , 
301163924 , 
301164354 , 
301164420 , 
301164472 , 
301164488 , 
301164546 , 
301164610 , 
301164798 , 
301164932 , 
301165014 , 
301165016 , 
301165042 , 
301165136 , 
301165290 , 
301165298 , 
301165302 , 
301166016 , 
301166330 , 
301166468 , 
301167042 , 
301167044 , 
301167180 , 
301167256 , 
301167514 , 
301167712 , 
301167772 , 
301167794 , 
301168224 , 
301168236 , 
301168320 , 
301169048 , 
301169154 , 
301169918 , 
301170118 , 
301170194 , 
301170226 , 
301170454 , 
301171244 , 
301171529 , 
301171808 , 
301172048 , 
301172186 , 
301172195 , 
301172303 , 
301172741 , 
301172774 , 
301173899 , 
301174541 , 
301176818 , 
301176905 , 
301176932 , 
301178066 , 
301179065 , 
301179209 , 
301180928 , 
301188680 , 
301189508 , 
301189958 , 
301193546 , 
301194002 , 
301194077 , 
301195667 , 
301198631 , 
301200170 , 
301200179 , 
301202043 , 
301203915 , 
301204194 , 
301205151 , 
301206366 , 
301207737 , 
301209114 , 
301209690 , 
301214970 , 
301216605 , 
301216938 , 
301217616 , 
301217826 , 
301218624 , 
301224207 , 
301224462 , 
301227021 , 
301228101 , 
301228104 , 
301228200 , 
301230474 , 
301238564 , 
301245260 , 
301250213 , 
301254003 , 
301255191 , 
301257414 , 
301257711 , 
301261519 , 
301262291 , 
301262608)

-- Aylık İstenen Pazarlama
SELECT o.id as UyeID, IF(o.isActivated=1,"Aktif","Pasif") as UyeDurum, t.serial_no as MaliNo, 
t.firstActivationDate as TerminalAktivasyonTarihi, IF(t.terminalStatus=1,"Aktif","Pasif") as TerminalDurum, c.name as Kanal,
p.name as Plan, a.name as Model, s2.name as Hizmet FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN subscription.Plan p ON p.id = s.planId 
JOIN subscription.Service s2 ON s2.id = p.serviceId 
LEFT JOIN subscription.Addon a ON a.id = p.addonId
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
JOIN odeal.Channel c ON c.id = t.channelId 
WHERE t.firstActivationDate >= "2024-06-01 23:59:59" AND t.firstActivationDate <= "2024-06-30 23:59:59" AND (s.cancelledAt IS NULL OR s.cancelledAt > "2024-05-31 23:59:59")


SELECT bp.id, bp.amount, bp.serviceId, bp.paymentType FROM odeal.BasePayment bp WHERE bp.id = 685061433




SELECT COUNT(*) FROM (
SELECT Login.personId, 
ROW_NUMBER() OVER (PARTITION BY Login.personId ORDER BY Login.lastLogin DESC) as Sira FROM (
SELECT c.personId, c.lastlogin,
COUNT(c.personId) as Adet
FROM credentials.credential c 
WHERE c.lastLogin >= DATE_FORMAT(DATE_SUB(CURDATE(),INTERVAL 1 MONTH),"%Y-%m-%d 00:00:00") AND c.lastlogin <= DATE_FORMAT(DATE_SUB(CURDATE(),INTERVAL 1 MONTH),"%Y-%m-%d 23:59:59")
GROUP BY c.personId, c.lastlogin) as Login) as Login2
WHERE Login2.Sira = 1;

 SELECT * FROM odeal.BasePayment bp 
where bp.posId = 14
and bp.currentStatus = 6
AND bp.signedDate >= "2024-06-09 00:00:00" AND bp.signedDate <= "2024-06-09 23:59:59"
order by bp.id DESC

SELECT * FROM credentials.credential c 

SELECT DATE_FORMAT(DATE_SUB(CURDATE(),INTERVAL 0 DAY),"%Y-%m-%d 00:00:00")

SELECT DATE_FORMAT(DATE_SUB(CURDATE(),INTERVAL 0 DAY),"%Y-%m-%d 23:59:59")


SELECT * FROM odeal.InstallmentRule ir WHERE ir.organisationId IS NOT NULL AND ir.expiryDate IS NOT NULL

SELECT * FROM information_schema.COLUMNS c
WHERE c.COLUMN_NAME LIKE "%brand%"

SELECT o.id as UyeID, COUNT(s.id) as CeptePosAbonelikAdet FROM odeal.Organisation o 
JOIN subscription.Subscription s ON s.organisationId = o.id 
JOIN subscription.Plan p ON p.id = s.planId 
WHERE p.serviceId = 3 AND s.status = 1
GROUP BY o.id HAVING COUNT(s.id) > 1

SELECT * FROM (
SELECT o.id, bp.organisationId as SerialNo, bp.id as IslemID,
CASE
	WHEN bp.paymentType = 0 THEN "Kredi Kartı / Banka Kartı"
	WHEN bp.paymentType = 1 THEN "Kredi Kartı / Banka Kartı / Ceptepos"
	WHEN bp.paymentType = 2 THEN "Kredi Kartı / Banka Kartı / Terminal"
	WHEN bp.paymentType = 3 THEN "Kredi Kartı / Banka Kartı / 3D Ödeme"
	WHEN bp.paymentType = 4 THEN "Nakit"
	WHEN bp.paymentType = 5 THEN "BKM Express"
	WHEN bp.paymentType = 6 THEN "Tekrarlı Ödeme"
	WHEN bp.paymentType = 7 THEN "Kredi Kartı / Banka Kartı"
	WHEN bp.paymentType = 8 THEN "Kredi Kartı / Banka Kartı"
	WHEN bp.paymentType = 9 THEN "Istanbul Kart"
	WHEN bp.paymentType = 10 THEN "Hediye Kartı"
	WHEN bp.paymentType = 11 THEN "Senet"
	WHEN bp.paymentType = 12 THEN "Çek"
	WHEN bp.paymentType = 13 THEN "Açık Hesap"
	WHEN bp.paymentType = 14 THEN "Kredili"
	WHEN bp.paymentType = 15 THEN "Havale/Eft"
	WHEN bp.paymentType = 16 THEN "Yemek Kartı/Çeki"
	WHEN bp.paymentType = 17 THEN "Belediye Ulaşım Kartları, Yardım Kartları ve Çekleri"
END as PaymentTipi,
bp.posId, bp.signedDate, DATE_FORMAT(bp.signedDate, "%m %Y") as YilAy, bp.appliedRate, bp.amount, bp.serviceId, Abonelik.id as AbonelikID,
 "CeptePos" as Tedarikci, Abonelik.`_createdDate` as AktivasyonTarihi, p2.installment, IF(p2.installment>1,"Taksitli" , "Tek Çekim") as TaksitDurum, c2.name as Kanal, p.addonId as Cihaz,
p.name as Plan, p.commissionRates as PlanKomisyon
FROM odeal.Organisation o 
JOIN (SELECT * FROM subscription.Subscription s WHERE s.id IN (
SELECT MAX(s.id) FROM odeal.Organisation o 
JOIN subscription.Subscription s ON s.organisationId = o.id
JOIN subscription.Plan p ON p.id = s.planId AND p.serviceId = 3
GROUP BY o.id)) as Abonelik ON Abonelik.organisationId = o.id
JOIN subscription.Plan p ON p.id = Abonelik.planId
JOIN odeal.BasePayment bp ON bp.organisationId = o.id AND bp.currentStatus = 6 AND bp.paymentType <> 4 AND bp.serviceId = 3 AND bp.signedDate >= DATE_FORMAT(DATE_SUB(CURDATE(), INTERVAL 1 WEEK), "%Y-%m-%d") AND
bp.signedDate <= NOW()
JOIN odeal.Payment p2 ON p2.id = bp.id
LEFT JOIN odeal.Channel c2 ON c2.id = Abonelik.channelId
UNION
SELECT o.id, t.serial_no as SerialNo, bp.id as IslemID,
CASE
	WHEN bp.paymentType = 0 THEN "Kredi Kartı / Banka Kartı"
	WHEN bp.paymentType = 1 THEN "Kredi Kartı / Banka Kartı / Ceptepos"
	WHEN bp.paymentType = 2 THEN "Kredi Kartı / Banka Kartı / Terminal"
	WHEN bp.paymentType = 3 THEN "Kredi Kartı / Banka Kartı / 3D Ödeme"
	WHEN bp.paymentType = 4 THEN "Nakit"
	WHEN bp.paymentType = 5 THEN "BKM Express"
	WHEN bp.paymentType = 6 THEN "Tekrarlı Ödeme"
	WHEN bp.paymentType = 7 THEN "Kredi Kartı / Banka Kartı"
	WHEN bp.paymentType = 8 THEN "Kredi Kartı / Banka Kartı"
	WHEN bp.paymentType = 9 THEN "Istanbul Kart"
	WHEN bp.paymentType = 10 THEN "Hediye Kartı"
	WHEN bp.paymentType = 11 THEN "Senet"
	WHEN bp.paymentType = 12 THEN "Çek"
	WHEN bp.paymentType = 13 THEN "Açık Hesap"
	WHEN bp.paymentType = 14 THEN "Kredili"
	WHEN bp.paymentType = 15 THEN "Havale/Eft"
	WHEN bp.paymentType = 16 THEN "Yemek Kartı/Çeki"
	WHEN bp.paymentType = 17 THEN "Belediye Ulaşım Kartları, Yardım Kartları ve Çekleri"
END as PaymentTipi,
bp.posId, bp.signedDate, DATE_FORMAT(bp.signedDate, "%m %Y") as YilAy, bp.appliedRate, bp.amount, bp.serviceId, s.id as AbonelikID, t.supplier as Tedarikci,  t.firstActivationDate as AktivasyonTarihi, 
tp.installment, IF(tp.installment>1, "Taksitli" , "Tek Çekim") as TaksitDurum, c2.name as Kanal, p.addonId as Cihaz,
p.name as Plan, p.commissionRates as PlanKomisyon
FROM odeal.Organisation o 
JOIN odeal.Terminal t ON t.organisation_id = o.id
JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN subscription.Subscription s ON s.id = t.subscription_id
LEFT JOIN subscription.Plan p ON p.id = s.planId
LEFT JOIN odeal.Channel c2 ON c2.id = t.channelId
JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.paymentType <> 4 AND bp.serviceId <>3 AND bp.signedDate >= DATE_FORMAT(DATE_SUB(CURDATE(), INTERVAL 1 WEEK), "%Y-%m-%d") AND
bp.signedDate <= NOW()
) as Islemler

SELECT m.id, m.organisationId, CONCAT(m.firstName," ",m.LastName) as Yetkili, m.phone, m.email  FROM odeal.Merchant m WHERE m.role = 0 AND m.phone IN ('5551009663',	'5511765856',	'5536260933',	'5323826214',	'5334234237',	'5530666078',	'5454505006',	'5374074747',	'5346003587',	'5468501819',	'5415586477',	'5433627816',	'5326969259',	'5325112231',	'5325729970',	'5384510675',	'5355225988',	'5357410358',	'5428290864',	'5539323900',	'5327012803',	'5456793603',	'5449137270',	'5064349540',	'5549905118',	'5436189040',	'5331499478',	'5545617979',	'5388384744',	'5356926948',	'5324469988',	'5318157811',	'5324234875',	'5327336301',	'5313504092',	'5447705661',	'5368652139',	'5358683648',	'5419202119',	'5302616805',	'5322041918',	'5496390303',	'5444728530',	'5452233445',	'5062985537',	'5469605353',	'5338902457',	'5436929799',	'5051184101',	'5426471413',	'5320566150',	'5426261723',	'5062720183',	'5369589597',	'5333439543',	'5443794648',	'5433836352',	'5323682227',	'5368199937',	'5456831668',	'5541163344',	'5347421083',	'5547078959',	'5368945662',	'5437842466',	'5365790848',	'5327689738',	'5541404348',	'5358872292',	'5075774230',	'5427284944',	'5423104149',	'5386714902',	'5067955506',	'5363309607',	'5557662491',	'5448347438',	'5358914210',	'5373483330',	'5321329805',	'5522432009',	'5302616520',	'5466133616',	'5332686268',	'5375518639',	'5364057555',	'5427770532',	'5412362038',	'5379784774',	'5322522779',	'5424614598',	'5326684542',	'5415109025',	'5326414294',	'5514141721',	'5321675313',	'5468047206',	'5324680538',	'5353081304',	'5494920068',	'5467916585',	'5077948026',	'5366402222',	'5444074871',	'5382112726',	'5337945842',	'5394575531',	'5325494126',	'5358246053',	'5428234210',	'5465351400',	'5445667316',	'5541362480',	'5304512437',	'5413281330',	'5326769246',	'5439761723',	'5373742832',	'5346012571',	'5546213675',	'5353843081',	'5327001476',	'5526017848',	'5325440700',	'5412421600',	'5327036164',	'5395959431',	'5378511420',	'5389230293',	'5516561455',	'5337229950',	'5315973683',	'5326768706',	'5357234094',	'5354809855',	'5533870111',	'5432339115',	'5545453758',	'5445750772',	'5456791100',	'5012452599',	'5393778056',	'5362841632',	'5418628999',	'5301478638',	'5414777128',	'5438720555',	'5079249910',	'5334961404',	'5075266377',	'5315798171',	'5544499009',	'5322479815',	'5345854961',	'5337643490',	'5335066860',	'5331592510',	'5324228317',	'5423719047',	'5529410374',	'5307752201',	'5452524850',	'5362249298',	'5427781447',	'5326518221',	'5335405222',	'5312661826',	'5444041122',	'5435283840',	'5337479124',	'5435200411',	'5077609700',	'5382547691',	'5426576052',	'5525308239',	'5456050019',	'5313041343',	'5307821255',	'5323086322',	'5464344568',	'5456061373',	'5447310352',	'5324226592',	'5354467993',	'5388407357',	'5464988718',	'5448306263',	'5353343377',	'5542657830',	'5076046566',	'5379147826',	'5412807858',	'5071053742',	'5439052231',	'5302095906',	'5320597990',	'5323173864',	'5326063317',	'5336987874',	'5312549072',	'5453301026',	'5333467961',	'5412558466',	'5343822324',	'5438137024',	'5358919038',	'5357195352',	'5446435838',	'5320662672',	'5464166668',	'5394878054',	'5348292203',	'5337489443',	'5535559192',	'5413878987',	'5068506242',	'5334877558',	'5325451041',	'5423391154',	'5320683286',	'5466103973',	'5322605365',	'5415476727',	'5366930724',	'5453044549',	'5310829171',	'5346723998',	'5425792469',	'5324330335',	'5326430396',	'5333747608',	'5378771329',	'5416417851',	'5497158262',	'5449669059',	'5350478826',	'5323303855',	'5052910691',	'5335783900',	'5550448480',	'5319940092',	'5332320337',	'5372414816',	'5492773005',	'5538368113',	'5073561328',	'5355455479',	'5322527052',	'5325133017',	'5317917957',	'5327097496',	'5075060113',	'5067091802',	'5325473800',	'5452945080',	'5447303252',	'5324421000',	'5444252923',	'5385481725',	'5327122252',	'5375935367',	'5437915736',	'5522101208',	'5334544382',	'5333551500',	'5357326916',	'5438537599',	'5053544400',	'5354344410',	'5370167216',	'5383653771',	'5314302545',	'5412212598',	'5326921092',	'5469450144',	'5326358859',	'5377425487',	'5074571535',	'5059951516',	'5322744939',	'5302632405',	'5335197331',	'5324684642',	'5376640123',	'5306671452',	'5442096273',	'5534104118',	'5364088524',	'5448836779',	'5557469473',	'5326174131',	'5464301274',	'5418383866',	'5064332736',	'5414604161',	'5532239328',	'5303286475',	'5456911207',	'5452250677',	'5325443240',	'5382889253',	'5434901570',	'5356805465',	'5335454180',	'5445739426',	'5362409468',	'5416626288',	'5551660033',	'5374840068',	'5538400614',	'5526751509',	'5536127905',	'5334709626',	'5465210242',	'5322301593',	'5529389755',	'5325147471',	'5548999690',	'5326525212',	'5446585884',	'5448420117',	'5304570725',	'5079532006',	'5434632663',	'5307038642',	'5417785654',	'5498202075',	'5545965628',	'5322650186',	'5446179785',	'5054914390',	'5462954483',	'5071413440',	'5536900099',	'5063891856',	'5424488151',	'5453664200',	'5336168344',	'5523017003',	'5321568694',	'5304109454',	'5547950094',	'5414416365',	'5077645172',	'5304069914',	'5392459707',	'5380403477',	'5077456615',	'5392480101',	'5332653658',	'5426650284',	'5496692314',	'5374927435',	'5446331171',	'5358297372',	'5525991984',	'5348677015',	'5433136752',	'5458570023',	'5397637233',	'5069535028',	'5553062323',	'5322519596',	'5062410134',	'5300881437',	'5075531678',	'5327106324',	'5413667201',	'5446246527',	'5376184541',	'5338111873',	'5541113258',	'5075687168',	'5323110500',	'5356129124',	'5359301791',	'5551455126',	'5527337506',	'5321541314',	'5078221238',	'5063746150',	'5322930514',	'5322206707',	'5301770694',	'5367007752',	'5432540160',	'5063295691',	'5414051215',	'5303782522',	'5447716107',	'5321553564',	'5452476473',	'5324432576',	'5459454881',	'5321391881',	'5392185561',	'5532517255',	'5443790994',	'5418350158',	'5318916360',	'5432971595',	'5368388573',	'5340123665',	'5347951034',	'5352581366',	'5445053595',	'5068634444',	'5454040094',	'5427251323',	'5416800907',	'5324641832',	'5320600537',	'5325904417',	'5321530634',	'5366635325',	'5384859618',	'5337655082',	'5428089889',	'5052874041',	'5436502135',	'5054547966',	'5076115420',	'5354182795',	'5362537040',	'5444064479',	'5555592544',	'5306158667',	'5323375408',	'5317418750',	'5416326589',	'5421092959',	'5326323386',	'5326527243',	'5465494404',	'5378805353',	'5326566950',	'5079490494',	'5452812547',	'5322624486',	'5432049436',	'5324925035',	'5428412019',	'5332253217',	'5497695949',	'5522067681',	'5512020071',	'5309597397',	'5326595136',	'5380927954',	'5336633357',	'5353343698',	'5078621133',	'5435280615',	'5322971694',	'5306219723',	'5454750408',	'5377841431',	'5075550345',	'5447226275',	'5305264843',	'5069094413',	'5446937765',	'5387716060',	'5322680487',	'5323240222',	'5553882129',	'5340221444',	'5309779943',	'5056728080',	'5301122856',	'5335744514',	'5300969729',	'5445238395',	'5335926244',	'5078403655',	'5415890356',	'5075276722',	'5438946874',	'5306629730',	'5301553631',	'5442880575',	'5519322424',	'5306630661',	'5335566900',	'5549856898',	'5355899155',	'5511661079',	'5071836775',	'5322155855',	'5414141854',	'5444982013',	'5425434301',	'5558788939',	'5078927373',	'5528337848',	'5411181805',	'5428046650',	'5327448777',	'5422800552',	'5495220755',	'5060217544',	'5543454884',	'5435091993',	'5356084629',	'5383159282',	'5536458338',	'5320629195',	'5313048768',	'5300110701',	'5433098995',	'5327787862',	'5305470146',	'5435495758',	'5324906000',	'5378523343',	'5312573151',	'5333259089',	'5363245783',	'5322009411',	'5077074357',	'5064252595',	'5539494960',	'5332042921',	'5325781154',	'5424558200',	'5326940328',	'5468745317',	'5323579067',	'5324307676',	'5076578481',	'5446928822',	'5416327967',	'5454628507',	'5465171566',	'5426417122',	'5449136874',	'5075576500',	'5433431919',	'5447280939',	'5510420511',	'5414423077',	'5422675218',	'5457996832',	'5327878031',	'5433229090',	'5302609162',	'5321732760',	'5337351955',	'5424289623',	'5326886456',	'5369485866',	'5558081216',	'5332542113',	'5434236505',	'5444471889',	'5423787879',	'5325437964',	'5541201615',	'5304563152',	'5324548144',	'5052651180',	'5078672689',	'5335796611',	'5447382930',	'5442241798',	'5423288908',	'5363523195',	'5447974343',	'5324963331',	'5557541472',	'5438831912',	'5458447223',	'5528649843',	'5436963402',	'5455215166',	'5055272924',	'5414541735',	'5376913644',	'5551522077',	'5456640928',	'5340186164',	'5356276213',	'5433137669',	'5332814228',	'5336507276',	'5327176291',	'5411446060',	'5453696574',	'5464507452',	'5313018077',	'5354233237',	'5423766124',	'5532510182',	'5304929840',	'5369548111',	'5324373348',	'5443417455',	'5327618251',	'5519596274',	'5355746799',	'5067197876',	'5383355480',	'5375103356',	'5453608671',	'5394611047',	'5057661448',	'5386110666',	'5370501227',	'5362308809',	'5324049416',	'5327341788',	'5394891171',	'5358757188',	'5326932445',	'5323868855',	'5559883436',	'5444064039',	'5453645669',	'5324556737',	'5309333408',	'5062432010',	'5377661286',	'5062784812',	'5070849575',	'5417675377',	'5557565889',	'5337475710',	'5334065916',	'5443447477',	'5352426065',	'5322971955',	'5398852514',	'5057666494',	'5556627252',	'5067015352',	'5454401054',	'5303136735',	'5079900980',	'5337168645',	'5468787703',	'5526575683',	'5545672978',	'5308703542',	'5355840424',	'5322218790',	'5510598270',	'5537318127',	'5077531121',	'5321747371',	'5352174995',	'5320605747',	'5079176952',	'5326056057',	'5393014818',	'5076974264',	'5439766760',	'5062511997',	'5334797635',	'5324023838',	'5078157458',	'5334782969',	'5324455223',	'5332800555',	'5442325121',	'5550815383',	'5079394462',	'5413914296',	'5543832327',	'5316908267',	'5431902447',	'5443717520',	'5545270296',	'5396248402',	'5395808893',	'5350785849',	'5422288576',	'5315261308',	'5337476090',	'5343264141',	'5374255168',	'5357639984',	'5321677270',	'5459278824',	'5056706067',	'5308422217',	'5322457702',	'5551433768',	'5302145943',	'5326778102',	'5322718366',	'5431160701',	'5326346239',	'5455682498',	'5368749399',	'5537777776',	'5363621535',	'5019112170',	'5424068503',	'5323651094',	'5335158388',	'5336438591',	'5428090866',	'5336767571',	'5516870122',	'5352971180',	'5425534207',	'5536411807',	'5532344314',	'5446379815',	'5335989513',	'5438231780',	'5357180201',	'5331595847',	'5467633824',	'5065821897',	'5379140560',	
'5344210221')

SELECT * FROM (
SELECT o.id as UyeID, o.activatedAt as UyeAktivasyonTarihi, c.name as Sehir,
       o.deActivatedAt as UyeDeaktivasyonTarihi, IF(o.isActivated=1,"Aktif","Pasif") as UyeDurum,
       t.serial_no as MaliNo,
       t.firstActivationDate as HizmetAktivasyonTarihi,
       IF(t.terminalStatus=1,"Aktif","Pasif") as HizmetDurum,
       p.name as Plan,
       s2.name as Hizmet,
       IF(p.taksitli=1,"Tek Çekim","Taksitli") as Taksit, bp.amount as IslemTutar, bp.signedDate as IslemTarih, bp.appliedRate as IslemKomisyon, bp.id as IslemID
       FROM odeal.Organisation o
JOIN odeal.Terminal t ON t.organisation_id = o.id
           LEFT JOIN odeal.City c ON c.id = o.cityId
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
JOIN odeal.BasePayment bp ON bp.id = tp.id
WHERE s2.id <> 3 AND o.demo = 0 AND bp.currentStatus = 6 AND bp.paymentType <> 4 AND bp.serviceId <>3 AND bp.signedDate >= DATE_FORMAT(DATE_SUB(CURDATE(), INTERVAL 1 DAY), "%Y-%m-%d") AND
bp.signedDate <= NOW()
UNION
SELECT o.id as UyeID, o.activatedAt as UyeAktivasyonTarihi, c.name as Sehir,
       o.deActivatedAt as UyeDeaktivasyonTarihi, IF(o.isActivated=1,"Aktif","Pasif") as UyeDurum,
         s.id as MaliNo,
        s.activationDate as HizmetAktivasyonTarihi,
       IF(s.status=1,"Aktif","Pasif") as HizmetDurum,
         p.name as Plan,
       s2.name as Hizmet,
       IF(p.taksitli=1,"Tek Çekim","Taksitli") as Taksit, bp.amount as IslemTutar, bp.signedDate as IslemTarih,  bp.appliedRate as IslemKomisyon, bp.id as IslemID
FROM odeal.Organisation o
LEFT JOIN odeal.City c ON c.id = o.cityId
JOIN subscription.Subscription s ON s.organisationId = o.id
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
JOIN odeal.BasePayment bp ON bp.organisationId = o.id
WHERE s2.id = 3 AND s.id IN (SELECT MAX(s.id) FROM subscription.Subscription s
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
LEFT JOIN odeal.Payment p2 ON p2.id = bp.id
WHERE s2.id = 3 AND o.demo = 0 AND bp.currentStatus = 6 AND bp.paymentType <> 4 AND bp.serviceId <>3 AND bp.signedDate >= DATE_FORMAT(DATE_SUB(CURDATE(), INTERVAL 1 DAY), "%Y-%m-%d") AND
bp.signedDate <= NOW()
GROUP BY s.organisationId)) AS TUM;


SELECT MAX(s.id) FROM subscription.Subscription s
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE s2.id = 3 AND s.status = 1
GROUP BY s.organisationId

SELECT o.id, o.marka, IF(o.isActivated=1,"Aktif","Pasif") as UyeDurum, t.serial_no as MaliNo,
       IF(t.terminalStatus=1,"Aktif","Pasif") as TerminalDurum, SUM(bp.amount) as Ciro, SUM(bp.paybackAmount) as GeriOdeme,
       s2.name as Hizmet
FROM odeal.Organisation o
JOIN odeal.Terminal t ON t.organisation_id = o.id
JOIN subscription.Subscription s ON s.id = t.subscription_id AND s.status = 1
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
JOIN odeal.BasePayment bp ON bp.id = tp.id
WHERE bp.currentStatus = 6 AND bp.signedDate >= '2024-06-01 00:00:00' AND bp.signedDate <= "2024-06-30 23:59:59" AND bp.serviceId <> 3
GROUP BY o.id, o.marka, t.serial_no, IF(o.isActivated=1,"Aktif","Pasif"), IF(t.terminalStatus=1,"Aktif","Pasif"), s2.name



SELECT DATE_FORMAT(bp.signedDate,"%Y-%m-%d") as Gun, bp.appliedRate as Komisyon, bp.serviceId as Hizmet, SUM(bp.amount) as Ciro, COUNT(bp.id) as IslemAdet FROM odeal.BasePayment bp
WHERE bp.currentStatus = 6 AND bp.paymentType <> 4 AND bp.signedDate >= '2022-01-01 00:00:00'
GROUP BY DATE_FORMAT(bp.signedDate,"%Y-%m-%d"), bp.appliedRate, bp.serviceId


SELECT bp.organisationId AS "Org. ID", SUM(bp.amount) AS "Tutar",COUNT(bp.id) AS "İşlem Adedi",
DATE(bp.signedDate) AS "İşlem Tarihi",serviceId,
IF(COALESCE(tp.installment, p.installment) >1,"Taksitli","Tek Çekim") AS "Taksit Durumu", bp.appliedRate as "Komisyon Oranı"
FROM odeal.BasePayment bp
LEFT JOIN odeal.Payment p ON p.id = bp.id
LEFT JOIN odeal.TerminalPayment tp ON tp.id = bp.id
WHERE  bp.currentStatus = 6
AND bp.cancelDate IS NULL
AND bp.signedDate IS NOT NULL
AND bp.organisationId IS NOT NULL AND bp.signedDate >= DATE_FORMAT(DATE_SUB(CURDATE(), INTERVAL 2 MONTH),"%Y-%m-01") AND bp.signedDate <= NOW()
GROUP BY bp.organisationId,serviceId,DATE(bp.signedDate), IF(COALESCE(tp.installment, p.installment) >1,"Taksitli","Tek Çekim"),
IF(bp.appliedRate = 0, "0 Komisyon","Diğer Komisyon"),bp.appliedRate

SELECT o.id, IF(o.isActivated=1,"Aktif","Pasif") as UyeDurum, t.serial_no,
       IF(t.terminalStatus=1,"Aktif","Pasif") as TerminalDurum,
       t.firstActivationDate as TerminalAktivasyonTarihi,
       s.name as Hizmet,
       COUNT(bp.id) as IslemAdet,
       SUM(bp.amount) as Ciro,
       MAX(bp.signedDate) as SonIslemTarihi
FROM odeal.Organisation o
JOIN odeal.Terminal t ON t.organisation_id = o.id
JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
JOIN odeal.BasePayment bp ON bp.id = tp.id
JOIN subscription.Subscription sub ON sub.id = t.subscription_id
JOIN subscription.Plan p ON p.id = sub.planId
JOIN subscription.Service s ON s.id = p.serviceId
WHERE bp.currentStatus = 6 AND o.id = 301109836
GROUP BY o.id,IF(o.isActivated=1,"Aktif","Pasif"), t.serial_no,t.firstActivationDate, IF(t.terminalStatus=1,"Aktif","Pasif"), s.name