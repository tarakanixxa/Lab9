// CQ08: Скільки дефектів має кожен верстат?
MATCH (m:Machine)<-[:DETECTED_ON]-(d:Defect)
WITH m, count(d) AS defectCount
WHERE defectCount > 0
RETURN m.id AS machine, m.name AS machineName, defectCount
ORDER BY defectCount DESC, machine LIMIT 10;
