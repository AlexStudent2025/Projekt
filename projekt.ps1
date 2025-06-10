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
    Write-Host "Backup lyckades!"
} catch {
    Write-Warning "BACKUP MISSLYCKADES! Kontakta IT!"
}