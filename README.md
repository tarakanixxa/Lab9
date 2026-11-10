# Lab 9 — Neo4j AuraDB

Готовий стартовий комплект для ЛР 9. Предметна область продовжує ЛР 7: виробничий комплекс «Львів» / Metal-Detail. Дані синтетичні.

## Склад
- `data/` — 120 вузлів і 281 зв'язків у CSV.
- `import/` — імпорт через LOAD CSV/MERGE, constraints, indexes, verification.
- `queries/` — 12 Cypher-запитів, 2 аналізи впливу, GDS, PROFILE, ручні перевірки.
- `docs/` — звіт, схема draw.io, CQ mapping, результати запитів, GDS, SPARQL-vs-Cypher.
- `sparql/` — п'ять чернеток SPARQL; namespace треба звірити з ЛР 7.
- `tests/` — 10 питань text-to-Cypher і runner.
- `llm_log/`, `claims/` — протокол LLM-експерта.

## 0. Потрібно
1. Neo4j AuraDB 5.x.
2. Python 3.10+ (для тестового клієнта).
3. GitHub-репозиторій або інший публічний HTTPS хостинг для CSV, оскільки Aura `LOAD CSV` читає віддалений URL, а не локальний диск.

## 1. Підготовка CSV для Aura
Завантаж `data/nodes.csv` і `data/relationships.csv` у власний GitHub-репозиторій. Відкрий кожен файл → Raw → скопіюй HTTPS адресу `raw.githubusercontent.com/...`.
У `import/import.cypher` заміни всі:
- `https://RAW_GITHUB_URL/nodes.csv`
- `https://RAW_GITHUB_URL/relationships.csv`
на відповідні raw URLs.

## 2. Порядок запуску в Aura Query
1. Відкрий https://console.neo4j.io/ і створи AuraDB Free instance.
2. Збережи пароль локально; не надсилай його в чат.
3. В Aura Query виконай `import/constraints.cypher`.
4. Виконай `import/import.cypher` (можна вставити блоками).
5. Виконай `import/verify.cypher`.
6. Виконай запити з `queries/` по черзі.
7. Повтори імпорт і перевір незмінність кількостей.
8. Виконай навмисне порушення constraint окремо й зафіксуй помилку.

## 3. Python
```bash
python -m venv .venv
# Windows:
.venv\\Scripts\\activate
pip install -r requirements.txt
```
Задай змінні середовища:
```text
NEO4J_URI=neo4j+s://<your-instance-id>.databases.neo4j.io
NEO4J_USERNAME=neo4j
NEO4J_PASSWORD=<your-password>
```
Перевірка: `python scripts/check_connection.py`.

Для відповідності вимозі read-only role створи в Aura окремого користувача з вбудованою роллю `reader` (якщо керування користувачами/ролями доступне у твоєму тарифі) та використовуй саме його credentials для `NEO4J_USERNAME` / `NEO4J_PASSWORD`. Не запускай text-to-Cypher під адміністратором для фінальної демонстрації. `execute_read` і фільтр запитів у коді — додаткові запобіжники, але не замінюють серверну RBAC-роль.

Для text-to-Cypher:
```powershell
$env:OPENAI_API_KEY="..."
$env:OPENAI_MODEL="gpt-4.1-mini"
python tests/text_to_cypher.py
```
Без API key runner переходить на демонстраційні шаблони. Це перевіряє read-only виконання/валідацію, але не є оцінкою генеративної моделі.

## 4. GDS
В Aura перевір: `CALL gds.version();`
Якщо процедура не знайдена/не підтримується тарифом, GDS-частину не можна позначати як виконану. Потрібен доступний Aura Graph Analytics або Neo4j 5.x із сумісною бібліотекою GDS.

## 5. Що внести перед здачею
- реальні counts вузлів і зв'язків;
- скриншот `SHOW CONSTRAINTS` / `SHOW INDEXES`;
- counts до/після повторного імпорту;
- фактичне повідомлення про порушення constraint;
- результати 8+ Cypher запитів і три ручні перевірки;
- PageRank top-10, мінімум 3 Louvain communities, PROFILE до/після;
- п'ять фактичних SPARQL/Cypher пар результатів;
- t2c_results.jsonl, частка успіху, час і три помилки/контрольні негативні тести.

## 6. Безпека
Не публікуй Neo4j пароль або OpenAI API key у GitHub, звіті чи чаті. Додай `.env` до `.gitignore`. Не вставляй у звіт вигадані результати.
