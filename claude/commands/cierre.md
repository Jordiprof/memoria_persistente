---
description: Cierra la sesión — guarda journal, tareas, estado y hace commit
allowed-tools: Bash(date:*), Bash(git:*), Read, Write, Edit, Glob, Grep
---
Fecha de hoy (real): !`date +%Y-%m-%d`
Hora: !`date +%H:%M`

Ejecuta el **RITUAL DE CIERRE** de `./AGENTS.md` al pie de la letra:
1. Razonamiento de **máximo 3 líneas** sobre lo hecho hoy.
2. APPEND al journal de hoy (`## Hecho` / `## Decisiones` / `## Mañana`);
   ACTUALIZA `memory/TASKS.md`; REESCRIBE `memory/STATE.md` (breve, ≤ 20 líneas);
   PROMOCIÓN a `memory/knowledge/` si surgió algún hecho duradero.
3. `git add memory/ && git commit -m "memoria: cierre <HOY>"` (SOLO `memory/`).

Usa únicamente la fecha/hora reales de arriba. Nada de saludos ni texto fuera del razonamiento.
