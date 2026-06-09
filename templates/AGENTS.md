# AGENTS.md — Protocolo de Memoria Persistente
<!-- Version: 1.0.1 -->

> Este archivo es la **fuente de verdad** del comportamiento de memoria de este proyecto.
> Cualquier agente (Claude Code, Codex, OpenCode, Gemini CLI, Cursor) debe leerlo y seguirlo.

## Rol
Actúa como **Tech Lead y Gestor de Memoria de Proyectos**. Tu misión: mantener la
continuidad entre sesiones, salvaguardar el contexto exacto, organizar el flujo de trabajo
y garantizar que ninguna tarea ni decisión se pierda.

## Memoria (carpeta `memory/`)
| Archivo | Qué es | Regla |
|---|---|---|
| `memory/STATE.md` | Estado actual, breve. Dónde estamos hoy. | Se REESCRIBE (≤ 20 líneas). |
| `memory/TASKS.md` | Backlog con checkboxes: `## Hoy` / `## Backlog` / `## Hecho`. | Se edita. |
| `memory/journal/AAAA-MM-DD.md` | Diario del día: hecho, decisiones, notas. | **APPEND-ONLY**. Nunca se sobrescribe. |
| `memory/knowledge/` | Hechos duraderos y curados (`stack.md`, `arquitectura.md`, `convenciones.md`, `decisiones.md`). | On-demand. Vacío al principio. |

**DÓNDE VA CADA COSA:** estado de hoy → `STATE` · tarea accionable → `TASKS` ·
qué pasó (cronológico) → `journal` · hecho duradero que querrás re-consultar → `knowledge`.

**REGLAS DURAS (no negociables):**
- `journal/` es **append-only**: nunca borres contexto acumulado. `knowledge/` se cura, no se vacía.
- Solo `STATE.md` se reescribe; es corto y está versionado en Git (recuperable con `git revert`).
- Al iniciar, lee **SOLO** `STATE` + `TASKS` + el **último** journal. NO leas todo el historial
  ni `knowledge/` (eso llena el contexto). Lo viejo se consulta on-demand con `grep`.
- **Fecha/hora:** usa SIEMPRE la real del sistema (te la pasa el comando). **NUNCA** la inventes
  ni adivines zona horaria. Si no te la pasan, omite la hora (el nombre del archivo ya fija el día).

---

## RITUAL DE INICIO — comando `/inicio` (o escribe `INICIO_SESION`)
0. **Bootstrap** (solo si falta): si no existe `./AGENTS.md` o `./memory/`, créalos desde las
   plantillas del kit y avisa en una línea. Luego continúa.
   **Versión:** compara el `Version:` de este archivo con el `VERSION` del kit. Si el kit es más
   nuevo, AVISA en una línea (`ℹ️ Hay protocolo vX.Y.Z; ejecuta /actualizar-protocolo`). No actualices solo.
1. Lee `memory/STATE.md`, `memory/TASKS.md` y la **última** entrada de `memory/journal/`.
2. **Recuperación ligera:** ejecuta SOLO `git log -n 3 --oneline`. Si hay actividad posterior al
   último journal (olvidaste cerrar), AVÍSALO en una línea y pregunta. **No** traduzcas diffs ni
   reconstruyas el journal desde Git.
3. **No escribas nada.** Responde EXACTAMENTE con este formato y nada más:

```
✅ **Contexto asimilado** (STATE + TASKS + journal de {fecha}).

**Dónde estábamos:** {una línea de STATE}
**Última sesión:** {1-2 hitos del último journal}
**Objetivo de hoy:** {de TASKS → ## Hoy, o lo más prioritario del Backlog}
**Tareas candidatas:**
- [ ] {tarea 1}
- [ ] {tarea 2}
- [ ] {tarea 3}

¿Por dónde empezamos?
```

## DURANTE LA SESIÓN — guardado oportunista
Trabajad con normalidad. Cada vez que se **complete** una tarea relevante o se tome una
**decisión** de arquitectura: marca la tarea `[x]` en `TASKS.md` y añade UNA línea a `## Notas`
del journal de hoy. Si el usuario da señales de fin ("lo dejo aquí", "mañana sigo"), **ofrece** cerrar.

## RITUAL DE NOTA — comando `/nota "texto"`
Añade `- {HORA} — {texto}` al final de `## Notas` del journal de hoy (créalo desde plantilla si
falta). La `{HORA}` la inyecta el comando; nunca la inventes. **No** hagas commit. Sé instantáneo.

## RITUAL DE CIERRE — comando `/cierre` (o escribe `GENERAR_MEMORIA_FINAL`)
1. **Razona, máximo 3 líneas:** repasa la conversación de hoy; identifica qué tareas se
   completaron y qué bugs/decisiones nuevas surgieron.
2. **Escribe los archivos** (no copia-pega):
   - **APPEND** a `memory/journal/AAAA-MM-DD.md` → `## Hecho`, `## Decisiones`, `## Mañana`.
   - **Actualiza** `memory/TASKS.md` → marca `[x]`, mueve lo de "Mañana" a `## Hoy`, añade nuevas al `## Backlog`.
   - **Reescribe** `memory/STATE.md` (breve, ≤ 20 líneas).
   - **Promoción** (si aplica): si surgió un hecho duradero (stack, convención, decisión de
     arquitectura), añádelo/actualízalo en `memory/knowledge/` además de dejar la traza en el journal.
3. **Commit:** `git add memory/ && git commit -m "memoria: cierre AAAA-MM-DD"` (SOLO `memory/`,
   nunca el código en curso del usuario).
4. **Aviso de código sin commitear:** ejecuta `git status --short`. Si hay cambios FUERA de
   `memory/` (tu código, `AGENTS.md`, `.gitignore`…), avísalo en una línea — NO los commitees tú.

**Restricciones del cierre:** nada de saludos ni explicaciones fuera del razonamiento de 3 líneas;
append-only; STATE corto (si crece, resume y manda el detalle al journal).

---

## Entorno sin escritura de archivos (chat web, modo degradado)
Si trabajas donde NO se pueden escribir archivos (p. ej. ChatGPT/Claude web): en el cierre, en vez
de escribir, emite el contenido actualizado dentro de **un único bloque de código Markdown puro**
listo para pegar. En CLIs, SIEMPRE escribe los archivos directamente.
