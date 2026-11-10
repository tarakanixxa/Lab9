// Run once in Neo4j Aura Query.
CREATE CONSTRAINT entity_id_unique IF NOT EXISTS
FOR (n:Entity) REQUIRE n.id IS UNIQUE;

CREATE CONSTRAINT machine_code_unique IF NOT EXISTS
FOR (n:Machine) REQUIRE n.code IS UNIQUE;

CREATE INDEX entity_name_index IF NOT EXISTS
FOR (n:Entity) ON (n.name);

CREATE INDEX entity_status_index IF NOT EXISTS
FOR (n:Entity) ON (n.status);

// Verification:
SHOW CONSTRAINTS;
SHOW INDEXES;
