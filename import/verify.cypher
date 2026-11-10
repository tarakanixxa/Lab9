// Counts
MATCH (n:Entity) RETURN count(n) AS nodes;
MATCH ()-[r]->() RETURN count(r) AS relationships;

// Label distribution
MATCH (n:Entity) RETURN labels(n) AS labels, count(*) AS amount ORDER BY amount DESC;

// Idempotency: record these counts, rerun import.cypher, then run again.
// The two counts must remain unchanged because nodes and relationships use MERGE.

// Constraint violation demo (intentionally expected to fail):
// CREATE (:Entity {id: 'FC-001', name: 'Duplicate ID'});
// Expected: Neo4j ClientError due to entity_id_unique uniqueness constraint.
