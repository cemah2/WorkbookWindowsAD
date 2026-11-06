<#
.SYNOPSIS  Durcit la protection des credentials : WDigest off + RunAsPPL. Lab (tester avant prod).
.NOTES     Credential Guard s'active via GPO/Device Guard (VBS) et nécessite un redémarrage.
#>
[CmdletBinding(SupportsShouldProcess)] param()
if ($PSCmdlet.ShouldProcess("LSASS","Durcir (WDigest off, RunAsPPL)")) {
  New-ItemProperty "HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\WDigest" -Name UseLogonCredential -Value 0 -PropertyType DWord -Force | Out-Null
  New-ItemProperty "HKLM:\SYSTEM\CurrentControlSet\Control\Lsa" -Name RunAsPPL -Value 1 -PropertyType DWord -Force | Out-Null
  Write-Host "WDigest off + RunAsPPL posés. Redémarrer. Activer Credential Guard via GPO (VBS)." -ForegroundColor Green
}
