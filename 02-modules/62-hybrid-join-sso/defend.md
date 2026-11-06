# Defend — Protéger la jonction et le PRT

## Durcissement
1. **TPM obligatoire** (PRT lié au matériel) ; **Credential Guard** sur les postes.
2. **Conditional Access** (module 64) : exiger appareil **conforme**/joint, bloquer les contextes à
   risque, **token protection** (lier le token à l'appareil) quand disponible.
3. **Device compliance (Intune)** ; révocation rapide des appareils/sessions compromis.
4. **Limiter l'admin local** sur les postes (le vol de PRT exige souvent l'admin local) → LAPS/tiering.
5. Bloquer/surveiller les flux **device code** non attendus.

## Détection
| Source | Signal |
|---|---|
| Entra Sign-in logs | usage de token/PRT depuis un nouvel appareil/emplacement, device code |
| Identity Protection | connexions à risque, anomalies |
| Endpoint/EDR | accès à LSASS/CloudAP (extraction PRT) |

### Règle (conceptuelle, KQL — sign-in)
```kusto
SigninLogs
| where AuthenticationProtocol == "deviceCode"
| where ResultType == 0
// corréler avec utilisateurs/apps inattendus
```

## Preuve de détection (purple team)
Rejoue un device code flow (lab) et un Pass-the-PRT (si TPM absent), vérifie les sign-in logs et
Identity Protection. Teste une politique CA exigeant un appareil conforme.

## Rejouer contre CORP durci
Avec TPM + CA (device compliant + token protection) + admin local restreint : Pass-the-PRT et device
code phishing deviennent beaucoup plus difficiles et détectés.
