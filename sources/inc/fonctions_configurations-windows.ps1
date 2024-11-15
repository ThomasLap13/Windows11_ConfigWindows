# Activation automatique du pavé numérique
Function Enable-PaveNumerique {
    Write-Host "Activation automatique du pave numérique..."
    Write-Host "--------------------------------------------"
	If (!(Test-Path "HKU:")) {
		New-PSDrive -Name "HKU" -PSProvider "Registry" -Root "HKEY_USERS" | Out-Null
	}
	Set-ItemProperty -Path "HKU:\.DEFAULT\Control Panel\Keyboard" -Name "InitialKeyboardIndicators" -Type DWord -Value 2147483650
	Add-Type -AssemblyName System.Windows.Forms
	If (!([System.Windows.Forms.Control]::IsKeyLocked('NumLock'))) {
		$wsh = New-Object -ComObject WScript.Shell
		$wsh.SendKeys('{NUMLOCK}')
	}
}

# Désactivation de Cortana
Function Disable-Cortana {
	Write-Host "Desactivation de Cortana..."
    Write-Host "--------------------------------------------"
	If (!(Test-Path "HKCU:\Software\Microsoft\Personalization\Settings")) {
		New-Item -Path "HKCU:\Software\Microsoft\Personalization\Settings" -Force | Out-Null
	}
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Personalization\Settings" -Name "AcceptedPrivacyPolicy" -Type DWord -Value 0
	If (!(Test-Path "HKCU:\Software\Microsoft\InputPersonalization\TrainedDataStore")) {
		New-Item -Path "HKCU:\Software\Microsoft\InputPersonalization\TrainedDataStore" -Force | Out-Null
	}
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\InputPersonalization" -Name "RestrictImplicitTextCollection" -Type DWord -Value 1
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\InputPersonalization" -Name "RestrictImplicitInkCollection" -Type DWord -Value 1
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\InputPersonalization\TrainedDataStore" -Name "HarvestContacts" -Type DWord -Value 0
	Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ShowCortanaButton" -Type DWord -Value 0
	Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\PolicyManager\default\Experience\AllowCortana" -Name "Value" -Type DWord -Value 0
	If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search")) {
		New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search" -Force | Out-Null
	}
	Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search" -Name "AllowCortana" -Type DWord -Value 0
	If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\InputPersonalization")) {
		New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\InputPersonalization" -Force | Out-Null
	}
	Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\InputPersonalization" -Name "AllowInputPersonalization" -Type DWord -Value 0
	Get-AppxPackage "Microsoft.549981C3F5F10" | Remove-AppxPackage
}

# Désactivation des expériences des utilisateurs connectés et de la télémétrie
Function Disable-ExperienceUtilisateursConnectes {
	Write-Host "Désactivation des expériences des utilisateurs connectés et de la télémétrie..."
    Write-Host "--------------------------------------------"
    Stop-Service "DiagTrack" -WarningAction SilentlyContinue
	Set-Service "DiagTrack" -StartupType Disabled
}

# Désactivation de la télémétrie pour Windows 11
Function Disable-Telemetrie {
    Write-Host "Desactivation de la telemetrie..."
    Write-Host "--------------------------------------------"
    $telemetryPaths = @(
        "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection",
        "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Policies\DataCollection",
        "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection",
        "HKLM:\SOFTWARE\Policies\Microsoft\Windows\PreviewBuilds",
        "HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\CurrentVersion\Software Protection Platform",
        "HKLM:\SOFTWARE\Policies\Microsoft\SQMClient\Windows",
        "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppCompat",
        "HKLM:\SOFTWARE\Policies\Microsoft\AppV\CEIP",
        "HKLM:\SOFTWARE\Policies\Microsoft\Windows\TabletPC",
        "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\TextInput"
    )
    foreach ($path in $telemetryPaths) {
        If (!(Test-Path $path)) {
            New-Item -Path $path -Force | Out-Null
        }
    }
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection" -Name "AllowTelemetry" -Type DWord -Value 0
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Policies\DataCollection" -Name "AllowTelemetry" -Type DWord -Value 0
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection" -Name "AllowTelemetry" -Type DWord -Value 0
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\PreviewBuilds" -Name "AllowBuildPreview" -Type DWord -Value 0
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\CurrentVersion\Software Protection Platform" -Name "NoGenTicket" -Type DWord -Value 1
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\SQMClient\Windows" -Name "CEIPEnable" -Type DWord -Value 0
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppCompat" -Name "AITEnable" -Type DWord -Value 0
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppCompat" -Name "DisableInventory" -Type DWord -Value 1
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\AppV\CEIP" -Name "CEIPEnable" -Type DWord -Value 0
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\TabletPC" -Name "PreventHandwritingDataSharing" -Type DWord -Value 1
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\TextInput" -Name "AllowLinguisticDataCollection" -Type DWord -Value 0
    $scheduledTasks = @(
        "Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser",
        "Microsoft\Windows\Application Experience\ProgramDataUpdater",
        "Microsoft\Windows\Autochk\Proxy",
        "Microsoft\Windows\Customer Experience Improvement Program\Consolidator",
        "Microsoft\Windows\Customer Experience Improvement Program\UsbCeip",
        "Microsoft\Windows\DiskDiagnostic\Microsoft-Windows-DiskDiagnosticDataCollector",
        "Microsoft\Office\Office ClickToRun Service Monitor",
        "Microsoft\Office\OfficeTelemetryAgentFallBack2016",
        "Microsoft\Office\OfficeTelemetryAgentLogOn2016"
    )
    foreach ($task in $scheduledTasks) {
        Disable-ScheduledTask -TaskName $task -ErrorAction SilentlyContinue | Out-Null
    }
}

# Désactivation de la suggestion et de l'installation automatique d'applications
Function Disable-InstallationAutoApplis {
	Write-Host "Desactivation de la suggestion et de l'installation automatique d'applications..."
    Write-Host "--------------------------------------------"
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "ContentDeliveryAllowed" -Type DWord -Value 0
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "OemPreInstalledAppsEnabled" -Type DWord -Value 0
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "PreInstalledAppsEnabled" -Type DWord -Value 0
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "PreInstalledAppsEverEnabled" -Type DWord -Value 0
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SilentInstalledAppsEnabled" -Type DWord -Value 0
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContent-310093Enabled" -Type DWord -Value 0
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContent-314559Enabled" -Type DWord -Value 0
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContent-338387Enabled" -Type DWord -Value 0
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContent-338388Enabled" -Type DWord -Value 0
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContent-338389Enabled" -Type DWord -Value 0
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContent-338393Enabled" -Type DWord -Value 0
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContent-353694Enabled" -Type DWord -Value 0
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContent-353696Enabled" -Type DWord -Value 0
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContent-353698Enabled" -Type DWord -Value 0
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SystemPaneSuggestionsEnabled" -Type DWord -Value 0
	If (!(Test-Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\UserProfileEngagement")) {
		New-Item -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\UserProfileEngagement" -Force | Out-Null
	}
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\UserProfileEngagement" -Name "ScoobeSystemSettingEnabled" -Type DWord -Value 0
	If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\WindowsInkWorkspace")) {
		New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\WindowsInkWorkspace" -Force | Out-Null
	}
	Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\WindowsInkWorkspace" -Name "AllowSuggestedAppsInWindowsInkWorkspace" -Type DWord -Value 0
	If ([System.Environment]::OSVersion.Version.Build -ge 17134) {
		$key = Get-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\CloudStore\Store\Cache\DefaultAccount\*windows.data.placeholdertilecollection\Current"
		Set-ItemProperty -Path $key.PSPath -Name "Data" -Type Binary -Value $key.Data[0..15]
		Stop-Process -Name "ShellExperienceHost" -Force -ErrorAction SilentlyContinue
	}
}

# Désactivation de l'historique de l'activité
Function Disable-HistoriqueActivite {
	Write-Host "Desactivation de l'historique de l'activite..."
    Write-Host "--------------------------------------------"
    If (!(Test-Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\activity")) {
		New-Item -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\activity" -Force | Out-Null
	}
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\activity" -Name "Value" -Type String -Value "Deny"
	Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System" -Name "EnableActivityFeed" -Type DWord -Value 0
	Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System" -Name "PublishUserActivities" -Type DWord -Value 0
	Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System" -Name "UploadUserActivities" -Type DWord -Value 0
}

# Désactivation de la reconnaissance vocale en ligne
Function Disable-ReconnaissanceVocale {
	Write-Host "Desactivation de la reconnaissance vocale en ligne..."
    Write-Host "--------------------------------------------"
    If (!(Test-Path "HKCU:\Software\Microsoft\Speech_OneCore\Settings\OnlineSpeechPrivacy")) {
		New-Item -Path "HKCU:\Software\Microsoft\Speech_OneCore\Settings\OnlineSpeechPrivacy" -Force | Out-Null
	}
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Speech_OneCore\Settings\OnlineSpeechPrivacy" -Name "HasAccepted" -Type DWord -Value 0
}

# Empêcher Windows de suivre les demarrages d'applications
Function Disable-SuiviDemarrageApps {
	Write-Host "Empecher Windows de suivre les demarrages d'applications..."
    Write-Host "--------------------------------------------"
    If (!(Test-Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced")) {
		New-Item -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Force | Out-Null
	}
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "Start_TrackProgs" -Type DWord -Value 0
}

# Désactivation de la localisation
Function Disable-Localisation {
	Write-Host "Desactivation de la localisation..."
    Write-Host "--------------------------------------------"
    If (!(Test-Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\location")) {
		New-Item -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\location" -Force | Out-Null
	}
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\location" -Name "Value" -Type String -Value "Deny"
}

# Désactivation du retour d'experience utilisateur
Function Disable-RetourExperience {
	Write-Host "Desactivation du retour d'experience utilisateur..."
    Write-Host "--------------------------------------------"
	If (!(Test-Path "HKCU:\Software\Microsoft\Siuf\Rules")) {
		New-Item -Path "HKCU:\Software\Microsoft\Siuf\Rules" -Force | Out-Null
	}
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Siuf\Rules" -Name "NumberOfSIUFInPeriod" -Type DWord -Value 0
	Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection" -Name "DoNotShowFeedbackNotifications" -Type DWord -Value 1
	Disable-ScheduledTask -TaskName "Microsoft\Windows\Feedback\Siuf\DmClient" -ErrorAction SilentlyContinue | Out-Null
	Disable-ScheduledTask -TaskName "Microsoft\Windows\Feedback\Siuf\DmClientOnScenarioDownload" -ErrorAction SilentlyContinue | Out-Null
}

# Désactivation des données de diagnostic pour personnaliser l'expérience utilisateur
Function Disable-ExperienceSurMesure {
	Write-Host "Desactivation des donnees de diagnostic pour personnaliser l'experience utilisateur..."
    Write-Host "--------------------------------------------"
	If (!(Test-Path "HKCU:\Software\Policies\Microsoft\Windows\CloudContent")) {
		New-Item -Path "HKCU:\Software\Policies\Microsoft\Windows\CloudContent" -Force | Out-Null
	}
	Set-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\Windows\CloudContent" -Name "DisableTailoredExperiencesWithDiagnosticData" -Type DWord -Value 1
}

# Désactivation des identifiants publicitaires
Function Disable-IdPublicitaires {
	Write-Host "Desactivation des identifiants publicitaires..."
    Write-Host "--------------------------------------------"
    If (!(Test-Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\AdvertisingInfo")) {
		New-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\AdvertisingInfo" -Force | Out-Null
	}
	Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\AdvertisingInfo" -Name "Enabled" -Type DWord -Value 0
}

# Désactivation de l'accès en arrière-plan des applications UWP
Function Disable-ArrierePlanUWP {
	Write-Host "Desactivation de l'acces en arriere-plan des applications UWP..."
    Write-Host "--------------------------------------------"
    If (!(Test-Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications")) {
		New-Item -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications" -Force | Out-Null
	}
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications" -Name "GlobalUserDisabled" -Type DWord -Value 1
}

# Désactivation de l'accès à l'activation vocale à partir des applications UWP
Function Disable-AcivationVocaleUWP {
	Write-Host "Desactivation de l'acces à l'activation vocale à partir des applications UWP..."
    Write-Host "--------------------------------------------"
    If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy")) {
		New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" -Force | Out-Null
	}
	Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" -Name "LetAppsActivateWithVoice" -Type DWord -Value 2
	Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" -Name "LetAppsActivateWithVoiceAboveLock" -Type DWord -Value 2
}

# Désactivation de l'accès aux notifications pour les applications UWP
Function Disable-NotificationsUWP {
	Write-Host "Desactivation de l'acces aux notifications pour les applications UWP..."
    Write-Host "--------------------------------------------"
    If (!(Test-Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\userNotificationListener")) {
		New-Item -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\userNotificationListener" -Force | Out-Null
	}
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\userNotificationListener" -Name "Value" -Type String -Value "Deny"
}

# Désactivation de l'accès aux données du compte pour les applications UWP
Function Disable-DonneesCompteUWP {
	Write-Host "Desactivation de l'accès aux donnees du compte pour les applications UWP..."
    Write-Host "--------------------------------------------"

    If (!(Test-Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\userAccountInformation")) {
		New-Item -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\userAccountInformation" -Force | Out-Null
	}
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\userAccountInformation" -Name "Value" -Type String -Value "Deny"
}

# Désactivation de l'accès aux contacts pour les applications UWP
Function Disable-ContactsUWP {
	Write-Host "Desactivation de l'acces aux contacts pour les applications UWP..."
    Write-Host "--------------------------------------------"
    If (!(Test-Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\contacts")) {
		New-Item -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\contacts" -Force | Out-Null
	}
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\contacts" -Name "Value" -Type String -Value "Deny"
}

# Désactivation de l'accès au calendrier pour les applications UWP
Function Disable-CalendrierUWP {
	Write-Host "Desactivation de l'acces au calendrier pour les applications UWP..."
    Write-Host "--------------------------------------------"
    If (!(Test-Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\appointments")) {
		New-Item -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\appointments" -Force | Out-Null
	}
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\appointments" -Name "Value" -Type String -Value "Deny"
}

# Désactivation de l'accès aux appels téléphoniques pour les applications UWP
Function Disable-AppelsUWP {
	Write-Host "Desactivation de l'acces aux appels telephoniques pour les applications UWP..."
    Write-Host "--------------------------------------------"
    If (!(Test-Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\phoneCall")) {
		New-Item -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\phoneCall" -Force | Out-Null
	}
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\phoneCall" -Name "Value" -Type String -Value "Deny"
}

# Désactivation de l'accès a l'historique appels téléphoniques pour les applications UWP
Function Disable-HistoriqueAppelsUWP {
	Write-Host "Desactivation de l'acces a l'historique appels telephoniques pour les applications UWP..."
    Write-Host "--------------------------------------------"
    If (!(Test-Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\phoneCallHistory")) {
		New-Item -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\phoneCallHistory" -Force | Out-Null
	}
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\phoneCallHistory" -Name "Value" -Type String -Value "Deny"
}

# Désactivation de l'accès aux e-mails pour les applications UWP
Function Disable-MailsUWP {
	Write-Host "Desactivation de l'acces aux e-mails pour les applications UWP..."
    Write-Host "--------------------------------------------"
    If (!(Test-Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\email")) {
		New-Item -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\email" -Force | Out-Null
	}
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\email" -Name "Value" -Type String -Value "Deny"
}

# Désactivation de l'accès aux tâches pour les applications UWP
Function Disable-TachesUWP {
	Write-Host "Desactivation de l'acces aux taches pour les applications UWP..."
    Write-Host "--------------------------------------------"
    If (!(Test-Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\userDataTasks")) {
		New-Item -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\userDataTasks" -Force | Out-Null
	}
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\userDataTasks" -Name "Value" -Type String -Value "Deny"
}

# Désactivation de l'accès à la messagerie pour les applications UWP
Function Disable-MessagerieUWP {
	Write-Host "Desactivation de l'acces a la messagerie pour les applications UWP..."
    Write-Host "--------------------------------------------"
    If (!(Test-Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\chat")) {
		New-Item -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\chat" -Force | Out-Null
	}
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\chat" -Name "Value" -Type String -Value "Deny"
}

# Désactivation de l'accès au Bluetooth pour les applications UWP
Function Disable-BluetoothUWP {
	Write-Host "Desactivation de l'acces au Bluetooth pour les applications UWP..."
    Write-Host "--------------------------------------------"
    If (!(Test-Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\radios")) {
		New-Item -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\radios" -Force | Out-Null
	}
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\radios" -Name "Value" -Type String -Value "Deny"
}

# Désactivation de l'accès aux informations de diagnostic les applications UWP
Function Disable-InfosDiagnosticUWP {
	Write-Host "Desactivation de l'acces aux informations de diagnostic les applications UWP..."
    Write-Host "--------------------------------------------"
    If (!(Test-Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\appDiagnostics")) {
		New-Item -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\appDiagnostics" -Force | Out-Null
	}
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\appDiagnostics" -Name "Value" -Type String -Value "Deny"
}

# Désactiver Windows Media Player
Function Disable-WindowsMediaPlayer {
    Write-Host "Desactivation de Windows Media Player..."
    Write-Host "--------------------------------------------"
	Get-WindowsOptionalFeature -Online | Where-Object { $_.FeatureName -eq "WindowsMediaPlayer" } | Disable-WindowsOptionalFeature -Online -NoRestart -WarningAction SilentlyContinue | Out-Null
	Get-WindowsCapability -Online | Where-Object { $_.Name -like "Media.WindowsMediaPlayer*" } | Remove-WindowsCapability -Online | Out-Null
}

# Masquer l'icône Contacts de la barre des tâches
Function Set-BarreDesTachesMasquerIconeContact {
	Write-Host "Masquer l'icon Contacts de la barre des taches..."
    Write-Host "--------------------------------------------"

    If (!(Test-Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced\People")) {
		New-Item -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced\People" | Out-Null
	}
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced\People" -Name "PeopleBand" -Type DWord -Value 0
}

# Détacher toutes les applications de la barre des tâches par défaut
Function Set-DetacherApplisBarreDesTaches {
    Write-Host "Detachement de toutes les applications de la barre des taches par défaut..."
    Write-Host "--------------------------------------------"
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Taskband" -Name "Favorites" -Type Binary -Value ([byte[]](255))
	Remove-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Taskband" -Name "FavoritesResolve" -ErrorAction SilentlyContinue
}

# Afficher l'icône de recherche dans la barre des tâches
Function Set-IconeRechercheBarreDesTaches {
    Write-Host "Afficher l'icon de recherche dans la barre des taches..."
    Write-Host "--------------------------------------------"
	If (!(Test-Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Search")) {
		New-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Search" | Out-Null
	}
	Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Search" -Name "SearchboxTaskbarMode" -Type DWord -Value 1
    Start-Sleep -s 2
	Stop-Process -Name "explorer" -Force -ErrorAction SilentlyContinue
	Start-Sleep -s 2
}

# Configurer le panneau de configuration pour afficher des icônes
Function Set-PanneauDeConfigurationIcones {
	Write-Host "Configuration du panneau de configuration pour afficher des icones..."
    Write-Host "--------------------------------------------"
    If (!(Test-Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\ControlPanel")) {
		New-Item -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\ControlPanel" | Out-Null
	}
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\ControlPanel" -Name "StartupPage" -Type DWord -Value 1
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\ControlPanel" -Name "AllItemsIconView" -Type DWord -Value 1
}

# Afficher le chemin d'accès complet au répertoire dans la barre de titre de l'Explorateur
Function Set-ExplorateurCheminComplet {
    Write-Host "Afficher le chemin d'acces complet au repertoire dans la barre de titre de l'Explorateur..."
    Write-Host "--------------------------------------------"
    If (!(Test-Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\CabinetState")) {
		New-Item -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\CabinetState" -Force | Out-Null
	}
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\CabinetState" -Name "FullPath" -Type DWord -Value 1
}

# Afficher les extensions de fichiers
Function Set-ExplorateurAfficherExtensionsFichiers {
    Write-Host "Afficher les extensions de fichiers..."
    Write-Host "--------------------------------------------"
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "HideFileExt" -Type DWord -Value 0
}

# Afficher les fichiers cachés
Function Set-ExplorateurAfficherFichiersCaches {
    Write-Host "Afficher les fichiers caches..."
    Write-Host "--------------------------------------------"
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "Hidden" -Type DWord -Value 1
}

# Développer jusqu'au dossier ouvert
Function Set-ExplorateurDevelopperDossierOuvert {
    Write-Host "Développer jusqu'au dossier ouvert..."
    Write-Host "--------------------------------------------"
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "NavPaneExpandToCurrentFolder" -Type DWord -Value 1
}

# Changer la vue par défaut de l'explorateur vers "ce PC"
Function Set-ExplorateurChangerVueCePC {
    Write-Host "Changement de la vue par défaut de l'explorateur vers 'ce PC'..."
    Write-Host "--------------------------------------------"
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "LaunchTo" -Type DWord -Value 1
}

# Changer la vue par défaut de l'explorateur vers "Accès rapide"
Function Set-ExplorateurChangerVueAccesRapide {
    Write-Host "Changement de la vue par défaut de l'explorateur vers 'Acces rapide'..."
    Write-Host "--------------------------------------------"
    Remove-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "LaunchTo" -ErrorAction SilentlyContinue
}

# Cacher l'icône 'Objet 3D' dans l'explorateur de fichier
Function Set-ExplorateurCacherObjet3D {
    Write-Host "Cacher l'icone 'Objet 3D' dans l'explorateur de fichier..."
    Write-Host "--------------------------------------------"
    Remove-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{0DB7E03F-FC29-4DC6-9020-FF41B59E513A}" -Recurse -ErrorAction SilentlyContinue
}