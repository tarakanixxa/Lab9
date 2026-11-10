// CQ12: Які продукти пов'язані з матеріалами через технологічний процес?
MATCH (m:Material)-[:REQUIRED_FOR]->(p:Product)
OPTIONAL MATCH (p)-[:RESULT_OF]->(pr:Process)
RETURN m.name AS material, p.name AS product, pr.name AS process
ORDER BY material LIMIT 30;
