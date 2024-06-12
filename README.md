# Atualização de Servidor de Horário (NTP) do Windows para resolver problemas com a provedora de internet VIVO.

## Sobre
Usuários no Brasil que utilizam o serviço de internet da Vivo frequentemente enfrentam dificuldades com a sincronização dos relógios do sistema com o servidor de tempo padrão do Windows. Esses problemas de sincronização ocorrem sem um padrão definido, em intervalos completamente aleatórios.

A causa principal desses problemas de sincronização são restrições ao tráfego de rede. Enquanto a Vivo permite tráfego para alguns servidores de tempo específicos, outros são bloqueados, afetando a conexão necessária para realizar a sincronização do horário.

Este script atualiza os servidores NTP da máquina para aqueles que são conhecidos por estar autorizados e que não sofrem com as restrições da operadora.

## Instruções
**Importante**: O script terão de ser executados como administrador para funcionar.

1. **Arquivo .bat (CMD)**
    - Baixe `UpdateNTP.bat`
    - Execute o arquivo.
    - Certifique-se de autorizar a execução do script como administrador.

O script atualiza automaticamente as configurações do servidor NTP e sincronizam o relógio do sistema após a mudança.

## Contribuições
Contribuições são bem-vindas! Sinta-se à vontade para fazer fork deste repositório e enviar pull requests com melhorias.
