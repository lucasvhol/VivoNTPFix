@echo off
:: Verifica privilégios de administrador (mesma lógica de antes)
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
if '%errorlevel%' NEQ '0' (
    echo Requesting administrative privileges...
    goto UACPrompt
) else ( goto gotAdmin )

:UACPrompt
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    set params = %*:"=""
    echo UAC.ShellExecute "cmd.exe", "/c %~s0 %params%", "", "runas", 1 >> "%temp%\getadmin.vbs"
    "%temp%\getadmin.vbs"
    del "%temp%\getadmin.vbs"
    exit /B

:gotAdmin
    pushd "%CD%"
    CD /D "%~dp0"

:: --- LÓGICA DE DETECÇÃO DE IDIOMA ---
for /f "tokens=2 delims==" %%G in ('wmic os get locale /value') do for /f "delims=" %%H in ("%%G") do set "LOCALE=%%H"

if "%LOCALE%"=="1046" (
    set "LANG_TITLE=FIX DE SINCRONIZACAO DE HORA (NTP.br) PARA REDE VIVO"
    set "LANG_INFO=Este script ira configurar os servidores NTP.br no Windows."
    set "LANG_PROMPT=Pressione qualquer tecla para continuar ou CTRL+C para cancelar."
    set "LANG_STEP1=[PASSO 1 de 3] Adicionando servidores NTP.br ao registro..."
    set "LANG_STEP2=[PASSO 2 de 3] Configurando o servidor padrao..."
    set "LANG_STEP3=[PASSO 3 de 3] Reiniciando o servico de tempo e sincronizando..."
    set "LANG_SUCCESS_TITLE=PROCESSO CONCLUIDO!"
    set "LANG_SUCCESS_MSG=O horario do seu sistema foi sincronizado com os servidores NTP.br."
    set "LANG_EXIT=Pressione qualquer tecla para sair."
) else (
    set "LANG_TITLE=NTP SYNC FIX FOR VIVO ISP (NTP.br)"
    set "LANG_INFO=This script will configure the NTP.br servers on your Windows system."
    set "LANG_PROMPT=Press any key to continue or CTRL+C to cancel."
    set "LANG_STEP1=[STEP 1 of 3] Adding NTP.br servers to the registry..."
    set "LANG_STEP2=[STEP 2 of 3] Setting the default server..."
    set "LANG_STEP3=[STEP 3 of 3] Restarting the time service and syncing..."
    set "LANG_SUCCESS_TITLE=PROCESS COMPLETE!"
    set "LANG_SUCCESS_MSG=Your system time has been synced with the NTP.br servers."
    set "LANG_EXIT=Press any key to exit."
)

:: --- INÍCIO DA LÓGICA PRINCIPAL ---

echo ==========================================================
echo  %LANG_TITLE%
echo ==========================================================
echo.
echo %LANG_INFO%
echo %LANG_PROMPT%
pause > nul

echo.
echo %LANG_STEP1%
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\DateTime\Servers" /v 1 /t REG_SZ /d "a.st1.ntp.br" /f > nul
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\DateTime\Servers" /v 2 /t REG_SZ /d "b.st1.ntp.br" /f > nul
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\DateTime\Servers" /v 3 /t REG_SZ /d "c.st1.ntp.br" /f > nul
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\DateTime\Servers" /v 4 /t REG_SZ /d "d.st1.ntp.br" /f > nul
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\DateTime\Servers" /v 5 /t REG_SZ /d "a.ntp.br" /f > nul
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\DateTime\Servers" /v 6 /t REG_SZ /d "b.ntp.br" /f > nul
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\DateTime\Servers" /v 7 /t REG_SZ /d "c.ntp.br" /f > nul
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\DateTime\Servers" /v 8 /t REG_SZ /d "gps.ntp.br" /f > nul

echo.
echo %LANG_STEP2%
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\DateTime\Servers" /ve /t REG_SZ /d 1 /f > nul

echo.
echo %LANG_STEP3%
net stop w32time
net start w32time
w32tm /config /update
w32tm /resync /force

echo.
echo ==========================================================
echo  %LANG_SUCCESS_TITLE%
echo ==========================================================
echo %LANG_SUCCESS_MSG%
echo.
echo %LANG_EXIT%
pause > nul
