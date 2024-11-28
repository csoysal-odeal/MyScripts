SELECT utd.Ay, utd.KullanimDurum, COUNT(*) FROM UyeTerminalDetay utd 
GROUP BY utd.Ay, utd.KullanimDurum 