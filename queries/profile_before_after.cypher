// PROFILE A — broad scan baseline (run before optimization; record DB hits/time)
PROFILE
MATCH (n:Entity)
WHERE n.name CONTAINS 'Верстат'
RETURN n.id, n.name;

// PROFILE B — indexed equality lookup (compare after index exists)
PROFILE
MATCH (n:Entity {name:'Верстат ЧПК 01'})
RETURN n.id, n.name;

// A/B note: PROFILE executes the query. Compare operator tree, DB Hits and elapsed time.
// Do not invent measurements; paste actual values from Aura Query result.
