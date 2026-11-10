// CQ10: Аналіз впливу дефекту на процеси/продукцію до глибини 3.
MATCH p=(d:Defect {id:'DF-03'})-[*1..3]-(x)
RETURN DISTINCT x.id AS relatedId, x.name AS relatedName, labels(x) AS labels,
       min(length(p)) AS depth
ORDER BY depth, relatedId LIMIT 50;
