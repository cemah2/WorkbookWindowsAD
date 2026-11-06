# Automate — DHCP
`Set-DhcpBaseline.ps1` installe, autorise et configure une étendue de façon idempotente.
En Phase 3, intégré via Ansible (community.windows) / DSC.
## Usage
```powershell
.\Set-DhcpBaseline.ps1 -ServerFqdn "par-dc-01.corp.meridian.com" -ServerIp "10.10.0.10" `
  -ScopeId "10.10.10.0" -Start "10.10.10.100" -End "10.10.10.200" -Mask "255.255.0.0" `
  -Router "10.10.0.1" -Dns "10.10.0.10" -DnsDomain "corp.meridian.com"
```
