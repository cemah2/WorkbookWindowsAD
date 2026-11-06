<#
.SYNOPSIS  Configuration DSC d'exemple : garantit un rôle, un service et un réglage registre.
           Idempotente par conception. Lab (PowerShell 5.1 recommandé pour les ressources AD).
#>
Configuration BaseServer {
  Import-DscResource -ModuleName PSDesiredStateConfiguration
  Node "localhost" {
    WindowsFeature DNS {
      Name   = "DNS"
      Ensure = "Present"
    }
    Service DnsRunning {
      Name      = "DNS"
      State     = "Running"
      DependsOn = "[WindowsFeature]DNS"
    }
    Registry Banner {
      Key       = "HKLM:\Software\Microsoft\Windows\CurrentVersion\Policies\System"
      ValueName = "legalnoticecaption"
      ValueData = "Acces reserve"
      ValueType = "String"
      Ensure    = "Present"
    }
  }
}
# Pour compiler : BaseServer -OutputPath .\mof
