// Manual verification 1: FC-001 has exactly four workshops in the generated CSV.
MATCH (:Factory {id:'FC-001'})-[:HAS_WORKSHOP]->(w:Workshop)
RETURN count(w) AS actualWorkshops;

// Manual verification 2: MC-01 is connected to WS-01 by CONTAINS_MACHINE and LOCATED_IN.
MATCH (w:Workshop)-[:CONTAINS_MACHINE|LOCATED_IN]->(m:Machine {id:'MC-01'})
RETURN w.id, m.id;

// Manual verification 3: DF-03 is connected to PR-03 and MC-03.
MATCH (p:Product {id:'PR-03'})-[:HAS_DEFECT]->(d:Defect {id:'DF-03'})-[:DETECTED_ON]->(m:Machine)
RETURN p.id, d.id, m.id;
