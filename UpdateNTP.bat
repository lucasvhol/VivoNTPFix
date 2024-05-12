@echo off
:: Verificar privilégios de administrador... / Checking admin access...
net session >nul 2>&1
if %errorlevel% == 1 (
    echo Solicitando privilégios de administrador... / Requesting administrator privilege...
    PowerShell -Command "Start-Process cmd -ArgumentList '/c %~f0' -Verb RunAs"
    exit /b
)

:: Adicionar servidores NTP / Add NTP servers
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\DateTime\Servers" /v 1 /d "a.st1.ntp.br" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\DateTime\Servers" /v 2 /d "b.st1.ntp.br" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\DateTime\Servers" /v 3 /d "c.st1.ntp.br" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\DateTime\Servers" /v 4 /d "d.st1.ntp.br" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\DateTime\Servers" /v 5 /d "a.ntp.br" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\DateTime\Servers" /v 6 /d "b.ntp.br" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\DateTime\Servers" /v 7 /d "c.ntp.br" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\DateTime\Servers" /v 8 /d "gps.ntp.br" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\DateTime\Servers" /ve /d 1 /f

:: Reiniciar o serviço de Horário do Windows / Restart Windows Time Service.
net stop w32time && net start w32time

:: Forçar atualização do horário / Force Time Refresh.
w32tm /resync

echo Servidores NTP atualizados e tempo sincronizado.  / NTP servers updated and time synced.
pause
