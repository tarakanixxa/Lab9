// CQ11: Які верстати мають технічне обслуговування і який його статус?
MATCH (m:Machine)-[:HAS_MAINTENANCE]->(t:Maintenance)
RETURN m.name AS machine, collect(t.status) AS maintenanceStatuses,
       count(t) AS maintenanceCount ORDER BY maintenanceCount DESC;
