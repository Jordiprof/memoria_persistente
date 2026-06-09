#!/usr/bin/env pwsh
# Instalador del kit de Memoria Persistente (Windows / PowerShell).
# Copia las plantillas a ~/.memoria-persistente y los comandos a las carpetas globales de
# cada herramienta, sustituyendo __KIT_HOME__ por la ruta absoluta de este equipo.

$ErrorActionPreference = "Stop"
$kitRoot    = $PSScriptRoot
$kitHome    = Join-Path $HOME ".memoria-persistente"
$kitHomeFwd = ($kitHome -replace '\\', '/')   # ruta con / para incrustar en los comandos

Write-Host "Instalando kit de memoria persistente..."
Write-Host "  Kit:  $kitRoot"
Write-Host "  Home: $kitHome"

# 1) Plantillas + VERSION a la carpeta home del kit
if (Test-Path (Join-Path $kitHome "templates")) {
    Remove-Item -Recurse -Force (Join-Path $kitHome "templates")
}
New-Item -ItemType Directory -Force -Path $kitHome | Out-Null
Copy-Item -Recurse -Force (Join-Path $kitRoot "templates") (Join-Path $kitHome "templates")
Copy-Item -Force (Join-Path $kitRoot "VERSION") (Join-Path $kitHome "VERSION")

# 2) Comandos a las carpetas globales, sustituyendo __KIT_HOME__ (UTF-8 sin BOM)
function Install-Commands($srcDir, $destDir) {
    if (-not (Test-Path $srcDir)) { return }
    New-Item -ItemType Directory -Force -Path $destDir | Out-Null
    $enc = New-Object System.Text.UTF8Encoding($false)
    Get-ChildItem -File $srcDir | ForEach-Object {
        $text = [System.IO.File]::ReadAllText($_.FullName)
        $text = $text.Replace('__KIT_HOME__', $kitHomeFwd)
        $dest = Join-Path $destDir $_.Name
        [System.IO.File]::WriteAllText($dest, $text, $enc)
        Write-Host "  + $dest"
    }
}

Install-Commands (Join-Path $kitRoot "claude\commands")  (Join-Path $HOME ".claude\commands")
Install-Commands (Join-Path $kitRoot "gemini\commands")  (Join-Path $HOME ".gemini\commands")
Install-Commands (Join-Path $kitRoot "opencode\command") (Join-Path $HOME ".config\opencode\command")
Install-Commands (Join-Path $kitRoot "codex\prompts")    (Join-Path $HOME ".codex\prompts")

Write-Host ""
Write-Host "OK. Comandos /inicio, /nota y /cierre instalados en global."
Write-Host "Cursor : copia cursor\memoria.mdc a .cursor\rules\ del proyecto (regla manual)."
Write-Host "ChatGPT: usa chatgpt\system-prompt.md en un Custom GPT."
