# Cambiar política de ejecución
Set-ExecutionPolicy Bypass -Scope Process -Force

# Instalar y ejecutar Get-WindowsAutoPilotInfo
Install-Script -Name Get-WindowsAutoPilotInfo -Force
Get-WindowsAutoPilotInfo.ps1 -OutputFile C:\autopilotinfo.csv
Get-WindowsAutoPilotInfo.ps1 -Online

# Esperar sincronización
Start-Sleep -Seconds 60

# Autenticación en Microsoft Graph
Install-Module Microsoft.Graph -Force -AllowClobber
Import-Module Microsoft.Graph
Connect-MgGraph -Scopes "Device.ReadWrite.All", "Group.ReadWrite.All"

# Obtener ID del dispositivo y agregarlo al grupo
$SerialNumber = (Import-Csv C:\autopilotinfo.csv).SerialNumber
$Device = Get-MgDevice -Filter "deviceId eq '$SerialNumber'"

if ($Device) {
    New-MgGroupMember -GroupId "4233eea5-71d7-4f1a-b55c-270e927f5a87" -DirectoryObjectId $Device.Id
    Write-Host "Dispositivo agregado al grupo correctamente." -ForegroundColor Green
} else {
    Write-Host "No se encontró el dispositivo en Azure AD." -ForegroundColor Red
}
