#Importera komprimeringsmodulen som behövs senare
Import-Module .\komprimering.psm1

#Självanteckning: kan jag få programmet att läsa dessa två nedanstående variabler från en konfig-fil istället?
#Definera vad det är som skall kopieras
$source = "C:\Projekt-Exempel\BusinessProgram"

#Definera vart backupen skall sparas
$backupLocation = "C:\Projekt-Exempel\NetworkDriveBackup"

#Spara det aktuella användarnamnet och datumet
$user = $env:USERNAME
$time = Get-Date -Format "yyyy-MM-dd-HH-mm"

#Definera vart backup-mappen skall skapas och vad den skall heta
$dest = "$backupLocation\BACKUP-$user-$time"

#Skapa själva backup-mappen
New-Item -Path $dest -ItemType Directory -Force

#Och kopiera över innehållet från källan till backupen. -Recurse ser till att alla undermappar kommer med
try {
    Copy-Item "$source\*" -Destination $dest -Recurse
        #Anropa komprimeringsmodulen
        Compress-Backup -FolderToCompress $dest    
    Write-Host "Backup lyckades!"
} catch {
    Write-Warning "BACKUP MISSLYCKADES! Kontakta IT-avdelningen!"
}