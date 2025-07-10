# Requer execução como Administrador (mesma lógica de antes)
if (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    $arguments = "& '" + $myinvocation.mycommand.definition + "'"
    Start-Process powershell -Verb runAs -ArgumentList $arguments
    break
}

# --- LÓGICA DE DETECÇÃO DE IDIOMA ---
$strings_en = @{
    title = "NTP SYNC FIX FOR VIVO ISP (NTP.br)"
    info = "This script will configure the NTP.br servers on your Windows system."
    prompt = "Press ENTER to continue or CTRL+C to cancel."
    step1 = "[STEP 1 of 3] Adding NTP.br servers to the registry..."
    step2 = "[STEP 2 of 3] Setting the default server..."
    step3 = "[STEP 3 of 3] Restarting the time service and syncing..."
    success_title = "PROCESS COMPLETE!"
    success_msg = "Your system time has been synced with the NTP.br servers."
    exit = "Press ENTER to exit."
}
$strings_pt = @{
    title = "FIX DE SINCRONIZACAO DE HORA (NTP.br) PARA REDE VIVO"
    info = "Este script ira configurar os servidores NTP.br no Windows."
    prompt = "Pressione ENTER para continuar ou CTRL+C para cancelar."
    step1 = "[PASSO 1 de 3] Adicionando servidores NTP.br ao registro..."
    step2 = "[PASSO 2 de 3] Configurando o servidor padrao..."
    step3 = "[PASSO 3 de 3] Reiniciando o servico de tempo e sincronizando..."
    success_title = "PROCESSO CONCLUIDO!"
    success_msg = "O horario do seu sistema foi sincronizado com os servidores NTP.br."
    exit = "Pressione ENTER para sair."
}

# Seleciona o idioma. Inglês é o padrão.
$culture = (Get-UICulture).Name
if ($culture -eq 'pt-BR') {
    $s = $strings_pt
} else {
    $s = $strings_en
}

# --- INÍCIO DA LÓGICA PRINCIPAL ---

Write-Host "==========================================================" -ForegroundColor Yellow
Write-Host " $($s.title) " -ForegroundColor Yellow
Write-Host "==========================================================" -ForegroundColor Yellow
Write-Host ""
Read-Host -Prompt $s.prompt

$regPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\DateTime\Servers"
if (-not (Test-Path $regPath)) { New-Item -Path $regPath -Force | Out-Null }

$servers = @{
    "1"="a.st1.ntp.br"; "2"="b.st1.ntp.br"; "3"="c.st1.ntp.br"; "4"="d.st1.ntp.br";
    "5"="a.ntp.br"; "6"="b.ntp.br"; "7"="c.ntp.br"; "8"="gps.ntp.br"
}

Write-Host ""
Write-Host $s.step1 -ForegroundColor Green
foreach ($key in $servers.Keys) { Set-ItemProperty -Path $regPath -Name $key -Value $servers[$key] }

Write-Host $s.step2 -ForegroundColor Green
Set-ItemProperty -Path $regPath -Name "(Default)" -Value "1"

Write-Host $s.step3 -ForegroundColor Green
Stop-Service -Name w32time -Force
Start-Service -Name w32time
w32tm /config /update
w32tm /resync /force

Write-Host ""
Write-Host "==========================================================" -ForegroundColor Yellow
Write-Host " $($s.success_title) " -ForegroundColor Yellow
Write-Host "==========================================================" -ForegroundColor Yellow
Write-Host $s.success_msg
Write-Host ""
Read-Host -Prompt $s.exit
