[Read this in English](README-en.md)

# Fix de Sincronização de Horário (NTP) para Operadora de Internet VIVO.

Este repositório contém uma solução para um problema recorrente em que computadores com Windows conectados à rede da operadora Vivo não conseguem sincronizar o relógio com os servidores de tempo padrão da Microsoft (`time.windows.com`).

## O Problema

A rede da Vivo aparenta ter um bloqueio ou instabilidade que impede a comunicação com servidores de horário (NTP) internacionais. Isso pode causar erros em:
- Certificados de segurança de sites (erros de SSL/TLS).
- Autenticação em serviços online e de jogos.
- Funcionamento de softwares que dependem da hora correta.

## A Solução

A solução consiste em configurar o Windows para utilizar os servidores de horário públicos e oficiais do Brasil, mantidos pelo projeto **NTP.br**. Esses servidores são de alta precisão e estão localizados no Brasil, não sendo afetados pelo bloqueio da operadora.

---

## Como Usar

Existem três maneiras de aplicar a correção. Escolha a que você se sentir mais confortável.

### Opção 1 (Recomendada para a maioria dos usuários): Arquivo de Registro `.reg`

Este é o método mais simples e direto.

1.  **Baixe o arquivo:** Clique [aqui](https://github.com/SEU_USUARIO/SEU_REPOSITORIO/raw/main/ntpbrasil.reg) para baixar o arquivo `ntpbrasil.reg`.
2.  **Execute o arquivo:** Encontre o arquivo na sua pasta de Downloads e dê um duplo-clique nele.
3.  **Confirme as alterações:** O Windows exibirá duas janelas de confirmação.
    *   A primeira é um Aviso de Segurança do Controle de Conta de Usuário (UAC). Clique em **"Sim"**.
    *   A segunda é do Editor de Registro, perguntando se você deseja continuar. Clique em **"Sim"**.
    
4.  **Pronto!** Os servidores já foram adicionados. Para ativar um deles, siga os passos da seção "Como Verificar se Funcionou".

### Opção 2 (Automatizada): Script Batch `.bat`

Este método faz tudo automaticamente: adiciona os servidores, define um como padrão e já força a sincronização do relógio.

1.  **Baixe o arquivo:** Clique [aqui](https://github.com/SEU_USUARIO/SEU_REPOSITORIO/raw/main/fix-ntp-vivo.bat) para baixar o arquivo `fix-ntp-vivo.bat`.
2.  **Execute como Administrador:** Encontre o arquivo na sua pasta de Downloads, clique nele com o **botão direito** e selecione a opção **"Executar como administrador"**.
    
3.  **Siga as instruções:** Uma tela preta de terminal irá se abrir e guiar o processo. Ao final, seu relógio já estará sincronizado.

### Opção 3 (Para Usuários Avançados): Script PowerShell `.ps1`

Esta opção é recomendada para administradores de sistema ou usuários familiarizados com o PowerShell.

1.  **Baixe o arquivo:** Clique [aqui](https://github.com/SEU_USUARIO/SEU_REPOSITORIO/raw/main/fix-ntp-vivo.ps1) para baixar o arquivo `fix-ntp-vivo.ps1`.
2.  **Execute com o PowerShell:** Por padrão, o Windows bloqueia a execução de scripts. A forma mais fácil de executar é:
    *   Encontrar o arquivo na sua pasta de Downloads.
    *   Clicar com o **botão direito** sobre ele.
    *   Selecionar a opção **"Executar com o PowerShell"**.
3.  **Confirme a elevação:** O script pedirá privilégios de administrador. Aceite no prompt do UAC. Ele fará o resto do trabalho automaticamente.

---

## Como Verificar se Funcionou

Você pode confirmar que a configuração foi aplicada de duas formas:

#### Verificação Manual (Interface Gráfica)

1.  Abra o **Painel de Controle**.
2.  Vá para **"Relógio e Região"** > **"Data e Hora"**.
3.  Na aba **"Horário na Internet"**, clique em **"Alterar configurações..."**.
4.  Na lista de servidores, você verá os novos endereços do `ntp.br`. Selecione um e clique em **"Atualizar agora"**.



#### Verificação via Linha de Comando

1. Abra o **Prompt de Comando** ou **PowerShell**.
2. Digite o comando abaixo e pressione Enter:
   ```
   w32tm /query /peers
   ```
3. A saída deve mostrar o servidor do `ntp.br` que está sendo usado para sincronia.

## Detalhes Técnicos

Os scripts e o arquivo `.reg` modificam a seguinte chave do Registro do Windows, que armazena a lista de servidores NTP disponíveis na interface gráfica:

`HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\DateTime\Servers`

Os servidores adicionados são:
- `a.st1.ntp.br`
- `b.st1.ntp.br`
- `c.st1.ntp.br`
- `d.st1.ntp.br`
- `a.ntp.br`
- `b.ntp.br`
- `c.ntp.br`
- `gps.ntp.br`

Os scripts `.bat` e `.ps1` também executam os comandos `net stop/start w32time` e `w32tm /resync` para forçar a aplicação imediata das novas configurações.
