INSERT INTO `players` (`playeruuid`, `firstname`, `lastname`, `borndate`, `documentnr`, `gdpraccept`)
SELECT 
    UUID(),
    (SELECT firstname FROM (SELECT 'Ana' AS firstname UNION SELECT 'Bojan' UNION SELECT 'Cvetka' UNION SELECT 'Damjan' UNION SELECT 'Eva' UNION SELECT 'Franc' UNION SELECT 'Gaja' UNION SELECT 'Hugo' UNION SELECT 'Irena' UNION SELECT 'Janez') AS fn ORDER BY RAND() LIMIT 1),
    (SELECT lastname FROM (SELECT 'Novak' AS lastname UNION SELECT 'Kovač' UNION SELECT 'Golob' UNION SELECT 'Hribar' UNION SELECT 'Kos' UNION SELECT 'Žagar' UNION SELECT 'Zupan' UNION SELECT 'Vidmar' UNION SELECT 'Petrovič' UNION SELECT 'Horvat') AS ln ORDER BY RAND() LIMIT 1),
    DATE_SUB(CURRENT_DATE(), INTERVAL FLOOR(18 + RAND() * 62) YEAR),
    (SELECT SUBSTRING(MD5(RAND()) FROM 1 FOR 9)),
    FLOOR(RAND() * 2)
FROM 
    information_schema.tables
LIMIT 50;
