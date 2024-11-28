 SELECT Satislar.organisation_id, Satislar.mali_no, Satislar.sales_date, Satislar.UyeDurum, Satislar.TerminalDurum, Satislar.SatisKanal, Satislar.Sira FROM (
 SELECT OdealSatis.*, ca.unvan, ca.activation_date, IF(ca.is_activated=1,"Aktif","Pasif") as UyeDurum,
 ROW_NUMBER() OVER (PARTITION BY OdealSatis.organisation_id ORDER BY OdealSatis.sales_date ASC) as Sira
 FROM crm_account ca
JOIN (SELECT os.odeal_satis_id, os.mali_no, os.crm_account, os.organisation_id, os.sales_date, os.satis_iptal_tarihi, Terminal.serial_no, Terminal.first_activation_date, Terminal.label as TerminalDurum, Terminal.subject as SatisKanal 
FROM odeal_satis os
LEFT JOIN (SELECT ot.*, fd.label, oc.subject FROM odeal_terminal ot 
LEFT JOIN odeal_channel oc ON oc.odeal_channel_id = ot.odeal_channel
LEFT JOIN field_data fd ON fd.field_data_id = ot.terminal_status AND fd.os_app_id = "odeal" AND fd.os_model_id = "terminal" AND fd.field_id = "terminal_status"
WHERE ot.odeal_terminal_id IN (
SELECT MAX(ot.odeal_terminal_id) FROM odeal_terminal ot
GROUP BY ot.serial_no)) as Terminal ON Terminal.serial_no = os.mali_no AND Terminal.organisation_id = os.organisation_id 
WHERE os.odeal_satis_id IN (
SELECT MAX(os.odeal_satis_id) FROM odeal_satis os 
GROUP BY os.mali_no) AND os.sales_date IS NOT NULL AND Terminal.first_activation_date IS NOT NULL AND os.satis_iptal_tarihi IS NULL) as OdealSatis 
ON OdealSatis.crm_account = ca.crm_account_id) as Satislar

SELECT * FROM odeal_channel oc 

SELECT * FROM odeal_terminal ot 