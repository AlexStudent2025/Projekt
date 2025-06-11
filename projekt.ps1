#Importera komprimeringsmodulen som behövs senare
Import-Module .\komprimering.psm1

#Läs konfig-filen.
$configPath = "config.json"
$config = Get-Content $configPath | ConvertFrom-Json

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
        Remove-Item $dest -Recurse #Ta bort den okomprimerade mappen, vi behöver inte två kopior.
    Write-Host "Backup lyckades!"
} catch {
    Write-Warning "BACKUP MISSLYCKADES! Kontakta IT-avdelningen!"
}