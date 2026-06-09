---
description: Inicia sesión de memoria — carga estado y propone el plan del día
allowed-tools: Bash(date:*), Bash(git log:*), Read, Write, Edit, Glob, Grep
---
Contexto temporal real del sistema (úsalo; NO inventes fechas):
- Hoy: !`date +%Y-%m-%d`
- Hora: !`date +%H:%M`

Plantillas del kit (para bootstrap): `__KIT_HOME__/templates/`
Versión del kit: lee `__KIT_HOME__/VERSION` y compárala con el `Version:` de `./AGENTS.md`.
Si el kit es más nuevo, avisa en una línea (no actualices solo).

Ejecuta el **RITUAL DE INICIO** definido en `./AGENTS.md` de este proyecto, al pie de la letra.

Si NO existe `./AGENTS.md` o `./memory/`, primero haz **BOOTSTRAP**:
1. Copia `__KIT_HOME__/templates/AGENTS.md` → `./AGENTS.md`.
2. Crea `./memory/` con:
   - `STATE.md` y `TASKS.md` desde las plantillas, sustituyendo `{{PROYECTO}}` por el nombre de
     la carpeta actual y `{{FECHA}}` por la fecha de hoy (arriba).
   - `knowledge/README.md` desde la plantilla.
   - `journal/<HOY>.md` desde `__KIT_HOME__/templates/journal.md`, con `{{FECHA}}` = hoy.
3. Si no existe `./.gitignore`, copia `__KIT_HOME__/templates/gitignore` → `./.gitignore`.
4. Avisa en una línea: "🆕 Memoria inicializada (protocolo vX.Y.Z)." y continúa con el ritual.
