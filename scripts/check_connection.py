import os
from neo4j import GraphDatabase
uri=os.environ["NEO4J_URI"]
auth=(os.getenv("NEO4J_USERNAME","neo4j"),os.environ["NEO4J_PASSWORD"])
with GraphDatabase.driver(uri,auth=auth) as driver:
    driver.verify_connectivity()
    print("Neo4j Aura connection: OK")
    print(driver.execute_read(lambda tx: tx.run("RETURN 1 AS ok").single()["ok"]))
