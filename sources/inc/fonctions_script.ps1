# Fonction de pause
Function Pause($M="Appuyer sur une touche pour continuer...") {
    If($psISE){
        $S=New-Object -ComObject "WScript.Shell";$B=$S.Popup("$M",0,"Script Paused",0);
        Return
    };
    
    Write-Host -NoNewline $M;$I=16,17,18,20,91,92,93,144,145,166,167,168,169,170,171,172,173,174,175,176,177,178,179,180,181,182,183;
    While($K.VirtualKeyCode -Eq $Null -Or $I -Contains $K.VirtualKeyCode){
        $K=$Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")};
    Write-Host
}

# Red�marrer l'ordinateur
Function Set-RedémarragePC {
    Write-Host ""
    Write-Host "Redemarrage de l'ordinateur..."

    Start-Sleep -Seconds 5
    Restart-Computer
}

# Fonction de nettoyage de windows
Function Clear-Windows {
    Remove-Item -Path "$env:windir\temp\*" -Force -Recurse -ErrorAction SilentlyContinue -WarningAction SilentlyContinue
    Remove-Item -Path "$env:LOCALAPPDATA\temp\*" -Force -Recurse -ErrorAction SilentlyContinue -WarningAction SilentlyContinue

    Invoke-Expression -Command "$env:windir\system32\cleanmgr.exe"
}