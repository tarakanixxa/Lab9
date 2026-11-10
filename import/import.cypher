// Lab 9 — AuraDB import. Replace the URL placeholders with public HTTPS raw URLs.
// Run constraints.cypher first. MERGE keeps repeated imports idempotent.

LOAD CSV WITH HEADERS FROM 'https://RAW_GITHUB_URL/nodes.csv' AS row
WITH row WHERE row.label = 'Defect'
MERGE (n:Entity:Defect {id: row.id})
SET n.name = row.name, n.code = row.code, n.status = row.status,
    n.quantity = CASE WHEN row.quantity = '' THEN null ELSE toFloat(row.quantity) END,
    n.unit = row.unit, n.description = row.description;

LOAD CSV WITH HEADERS FROM 'https://RAW_GITHUB_URL/nodes.csv' AS row
WITH row WHERE row.label = 'Employee'
MERGE (n:Entity:Employee {id: row.id})
SET n.name = row.name, n.code = row.code, n.status = row.status,
    n.quantity = CASE WHEN row.quantity = '' THEN null ELSE toFloat(row.quantity) END,
    n.unit = row.unit, n.description = row.description;

LOAD CSV WITH HEADERS FROM 'https://RAW_GITHUB_URL/nodes.csv' AS row
WITH row WHERE row.label = 'Factory'
MERGE (n:Entity:Factory {id: row.id})
SET n.name = row.name, n.code = row.code, n.status = row.status,
    n.quantity = CASE WHEN row.quantity = '' THEN null ELSE toFloat(row.quantity) END,
    n.unit = row.unit, n.description = row.description;

LOAD CSV WITH HEADERS FROM 'https://RAW_GITHUB_URL/nodes.csv' AS row
WITH row WHERE row.label = 'Inventory'
MERGE (n:Entity:Inventory {id: row.id})
SET n.name = row.name, n.code = row.code, n.status = row.status,
    n.quantity = CASE WHEN row.quantity = '' THEN null ELSE toFloat(row.quantity) END,
    n.unit = row.unit, n.description = row.description;

LOAD CSV WITH HEADERS FROM 'https://RAW_GITHUB_URL/nodes.csv' AS row
WITH row WHERE row.label = 'Machine'
MERGE (n:Entity:Machine {id: row.id})
SET n.name = row.name, n.code = row.code, n.status = row.status,
    n.quantity = CASE WHEN row.quantity = '' THEN null ELSE toFloat(row.quantity) END,
    n.unit = row.unit, n.description = row.description;

LOAD CSV WITH HEADERS FROM 'https://RAW_GITHUB_URL/nodes.csv' AS row
WITH row WHERE row.label = 'Maintenance'
MERGE (n:Entity:Maintenance {id: row.id})
SET n.name = row.name, n.code = row.code, n.status = row.status,
    n.quantity = CASE WHEN row.quantity = '' THEN null ELSE toFloat(row.quantity) END,
    n.unit = row.unit, n.description = row.description;

LOAD CSV WITH HEADERS FROM 'https://RAW_GITHUB_URL/nodes.csv' AS row
WITH row WHERE row.label = 'Material'
MERGE (n:Entity:Material {id: row.id})
SET n.name = row.name, n.code = row.code, n.status = row.status,
    n.quantity = CASE WHEN row.quantity = '' THEN null ELSE toFloat(row.quantity) END,
    n.unit = row.unit, n.description = row.description;

LOAD CSV WITH HEADERS FROM 'https://RAW_GITHUB_URL/nodes.csv' AS row
WITH row WHERE row.label = 'Operation'
MERGE (n:Entity:Operation {id: row.id})
SET n.name = row.name, n.code = row.code, n.status = row.status,
    n.quantity = CASE WHEN row.quantity = '' THEN null ELSE toFloat(row.quantity) END,
    n.unit = row.unit, n.description = row.description;

LOAD CSV WITH HEADERS FROM 'https://RAW_GITHUB_URL/nodes.csv' AS row
WITH row WHERE row.label = 'Process'
MERGE (n:Entity:Process {id: row.id})
SET n.name = row.name, n.code = row.code, n.status = row.status,
    n.quantity = CASE WHEN row.quantity = '' THEN null ELSE toFloat(row.quantity) END,
    n.unit = row.unit, n.description = row.description;

LOAD CSV WITH HEADERS FROM 'https://RAW_GITHUB_URL/nodes.csv' AS row
WITH row WHERE row.label = 'Product'
MERGE (n:Entity:Product {id: row.id})
SET n.name = row.name, n.code = row.code, n.status = row.status,
    n.quantity = CASE WHEN row.quantity = '' THEN null ELSE toFloat(row.quantity) END,
    n.unit = row.unit, n.description = row.description;

LOAD CSV WITH HEADERS FROM 'https://RAW_GITHUB_URL/nodes.csv' AS row
WITH row WHERE row.label = 'ProductionComplex'
MERGE (n:Entity:ProductionComplex {id: row.id})
SET n.name = row.name, n.code = row.code, n.status = row.status,
    n.quantity = CASE WHEN row.quantity = '' THEN null ELSE toFloat(row.quantity) END,
    n.unit = row.unit, n.description = row.description;

LOAD CSV WITH HEADERS FROM 'https://RAW_GITHUB_URL/nodes.csv' AS row
WITH row WHERE row.label = 'Workshop'
MERGE (n:Entity:Workshop {id: row.id})
SET n.name = row.name, n.code = row.code, n.status = row.status,
    n.quantity = CASE WHEN row.quantity = '' THEN null ELSE toFloat(row.quantity) END,
    n.unit = row.unit, n.description = row.description;

LOAD CSV WITH HEADERS FROM 'https://RAW_GITHUB_URL/relationships.csv' AS row
WITH row WHERE row.type = 'ASSIGNED_TO'
MATCH (a:Entity {id: row.source_id})
MATCH (b:Entity {id: row.target_id})
MERGE (a)-[r:ASSIGNED_TO]->(b)
SET r.source = row.source, r.confidence = toFloat(row.confidence), r.validFrom = date(row.validFrom);

LOAD CSV WITH HEADERS FROM 'https://RAW_GITHUB_URL/relationships.csv' AS row
WITH row WHERE row.type = 'CONSUMES_MATERIAL'
MATCH (a:Entity {id: row.source_id})
MATCH (b:Entity {id: row.target_id})
MERGE (a)-[r:CONSUMES_MATERIAL]->(b)
SET r.source = row.source, r.confidence = toFloat(row.confidence), r.validFrom = date(row.validFrom);

LOAD CSV WITH HEADERS FROM 'https://RAW_GITHUB_URL/relationships.csv' AS row
WITH row WHERE row.type = 'CONTAINS_MACHINE'
MATCH (a:Entity {id: row.source_id})
MATCH (b:Entity {id: row.target_id})
MERGE (a)-[r:CONTAINS_MACHINE]->(b)
SET r.source = row.source, r.confidence = toFloat(row.confidence), r.validFrom = date(row.validFrom);

LOAD CSV WITH HEADERS FROM 'https://RAW_GITHUB_URL/relationships.csv' AS row
WITH row WHERE row.type = 'DETECTED_ON'
MATCH (a:Entity {id: row.source_id})
MATCH (b:Entity {id: row.target_id})
MERGE (a)-[r:DETECTED_ON]->(b)
SET r.source = row.source, r.confidence = toFloat(row.confidence), r.validFrom = date(row.validFrom);

LOAD CSV WITH HEADERS FROM 'https://RAW_GITHUB_URL/relationships.csv' AS row
WITH row WHERE row.type = 'EMPLOYS'
MATCH (a:Entity {id: row.source_id})
MATCH (b:Entity {id: row.target_id})
MERGE (a)-[r:EMPLOYS]->(b)
SET r.source = row.source, r.confidence = toFloat(row.confidence), r.validFrom = date(row.validFrom);

LOAD CSV WITH HEADERS FROM 'https://RAW_GITHUB_URL/relationships.csv' AS row
WITH row WHERE row.type = 'EXECUTES_PROCESS'
MATCH (a:Entity {id: row.source_id})
MATCH (b:Entity {id: row.target_id})
MERGE (a)-[r:EXECUTES_PROCESS]->(b)
SET r.source = row.source, r.confidence = toFloat(row.confidence), r.validFrom = date(row.validFrom);

LOAD CSV WITH HEADERS FROM 'https://RAW_GITHUB_URL/relationships.csv' AS row
WITH row WHERE row.type = 'HAS_DEFECT'
MATCH (a:Entity {id: row.source_id})
MATCH (b:Entity {id: row.target_id})
MERGE (a)-[r:HAS_DEFECT]->(b)
SET r.source = row.source, r.confidence = toFloat(row.confidence), r.validFrom = date(row.validFrom);

LOAD CSV WITH HEADERS FROM 'https://RAW_GITHUB_URL/relationships.csv' AS row
WITH row WHERE row.type = 'HAS_FACTORY'
MATCH (a:Entity {id: row.source_id})
MATCH (b:Entity {id: row.target_id})
MERGE (a)-[r:HAS_FACTORY]->(b)
SET r.source = row.source, r.confidence = toFloat(row.confidence), r.validFrom = date(row.validFrom);

LOAD CSV WITH HEADERS FROM 'https://RAW_GITHUB_URL/relationships.csv' AS row
WITH row WHERE row.type = 'HAS_MAINTENANCE'
MATCH (a:Entity {id: row.source_id})
MATCH (b:Entity {id: row.target_id})
MERGE (a)-[r:HAS_MAINTENANCE]->(b)
SET r.source = row.source, r.confidence = toFloat(row.confidence), r.validFrom = date(row.validFrom);

LOAD CSV WITH HEADERS FROM 'https://RAW_GITHUB_URL/relationships.csv' AS row
WITH row WHERE row.type = 'HAS_OPERATION'
MATCH (a:Entity {id: row.source_id})
MATCH (b:Entity {id: row.target_id})
MERGE (a)-[r:HAS_OPERATION]->(b)
SET r.source = row.source, r.confidence = toFloat(row.confidence), r.validFrom = date(row.validFrom);

LOAD CSV WITH HEADERS FROM 'https://RAW_GITHUB_URL/relationships.csv' AS row
WITH row WHERE row.type = 'HAS_WORKSHOP'
MATCH (a:Entity {id: row.source_id})
MATCH (b:Entity {id: row.target_id})
MERGE (a)-[r:HAS_WORKSHOP]->(b)
SET r.source = row.source, r.confidence = toFloat(row.confidence), r.validFrom = date(row.validFrom);

LOAD CSV WITH HEADERS FROM 'https://RAW_GITHUB_URL/relationships.csv' AS row
WITH row WHERE row.type = 'INSPECTED'
MATCH (a:Entity {id: row.source_id})
MATCH (b:Entity {id: row.target_id})
MERGE (a)-[r:INSPECTED]->(b)
SET r.source = row.source, r.confidence = toFloat(row.confidence), r.validFrom = date(row.validFrom);

LOAD CSV WITH HEADERS FROM 'https://RAW_GITHUB_URL/relationships.csv' AS row
WITH row WHERE row.type = 'LOCATED_IN'
MATCH (a:Entity {id: row.source_id})
MATCH (b:Entity {id: row.target_id})
MERGE (a)-[r:LOCATED_IN]->(b)
SET r.source = row.source, r.confidence = toFloat(row.confidence), r.validFrom = date(row.validFrom);

LOAD CSV WITH HEADERS FROM 'https://RAW_GITHUB_URL/relationships.csv' AS row
WITH row WHERE row.type = 'NEXT_OPERATION'
MATCH (a:Entity {id: row.source_id})
MATCH (b:Entity {id: row.target_id})
MERGE (a)-[r:NEXT_OPERATION]->(b)
SET r.source = row.source, r.confidence = toFloat(row.confidence), r.validFrom = date(row.validFrom);

LOAD CSV WITH HEADERS FROM 'https://RAW_GITHUB_URL/relationships.csv' AS row
WITH row WHERE row.type = 'OPERATES'
MATCH (a:Entity {id: row.source_id})
MATCH (b:Entity {id: row.target_id})
MERGE (a)-[r:OPERATES]->(b)
SET r.source = row.source, r.confidence = toFloat(row.confidence), r.validFrom = date(row.validFrom);

LOAD CSV WITH HEADERS FROM 'https://RAW_GITHUB_URL/relationships.csv' AS row
WITH row WHERE row.type = 'PERFORMED_ON'
MATCH (a:Entity {id: row.source_id})
MATCH (b:Entity {id: row.target_id})
MERGE (a)-[r:PERFORMED_ON]->(b)
SET r.source = row.source, r.confidence = toFloat(row.confidence), r.validFrom = date(row.validFrom);

LOAD CSV WITH HEADERS FROM 'https://RAW_GITHUB_URL/relationships.csv' AS row
WITH row WHERE row.type = 'PRODUCES'
MATCH (a:Entity {id: row.source_id})
MATCH (b:Entity {id: row.target_id})
MERGE (a)-[r:PRODUCES]->(b)
SET r.source = row.source, r.confidence = toFloat(row.confidence), r.validFrom = date(row.validFrom);

LOAD CSV WITH HEADERS FROM 'https://RAW_GITHUB_URL/relationships.csv' AS row
WITH row WHERE row.type = 'REQUIRED_FOR'
MATCH (a:Entity {id: row.source_id})
MATCH (b:Entity {id: row.target_id})
MERGE (a)-[r:REQUIRED_FOR]->(b)
SET r.source = row.source, r.confidence = toFloat(row.confidence), r.validFrom = date(row.validFrom);

LOAD CSV WITH HEADERS FROM 'https://RAW_GITHUB_URL/relationships.csv' AS row
WITH row WHERE row.type = 'RESULT_OF'
MATCH (a:Entity {id: row.source_id})
MATCH (b:Entity {id: row.target_id})
MERGE (a)-[r:RESULT_OF]->(b)
SET r.source = row.source, r.confidence = toFloat(row.confidence), r.validFrom = date(row.validFrom);

LOAD CSV WITH HEADERS FROM 'https://RAW_GITHUB_URL/relationships.csv' AS row
WITH row WHERE row.type = 'STORES_MATERIAL'
MATCH (a:Entity {id: row.source_id})
MATCH (b:Entity {id: row.target_id})
MERGE (a)-[r:STORES_MATERIAL]->(b)
SET r.source = row.source, r.confidence = toFloat(row.confidence), r.validFrom = date(row.validFrom);

LOAD CSV WITH HEADERS FROM 'https://RAW_GITHUB_URL/relationships.csv' AS row
WITH row WHERE row.type = 'USES_MATERIAL'
MATCH (a:Entity {id: row.source_id})
MATCH (b:Entity {id: row.target_id})
MERGE (a)-[r:USES_MATERIAL]->(b)
SET r.source = row.source, r.confidence = toFloat(row.confidence), r.validFrom = date(row.validFrom);
