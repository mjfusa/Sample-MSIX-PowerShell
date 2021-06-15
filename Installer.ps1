## Close app if running and populate registry.

##--Closes selected program if open--##
$Contoso = Get-Process -ProcessName CSAMMAN.exe -ErrorAction SilentlyContinue
if ($Contoso)
{
    # try gracefully first
    $Contoso.CloseMainWindow()
    # kill after five seconds
    Sleep 5
    if (!$Contoso.HasExited)
    {
        $Contoso | Stop-Process -Force
   }
}
##--Gets current user--##
$currentuser = ($(Get-WmiObject -Class Win32_ComputerSystem | Select-Object username).username -split "\\")[1]

#Copies in and merges the raw registry key for login information
Start-Process -FilePath "reg" -ArgumentList "IMPORT CSAM.reg" -WorkingDirectory . -WindowStyle Hidden -Wait 
Set-Itemproperty -path 'HKCU:\Software\Contoso\Manager\11.0\Link' -Name 'ServerName' -value rms.contoso.org -force 
Set-Itemproperty -path 'HKCU:\Software\Contoso\Manager\11.0\Link' -Name 'UserName' -value $CurrentUser -force
Set-Itemproperty -path 'HKCU:\Software\Contoso\Manager\11.0\Automation' -Name 'Logfile' -value "C:\Users\$CurrentUser\AppData\Roaming\Contoso\CSAM Manager V11\cvs.log" -force
Set-Itemproperty -path 'HKCU:\Software\Contoso\Manager\11.0\Logging\Error Logger' -Name 'Path' -value "C:\Users\$CurrentUser\AppData\Roaming\Contoso\CSAM Manager V11\Logs" -force
Set-Itemproperty -path 'HKCU:\Software\Contoso\Manager\11.0\Logging\Trace Logger' -Name 'Path' -value "C:\Users\$CurrentUser\AppData\Roaming\Contoso\CSAM Manager V11\Logs" -force
Set-Itemproperty -path 'HKCU:\Software\Contoso\Manager\11.0\Control' -Name 'UserRoot' -value "C:\Users\$CurrentUser\AppData\Roaming\Contoso\CSAM Manager V11" -force
Set-Itemproperty -path 'HKCU:\Software\Contoso\Manager\11.0\Repositories' -Name 'PCCache' -value "C:\Users\$CurrentUser\AppData\Roaming\Contoso\CSAM Manager V11\Cache" -force
Set-Itemproperty -path 'HKCU:\Software\Contoso\Manager\11.0\Repositories' -Name 'PCCOWCustReport' -value "C:\Users\$CurrentUser\AppData\Roaming\Contoso\CSAM Manager V11" -force
Set-Itemproperty -path 'HKCU:\Software\Contoso\Manager\11.0\Repositories' -Name 'PCCustError' -value "C:\Users\$CurrentUser\AppData\Roaming\Contoso\CSAM Manager V11\Logs" -force
Set-Itemproperty -path 'HKCU:\Software\Contoso\Manager\11.0\Repositories' -Name 'PCLog' -value "C:\Users\$CurrentUser\AppData\Roaming\Contoso\CSAM Manager V11\Logs" -force
Set-Itemproperty -path 'HKCU:\Software\Contoso\Manager\11.0\Repositories' -Name 'PCLogs' -value "C:\Users\$CurrentUser\AppData\Roaming\Contoso\CSAM Manager V11\Logs" -force
Set-Itemproperty -path 'HKCU:\Software\Contoso\Manager\11.0\Repositories' -Name 'PCServError' -value "C:\Users\$CurrentUser\AppData\Roaming\Contoso\CSAM Manager V11\Logs" -force
Set-Itemproperty -path 'HKCU:\Software\Contoso\Manager\11.0\Repositories' -Name 'PCStdReport' -value "C:\Users\$CurrentUser\AppData\Roaming\Contoso\CSAM Manager V11" -force
Set-Itemproperty -path 'HKCU:\Software\Contoso\Manager\11.0\Repositories' -Name 'PCTemp' -value "C:\Users\$CurrentUser\AppData\Roaming\Contoso\CSAM Manager V11\Temp" -force
Set-Itemproperty -path 'HKCU:\Software\Contoso\Manager\11.0\Repositories' -Name 'PCUser' -value "C:\Users\$CurrentUser\AppData\Roaming\Contoso\CSAM Manager V11" -force



