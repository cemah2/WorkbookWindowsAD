# Automate — Sysmon
`Install-Sysmon.ps1` : installe/ met à jour Sysmon avec une config fournie (idempotent). La config XML
n'est pas fournie ici (utiliser SwiftOnSecurity / Olaf Hartong, référencés) — la déposer à côté.
## Usage
```powershell
.\Install-Sysmon.ps1 -SysmonExe .\Sysmon64.exe -ConfigXml .\sysmonconfig.xml
```
