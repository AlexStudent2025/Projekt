#Funktion som komprimerar en mapp
function Compress-Backup {
    param ($folderToCompress)

    $zipFile = "$folderToCompress.zip"

    try {
        Compress-Archive -Path "$folderToCompress" -DestinationPath $zipFile -Force
        Write-Host "Mappen komprimerades till $zipFile"
    } catch {
        Write-Host "Kunde inte komprimera mappen! Kontakta IT-avdelningen!"
    }
}
