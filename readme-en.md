[Leia isto em Português](README.md)

# NTP Time Sync Fix for Vivo's Network in Brazil

This repository provides a solution for a recurring issue where Windows computers connected to the Vivo ISP network in Brazil fail to synchronize their clocks with Microsoft's default time servers (`time.windows.com`).

## The Problem

Vivo's network appears to have a block or instability that prevents communication with international Network Time Protocol (NTP) servers. This can lead to errors in:
- Website security certificates (SSL/TLS errors).
- Authentication for online services and games.
- Software that relies on an accurate system time.

## The Solution

The solution is to configure Windows to use Brazil's official public time servers, maintained by the **NTP.br** project. These servers are highly accurate, located within Brazil, and are not affected by the ISP's network policies.

---

## How to Apply the Fix

There are three ways to apply this fix. Choose the one you are most comfortable with.

### Option 1 (Recommended for most users): Registry File `.reg`

This is the simplest and most direct method.

1.  **Download the file:** Click [here](https://github.com/SEU_USUARIO/SEU_REPOSITORIO/raw/main/ntpbrasil.reg) to download the `ntpbrasil.reg` file. (Remember to update the link!)
2.  **Run the file:** Locate the file in your Downloads folder and double-click it.
3.  **Confirm the changes:** Windows will display two confirmation prompts.
    *   The first is a User Account Control (UAC) security warning. Click **"Yes"**.
    *   The second is from the Registry Editor, asking if you want to continue. Click **"Yes"**.
    
4.  **Done!** The servers have been added. To activate one, follow the steps in the "How to Verify" section below.

### Option 2 (Automated): Batch Script `.bat`

This method does everything automatically: it adds the servers, sets one as default, and forces the clock to sync immediately.

1.  **Download the file:** Click [here](https://github.com/SEU_USUARIO/SEU_REPOSITORIO/raw/main/fix-ntp-vivo.bat) to download the `fix-ntp-vivo.bat` file.
2.  **Run as Administrator:** Find the file in your Downloads folder, **right-click** it, and select **"Run as administrator"**.
    
3.  **Follow the instructions:** A black terminal window will open and guide you through the process. By the end, your clock will be synchronized. The script will display messages in English if your OS is not set to Brazilian Portuguese.

### Option 3 (For Advanced Users): PowerShell Script `.ps1`

This option is recommended for system administrators or users familiar with PowerShell.

1.  **Download the file:** Click [here](https://github.com/SEU_USUARIO/SEU_REPOSITORIO/raw/main/fix-ntp-vivo.ps1) to download the `fix-ntp-vivo.ps1` file.
2.  **Run with PowerShell:** By default, Windows blocks script execution. The easiest way to run it is:
    *   Find the file in your Downloads folder.
    *   **Right-click** on it.
    *   Select the **"Run with PowerShell"** option.
3.  **Confirm elevation:** The script will request administrative privileges. Accept the UAC prompt. It will handle the rest automatically. The script will display messages in English if your OS is not set to Brazilian Portuguese.

---

## How to Verify It Worked

You can confirm that the new configuration has been applied in two ways:

#### Manual Check (Graphical Interface)

1.  Open the **Control Panel**.
2.  Go to **"Clock and Region"** > **"Date and Time"**.
3.  On the **"Internet Time"** tab, click **"Change settings..."**.
4.  In the server dropdown list, you will now see the new `ntp.br` addresses. Select one and click **"Update now"**.

#### Command Line Check

1.  Open **Command Prompt** or **PowerShell**.
2.  Type the command below and press Enter:
   ```
   w32tm /query /peers
   ```
3.  The output should list the `ntp.br` server being used for synchronization.

## Technical Details

The scripts and `.reg` file modify the following Windows Registry key, which stores the list of NTP servers available in the graphical interface:

`HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\DateTime\Servers`

The added servers are:
- `a.st1.ntp.br`
- `b.st1.ntp.br`
- `c.st1.ntp.br`
- `d.st1.ntp.br`
- `a.ntp.br`
- `b.ntp.br`
- `c.ntp.br`
- `gps.ntp.br`

The `.bat` and `.ps1` scripts also execute the `net stop/start w32time` and `w32tm /resync` commands to immediately apply the new settings.
