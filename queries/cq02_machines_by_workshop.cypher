// CQ02: Які верстати розташовані в кожному цеху?
MATCH (w:Workshop)-[:CONTAINS_MACHINE]->(m:Machine)
RETURN w.name AS workshop, collect(m.name) AS machines, count(m) AS machineCount
ORDER BY workshop;
