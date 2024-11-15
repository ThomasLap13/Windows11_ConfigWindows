############################################################
# Script de paramètrage d'un poste Windows 11 
# Auteur : ThomasLap13 
# Date : 15/11/2024 
# Version 1 : Testé sur Windows 10/11 22H2/23H2 
############################################################

# Script configurations-windows
. "$PSScriptRoot\inc\fonctions_configurations-windows.ps1"
# Lancer le script en administrateur
if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) { Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File "$PSCommandPath"" -Verb RunAs; exit }

# Début du paramétrage
Write-Host ""
Write-Host "==============================================================================="
Write-Host "======        Bienvenue dans le script de parametrage automatique        ======"
Write-Host "==============================================================================="
Write-Host ""
Write-Host "Repondez au questionnaire avec :"
Write-Host "    - Oui = 1"
Write-Host "    - Non = 0"
Write-Host ""
Write-Host "*******************************************************************************"
Write-Host "*********************  Demarrage du parametrage Windows  **********************"
Write-Host "*******************************************************************************"
Write-Host ""

Enable-PaveNumerique
Disable-Cortana
Disable-ExperienceUtilisateursConnectes
Disable-Telemetrie
Disable-InstallationAutoApplis
Disable-HistoriqueActivite
Disable-ReconnaissanceVocale
Disable-SuiviDemarrageApps
Disable-Localisation
Disable-RetourExperience
Disable-ExperienceSurMesure
Disable-IdPublicitaires
Disable-ArrierePlanUWP
Disable-AcivationVocaleUWP
Disable-NotificationsUWP
Disable-DonneesCompteUWP
Disable-ContactsUWP
Disable-CalendrierUWP
Disable-AppelsUWP
Disable-HistoriqueAppelsUWP
Disable-MailsUWP
Disable-TachesUWP
Disable-MessagerieUWP
Disable-BluetoothUWP
Disable-InfosDiagnosticUWP
Disable-WindowsMediaPlayer
Set-BarreDesTachesMasquerIconeContact
Set-DetacherApplisBarreDesTaches
Set-IconeRechercheBarreDesTaches
Set-PanneauDeConfigurationIcones
Set-ExplorateurCheminComplet
Set-ExplorateurAfficherExtensionsFichiers
Set-ExplorateurAfficherFichiersCaches
Set-ExplorateurDevelopperDossierOuvert
Set-ExplorateurChangerVueCePC
Set-ExplorateurChangerVueAccesRapide

Write-Host ""
Clear-Windows
Write-Host "==============================================================================="
Pause("Configuration terminee. Appuyez sur une touche pour quitter (Le PC redemarrera)...")