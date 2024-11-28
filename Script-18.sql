SELECT *FROM (
SELECT bp.organisationId, bp.id,
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
bp.posId, bp.signedDate, bp.appliedRate, bp.amount, bp.serviceId, Abonelik.id as AbonelikID,
bp.organisationId as SerialNo, "CeptePos" as Tedarikci, Abonelik.`_createdDate` as AktivasyonTarihi, p2.installment, IF(p2.installment>1,"Taksitli" , "Tek Çekim") as TaksitDurum, c2.name as Kanal, p.addonId as Cihaz,
p.name as Plan, p.commissionRates as PlanKomisyon
 FROM odeal.BasePayment bp
JOIN (SELECT * FROM subscription.Subscription s WHERE s.id IN (
SELECT MAX(s.id) FROM odeal.Organisation o 
JOIN subscription.Subscription s ON s.organisationId = o.id
JOIN subscription.Plan p ON p.id = s.planId AND p.serviceId = 3
GROUP BY o.id)) as Abonelik ON Abonelik.organisationId = bp.organisationId
JOIN subscription.Plan p ON p.id = Abonelik.planId
LEFT JOIN odeal.Payment p2 ON p2.id = bp.id
LEFT JOIN odeal.Channel c2 ON c2.id = Abonelik.channelId
WHERE bp.currentStatus = 6 AND bp.serviceId = 3 AND bp.amount >= 1 AND bp.signedDate >= DATE_SUB(CURDATE(), INTERVAL 1 DAY) AND
bp.signedDate <= NOW()
UNION
SELECT bp.organisationId, bp.id,
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
bp.posId, bp.signedDate, bp.appliedRate, bp.amount, bp.serviceId, s.id as AbonelikID,
t.serial_no as SerialNo, t.supplier as Tedarikci,  t.firstActivationDate as AktivasyonTarihi, tp.installment, IF(tp.installment>1, "Taksitli" , "Tek Çekim") as TaksitDurum, c2.name as Kanal, p.addonId as Cihaz,
p.name as Plan, p.commissionRates as PlanKomisyon
 FROM odeal.BasePayment bp
LEFT JOIN odeal.TerminalPayment tp ON tp.id = bp.id
LEFT JOIN odeal.Terminal t ON t.id = tp.terminal_id
LEFT JOIN subscription.Subscription s ON s.id = t.subscription_id
LEFT JOIN subscription.Plan p ON p.id = s.planId
LEFT JOIN odeal.Channel c2 ON c2.id = t.channelId
WHERE bp.currentStatus = 6 AND bp.serviceId <>3 AND bp.amount >= 1 AND bp.signedDate >= DATE_SUB(CURDATE(), INTERVAL 1 DAY) AND
bp.signedDate <= NOW()
) as Islemler

bp.signedDate >= DATE_SUB(CURDATE(), INTERVAL 1 MONTH) AND

SELECT DATE_SUB(CURDATE(), INTERVAL 1 MONTH)

bp.signedDate <= LAST_DAY(DATE_SUB(CURDATE(), INTERVAL 1 MONTH))

SELECT * FROM tablo_adı
WHERE tarih_kolonu >= DATE_FORMAT(DATE_SUB(CURDATE(), INTERVAL 1 MONTH), "%Y-%m-01")
AND tarih_kolonu < DATE_FORMAT(CURDATE(), "%Y-%m-%d");


SELECT * FROM tablo_adı
WHERE tarih_kolonu >= DATE_FORMAT(CURDATE(), "%Y-%m-01")
AND tarih_kolonu < DATE_ADD(DATE_FORMAT(CURDATE(), "%Y-%m-01"), INTERVAL 1 MONTH);


SELECT DATE_FORMAT("2024-02-21 23:45:58","%Y-%m-%d %H:%i:%s")

SELECT DATE_SUB("2017-06-15", INTERVAL -2 MONTH);

SELECT * FROM odeal.Town t WHERE t.cityId = 34

SELECT * FROM odeal.Organisation o WHERE o.cityId = 34 AND o.townId =458


rp.eod_date >= DATE_FORMAT(DATE_SUB(CURDATE() - INTERVAL 7 DAY), '%Y-%m-%d')

SELECT DATE_SUB(CURDATE(),INTERVAL 7 DAY)

SELECT * FROM paymatch.bank_report br 
ORDER BY br.created_date DESC LIMIT 10


SELECT
bp.id,
rp.unique_key as main_key,
bp.amount,
bp.paybackAmount,
bp.service_name,
bp.uretici,
bp.plan_tipi,
date(rp.eod_date) as eod_date,
CASE 
   WHEN geri_odeme_durumu =1  THEN  1
   WHEN geri_odeme_durumu =0 THEN 0
   ELSE 2
END AS durum
FROM (SELECT b.id,b.paybackId, b.uniqueKey,b.amount,b.paybackAmount,
            s.name as service_name,tp.terminal_id,
           CASE
             WHEN LEFT(t.serial_no,3) = "PAX" THEN "PAX"
             WHEN LEFT(t.serial_no,1) = "2" OR LEFT(t.serial_no,1) = "J" THEN "INGENICO"
             WHEN LEFT(t.serial_no,1) = "B"  THEN "PROFILO"
           END AS uretici,
           CASE 
	           WHEN (b.paybackId is not null or b.paybackId!=0) THEN 1
               WHEN  (b.paybackId is null or b.paybackId=0) THEN 0
               ELSE 2
           END AS geri_odeme_durumu,
            CASE
             WHEN tp.installment IN (1,0) THEN "Tek Çekim"
             ELSE "Taksitli"
           END AS plan_tipi
           FROM odeal.BasePayment b
           JOIN odeal.TerminalPayment tp ON tp.id=b.id
           JOIN odeal.Terminal t  ON tp.terminal_id =t.id
           JOIN subscription.Service s ON s.id=b.serviceId 
           WHERE  b.signedDate is not null 
           and b.cancelDate is null
           and b.amount>=1
           and b.organisationId is not null
           and b.currentStatus=6 and b.signedDate >= DATE_SUB(CURDATE(), INTERVAL 14 DAY) and b.signedDate <= NOW()) bp
JOIN  paymatch.eod_received_payment rp on bp.uniqueKey=rp.unique_key
WHERE rp.eod_date >= DATE_SUB(CURDATE(),INTERVAL 7 DAY)


SELECT e.id AS einvoiceId,bp.id AS basepaymentId, tp.terminal_id, e.organisationId AS "Organizasyon Id",e.invoiceType AS "Fatura Tipi",
e.created_date AS "Fatura Oluşturulma Tarihi", e.last_modified_date AS "Fatura Güncellenme Tarihi",
bp.signedDate AS "İşlem Tarihi",b.gross_price AS "Tutar",
TIME_TO_SEC(TIMEDIFF(e.created_date,bp.`_createdDate`)) AS "Fatura Oluşma Süresi",
CASE WHEN e.state IN ("COMPLETED","CANCELLED") THEN 
	IF(bp.id IS NULL,TIME_TO_SEC(TIMEDIFF(e.last_modified_date ,e.created_date)),
	TIME_TO_SEC(TIMEDIFF(e.last_modified_date ,bp.`_createdDate`))) ELSE NULL END AS "Fatura Tamamlanma Süresi",
bp.currentStatus, bp.serviceId,
IF(COALESCE(tp.installment,p.installment) = 1 OR
COALESCE(tp.installment,p.installment) = 0 OR
bp.id IS NULL, "Tek Çekim","Taksitli") AS "İşlem Türü",
IF(bp.id IS NULL, "Nakit İşlem", "İşlem Kaydı Var") AS "İşlem Kaydı",
e.status AS "Statü", e.state AS "Durum", e.integrator AS "Entegratör", b.created_by AS "Oluşturan", t.serial_no, bp.paymentType
FROM odeal.EInvoice e 
LEFT JOIN odeal.BasePayment bp ON bp.basketId = e.basketId 
LEFT JOIN odeal.TerminalPayment tp ON bp.id = tp.id 
LEFT JOIN odeal.Terminal t ON t.id = tp.terminal_id
LEFT JOIN odeal.Payment p ON p.id = bp.id 
JOIN retail.basket b ON b.id = e.basketId 
WHERE bp.signedDate >= DATE_FORMAT(DATE_SUB(CURDATE(),INTERVAL 1 MONTH),"%Y-%m-01") AND bp.signedDate <= NOW() AND bp.currentStatus = 6
ORDER BY e.id DESC

select date(gen_date)  from 
(select adddate('1970-01-01',t4*10000 + t3*1000 + t2*100 + t1*10 + t0) gen_date
from
 (select 0 t0 union select 1 union select 2 union select 3 union select 4 union select 5 union select 6 union select 7 union select 8 union select 9) t0,
 (select 0 t1 union select 1 union select 2 union select 3 union select 4 union select 5 union select 6 union select 7 union select 8 union select 9) t1,
 (select 0 t2 union select 1 union select 2 union select 3 union select 4 union select 5 union select 6 union select 7 union select 8 union select 9) t2,
 (select 0 t3 union select 1 union select 2 union select 3 union select 4 union select 5 union select 6 union select 7 union select 8 union select 9) t3,
 (select 0 t4 union select 1 union select 2 union select 3 union select 4 union select 5 union select 6 union select 7 union select 8 union select 9) t4) v
where gen_date between '2021-01-01' and CURRENT_DATE()