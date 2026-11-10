"""Text-to-Cypher runner for Neo4j Aura.
Read-only transaction + schema allowlist + LIMIT requirement.
Set NEO4J_URI, NEO4J_USERNAME, NEO4J_PASSWORD.
Optional LLM mode: OPENAI_API_KEY and OPENAI_MODEL.
"""
import os, json, re, time
from pathlib import Path
from neo4j import GraphDatabase

SCHEMA = """
Labels: Entity, ProductionComplex, Factory, Workshop, Machine, Employee, Material, Product,
Process, Operation, Defect, Maintenance, Inventory.
Relationships: HAS_FACTORY, HAS_WORKSHOP, CONTAINS_MACHINE, EMPLOYS, OPERATES,
USES_MATERIAL, PRODUCES, HAS_OPERATION, NEXT_OPERATION, STORES_MATERIAL,
HAS_DEFECT, DETECTED_ON, INSPECTED, HAS_MAINTENANCE, EXECUTES_PROCESS,
PERFORMED_ON, REQUIRED_FOR, RESULT_OF, CONSUMES_MATERIAL, ASSIGNED_TO, LOCATED_IN.
Properties: id, name, code, status, quantity, unit, description.
All generated queries must be read-only and include LIMIT <= 100.
"""
DEMO = [
"MATCH (f:Factory {id:'FC-001'})-[:HAS_WORKSHOP]->(w:Workshop) RETURN w.name AS workshop LIMIT 100",
"MATCH (w:Workshop)-[:CONTAINS_MACHINE]->(m:Machine) RETURN w.name AS workshop, m.name AS machine LIMIT 100",
"MATCH (e:Employee)-[:OPERATES]->(m:Machine) RETURN e.name AS employee, m.name AS machine LIMIT 100",
"MATCH (i:Inventory)-[:STORES_MATERIAL]->(m:Material) RETURN m.name AS material, sum(i.quantity) AS stockKg LIMIT 100",
"MATCH (p:Product)-[:HAS_DEFECT]->(d:Defect) RETURN p.name AS product, d.name AS defect LIMIT 100",
"MATCH p=(o:Operation {id:'OP-01'})-[:NEXT_OPERATION*1..3]->(x:Operation) RETURN [n IN nodes(p) | n.id] AS path LIMIT 100",
"MATCH (a:Machine {id:'MC-01'}), (b:Product {id:'PR-01'}) MATCH p=shortestPath((a)-[*..6]-(b)) RETURN [n IN nodes(p) | n.id] AS path LIMIT 100",
"MATCH (m:Machine)<-[:DETECTED_ON]-(d:Defect) WITH m, count(d) AS c RETURN m.id AS machine, c AS defects ORDER BY c DESC LIMIT 100",
"MATCH p=(m:Machine {id:'MC-01'})-[*1..3]-(x) RETURN DISTINCT x.id AS id, labels(x) AS labels LIMIT 100",
"MATCH (m:Machine)-[:HAS_MAINTENANCE]->(t:Maintenance) RETURN m.name AS machine, t.status AS maintenanceStatus LIMIT 100"
]
FORBIDDEN = re.compile(r"\b(CREATE|MERGE|DELETE|DETACH|SET|REMOVE|DROP|ALTER|GRANT|DENY|REVOKE|LOAD\s+CSV|CALL\s+dbms|CALL\s+apoc\.periodic)\b", re.I)
ALLOWED_START = re.compile(r"^\s*(MATCH|OPTIONAL\s+MATCH|WITH|UNWIND)\b", re.I)
LIMIT_RE = re.compile(r"\bLIMIT\s+(\d+)\b", re.I)

def validate(cypher):
    if not ALLOWED_START.search(cypher):
        raise ValueError("Запит має починатися з MATCH/OPTIONAL MATCH/WITH/UNWIND.")
    if FORBIDDEN.search(cypher):
        raise ValueError("Заборонена write/admin-конструкція.")
    m = LIMIT_RE.search(cypher)
    if not m or int(m.group(1)) > 100:
        raise ValueError("Обов'язковий LIMIT від 1 до 100.")
    if ";" in cypher.strip().rstrip(";"):
        raise ValueError("Дозволено лише один запит.")
    return cypher

def ask_llm(question):
    key = os.getenv("OPENAI_API_KEY")
    if not key:
        return None
    from openai import OpenAI
    client = OpenAI(api_key=key)
    model = os.getenv("OPENAI_MODEL", "gpt-4.1-mini")
    response = client.chat.completions.create(
        model=model, temperature=0,
        messages=[
            {"role":"system","content":"Generate exactly one read-only Cypher query. Use only this schema:\n"+SCHEMA+"Include LIMIT <= 100. Output only Cypher."},
            {"role":"user","content":question}
        ]
    )
    return response.choices[0].message.content.strip().strip("`")

def main():
    uri=os.environ["NEO4J_URI"]
    user=os.getenv("NEO4J_USERNAME","neo4j")
    password=os.environ["NEO4J_PASSWORD"]
    driver=GraphDatabase.driver(uri,auth=(user,password))
    qs=[json.loads(x) for x in Path(__file__).with_name("t2c.jsonl").read_text(encoding="utf-8").splitlines() if x.strip()]
    out=[]
    for i,item in enumerate(qs):
        start=time.perf_counter()
        query=ask_llm(item["question"]) or DEMO[i]
        record={"id":item["id"],"question":item["question"],"cypher":query}
        try:
            validate(query)
            # execute_read routes the transaction with READ access mode.
            rows=driver.execute_read(lambda tx: [dict(r) for r in tx.run(query)])
            record.update({"ok":True,"rows":rows,"error":None})
        except Exception as e:
            record.update({"ok":False,"rows":[],"error":str(e)})
        record["elapsed_ms"]=round((time.perf_counter()-start)*1000,3)
        out.append(record)
        print(record["id"], "OK" if record["ok"] else "ERROR", record["elapsed_ms"], "ms")
    Path(__file__).with_name("t2c_results.jsonl").write_text(
        "".join(json.dumps(x,ensure_ascii=False,default=str)+"\n" for x in out),encoding="utf-8")
    ok=sum(x["ok"] for x in out)
    print(f"Correct/executed: {ok}/{len(out)} = {ok/len(out)*100:.1f}%")
    driver.close()

if __name__=="__main__":
    main()
