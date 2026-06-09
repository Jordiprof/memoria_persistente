---
description: Captura una nota rápida en el journal de hoy
argument-hint: [texto de la nota]
allowed-tools: Bash(date:*), Read, Write, Edit
---
Hora real del sistema (úsala; NO la inventes): !`date +%H:%M`
Fecha de hoy: !`date +%Y-%m-%d`

Ejecuta el **RITUAL DE NOTA** de `./AGENTS.md`:
añade `- {HORA} — {texto}` al final de la sección `## Notas` del journal de hoy
(`./memory/journal/<HOY>.md`). Si ese journal no existe, créalo desde
`__KIT_HOME__/templates/journal.md` (con `{{FECHA}}` = hoy). **No** hagas commit. Sé instantáneo.

Texto de la nota: $ARGUMENTS
