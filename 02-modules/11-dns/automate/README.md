# Automate — DNS

`Set-DnsBaseline.ps1` reproduit la configuration de `build.md` (zone inverse, forwarder,
mises à jour sécurisées, scavenging) de façon idempotente. En Phase 3, ce rôle sera intégré à
DSC/Ansible (module xDnsServer / collection ansible community.windows).

## Usage
```powershell
.\Set-DnsBaseline.ps1 -Zone "corp.meridian.com" -ReverseNetworkId "10.10.0.0/16" `
                      -Forwarder "10.10.0.1"
```
