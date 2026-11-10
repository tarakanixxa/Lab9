// Requires Graph Data Science (GDS) availability in the Aura instance.
// If Aura Graph Analytics is not enabled for this instance, run the same algorithms
// in an eligible Aura Graph Analytics workspace or local Neo4j with GDS installed.

// Project an undirected analytical projection.
CALL gds.graph.project(
  'manufacturingGraph',
  'Entity',
  { '*': { orientation: 'UNDIRECTED' } }
);

// PageRank: top 10
CALL gds.pageRank.stream('manufacturingGraph')
YIELD nodeId, score
RETURN gds.util.asNode(nodeId).id AS id,
       gds.util.asNode(nodeId).name AS name,
       score AS pagerank
ORDER BY pagerank DESC
LIMIT 10;

// Persist PageRank
CALL gds.pageRank.write('manufacturingGraph', {writeProperty:'pagerank'})
YIELD nodePropertiesWritten, ranIterations;

// Louvain: community assignments
CALL gds.louvain.stream('manufacturingGraph')
YIELD nodeId, communityId
RETURN communityId, count(*) AS members,
       collect(gds.util.asNode(nodeId).id)[0..10] AS sampleMembers
ORDER BY members DESC;

// Persist communities
CALL gds.louvain.write('manufacturingGraph', {writeProperty:'community'})
YIELD communityCount, nodePropertiesWritten;

// Verify persisted values
MATCH (n:Entity)
RETURN count(n) AS total,
       count(n.pagerank) AS withPageRank,
       count(n.community) AS withCommunity;

// Clean up in-memory projection when finished
CALL gds.graph.drop('manufacturingGraph');
