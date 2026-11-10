# Результати Cypher — шаблон заповнення

У `queries/` розміщено 12 запитів. Для кожного після запуску в Aura слід вставити фактичний результат (таблицю або кількість рядків) та скриншот/посилання на запис у протоколі.

| Файл | CQ | Конструкції | Очікувана перевірка |
|---|---|---|---|
| cq01_structure | CQ01 | MATCH, ORDER BY | 4 цехи |
| cq02_machines_by_workshop | CQ02 | MATCH, collect, count | 20 верстатів розподілено по 4 цехах |
| cq03_employees | CQ03 | OPTIONAL MATCH, ORDER BY, LIMIT | 20 працівників і відповідні верстати |
| cq04_material_stock | CQ04 | sum, count, aggregation | 10 матеріалів/партій |
| cq05_product_defects | CQ05 | relationship properties | 9 зв'язків продукт-дефект |
| cq06_operation_chain | CQ06 | variable-length path | ланцюг операцій глибиною до 5 |
| cq07_shortest_process | CQ07 | shortestPath | найкоротший знайдений шлях або відсутність шляху |
| cq08_defect_aggregation | CQ08 | WITH, WHERE, aggregation | підрахунок дефектів на верстатах |
| cq09_influence_machine | CQ09 | variable-length path 1..3 | залежності верстата до глибини 3 |
| cq10_influence_defect | CQ10 | variable-length path 1..3 | залежності дефекту до глибини 3 |
| cq11_maintenance | CQ11 | collect, count | ТО для верстатів |
| cq12_material_to_product | CQ12 | OPTIONAL MATCH | матеріал-продукт-процес |

## Ручна перевірка
Виконайте `queries/manual_checks.cypher`. Порівняйте результати з CSV:
1. FC-001 має чотири ребра HAS_WORKSHOP.
2. MC-01 пов'язаний із WS-01.
3. DF-03 пов'язаний із PR-03 і MC-03.

Фактичні результати Aura тут навмисно не підставлені до запуску.
