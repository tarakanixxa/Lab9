// CQ06: Який ланцюг наступних операцій доступний від OP-01 (глибина 1..5)?
MATCH p=(start:Operation {id:'OP-01'})-[:NEXT_OPERATION*1..5]->(next:Operation)
RETURN [n IN nodes(p) | n.name] AS operationPath, length(p) AS depth
ORDER BY depth LIMIT 20;
