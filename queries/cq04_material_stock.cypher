// CQ04: Який обсяг матеріалу є в партіях складу?
MATCH (i:Inventory)-[r:STORES_MATERIAL]->(m:Material)
RETURN m.name AS material, sum(i.quantity) AS stockKg, count(i) AS batches
ORDER BY stockKg DESC;
