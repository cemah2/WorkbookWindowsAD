# Automate — NTLM (audit/réduction)
`Get-NtlmUsage.ps1` extrait l'usage NTLM récent (journal Operational) pour inventorier ce qui
devra migrer vers Kerberos avant une restriction. Lecture seule.
## Usage
```powershell
.\Get-NtlmUsage.ps1 -MaxEvents 200 -OutFile ".\ntlm-usage.csv"
```
