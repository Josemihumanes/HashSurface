# Cambiar la política de ejecución a Bypass
Write-Host "Cambiando la política de ejecución a Bypass..." -ForegroundColor Yellow
Set-ExecutionPolicy Bypass -Scope Process -Force

# Instalar el script Get-WindowsAutoPilotInfo
Write-Host "Instalando el script Get-WindowsAutoPilotInfo..." -ForegroundColor Yellow
Install-Script -Name Get-WindowsAutoPilotInfo -Force

# Ejecutar Get-WindowsAutoPilotInfo para exportar datos a un archivo CSV
Write-Host "Obteniendo información de AutoPilot y guardando en C:\autopilotinfo.csv..." -ForegroundColor Yellow
Get-WindowsAutoPilotInfo.ps1 -OutputFile C:\autopilotinfo.csv

# Subir la información a Microsoft Autopilot (requiere permisos y conexión configurados)
Write-Host "Subiendo información de AutoPilot a Microsoft Autopilot Online..." -ForegroundColor Yellow
Get-WindowsAutoPilotInfo.ps1 -Online

Write-Host "Proceso completado." -ForegroundColor Green
