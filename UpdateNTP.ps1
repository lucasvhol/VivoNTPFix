# Solicitar execução como administrador se não estiver rodando com privilégios elevados. / Request to run as administrator if not running with elevated privileges
if (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator))
{
    Start-Process PowerShell -ArgumentList "-File `"$PSCommandPath`"" -Verb RunAs
    exit
}

# Ajustar temporariamente a política de execução para permitir scripts // Temporarily adjust execution policy to allow scripts
Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope Process -Force

# Definir servidores NTP / Setting NTP servers.
$ntpServers = @{
    "1"="a.st1.ntp.br";
    "2"="b.st1.ntp.br";
    "3"="c.st1.ntp.br";
    "4"="d.st1.ntp.br";
    "5"="a.ntp.br";
    "6"="b.ntp.br";
    "7"="c.ntp.br";
    "8"="gps.ntp.br";
}

# Adicionar entradas no registro // Add registry files.
$ntpServers.Keys | ForEach-Object {
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\DateTime\Servers" -Name $_ -Value $ntpServers[$_]
}
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\DateTime\Servers" -Name "@" -Value "1"

# Reiniciar o serviço de Horário do Windows / Restart Windows Time Service.
Restart-Service w32time

# Forçar a ressincronização do tempo / Force Time Refresh.
w32tm /resync

Write-Host "Servidores NTP atualizados e sincronização do tempo forçada. | Updated NTP servers and forced time synchronization"
