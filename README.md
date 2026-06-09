# 🧠 memoria_persistente

Kit **reutilizable** de memoria persistente para agentes de IA. Funciona en **Claude Code,
Cursor, Gemini CLI, OpenCode, Codex** (y ChatGPT en modo copia-pega). Privado y local: solo
archivos Markdown versionados con Git. Sin servicios externos, sin vector DB.

## Idea en 10 segundos

```
☀️  /inicio              → lee el estado y te propone el plan del día
⚙️  /nota "lo que sea"   → captura al vuelo en el diario
🌙  /cierre              → guarda todo (journal + tareas + estado) y hace commit
```

Cada proyecto guarda su memoria en su propia carpeta `memory/`. Los comandos viven en global,
así que `/inicio`, `/nota` y `/cierre` funcionan en **cualquier** proyecto sin reinstalar.

## Instalación (una sola vez)

```powershell
# Windows (PowerShell)
git clone https://github.com/Jordiprof/memoria_persistente
cd memoria_persistente
./install.ps1
```

```bash
# macOS / Linux
git clone https://github.com/Jordiprof/memoria_persistente
cd memoria_persistente
bash install.sh
```

El instalador copia las plantillas a `~/.memoria-persistente/` y los comandos a las carpetas
globales de cada herramienta (`~/.claude/commands/`, `~/.gemini/commands/`,
`~/.config/opencode/command/`, `~/.codex/prompts/`).

## Uso en un proyecto nuevo

1. Abre el proyecto en tu herramienta.
2. Ejecuta `/inicio`. La **primera vez** crea `AGENTS.md` + `memory/` automáticamente (bootstrap).
3. Trabaja normal. Usa `/nota "..."` para apuntar cosas al vuelo.
4. Al terminar el día, `/cierre` guarda todo y hace commit (solo de `memory/`, nunca tu código).

> En Cursor: la memoria está **inactiva** por defecto; se activa solo si escribes
> `INICIO_SESION` o `GENERAR_MEMORIA_FINAL`. En ChatGPT: usa `chatgpt/system-prompt.md`.

## Estructura de la memoria (por proyecto)

```
mi-proyecto/
├── AGENTS.md                 # el protocolo (fuente de verdad)
└── memory/
    ├── STATE.md              # dónde estamos hoy (se reescribe, breve)
    ├── TASKS.md              # Hoy / Backlog / Hecho
    ├── journal/AAAA-MM-DD.md # diario append-only
    └── knowledge/            # hechos duraderos (on-demand)
```

## Privacidad y seguridad

- 100% local: nada sale de tu máquina.
- `journal/` es append-only + Git → es muy difícil perder contexto.
- `STATE.md` es lo único que se reescribe, y se recupera con `git revert`.

## Versionado del protocolo

`AGENTS.md` lleva una línea `Version:`. Si actualizas el kit (`git pull` + reinstalar), `/inicio`
te avisará en los proyectos que tengan una versión antigua, **sin** tocarlos automáticamente.

## Navegar la memoria en Obsidian

Abre la carpeta del proyecto como *vault* de Obsidian: verás `memory/` navegable, con su Graph View.
