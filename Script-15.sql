SELECT DATE_FORMAT(t.`date`,"%Y-%m"), SUM(t.aktivasyon) as Adet FROM dataminer.taksidepos t 
GROUP BY DATE_FORMAT(t.`date`,"%Y-%m") 