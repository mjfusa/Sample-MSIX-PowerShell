## Sample: MSIX / PowerShell Script / Registry Init

Included in this sample is an MSIX that creates installs a console Hello World app and updates registry keys with a PowerShell script. It first creates registry keys by importing a .REG file - also in the script.

The file [StartingScriptWrapper.PS1](https://docs.microsoft.com/en-us/windows/msix/psf/run-scripts-with-package-support-framework) must also be included in the same folder as the script. This runs some prerequisites required to run the target script.

When you install the sample MSIX, it will run your script. Be sure to install the certificate first. See the instructions at the bottom of this file. To verify that the registry key were created, you must run regedit in the context of the MSIX package. You can do this with the following (run as admin) PowerShell command:

```PowerShell
Invoke-CommandInDesktopPackage -PackageFamilyName "ConsoleAppSample_n3sawgb4qe5x4" -AppId "App" -Command "regedt32.exe" -PreventBreakaway
```

Here is the basic layout for the Package Support Framework files needed to run scripts. I left out other files.

```bash
├── AppName
│   ├── AppName.exe
│   ├── Install.ps1
│   └── StartingScriptWrapper.ps1
├── PsfLauncher32.exe
├── PsfLauncher64.exe
├── PsfRunDll32.exe
├── PsfRunDll64.exe
└── config.json
```

Note: The files necessary for PSF are in the root.

Note 2: Both 32 and 64 bit [PSF binaries](https://github.com/Microsoft/MSIX-PackageSupportFramework/#get-the-pre-built-package-support-framework-binaries) required even though the machine you’re installing on is one or the other.

Here is the config.json:

```json
{
  "applications": [
    {
      "id": "App",
      "executable": "ConsoleApp2/ConsoleApp2.exe",
      "workingDirectory": "ConsoleApp2/",
      "stopOnScriptError": false,
      "startScript": {
        "scriptPath": "Installer.ps1",
        "runInVirtualEnvironment": true,
        "showWindow": true,
        "waitForScriptToFinish": true,
        "runOnce": true
      }
    }
  ]
}
```
Also include is a sample config.json showing how to setup [PSF Tracing](https://docs.microsoft.com/en-us/windows/msix/psf/package-support-framework#use-the-trace-fixup). See config-trace.json.

Here are the steps for installing the certificate the that sample MSIX is signed with:

1. Right-click on the **.msix** package and select **properties**.

2. Under the **Digital Signatures** tab you should see the test certificate. Click to select the certificate and click on **Details** button.

3. Select the button **View Certificate**.

4. Select the button **Install Certificate**.

5. From the **Store Location** radio buttons select **Local Machine**. Click the **Next** button.

6. Click **Yes** on the admin prompt for changes to your device.

7. On the **Certificate Import Wizard** chose the radio button **Place all certificates in the following store** then select the Browse button.

8. Select the **Trusted People** certificate store. Then click the OK button.

9. Click the **Next** button on the **Certificate Import Wizard** window.

10. Click **Finish** button to complete the certificate install.

11. You can now close all windows and double click on the .msixbundle or .msix file to install the application.
