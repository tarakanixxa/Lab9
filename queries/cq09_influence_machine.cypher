// CQ09: Аналіз впливу: які сутності досяжні від верстата до глибини 3?
MATCH p=(m:Machine {id:'MC-01'})-[*1..3]-(x)
RETURN DISTINCT labels(x) AS targetLabels, x.id AS targetId, x.name AS targetName,
       min(length(p)) AS minDepth
ORDER BY minDepth, targetLabels LIMIT 50;
