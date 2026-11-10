// CQ03: Які працівники обслуговують верстати та де вони закріплені?
MATCH (e:Employee)-[:OPERATES]->(m:Machine)
OPTIONAL MATCH (e)-[:ASSIGNED_TO]->(w:Workshop)
RETURN e.name AS employee, m.name AS machine, w.name AS workshop
ORDER BY employee LIMIT 30;
