SELECT oys.odeal_yazarkasa_sokum_id as sokumId, os5.odeal_id as odeal_abonelik_id,
ca.name AS org,
ca.odeal_id  AS orgId,
ot.serial_no AS MaliNo,
fd.label AS sonuc,
fd2.label AS sebep, 
fd3.label AS Vadeli,
CONCAT(u.firstname," ",u.lastname) AS temsilci,
os2.taksite_acikmi,
ca.odeal_id,
oys.backoffice_aciklama,
oys.aciklama ,
oys.donem_ay, oys.donem_yil,
 STR_TO_DATE(CONCAT("1","-",oys.donem_ay,"-", IF(oys.donem_yil = 3,oys.donem_yil+2020,oys.donem_yil)),"%d-%m-%YY") as donem,
 oys.created_on ,oys.last_modified_on, fd4.label AS Tedarikci,
IF(fd5.label LIKE "%mobil%","Mobil","Masaüstü") AS yazarkasa_tipi 
FROM odeal_yazarkasa_sokum oys 
LEFT JOIN odeal_subscription os on oys.abonelik = os.odeal_subscription_id 
LEFT JOIN crm_account ca on ca.crm_account_id  = oys.organizasyon 
LEFT JOIN odeal_terminal ot on oys.terminal = ot.odeal_terminal_id
LEFT JOIN odeal_subscription os3 on os3.odeal_subscription_id = oys.abonelik 
LEFT JOIN odeal_subscription os5 ON os5.odeal_subscription_id = ot.abonelik 
LEFT JOIN odeal_satis os2 on os2.mali_no = ot.serial_no and ca.odeal_id = os2.organisation_id
AND os2.odeal_satis_id = (
SELECT MAX(os4.odeal_satis_id) FROM odeal_satis os4 WHERE os4.mali_no = ot.serial_no AND
os4.created_on < oys.created_on)
LEFT JOIN crm_potential cp on cp.crm_potential_id = os2.iliskili_firsat 
LEFT JOIN field_data fd3 ON fd3.os_model_id = "potential" AND fd3.field_id = "yazar_kasa" AND fd3.field_data_id = cp.yazar_kasa 
LEFT JOIN `user` u  on os2.created_by = u.user_id 
LEFT JOIN field_data fd2 on fd2.field_data_id = oys.deaktif_nedenleri and fd2.field_id  = "deaktif_nedenleri" and fd2.os_model_id = "yazarkasa_sokum" 
LEFT JOIN field_data fd on fd.field_data_id = oys.sokum_sonucu  and fd.field_id = "sokum_sonucu"
LEFT JOIN field_data fd4 ON fd4.field_data_id = os2.tedarikci AND fd4.os_model_id = "satis" AND fd4.field_id = "tedarikci"
LEFT JOIN field_data fd5 ON fd5.field_data_id = os2.yazar_kasa_tipi 
AND fd5.os_model_id = "satis" AND fd5.field_id = "yazar_kasa_tipi"
WHERE donem_yil IS NOT NULL and donem_ay IS NOT NULL
AND oys.terminal IS NOT NULL