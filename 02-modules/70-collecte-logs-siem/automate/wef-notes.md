# Windows Event Forwarding (WEF) — rappels (lab)

## Collecteur
wecutil qc                       # activer le service de collecte
# Créer des abonnements (source-initiated) ciblant Security/Sysmon/PowerShell

## Sources (GPO)
# Computer Config > Policies > Admin Templates > Windows Components > Event Forwarding
#   -> "Configure target Subscription Manager" = Server=http://collector:5985/wsman/SubscriptionManager/WEC

## Canaux clés à forwarder
# Security ; Microsoft-Windows-Sysmon/Operational ; Microsoft-Windows-PowerShell/Operational ; DNS Server
