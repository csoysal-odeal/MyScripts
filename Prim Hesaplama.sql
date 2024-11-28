SELECT id,organisationId,terminal_id,serial_no,serviceId ,channel_id,taksitli, isActivated ,terminalStatus,activationDate,cancelDate
FROM (
    SELECT o.id, o.organisationId, t.id as terminal_id, t.serial_no, pln.serviceId, t.channelId as channel_id, sb.status, o.isActivated , o.activatedAt  , o.deActivatedAt, sb.start,
pln.taksitli,t.terminalStatus,
        case
            when o.activatedAt > t.firstActivationDate and sb.status=1 then o.activatedAt
            else t.firstActivationDate
        end activationDate,
       case 
	  when t.terminalStatus=0  and sb.status<>0 then 
	    (case when o.isActivated=0 and sb.cancelledAt is null and o.deActivatedAt>o.activatedAt then o.deActivatedAt 
	            else sb.cancelledAt end )
	  when terminalStatus=1 then null 
	  else sb.cancelledAt
	end cancelDate
FROM odeal.Organisation o
        JOIN subscription.Subscription sb ON sb.organisationId = o.id 
        JOIN subscription.Plan pln ON pln.id = sb.planId and serviceId<>3 
        JOIN odeal.Terminal t ON t.subscription_id = sb.id   
        WHERE o.demo = 0
    ) temp2 
 WHERE 
id NOT IN (301011013,301160192) AND id = 301001608
ORDER BY id, activationDate


SELECT id,organisationId,terminal_id,serial_no,serviceId ,channel_id,taksitli, isActivated ,terminalStatus,activationDate,cancelDate,
(@row_number := @row_number + 1) AS siralama
FROM (
    SELECT o.id, o.organisationId, t.id as terminal_id, t.serial_no, pln.serviceId, t.channelId as channel_id, sb.status, o.isActivated , o.activatedAt  , o.deActivatedAt, sb.start,
pln.taksitli,t.terminalStatus, (@row_number := 0) AS dummy_var,
        case
            when o.activatedAt > t.firstActivationDate and sb.status=1 then o.activatedAt
            else t.firstActivationDate
        end activationDate,
       case 
      when t.terminalStatus=0  and sb.status<>0 then 
        (case when o.isActivated=0 and sb.cancelledAt is null and o.deActivatedAt>o.activatedAt then o.deActivatedAt 
                else sb.cancelledAt end )
      when terminalStatus=1 then null 
      else sb.cancelledAt
    end cancelDate
FROM odeal.Organisation o
        JOIN subscription.Subscription sb ON sb.organisationId = o.id 
        JOIN subscription.Plan pln ON pln.id = sb.planId and serviceId<>3 
        JOIN odeal.Terminal t ON t.subscription_id = sb.id
        WHERE o.demo = 0
    ) temp2 
 WHERE
id NOT IN (301011013,301160192) 
ORDER BY id, activationDate


SELECT Aktivasyon.id as OrgID, Aktivasyon.serial_no as MaliNo, IF(Aktivasyon.rn>1,"ESKİ","YENİ") as Sira FROM (
SELECT Terminal.id, Terminal.serial_no, Terminal.firstActivationDate, Terminal.terminalStatus, @terminal:=CASE WHEN @orgid <> id THEN 1 ELSE @terminal+1 END AS rn,
   @orgid:=id AS clset
FROM
  (SELECT @terminal:= -1) term,
  (SELECT @orgid:= -1) c,
  (SELECT o.id, t.serial_no, t.firstActivationDate, t.terminalStatus FROM odeal.Organisation o 
  JOIN odeal.Terminal t ON t.organisation_id = o.id WHERE t.firstActivationDate IS NOT NULL
  ORDER BY o.id, t.firstActivationDate
  ) as Terminal) as Aktivasyon


SELECT Terminaller.id, Terminaller.organisationId, Terminaller.terminal_id, Terminaller.serial_no, 
Terminaller.serviceId, Terminaller.channel_id, Terminaller.taksitli, Terminaller.isActivated, 
Terminaller.terminalStatus, Terminaller.activationDate, Terminaller.activatedAt, Terminaller.cancelDate,
Terminaller.deActivatedAt,
Terminaller.rn as Siralama,
IF(MONTH(Terminaller.activatedAt)=MONTH(Terminaller.activationDate),"1","2") as Durum, 
IF(ISNULL(Terminaller.cancelDate),1,Terminaller.rn) as IptalDurum, 
IF(IF(MONTH(Terminaller.activatedAt)=MONTH(Terminaller.activationDate),"1","2")=Terminaller.rn,"Yeni","Mevcut") as TerminalDurum,
IF(IF(MONTH(Terminaller.activatedAt)=MONTH(Terminaller.activationDate),"1","2")=1,"YENİ","EK CİHAZ") as SonDurum,
IF(EXTRACT(YEAR_MONTH FROM Terminaller.activatedAt)<EXTRACT(YEAR_MONTH FROM Terminaller.activationDate),"MEVCUT","YENİ") as UyeTerminalIliskisi
FROM (
SELECT id, organisationId, terminal_id, serial_no, serviceId, channel_id, taksitli, isActivated ,terminalStatus, activationDate, cancelDate, activatedAt, deActivatedAt,
@row_number := CASE WHEN @orgid <> id THEN 1 ELSE @row_number + 1 END AS rn,
@orgid := id AS clset
FROM (
    SELECT o.id, o.organisationId, t.id as terminal_id, t.serial_no, pln.serviceId, t.channelId as channel_id, sb.status, o.isActivated , o.activatedAt  , o.deActivatedAt, sb.start,
pln.taksitli,t.terminalStatus, (@row_number := 0) AS dummy_var, @orgid:=0 AS c,
        CASE 
            WHEN o.activatedAt > t.firstActivationDate AND sb.status=1 THEN o.activatedAt
            ELSE t.firstActivationDate
        END activationDate,
           CASE 
              WHEN t.terminalStatus=0  AND sb.status<>0 THEN 
                (CASE WHEN o.isActivated=0 AND sb.cancelledAt IS NULL AND o.deActivatedAt>o.activatedAt THEN o.deActivatedAt 
                      ELSE sb.cancelledAt END)
              WHEN terminalStatus=1 THEN NULL 
              ELSE sb.cancelledAt
        END cancelDate
FROM odeal.Organisation o
        JOIN subscription.Subscription sb ON sb.organisationId = o.id 
        JOIN subscription.Plan pln ON pln.id = sb.planId and serviceId<>3 
        JOIN odeal.Terminal t ON t.subscription_id = sb.id
        WHERE o.demo = 0 ORDER BY id, cancelDate, activationDate
    ) temp2 
WHERE id NOT IN (301011013,301160192)) as Terminaller
WHERE Terminaller.id = 301184420 AND Terminaller.activationDate IS NOT NULL


AND MONTH(Terminaller.activationDate) = "03" AND YEAR(Terminaller.activationDate) = "2024"


  SELECT o.id, t.serial_no, t.firstActivationDate, o.deActivatedAt FROM odeal.Organisation o 
  LEFT JOIN odeal.Terminal t ON t.organisation_id = o.id
  WHERE t.serial_no = "FT30066291" ORDER BY o.id, t.firstActivationDate
  
  301256961 301048156 301254048 301184420
  
  SELECT o.id as UyeID, o.activatedAt, o.deActivatedAt FROM odeal.Organisation o
  
  SELECT EXTRACT(YEAR_MONTH FROM o.activatedAt)  FROM odeal.Organisation o WHERE o.id = 301024764  
  
SELECT t.organisation_id, t.serial_no, t.id, SUM(bp.amount) as Ciro, MAX(bp.signedDate) as SonTarih, MIN(bp.signedDate) as IlkTarih FROM odeal.BasePayment bp
JOIN odeal.TerminalPayment tp ON tp.id = bp.id 
JOIN odeal.Terminal t ON t.id = tp.terminal_id 
WHERE t.serial_no = "FT30066291" AND bp.currentStatus = 6
GROUP BY t.organisation_id, t.serial_no, t.id

-- Prim Hesap 1
SELECT *, (Prim.AyYilTerminalAktivasyon-Prim.AyYilUyeAktivasyon) as Fark, 
IF(Prim.AyYilUyeAktivasyon=Prim.AyYilTerminalAktivasyon AND Prim.Sira=1 AND (Prim.AyYilTerminalAktivasyon-Prim.AyYilUyeAktivasyon)<30,"Yeni",
	IF(Prim.AyYilUyeAktivasyon=Prim.AyYilTerminalAktivasyon AND Prim.Sira>1 AND (Prim.AyYilTerminalAktivasyon-Prim.AyYilUyeAktivasyon)<30,"Ek Cihaz",
		IF(Prim.AyYilUyeAktivasyon<>Prim.AyYilTerminalAktivasyon AND (Prim.AyYilTerminalAktivasyon-Prim.AyYilUyeAktivasyon)>30 AND Prim.Sira>1,"Mevcut","Yeni")))
as Durum FROM (
SELECT *, EXTRACT(YEAR_MONTH FROM Aktivasyon.activatedAt) as AyYilUyeAktivasyon, EXTRACT(YEAR_MONTH FROM Aktivasyon.activationDate) as AyYilTerminalAktivasyon FROM (
SELECT *, ROW_NUMBER() OVER (PARTITION BY Aktivasyon1.id ORDER BY Aktivasyon1.firstActivationDate) as Sira FROM (
SELECT o.id, o.organisationId, t.id as terminal_id, t.serial_no, t.firstActivationDate, pln.serviceId, t.channelId as channel_id, sb.status, o.isActivated , o.activatedAt  , o.deActivatedAt, sb.start,
pln.taksitli,t.terminalStatus,
        CASE 
            WHEN o.activatedAt > t.firstActivationDate AND sb.status=1 THEN o.activatedAt
            ELSE t.firstActivationDate
        END as activationDate,
           CASE 
              WHEN t.terminalStatus=0  AND sb.status<>0 THEN 
                (CASE WHEN o.isActivated=0 AND sb.cancelledAt IS NULL AND o.deActivatedAt>o.activatedAt THEN o.deActivatedAt 
                      ELSE sb.cancelledAt END)
              WHEN terminalStatus=1 THEN NULL 
              ELSE sb.cancelledAt
        END as cancelDate
FROM odeal.Organisation o
        JOIN subscription.Subscription sb ON sb.organisationId = o.id 
        JOIN subscription.Plan pln ON pln.id = sb.planId and serviceId<>3 
        JOIN odeal.Terminal t ON t.subscription_id = sb.id
        WHERE o.demo = 0 AND t.firstActivationDate IS NOT NULL AND o.id = 301256013 ORDER BY activationDate) as Aktivasyon1 WHERE Aktivasyon1.cancelDate IS NULL) as Aktivasyon) as Prim

        
        
-- Prim Hesap 2        
SELECT *,IF(Prim2.Fark>0 AND Prim2.GunKural<120 AND Prim2.CeptePos=0,"Mevcut",
			IF(Prim2.Fark=0 AND Prim2.Sira=1,"Yeni",
                IF(Prim2.Fark=0 AND Prim2.Sira=1 AND Prim2.OlusmaFark>0 AND Prim2.GunKural>0 AND Prim2.GunFark<10 AND ISNULL(Prim2.SonrakiFark),"Yeni",
				IF(Prim2.Fark>0 AND Prim2.Sira=1 AND Prim2.GunFark<=10,"Yeni",
					IF(Prim2.Fark>0 AND Prim2.Sira=1 AND Prim2.GunFark>10 AND Prim2.CeptePos=1,"Yeni",
					IF(Prim2.Fark>0 AND Prim2.Sira=1 AND Prim2.GunFark>10 AND Prim2.CeptePos=1 AND Prim2.GunKural<120,"Yeni",
						IF(Prim2.Fark=0 AND Prim2.Sira>1,"Ek Cihaz",
							IF(Prim2.Fark>0 AND Prim2.Sira>1 AND Prim2.GunFark<=10 AND Prim2.SonrakiFark<1,"Ek Cihaz",
							IF(Prim2.Fark>0 AND Prim2.Sira>1 AND Prim2.GunFark<=10 AND ISNULL(Prim2.SonrakiFark),"Ek Cihaz",
							IF(Prim2.Fark>0 AND Prim2.Sira>1 AND Prim2.GunFark<=10,"Ek Cihaz",
								IF(Prim2.Fark>0 AND Prim2.Sira>1 AND Prim2.GunFark>10 AND Prim2.CeptePos=1,"Ek Cihaz",
								IF(Prim2.Fark>0 AND Prim2.Sira>1 AND Prim2.GunFark>10 AND Prim2.CeptePos=1 AND Prim2.GunKural<120,"Ek Cihaz",
								    IF(Prim2.Fark=0 AND Prim2.Sira>1 AND Prim2.OlusmaFark>0 AND Prim2.GunKural>0 AND Prim2.GunFark<10 AND ISNULL(Prim2.SonrakiFark),"Ek Cihaz",
									IF(Prim2.Fark>0 AND Prim2.Sira>1 AND Prim2.GunFark>10 AND Prim2.CeptePos=0,"Mevcut","Yeni"))))))))))))))
as Durum FROM (
SELECT *, 
TIMESTAMPDIFF(month,Prim.GunAyYilUyeAktivasyon,GunAyYilTerminalAktivasyon) as Fark, 
TIMESTAMPDIFF(MONTH,Prim.GunAyYilUyeOlusturma,Prim.GunAyYilUyeAktivasyon) as OlusmaFark, 
TIMESTAMPDIFF(DAY,Prim.GunAyYilUyeAktivasyon,Prim.GunAyYilTerminalAktivasyon) as GunFark, 
TIMESTAMPDIFF(MONTH,Prim.GunAyYilTerminalAktivasyon,Prim.SonrakiIlkAktivasyonTarih) as SonrakiFark, 
TIMESTAMPDIFF(DAY,Prim.GunAyYilUyeDeaktivasyon,Prim.GunAyYilUyeAktivasyon) as GunKural
 FROM (
SELECT *, EXTRACT(YEAR_MONTH FROM Aktivasyon.activatedAt) as AyYilUyeAktivasyon, EXTRACT(YEAR_MONTH FROM Aktivasyon.createdAt) as AyYilUyeOlusturma, EXTRACT(YEAR_MONTH FROM Aktivasyon.activationDate) as AyYilTerminalAktivasyon,
DATE(Aktivasyon.activatedAt) as GunAyYilUyeAktivasyon, DATE(Aktivasyon.createdAt) as GunAyYilUyeOlusturma, DATE(Aktivasyon.deActivatedAt) as GunAyYilUyeDeaktivasyon, DATE(Aktivasyon.activationDate) as GunAyYilTerminalAktivasyon, DATE(Aktivasyon.SonrakiIlkAktivasyonTarih), EXTRACT(YEAR_MONTH FROM Aktivasyon.SonrakiIlkAktivasyonTarih) as SonrakiAyYilTerminalAktivasyon FROM (
SELECT  *, ROW_NUMBER() OVER (PARTITION BY Aktivasyon1.id ORDER BY Aktivasyon1.firstActivationDate) as Sira, LEAD(Aktivasyon1.firstActivationDate) OVER(PARTITION BY Aktivasyon1.id) as SonrakiIlkAktivasyonTarih FROM (
SELECT DISTINCT o.id, o.organisationId, t.id as terminal_id, t.serial_no, t.firstActivationDate, pln.serviceId, t.channelId as channel_id, sb.status, o.isActivated , o.activatedAt, o.createdAt, o.deActivatedAt, sb.start,
pln.taksitli,t.terminalStatus,
        CASE 
            WHEN o.activatedAt > t.firstActivationDate AND sb.status=1 THEN o.activatedAt
            ELSE t.firstActivationDate
        END as activationDate,
           CASE 
              WHEN t.terminalStatus=0  AND sb.status<>0 THEN 
                (CASE WHEN o.isActivated=0 AND sb.cancelledAt IS NULL AND o.deActivatedAt>o.activatedAt THEN o.deActivatedAt 
                      ELSE sb.cancelledAt END)
              WHEN terminalStatus=1 THEN NULL 
              ELSE sb.cancelledAt
        END as cancelDate, IF(ISNULL(CeptePos.id),"0","1") as CeptePos
FROM odeal.Organisation o
        JOIN subscription.Subscription sb ON sb.organisationId = o.id 
        JOIN subscription.Plan pln ON pln.id = sb.planId and serviceId<>3 
        JOIN odeal.Terminal t ON t.subscription_id = sb.id
        LEFT JOIN (SELECT o.id, s.id as Abonelik, p.name, t.serial_no FROM odeal.Organisation o
JOIN subscription.Subscription s ON s.organisationId = o.id
JOIN subscription.Plan p ON p.id = s.planId AND p.serviceId = 3
LEFT JOIN odeal.Terminal t ON t.organisation_id = o.id
WHERE o.isActivated = 1 AND s.id IN (
SELECT MAX(s.id) FROM odeal.Organisation o
JOIN subscription.Subscription s ON s.organisationId = o.id
JOIN subscription.Plan p ON p.id = s.planId AND p.serviceId = 3
WHERE o.isActivated = 1 GROUP BY o.id)) as CeptePos ON CeptePos.id = o.id AND CeptePos.serial_no = t.serial_no
        WHERE o.demo = 0 AND t.firstActivationDate IS NOT NULL AND t.terminalStatus = 1 ORDER BY activationDate) as Aktivasyon1 
        WHERE Aktivasyon1.cancelDate IS NULL) as Aktivasyon) as Prim) as Prim2 WHERE Prim2.id = 301229886
        
-- Prim Hesap 3  

SELECT IF(Prim2.terminalStatus=1,"Aktif","Pasif") as TerminalDurum,
IF(Prim2.Fark=0 AND Prim2.Sira=1 AND Prim2.OlusmaFark=0 AND Prim2.GunKural<180,"Yeni",
		IF(Prim2.Fark=0 AND Prim2.Sira=1 AND Prim2.OlusmaFark>=0 AND Prim2.terminalStatus=1,"Yeni",
			IF(Prim2.Fark=0 AND Prim2.Sira>1 AND Prim2.GunFark<10 AND Prim2.terminalStatus=1 AND Prim2.TerminalAyFark>0 AND Prim2.GunKural>=180,"Yeni",
			IF(Prim2.Fark=0 AND Prim2.Sira>1 AND Prim2.GunFark<10 AND Prim2.terminalStatus=1 AND ISNULL(Prim2.TerminalAyFark) AND ISNULL(Prim2.GunKural),"Yeni",
				IF(Prim2.Fark>0 AND Prim2.Sira=1 AND Prim2.GunFark<10 AND Prim2.GunKural>180,"Yeni",
				  IF(Prim2.Fark>0 AND Prim2.Sira=1 AND Prim2.GunFark<10 AND Prim2.terminalStatus=1 AND ISNULL(Prim2.GunKural),"Yeni",
						IF(Prim2.Fark>0 AND Prim2.Sira=1 AND Prim2.GunFark>10 AND Prim2.CeptePos=0 AND Prim2.GunKural>180,"Yeni",
						   IF(Prim2.Fark>0 AND Prim2.Sira=1 AND Prim2.GunFark>10 AND Prim2.CeptePos=0 AND ISNULL(Prim2.GunKural),"Yeni",
							IF(Prim2.Fark>0 AND Prim2.Sira=1 AND Prim2.GunFark>10 AND Prim2.CeptePos=1 AND Prim2.GunKural<180,"Yeni",
							IF(Prim2.Fark>0 AND Prim2.Sira=1 AND Prim2.GunFark>10 AND Prim2.CeptePos=1 AND ISNULL(Prim2.GunKural),"Yeni",
							IF(Prim2.Fark>0 AND Prim2.Sira>1 AND Prim2.GunFark<10 AND Prim2.CeptePos=0 AND ISNULL(Prim2.GunKural),"Yeni",
							  IF(Prim2.Fark>0 AND Prim2.Sira>1 AND Prim2.GunFark<10 AND Prim2.CeptePos=0 AND ISNULL(Prim2.TerminalAyFark) AND ISNULL(Prim2.GunKural) AND Prim2.terminalStatus=1,"Yeni",
							      IF(Prim2.Fark>0 AND Prim2.Sira>1 AND Prim2.GunFark>0 AND Prim2.CeptePos=1 AND Prim2.GunKural<180 AND Prim2.terminalStatus=1 AND ISNULL(Prim2.TerminalAyFark),"Yeni",
							       IF(Prim2.Fark>0 AND Prim2.Sira>1 AND Prim2.GunFark>0 AND Prim2.CeptePos=1 AND ISNULL(Prim2.GunKural) AND ISNULL(Prim2.TerminalAyFark) AND Prim2.terminalStatus=1,"Yeni",
							         IF(Prim2.Fark>0 AND Prim2.Sira>1 AND Prim2.GunFark>0 AND Prim2.CeptePos=0 AND Prim2.GunKural>180 AND Prim2.terminalStatus=1,"Yeni",
									IF(Prim2.Fark=0 AND Prim2.Sira>1 AND Prim2.GunKural>=180,"Ek Cihaz",
									   IF(Prim2.Fark=0 AND Prim2.Sira>1 AND Prim2.GunKural>=180 AND Prim2.TerminalAyFark=0,"Ek Cihaz",
				  						IF(Prim2.Fark=0 AND Prim2.Sira>1 AND Prim2.OlusmaFark>0 AND Prim2.GunKural>0 AND Prim2.GunFark<10 AND ISNULL(Prim2.TerminalAyFark),"Ek Cihaz",
					  						IF(Prim2.Fark=0 AND Prim2.Sira>1 AND ISNULL(Prim2.GunKural),"Ek Cihaz",
					  							IF(Prim2.Fark=0 AND Prim2.Sira>1 AND Prim2.GunKural<180 AND ISNULL(Prim2.TerminalAyFark),"Ek Cihaz",
					  					IF(Prim2.Fark>0 AND Prim2.Sira>1 AND Prim2.GunFark>10 AND Prim2.CeptePos=1 AND Prim2.GunKural<180,"Ek Cihaz",
				  							IF(Prim2.Fark>0 AND Prim2.Sira>1 AND Prim2.GunFark<10 AND Prim2.CeptePos=1 AND Prim2.TerminalAyFark=0,"Ek Cihaz",
				  							   IF(Prim2.Fark>0 AND Prim2.Sira>1 AND Prim2.GunFark<10 AND Prim2.CeptePos=0 AND Prim2.TerminalAyFark>0,"Ek Cihaz",
				  							  	IF(Prim2.Fark>0 AND Prim2.Sira>1 AND Prim2.GunFark>10 AND Prim2.CeptePos=1 AND Prim2.TerminalAyFark=0 AND Prim2.GunKural>0,"Ek Cihaz",
				  							  		IF(Prim2.Fark>0 AND Prim2.Sira>1 AND Prim2.GunFark>10 AND Prim2.CeptePos=1 AND Prim2.TerminalAyFark=0 AND ISNULL(Prim2.GunKural),"Ek Cihaz",
				  							  		IF(Prim2.Fark>0 AND Prim2.Sira>1 AND Prim2.GunFark>10 AND Prim2.CeptePos=0 AND Prim2.TerminalAyFark=0 AND ISNULL(Prim2.GunKural),"Ek Cihaz",
				  							  			IF(Prim2.Fark>0 AND Prim2.Sira>1 AND Prim2.GunFark<=10 AND ISNULL(Prim2.TerminalAyFark),"Ek Cihaz",
				  							   				IF(Prim2.Fark>0 AND Prim2.Sira>1 AND Prim2.GunFark<10 AND Prim2.CeptePos=1,"Ek Cihaz",
													   			IF(Prim2.Fark=0 AND Prim2.Sira>1 AND Prim2.GunFark<10 AND Prim2.GunKural>=180,"Ek Cihaz","Mevcut")))))))))))))))))))))))))))))
as Durum, Prim2.* FROM (
SELECT *, 
PERIOD_DIFF(DATE_FORMAT(Prim.GunAyYilTerminalAktivasyon,"%Y%m"),DATE_FORMAT(Prim.GunAyYilUyeAktivasyon,"%Y%m")) as Fark, -- Üye İşyerinin Aktif olduğu tarih ile ilk fiziki cihazının aktif olduğu tarih arasındaki Aylık farktır. 
PERIOD_DIFF(DATE_FORMAT(Prim.GunAyYilUyeAktivasyon,"%Y%m"),DATE_FORMAT(Prim.GunAyYilUyeOlusturma,"%Y%m")) as OlusmaFark, -- Üye İşyerinin oluşturulma tarihi ile aktifleştirilme tarihi arasındaki Aylık farktır.
TIMESTAMPDIFF(DAY,Prim.GunAyYilUyeAktivasyon,Prim.GunAyYilTerminalAktivasyon) as GunFark, -- Üye İşyerinin aktif olduğu tarih ile ilk fiziki cihazının aktif olduğu tarih arasındaki Günlük farktır.
PERIOD_DIFF(DATE_FORMAT(Prim.GunAyYilTerminalAktivasyon,"%Y%m"),DATE_FORMAT(Prim.SonrakiAyYilTerminal_Aktivasyon,"%Y%m")) as TerminalAyFark, -- Üye İşyerinin aktif olduğu tarih ile ilk cihazı ve ek cihazının aynı ay içinde olma durumunu gösteren Aylık farktır.
TIMESTAMPDIFF(DAY,Prim.SonrakiAyYilTerminal_Aktivasyon,Prim.GunAyYilTerminalAktivasyon) as TerminalGunFark,
TIMESTAMPDIFF(DAY,Prim.GunAyYilUyeDeaktivasyon,Prim.GunAyYilUyeAktivasyon) as GunKural -- Üye İşyerinin deaktif tarihi ile daha sonra yeniden aktif olma tarihi arasındaki Aylık farktır.
 FROM (
SELECT *, 
EXTRACT(YEAR_MONTH FROM Aktivasyon.activatedAt) as AyYilUyeAktivasyon, 
EXTRACT(YEAR_MONTH FROM Aktivasyon.createdAt) as AyYilUyeOlusturma, 
EXTRACT(YEAR_MONTH FROM Aktivasyon.activationDate) as AyYilTerminalAktivasyon,
DATE(Aktivasyon.activatedAt) as GunAyYilUyeAktivasyon, 
DATE(Aktivasyon.createdAt) as GunAyYilUyeOlusturma, 
DATE(Aktivasyon.deActivatedAt) as GunAyYilUyeDeaktivasyon, 
DATE(Aktivasyon.activationDate) as GunAyYilTerminalAktivasyon, 
DATE(Aktivasyon.SonrakiIlkAktivasyonTarih) as SonrakiAyYilTerminal_Aktivasyon, 
EXTRACT(YEAR_MONTH FROM Aktivasyon.SonrakiIlkAktivasyonTarih) as SonrakiAyYilTerminalAktivasyon 
FROM (
SELECT  *, 
ROW_NUMBER() OVER (PARTITION BY Aktivasyon1.id ORDER BY Aktivasyon1.serial_no, Aktivasyon1.firstActivationDate) as Sira,
ROW_NUMBER() OVER (PARTITION BY Aktivasyon1.id ORDER BY Aktivasyon1.serial_no, Aktivasyon1.firstActivationDate) as Sira2,
LAG(Aktivasyon1.firstActivationDate) OVER(PARTITION BY Aktivasyon1.id) as SonrakiIlkAktivasyonTarih FROM (
SELECT DISTINCT o.id, o.organisationId, t.id as terminal_id, t.serial_no, t.firstActivationDate, pln.serviceId, t.channelId as channel_id, sb.status, o.isActivated , o.activatedAt, o.createdAt, o.deActivatedAt, sb.start,
pln.taksitli,t.terminalStatus,
        CASE 
            WHEN o.activatedAt > t.firstActivationDate AND sb.status=1 THEN o.activatedAt
            ELSE t.firstActivationDate
        END as activationDate,
           CASE 
              WHEN t.terminalStatus=0  AND sb.status<>0 THEN 
                (CASE WHEN o.isActivated=0 AND sb.cancelledAt IS NULL AND o.deActivatedAt>o.activatedAt THEN o.deActivatedAt 
                      ELSE sb.cancelledAt END)
              WHEN terminalStatus=1 THEN NULL 
              ELSE sb.cancelledAt
        END as cancelDate, IF(ISNULL(CeptePos.id),"0","1") as CeptePos
FROM odeal.Organisation o
        JOIN subscription.Subscription sb ON sb.organisationId = o.id 
        JOIN subscription.Plan pln ON pln.id = sb.planId and serviceId<>3 
        JOIN odeal.Terminal t ON t.subscription_id = sb.id
        LEFT JOIN (SELECT o.id, s.id as Abonelik, p.name, t.serial_no FROM odeal.Organisation o
JOIN subscription.Subscription s ON s.organisationId = o.id
JOIN subscription.Plan p ON p.id = s.planId AND p.serviceId = 3
LEFT JOIN odeal.Terminal t ON t.organisation_id = o.id
WHERE o.isActivated = 1 AND s.id IN (
SELECT MAX(s.id) FROM odeal.Organisation o
JOIN subscription.Subscription s ON s.organisationId = o.id
JOIN subscription.Plan p ON p.id = s.planId AND p.serviceId = 3
WHERE o.isActivated = 1 GROUP BY o.id)) as CeptePos ON CeptePos.id = o.id AND CeptePos.serial_no = t.serial_no
        WHERE o.demo = 0 AND t.firstActivationDate IS NOT NULL ORDER BY activationDate) as Aktivasyon1 
        ) as Aktivasyon) as Prim) as Prim2 WHERE Prim2.id IN (301109266,301262775);
        
       301199945  301109266

        
        IN (301139246,301058722,301019643,301071753,301226010,301255878,301260772,301260482)

        
        IN ()

  301010625,301013953,301019643, 301058722
        
        
301256016

-- İPTALLER
SELECT * FROM (
SELECT o.id as UyeID, t.serial_no as IptalSeriNo, t.id as TerminalID, t.usageStatus, t.terminalStatus, t.firstActivationDate, o.isActivated, s.cancelledAt,
ROW_NUMBER() OVER (PARTITION BY o.id ORDER BY t.firstActivationDate) as Sira
FROM odeal.Organisation o 
JOIN odeal.Terminal t ON t.organisation_id = o.id
JOIN subscription.Subscription s ON s.id = t.subscription_id
WHERE t.terminalStatus = 0 AND (s.cancelledAt IS NULL OR s.cancelledAt IS NOT NULL)) as Terminal WHERE Terminal.UyeID = 301263396

-- YENİ
SELECT * FROM (
SELECT o.id as UyeID, t.serial_no as YeniSeriNo, t.id as TerminalID, t.terminalStatus, t.firstActivationDate, o.isActivated, s.cancelledAt,
ROW_NUMBER() OVER (PARTITION BY o.id ORDER BY t.firstActivationDate) as Sira
FROM odeal.Organisation o 
JOIN odeal.Terminal t ON t.organisation_id = o.id
JOIN subscription.Subscription s ON s.id = t.subscription_id
WHERE t.terminalStatus = 1 AND (s.cancelledAt IS NULL OR s.cancelledAt IS NOT NULL)) as Terminal WHERE Terminal.Sira = 1 AND Terminal.UyeID = 301263396

-- EK CİHAZ
SELECT * FROM (
SELECT *,
EXTRACT(YEAR_MONTH FROM Table1.OncekiAktivasyon) as OncekiAktivasyonYilAy,
EXTRACT(YEAR_MONTH FROM Table1.firstActivationDate) as AktivasyonYilAy,
IF(EXTRACT(YEAR_MONTH FROM Table1.OncekiAktivasyon)=EXTRACT(YEAR_MONTH FROM Table1.firstActivationDate),"EVET","HAYIR") as Durum
FROM (
SELECT * 
, FIRST_VALUE(Terminal.firstActivationDate) OVER (PARTITION BY Terminal.UyeID) as OncekiAktivasyon FROM (
SELECT o.id as UyeID, t.serial_no as EkCihazSeriNo, t.id as TerminalID, t.terminalStatus, t.firstActivationDate, o.isActivated, s.cancelledAt,
ROW_NUMBER() OVER (PARTITION BY o.id ORDER BY t.firstActivationDate) as Sira
FROM odeal.Organisation o 
JOIN odeal.Terminal t ON t.organisation_id = o.id
JOIN subscription.Subscription s ON s.id = t.subscription_id
WHERE t.terminalStatus = 1 AND s.cancelledAt IS NULL) as Terminal) as Table1) as EkCihaz
WHERE EkCihaz.Durum = "EVET" AND EkCihaz.Sira <> 1 AND EkCihaz.UyeID = 301196918

-- MEVCUT
SELECT * FROM (
SELECT *,
EXTRACT(YEAR_MONTH FROM Table1.OncekiAktivasyon) as OncekiAktivasyonYilAy,
EXTRACT(YEAR_MONTH FROM Table1.firstActivationDate) as AktivasyonYilAy,
IF(EXTRACT(YEAR_MONTH FROM Table1.OncekiAktivasyon)=EXTRACT(YEAR_MONTH FROM Table1.firstActivationDate),"EVET","HAYIR") as Durum
FROM (
SELECT * 
 FROM (
SELECT o.id as UyeID, t.serial_no as MevcutSeriNo, t.id as TerminalID, t.terminalStatus, t.firstActivationDate, o.isActivated, s.cancelledAt,
FIRST_VALUE(t.firstActivationDate) OVER (PARTITION BY o.id) as OncekiAktivasyon,
ROW_NUMBER() OVER (PARTITION BY o.id ORDER BY t.firstActivationDate) as Sira
FROM odeal.Organisation o 
JOIN odeal.Terminal t ON t.organisation_id = o.id
JOIN subscription.Subscription s ON s.id = t.subscription_id
WHERE t.terminalStatus = 1 AND s.cancelledAt IS NULL) as Terminal) as Table1) as Mevcut
WHERE Mevcut.Durum = "HAYIR" AND Mevcut.Sira <> 1 AND Mevcut.UyeID = 301196918

SELECT o.id, t.serial_no, t.firstActivationDate, t.created_at, t.`_createdDate`, t.terminalStatus, o.isActivated  FROM odeal.Organisation o 
JOIN odeal.Terminal t ON t.organisation_id = o.id WHERE t.serial_no = "BCJ00008177"

SELECT * FROM (
SELECT o.id, s.id as Abonelik, p.name, t.serial_no FROM odeal.Organisation o
JOIN subscription.Subscription s ON s.organisationId = o.id
JOIN subscription.Plan p ON p.id = s.planId AND p.serviceId = 3
LEFT JOIN odeal.Terminal t ON t.organisation_id = o.id
WHERE o.isActivated = 1 AND s.id IN (
SELECT MAX(s.id) FROM odeal.Organisation o
JOIN subscription.Subscription s ON s.organisationId = o.id
JOIN subscription.Plan p ON p.id = s.planId AND p.serviceId = 3
WHERE o.isActivated = 1 GROUP BY o.id)) as CeptePos WHERE CeptePos.id = 301196918;

301019547 AND o.id = 301019547 301018346

SELECT o.id, COUNT(t.id) as Adet, MAX(t.firstActivationDate) as IlkAktivasyon FROM odeal.Organisation o
JOIN odeal.Terminal t ON t.organisation_id = o.id  
GROUP BY o.id ORDER BY MAX(t.firstActivationDate) DESC

SELECT *, ROW_NUMBER() OVER (PARTITION BY Aktivasyon1.id ORDER BY Aktivasyon1.firstActivationDate) as Sira FROM (
SELECT o.id, o.organisationId, t.id as terminal_id, t.serial_no, t.firstActivationDate, pln.serviceId, t.channelId as channel_id, sb.status, o.isActivated , o.activatedAt  , o.deActivatedAt, sb.start,
pln.taksitli,t.terminalStatus,
        CASE 
            WHEN o.activatedAt > t.firstActivationDate AND sb.status=1 THEN o.activatedAt
            ELSE t.firstActivationDate
        END as activationDate,
           CASE 
              WHEN t.terminalStatus=0  AND sb.status<>0 THEN 
                (CASE WHEN o.isActivated=0 AND sb.cancelledAt IS NULL AND o.deActivatedAt>o.activatedAt THEN o.deActivatedAt 
                      ELSE sb.cancelledAt END)
              WHEN terminalStatus=1 THEN NULL 
              ELSE sb.cancelledAt
        END as cancelDate
FROM odeal.Organisation o
        JOIN subscription.Subscription sb ON sb.organisationId = o.id 
        JOIN subscription.Plan pln ON pln.id = sb.planId and serviceId<>3 
        JOIN odeal.Terminal t ON t.subscription_id = sb.id
        WHERE o.demo = 0 AND t.firstActivationDate IS NOT NULL ORDER BY activationDate) as Aktivasyon1 WHERE t.serial_no = "PAX710045544"
        
        
SELECT o.id, t.serial_no, t.firstActivationDate, c.name,
ROW_NUMBER() OVER (PARTITION BY o.id ORDER BY t.firstActivationDate) as Sira
FROM odeal.Organisation o
JOIN odeal.Terminal t ON t.organisation_id = o.id 
LEFT JOIN odeal.Channel c ON c.id = t.channelId 
WHERE o.demo = 0 AND o.isActivated = 1 AND t.terminalStatus = 1 AND t.firstActivationDate IS NOT NULL

SELECT o.id, p.serviceId, p.name, s.cancelledAt FROM odeal.Organisation o 
JOIN subscription.Subscription s ON s.organisationId = o.id
JOIN subscription.Plan p ON p.id = s.planId 
WHERE o.id = 301153154

SELECT o.id, o.activatedAt, o.deActivatedAt,
    PERIOD_DIFF(DATE_FORMAT(o.deActivatedAt, '%Y%m'), DATE_FORMAT(o.activatedAt, '%Y%m')) AS ay_farki
FROM odeal.Organisation o 
WHERE o.id = 301253991

SELECT o.id, t.serial_no, t.firstActivationDate, IF(t.terminalStatus=0,"Pasif","Aktif") as TerminalDurum FROM odeal.Organisation o 
JOIN odeal.Terminal t ON t.organisation_id = o.id 
WHERE o.demo = 0 AND t.serial_no IN ("PAX710054308",
"PAX710052348",
"PAX710052690",
"PAX710053299",
"PAX710054084")

SELECT *, s.activationDate, s.cancelledAt FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id 
WHERE t.serial_no = "2C51787219"




SELECT 
IF(PrimHesap.UyePrim="Eski","Mevcut",
	IF(PrimHesap.UyePrim="Yeni" AND PrimHesap.Sira=1,"Yeni",
		IF(PrimHesap.UyePrim="Eski" AND PrimHesap.Sira=1 AND PrimHesap.CepPosVarMi=0,"Yeni",
			IF(PrimHesap.UyePrim="Yeni" AND PrimHesap.Sira>1 AND PrimHesap.AktivasyonAyFark=0,"Ek Cihaz","Mevcut")))) as TerminalDurum, PrimHesap.*
FROM (
SELECT *,
DATEDIFF(Tum.SonrakiTarih,Tum.AktivasyonTarihi) as AktivasyonFark, 
TIMESTAMPDIFF(month,Tum.SonrakiTarih,Tum.AktivasyonTarihi) as AktivasyonAyFark,
ROW_NUMBER() OVER (PARTITION BY Tum.UyeID, Tum.CepPosVarMi ORDER BY Tum.HizmetDurum, Tum.AktivasyonTarihi) as Sira
FROM (
SELECT *, IF(T1.Tedarikci="CEPPOS",1,0) as CepPosVarMi,
DATE_FORMAT(NOW(),"%Y-%m-%d")  as Simdi,
DATE_FORMAT(T1.AktivasyonTarihi,"%Y-%m-%d") as Aktivasyon,
IFNULL(LAG(T1.AktivasyonTarihi) OVER (PARTITION BY T1.UyeID, IF(T1.Tedarikci="CEPPOS",1,0) ORDER BY T1.HizmetDurum, T1.AktivasyonTarihi),T1.AktivasyonTarihi) as SonrakiTarih,
IF(DATEDIFF(T1.deActivatedAt,T1.activatedAt)>180,"Yeni",IF(ISNULL(T1.deActivatedAt),"Yeni","Eski")) as UyePrim,
COUNT(T1.UyeID) OVER (PARTITION BY T1.UyeID) as ToplamHizmet,
COUNT(CASE WHEN T1.UyeDurum = "Aktif" AND T1.HizmetDurum = "Pasif" THEN T1.UyeID END) OVER (PARTITION BY T1.UyeID) as PasifHizmet,
COUNT(CASE WHEN T1.UyeDurum = "Aktif" AND T1.HizmetDurum = "Aktif" THEN T1.UyeID END) OVER (PARTITION BY T1.UyeID) as AktifHizmet,
COUNT(CASE WHEN T1.UyeDurum = "Pasif" AND T1.HizmetDurum = "Pasif" THEN T1.UyeID END) OVER (PARTITION BY  T1.UyeID) as UyePasif_HizmetPasif_Kontrol,
COUNT(CASE WHEN T1.UyeDurum = "Pasif" AND T1.HizmetDurum = "Aktif" THEN T1.UyeID END) OVER (PARTITION BY T1.UyeID) as UyePasif_HizmetAktif_Kontrol
FROM (
SELECT o.id as UyeID, CASE 
WHEN o.businessType=0 THEN "Bireysel" 
WHEN o.businessType=1 THEN "Şahıs" 
WHEN o.businessType=2 THEN "Tüzel" 
WHEN o.businessType=3 THEN "Dernek vb"
ELSE "Bilinmeyen" 
END as IsyeriTipi,
o.activatedAt, 
o.deActivatedAt, 
IF(o.isActivated=0,"Pasif","Aktif") as UyeDurum, 
t.serial_no as SerialNo, t.supplier as Tedarikci, 
t.firstActivationDate as AktivasyonTarihi, 
s.activationDate, s.cancelledAt, 
IF(t.terminalStatus=1,"Aktif","Pasif") as HizmetDurum 
FROM odeal.Organisation o 
JOIN odeal.Terminal t ON t.organisation_id = o.id
JOIN subscription.Subscription s ON s.id = t.subscription_id
WHERE o.demo = 0
UNION
SELECT CeptePos.UyeID, 
CeptePos.IsyeriTipi,
CeptePos.activatedAt, 
CeptePos.deActivatedAt,
CeptePos.UyeDurum, 
CeptePos.SerialNo, 
CeptePos.Tedarikci, 
CeptePos.AktivasyonTarihi, 
CeptePos.activationDate, 
CeptePos.cancelledAt, 
CeptePos.HizmetDurum 
FROM (
SELECT o.id as UyeID, CASE 
WHEN o.businessType=0 THEN "Bireysel" 
WHEN o.businessType=1 THEN "Şahıs" 
WHEN o.businessType=2 THEN "Tüzel" 
WHEN o.businessType=3 THEN "Dernek vb"
ELSE "Bilinmeyen" 
END as IsyeriTipi, o.activatedAt, o.deActivatedAt, IF(o.isActivated=0,"Pasif","Aktif") as UyeDurum,
s.id as SerialNo, s2.name as Tedarikci, s.activationDate as AktivasyonTarihi, s.activationDate, s.cancelledAt,  IF(s.status=1,"Aktif","Pasif") as HizmetDurum,
ROW_NUMBER() OVER (PARTITION BY o.id ORDER BY s.id DESC) as sira
FROM odeal.Organisation o 
JOIN subscription.Subscription s ON s.organisationId = o.id
JOIN subscription.Plan p ON p.id = s.planId 
JOIN subscription.Service s2 ON s2.id = p.serviceId 
WHERE p.serviceId = 3 AND o.demo = 0 AND s.status=1) as CeptePos
WHERE CeptePos.sira =1) as T1) as Tum
ORDER BY Tum.UyeID) as PrimHesap WHERE PrimHesap.UyeDurum = "Aktif" AND PrimHesap.HizmetDurum = "Pasif"



SELECT * FROM odeal.Organisation o WHERE o.businessType 

SELECT CeptePos.UyeID, CeptePos.activatedAt, CeptePos.deActivatedAt, CeptePos.UyeDurum, CeptePos.SerialNo, CeptePos.Tedarikci, CeptePos.AktivasyonTarihi, CeptePos.activationDate, CeptePos.cancelledAt, CeptePos.HizmetDurum, CeptePos.Sira FROM (
SELECT o.id as UyeID, o.activatedAt, o.deActivatedAt, IF(o.isActivated=0,"Pasif","Aktif") as UyeDurum, s.id as SerialNo, s2.name as Tedarikci, s.activationDate as AktivasyonTarihi, s.activationDate, s.cancelledAt,  IF(s.status=1,"Aktif","Pasif") as HizmetDurum,
ROW_NUMBER() OVER (PARTITION BY o.id ORDER BY s.id) as sira
FROM odeal.Organisation o 
JOIN subscription.Subscription s ON s.organisationId = o.id
JOIN subscription.Plan p ON p.id = s.planId 
JOIN subscription.Service s2 ON s2.id = p.serviceId 
WHERE p.serviceId = 3 AND o.demo = 0 AND s.status=1) as CeptePos


SELECT * FROM (
SELECT *, 
COUNT(CASE WHEN T1.UyeDurum = "Pasif" AND T1.HizmetDurum = "Pasif" THEN T1.UyeID END) OVER (PARTITION BY  T1.UyeID) as UyePasif_HizmetPasif_Kontrol,
COUNT(CASE WHEN T1.UyeDurum = "Pasif" AND T1.HizmetDurum = "Aktif" THEN T1.UyeID END) OVER (PARTITION BY T1.UyeID) as UyePasif_HizmetAktif_Kontrol
FROM (
SELECT o.id as UyeID, o.activatedAt, o.deActivatedAt, IF(o.isActivated=0,"Pasif","Aktif") as UyeDurum, t.serial_no as SerialNo, t.supplier as Tedarikci, t.firstActivationDate as AktivasyonTarihi, s.activationDate, s.cancelledAt, IF(t.terminalStatus=1,"Aktif","Pasif") as HizmetDurum FROM odeal.Organisation o 
JOIN odeal.Terminal t ON t.organisation_id = o.id
JOIN subscription.Subscription s ON s.id = t.subscription_id
WHERE o.demo = 0
UNION
SELECT CeptePos.UyeID, CeptePos.activatedAt, CeptePos.deActivatedAt, CeptePos.UyeDurum, CeptePos.SerialNo, CeptePos.Tedarikci, CeptePos.AktivasyonTarihi, CeptePos.activationDate, CeptePos.cancelledAt, CeptePos.HizmetDurum FROM (
SELECT o.id as UyeID, o.activatedAt, o.deActivatedAt, IF(o.isActivated=0,"Pasif","Aktif") as UyeDurum, s.id as SerialNo, s2.name as Tedarikci, s.activationDate as AktivasyonTarihi, s.activationDate, s.cancelledAt,  IF(s.status=1,"Aktif","Pasif") as HizmetDurum,
ROW_NUMBER() OVER (PARTITION BY o.id ORDER BY s.id) as sira
FROM odeal.Organisation o 
JOIN subscription.Subscription s ON s.organisationId = o.id
JOIN subscription.Plan p ON p.id = s.planId 
JOIN subscription.Service s2 ON s2.id = p.serviceId 
WHERE p.serviceId = 3 AND o.demo = 0) as CeptePos
WHERE CeptePos.sira =1) as T1) as Tum


SELECT Tum.UyeID, IF(Tum.ToplamHizmet=Tum.PasifHizmet,1,0) as Durum, DATEDIFF(CURDATE(),DATE(Tum.activatedAt))  as AktifGun
-- ROW_NUMBER() OVER (PARTITION BY Tum.UyeID ORDER BY Tum.AktivasyonTarihi) as Sira
FROM (
SELECT *, 
COUNT(T1.UyeID) OVER (PARTITION BY T1.UyeID) as ToplamHizmet,
COUNT(CASE WHEN T1.UyeDurum = "Aktif" AND T1.HizmetDurum = "Pasif" THEN T1.UyeID END) OVER (PARTITION BY T1.UyeID) as PasifHizmet,
COUNT(CASE WHEN T1.UyeDurum = "Aktif" AND T1.HizmetDurum = "Aktif" THEN T1.UyeID END) OVER (PARTITION BY T1.UyeID) as AktifHizmet,
COUNT(CASE WHEN T1.UyeDurum = "Pasif" AND T1.HizmetDurum = "Pasif" THEN T1.UyeID END) OVER (PARTITION BY  T1.UyeID) as UyePasif_HizmetPasif_Kontrol,
COUNT(CASE WHEN T1.UyeDurum = "Pasif" AND T1.HizmetDurum = "Aktif" THEN T1.UyeID END) OVER (PARTITION BY T1.UyeID) as UyePasif_HizmetAktif_Kontrol
FROM (
SELECT o.id as UyeID, o.activatedAt, o.deActivatedAt, IF(o.isActivated=0,"Pasif","Aktif") as UyeDurum, t.serial_no as SerialNo, t.supplier as Tedarikci, t.firstActivationDate as AktivasyonTarihi, s.activationDate, s.cancelledAt, IF(t.terminalStatus=1,"Aktif","Pasif") as HizmetDurum FROM odeal.Organisation o 
JOIN odeal.Terminal t ON t.organisation_id = o.id
JOIN subscription.Subscription s ON s.id = t.subscription_id
WHERE o.demo = 0
UNION
SELECT CeptePos.UyeID, CeptePos.activatedAt, CeptePos.deActivatedAt, CeptePos.UyeDurum, CeptePos.SerialNo, CeptePos.Tedarikci, CeptePos.AktivasyonTarihi, CeptePos.activationDate, CeptePos.cancelledAt, CeptePos.HizmetDurum FROM (
SELECT o.id as UyeID, o.activatedAt, o.deActivatedAt, IF(o.isActivated=0,"Pasif","Aktif") as UyeDurum, s.id as SerialNo, s2.name as Tedarikci, s.activationDate as AktivasyonTarihi, s.activationDate, s.cancelledAt,  IF(s.status=1,"Aktif","Pasif") as HizmetDurum,
ROW_NUMBER() OVER (PARTITION BY o.id ORDER BY s.id DESC) as sira
FROM odeal.Organisation o 
JOIN subscription.Subscription s ON s.organisationId = o.id
JOIN subscription.Plan p ON p.id = s.planId 
JOIN subscription.Service s2 ON s2.id = p.serviceId 
WHERE p.serviceId = 3 AND o.demo = 0 AND s.status=1) as CeptePos
WHERE CeptePos.sira =1) as T1) as Tum
WHERE Tum.UyePasif_HizmetPasif_Kontrol = 0 AND Tum.UyePasif_HizmetAktif_Kontrol = 0 AND IF(Tum.ToplamHizmet=Tum.PasifHizmet,1,0) > 0
GROUP BY Tum.UyeID, IF(Tum.ToplamHizmet=Tum.PasifHizmet,1,0), DATEDIFF(CURDATE(),DATE(Tum.activatedAt))

SELECT * FROM (
SELECT *, 
COUNT(CASE WHEN T1.UyeDurum = "Pasif" AND T1.HizmetDurum = "Pasif" THEN T1.UyeID END) OVER (PARTITION BY  T1.UyeID) as UyePasif_HizmetPasif_Kontrol,
COUNT(CASE WHEN T1.UyeDurum = "Pasif" AND T1.HizmetDurum = "Aktif" THEN T1.UyeID END) OVER (PARTITION BY T1.UyeID) as UyePasif_HizmetAktif_Kontrol
FROM (
SELECT o.id as UyeID, o.activatedAt, o.deActivatedAt, IF(o.isActivated=0,"Pasif","Aktif") as UyeDurum, t.serial_no as SerialNo, t.supplier as Tedarikci, t.firstActivationDate as AktivasyonTarihi, s.activationDate, s.cancelledAt, IF(t.terminalStatus=1,"Aktif","Pasif") as HizmetDurum FROM odeal.Organisation o 
JOIN odeal.Terminal t ON t.organisation_id = o.id
JOIN subscription.Subscription s ON s.id = t.subscription_id
WHERE o.demo = 0
UNION
SELECT CeptePos.UyeID, CeptePos.activatedAt, CeptePos.deActivatedAt, CeptePos.UyeDurum, CeptePos.SerialNo, CeptePos.Tedarikci, CeptePos.AktivasyonTarihi, CeptePos.activationDate, CeptePos.cancelledAt, CeptePos.HizmetDurum FROM (
SELECT o.id as UyeID, o.activatedAt, o.deActivatedAt, IF(o.isActivated=0,"Pasif","Aktif") as UyeDurum, s.id as SerialNo, s2.name as Tedarikci, s.activationDate as AktivasyonTarihi, s.activationDate, s.cancelledAt,  IF(s.status=1,"Aktif","Pasif") as HizmetDurum,
ROW_NUMBER() OVER (PARTITION BY o.id ORDER BY s.id) as sira
FROM odeal.Organisation o 
JOIN subscription.Subscription s ON s.organisationId = o.id
JOIN subscription.Plan p ON p.id = s.planId 
JOIN subscription.Service s2 ON s2.id = p.serviceId 
WHERE p.serviceId = 3 AND o.demo = 0) as CeptePos
WHERE CeptePos.sira =1) as T1) as Tum
WHERE Tum.UyePasif_HizmetPasif_Kontrol = 0 AND Tum.UyePasif_HizmetAktif_Kontrol > 0;
ORDER BY Tum.UyeID 


SELECT * FROM (
SELECT o.id as UyeID, o.activatedAt as UyeAktivasyonTarihi, o.deActivatedAt as UyeDeaktivasyonTarihi, t.serial_no as MaliNo, t.firstActivationDate as HizmetAktivasyonTarihi, s2.deactivationDate as HizmetDeaktivasyonTarihi,
IF(t.terminalStatus=1,"Aktif","Pasif") as HizmetDurum, s2.name as Hizmet FROM odeal.Organisation o 
JOIN odeal.Terminal t ON t.organisation_id = o.id
JOIN subscription.Subscription s ON s.id = t.subscription_id 
JOIN subscription.Plan p ON p.id = s.planId 
JOIN subscription.Service s2 ON s2.id = p.serviceId AND s2.id <> 3
WHERE o.isActivated = 1 AND o.demo = 0
UNION
SELECT o.id as UyeID, o.activatedAt as UyeAktivasyonTarihi, o.deActivatedAt as UyeDeaktivasyonTarihi, s.id as MaliNo, s.activationDate as HizmetAktivasyonTarihi, s.cancelledAt as HizmetDeaktivasyonTarihi, 
IF(s.status=1,"Aktif","Pasif") as HizmetDurum, s2.name as Hizmet FROM odeal.Organisation o 
JOIN subscription.Subscription s ON s.organisationId = o.id 
JOIN subscription.Plan p ON p.id = s.planId 
JOIN subscription.Service s2 ON s2.id = p.serviceId AND p.serviceId = 3
WHERE o.isActivated = 1 AND o.demo = 0 AND s.id IN (
SELECT MAX(s.id) FROM odeal.Organisation o 
JOIN subscription.Subscription s ON s.organisationId = o.id 
JOIN subscription.Plan p ON p.id = s.planId 
JOIN subscription.Service s2 ON s2.id = p.serviceId AND p.serviceId = 3
WHERE o.isActivated = 1 AND o.demo = 0
GROUP BY o.id)) as TumKayitlar

301266503


SELECT * FROM odeal.payment_summary ps WHERE ps.terminal_serial_no = "FT40013292"

SELECT * FROM odeal.end_of_day eod WHERE eod.terminal_serial_no = "FT40013292"