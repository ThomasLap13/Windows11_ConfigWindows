@echo off
:: Récupère le chemin du dossier contenant ce script
set SCRIPT_DIR=%~dp0

:: Vérifie si le script est exécuté avec des privilèges d'administrateur
net session >nul 2>&1
if %errorLevel% neq 0 (
    :: Relance le script avec des privilèges d'administrateur
    powershell -Command "Start-Process PowerShell -ArgumentList '-NoProfile -ExecutionPolicy Bypass -File \"%SCRIPT_DIR%sources\script_WindowsSettings.ps1\"' -Verb RunAs"
    exit
)

:: Si le script est déjà exécuté en tant qu'administrateur, l'exécute normalement
powershell -NoProfile -ExecutionPolicy Bypass -File "%SCRIPT_DIR%sources\script_WindowsSettings.ps1"
