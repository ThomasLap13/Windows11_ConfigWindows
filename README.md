### EN

Windows 11 Config Windows Script  
**Author:** ThomasLap13  
**Link:** [https://github.com/ThomasLap13](https://github.com/ThomasLap13)  
**Date:** 15/11/2024  
**Version:** 1 - Tested on Windows 10/11 23H2/24H2  

---

### List of config :

- "Enable-NumPad"
- "Disable-Cortana"
- "Disable-ConnectedUserExperiences"
- "Disable-Telemetry"
- "Disable-AutoAppInstallation"
- "Disable-ActivityHistory"
- "Disable-VoiceRecognition"
- "Disable-AppLaunchTracking"
- "Disable-Location"
- "Disable-FeedbackExperience"
- "Disable-CustomizedExperience"
- "Disable-AdvertisingID"
- "Disable-UWPBackground"
- "Disable-UWPVoiceActivation"
- "Disable-UWPNotifications"
- "Disable-UWPAccountData"
- "Disable-UWPContacts"
- "Disable-UWPCalendar"
- "Disable-UWPCalls"
- "Disable-UWPCallHistory"
- "Disable-UWPMails"
- "Disable-UWPTasks"
- "Disable-UWPMessaging"
- "Disable-UWPBluetooth"
- "Disable-UWPDiagnosticInfo"
- "Disable-WindowsMediaPlayer"
- "Set-TaskbarHideContactIcon"
- "Set-DetachAppsFromTaskbar"
- "Set-TaskbarSearchIcon"
- "Set-ControlPanelIcons"
- "Set-FileExplorerFullPath"
- "Set-FileExplorerShowFileExtensions"
- "Set-FileExplorerShowHiddenFiles"
- "Set-FileExplorerExpandOpenedFolder"
- "Set-FileExplorerChangeViewThisPC"
- "Set-FileExplorerChangeViewQuickAccess" 

---

### .\sources\script_WindowsSettings

The `script_WindowsSettings.ps1` file is the main file, which follows the different steps and calls the specific functions.  
Its role is to centralize the execution of other scripts without requiring direct programming.  
Other files starting with "script..." are derivatives of this initial file, each designed to execute specific functionalities.

---

### .\sources\inc

This folder contains all the specific scripts with the functions called in `fonctions_configurations-windows.ps1`.  
To create a new feature in a category other than the ones already present, simply create a "function_" file and call it in `fonctions_configurations-windows.ps1`.

---

### Additional Information

For any questions or further information, feel free to contact me:  
**ThomasLap13**, IT apprentice.

---
---

### FR

Script configuration Windows  
**Auteur:** ThomasLap13  
**Lien:** [https://github.com/ThomasLap13](https://github.com/ThomasLap13)  
**Date:** 14/11/2024  
**Version:** 1 - Testé sur Windows 10/11 23H2/24H2  

---

### Liste de la configuration :

- "Activer-PaveNumerique"
- "Desactiver-Cortana"
- "Desactiver-ExperiencesUtilisateursConnectes"
- "Desactiver-Telemetrie"
- "Desactiver-InstallationAutoApplications"
- "Desactiver-HistoriqueActivite"
- "Desactiver-ReconnaissanceVocale"
- "Desactiver-SuiviLancementApplications"
- "Desactiver-Localisation"
- "Desactiver-RetourExperience"
- "Desactiver-ExperiencePersonnalisee"
- "Desactiver-IdPublicitaires"
- "Desactiver-ArrierePlanUWP"
- "Desactiver-ActivationVocaleUWP"
- "Desactiver-NotificationsUWP"
- "Desactiver-DonneesCompteUWP"
- "Desactiver-ContactsUWP"
- "Desactiver-CalendrierUWP"
- "Desactiver-AppelsUWP"
- "Desactiver-HistoriqueAppelsUWP"
- "Desactiver-MailsUWP"
- "Desactiver-TachesUWP"
- "Desactiver-MessagerieUWP"
- "Desactiver-BluetoothUWP"
- "Desactiver-InfosDiagnosticUWP"
- "Desactiver-WindowsMediaPlayer"
- "Configurer-BarreTachesMasquerIconeContact"
- "Configurer-DetacherApplicationsBarreTaches"
- "Configurer-IconeRechercheBarreTaches"
- "Configurer-PanneauConfigurationIcones"
- "Configurer-ExplorateurCheminComplet"
- "Configurer-ExplorateurAfficherExtensionsFichiers"
- "Configurer-ExplorateurAfficherFichiersCaches"
- "Configurer-ExplorateurDevelopperDossierOuvert"
- "Configurer-ExplorateurVueCePC"
- "Configurer-ExplorateurVueAccesRapide"

---

### .\sources\script_WindowsSettings

Le fichier `script_WindowsSettings.ps1` est le fichier principal, qui suit les différentes étapes et appelle les fonctions spécifiques.  
Son rôle est de centraliser l’exécution des autres scripts sans nécessiter de programmation directe.  
Les autres fichiers commençant par "script..." sont des dérivés de ce fichier initial, chacun conçu pour exécuter des fonctionnalités bien précises.

---

### .\sources\inc

Ce dossier contient tous les scripts spécifiques avec les fonctions appelées dans `fonctions_configurations-windows.ps1`.  
Pour créer une nouvelle fonctionnalité dans une catégorie différente de celles déjà présentes, il suffit de créer un fichier "fonction_" et de l’appeler dans `fonctions_configurations-windows.ps1`.

---

### Informations supplémentaires

Pour toute question ou information supplémentaire, n'hésitez pas à me contacter :  
**ThomasLap13**, apprenti informatique.
