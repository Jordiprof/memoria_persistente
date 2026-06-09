---
description: Inicia sesión de memoria — carga estado y propone el plan del día
---
Contexto temporal real del sistema (úsalo; NO inventes fechas):
- Hoy: !`date +%Y-%m-%d`
- Hora: !`date +%H:%M`

Plantillas del kit (para bootstrap): `__KIT_HOME__/templates/`

Ejecuta el **RITUAL DE INICIO** de `./AGENTS.md`. Si NO existe `./AGENTS.md` o `./memory/`,
haz **bootstrap**: copia `__KIT_HOME__/templates/AGENTS.md` → `./AGENTS.md`; crea `./memory/`
con `STATE.md`, `TASKS.md` (sustituyendo `{{PROYECTO}}` por la carpeta y `{{FECHA}}` por hoy),
`knowledge/README.md` y `journal/<HOY>.md`; copia `gitignore` → `./.gitignore` si falta.
Luego avisa en una línea y continúa con el ritual.
