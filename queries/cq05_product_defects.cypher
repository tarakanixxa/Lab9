// CQ05: Які дефекти зафіксовані для продукції?
MATCH (p:Product)-[r:HAS_DEFECT]->(d:Defect)
RETURN p.name AS product, d.name AS defect, d.status AS status,
       r.source AS provenance, r.confidence AS confidence
ORDER BY product;
