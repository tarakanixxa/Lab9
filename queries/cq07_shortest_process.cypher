// CQ07: Який найкоротший шлях зв'язків між верстатом MC-01 та продуктом PR-01?
MATCH (a:Machine {id:'MC-01'}), (b:Product {id:'PR-01'})
MATCH p=shortestPath((a)-[*..6]-(b))
RETURN [n IN nodes(p) | n.id] AS path, length(p) AS hops;
