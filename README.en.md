# Time Server (NTP) Update for Windows to fix problems with VIVO internet provider.

## About
Users in Brazil who use Vivo's internet service often face difficulties with synchronizing their system clocks with the standard Windows time server. These synchronization issues occur without a defined pattern, at completely random intervals.

The main cause of these synchronization issues is network traffic restrictions. While Vivo allows traffic to certain specific time servers, others are blocked, affecting the connection needed to synchronize the time.

This script updates the NTP servers on the machine to those that are known to be authorized and not affected by the operator's restrictions.

## Instructions
**Important**: The scripts will request administrator permissions to function.

1. **.bat file (CMD)**
    - Download `UpdateNTP.bat`
    - Run the file.
    - Ensure you authorize the script to run as an administrator.

2. **.ps1 file (Powershell):**
    - Download `UpdateNTP.ps1`
    - Run the file.
    - Ensure you authorize the execution of third-party scripts on your machine.

The scripts automatically update the NTP server settings and synchronize the system clock after the change.

## Contributions
Contributions are welcome! Feel free to fork this repository and send pull requests with improvements.

## Language
Esse readme está disponível em Português (BR) também. [Clique aqui para acessar.](README.md).
