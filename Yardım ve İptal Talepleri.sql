SELECT Terminal.organisation_id, Terminal.serial_no, Terminal.TerminalID, COUNT(*) FROM (
SELECT ca.crm_account_id, ot.organisation_id,
       ot.serial_no, ot.terminal_status, ot.odeal_id as TerminalID,
       ca.is_activated, Iptal.terminal, ca.status,
       ca.name, ca.unvan,
       Iptal.odeal_yazarkasa_sokum_id, Iptal.sokum_sonucu
FROM crm_account ca
LEFT JOIN (SELECT * FROM odeal_yazarkasa_sokum oys WHERE oys.odeal_yazarkasa_sokum_id IN
(SELECT MAX(oys.odeal_yazarkasa_sokum_id) FROM odeal_yazarkasa_sokum oys
GROUP BY oys.terminal)) as Iptal ON ca.crm_account_id = Iptal.organizasyon
JOIN odeal_terminal ot ON ot.odeal_terminal_id = Iptal.terminal AND ot.organisation_id = ca.odeal_id) as Terminal
GROUP BY Terminal.organisation_id, Terminal.serial_no HAVING COUNT(*) > 1;

SELECT * FROM odeal_terminal ot WHERE ot.serial_no = "BCE00016703";

-- İPTAL VE YARDIM TALEPLERİ
SELECT ca.crm_account_id,
       ca.created_on,
       ca.application_date,
       ot.organisation_id as UyeID,
       ca.activation_date,
       ot.serial_no as MaliNo,
       ot.first_activation_date as TerminalIlkAktivasyonTarih,
       ot.ilk_kurulum_tarihi as TerminalAktivasyonTarih,
       ca.is_activated as UyeDurum,
       fd.label as TerminalDurum,
       Iptal.terminal as TerminalID,
       ca.name as Marka,
       ca.unvan as Unvan,
       fd3.label as SokumSonucu,
       Iptal.created_on as YazarKasaSokumTarih,
       CONCAT(Iptal.donem_ay,"-",Iptal.donem_yil) as Donem,
       Yardim.ticket_issue_id as TalepID,
       Yardim.issue_number as GorevNo,
       Yardim.subject as Aciklama
FROM crm_account ca
LEFT JOIN (SELECT * FROM odeal_yazarkasa_sokum oys WHERE oys.odeal_yazarkasa_sokum_id IN
(SELECT MAX(oys.odeal_yazarkasa_sokum_id) FROM odeal_yazarkasa_sokum oys
GROUP BY oys.terminal)) as Iptal ON ca.crm_account_id = Iptal.organizasyon
LEFT JOIN field_data fd3 ON fd3.os_app_id = "odeal" AND fd3.os_model_id = "yazarkasa_sokum" AND fd3.field_data_id = Iptal.sokum_sonucu AND fd3.field_id = "sokum_sonucu"
JOIN odeal_terminal ot ON ot.odeal_terminal_id = Iptal.terminal
LEFT JOIN field_data fd ON fd.os_app_id = "odeal" AND fd.os_model_id = "terminal" AND fd.field_data_id = ot.terminal_status AND fd.field_id = "terminal_status"
LEFT JOIN field_data fd2 ON fd2.os_app_id = "crm" AND fd2.os_model_id = "account" AND fd2.field_data_id = ca.is_activated AND fd2.field_id = "is_activated"
LEFT JOIN (SELECT ti.ticket_issue_id, ti.odeal_satis, ti.aciklama, ti.subject, ti.issue_number, ti.terminal, ti.crm_account_id, ti.created_on
FROM ticket_issue ti
WHERE ti.crm_account_id IS NOT NULL AND ti.terminal IS NOT NULL) as Yardim ON Yardim.terminal = ot.odeal_terminal_id
WHERE ot.serial_no = "BCE00016703";

SELECT ti.ticket_issue_id, ti.aciklama, ti.subject, ti.issue_number, ti.terminal, ti.crm_account_id, ti.created_on
FROM ticket_issue ti
WHERE ti.crm_account_id IS NOT NULL AND ti.terminal IS NOT NULL AND ti.terminal = 93830;

SELECT os.terminal_id, os.organisation_id, os.mali_no, os.save_type, os.odeal_satis_id FROM odeal_satis os
WHERE os.organisation_id = 301245794 AND os.mali_no = "PAX710043541";

SELECT ot.odeal_terminal_id,ot.serial_no,os.organisation_id, os.mali_no,
       os.invoice_total, os.fatura_no,os.fatura_tarih_saati
FROM odeal_terminal ot
JOIN odeal_satis os ON os.organisation_id = ot.organisation_id AND os.mali_no = ot.serial_no

SELECT Satis.organisation_id, Satis.mali_no, Satis.fatura_tarih_saati, Satis.fatura_no, Satis.odeal_satis_id, ot.odeal_terminal_id
FROM odeal_terminal ot
JOIN (SELECT * FROM odeal_satis os WHERE os.odeal_satis_id IN (
SELECT MAX(os.odeal_satis_id) FROM odeal_satis os GROUP BY os.organisation_id, os.mali_no)) as Satis ON Satis.organisation_id = ot.organisation_id AND Satis.mali_no = ot.serial_no
WHERE Satis.organisation_id = 301004394 AND Satis.mali_no = "BCJ00015483";

SELECT os.terminal_id, os.mali_no, os.organisation_id, os.odeal_satis_id FROM odeal_satis os WHERE os.odeal_satis_id IN (
SELECT MAX(os.odeal_satis_id) FROM odeal_satis os GROUP BY os.organisation_id, os.mali_no)
AND os.sales_date >= "2024-10-01 00:00:00";


301001251
2C51325956
FT40005255


SELECT os.odeal_satis_id as SatisID, os.crm_account, os.organisation_id as UyeID, os.mali_no as MaliNo, os.terminal_id as TerminalID, os.status, fd.label as SatisDurum
FROM odeal_satis os
LEFT JOIN field_data fd ON fd.field_data_id = os.save_type AND fd.os_app_id = "odeal" AND fd.os_model_id = "satis" AND fd.field_id = "save_type"
WHERE os.mali_no IS NOT NULL AND os.mali_no = "BCE00016703";

SELECT * FROM crm_account ca
LEFT JOIN (SELECT os.odeal_satis_id as SatisID, os.crm_account, os.organisation_id as UyeID, os.mali_no as MaliNo, os.terminal_id as TerminalID, os.status, fd.label as SatisDurum
FROM odeal_satis os
LEFT JOIN field_data fd ON fd.field_data_id = os.save_type AND fd.os_app_id = "odeal" AND fd.os_model_id = "satis" AND fd.field_id = "save_type"
WHERE os.mali_no IS NOT NULL AND os.mali_no = "BCE00016703") as Satis ON Satis.crm_account
         WHERE ca.odeal_id = 301065591;


SELECT * FROM odeal_talep ot WHERE ot.son_durum IS NOT NULL