<#
.SYNOPSIS  Audit de la protection des credentials (WDigest, RunAsPPL, Credential Guard). Lecture seule.
#>
[CmdletBinding()] param()
$wd = (Get-ItemProperty "HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\WDigest" -Name UseLogonCredential -ErrorAction SilentlyContinue).UseLogonCredential
$ppl = (Get-ItemProperty "HKLM:\SYSTEM\CurrentControlSet\Control\Lsa" -Name RunAsPPL -ErrorAction SilentlyContinue).RunAsPPL
$cg = Get-CimInstance Win32_DeviceGuard -Namespace root\Microsoft\Windows\DeviceGuard -ErrorAction SilentlyContinue
[pscustomobject]@{
  WDigestClearText = if ($wd -eq 1) {"ACTIVÉ (RISQUE)"} else {"off (ok)"}
  RunAsPPL         = if ($ppl -eq 1) {"ok (LSASS en PPL)"} else {"NON (à activer)"}
  CredGuardRunning = ($cg.SecurityServicesRunning -contains 1)
} | Format-List
