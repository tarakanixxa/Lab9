// CQ01: Які цехи належать заводу Metal-Detail?
MATCH (f:Factory {id:'FC-001'})-[:HAS_WORKSHOP]->(w:Workshop)
RETURN f.name AS factory, w.name AS workshop ORDER BY workshop;
