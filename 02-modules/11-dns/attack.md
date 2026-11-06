# Attack — Abus du DNS (reconnaissance & manipulation)

> ⚠️ Lab isolé uniquement (voir LEGAL.md). Ici : reconnaissance via DNS et principe des mises
> à jour dynamiques non sécurisées. L'exploitation avancée (DnsAdmins RCE, ADIDNS) est en Phase 5.

## Contexte / pré-requis
- Poste attaquant sur un réseau pouvant joindre le DNS du DC (lab).

## Techniques
- **MITRE ATT&CK** : T1590.002 (DNS), T1018 (Remote System Discovery), T1071.004 (DNS).
- **Outils** : `dig`, `nslookup`, `nmap`, (ADIDNS : outillage Phase 5).

## Déroulé
1. **Transfert de zone** (si mal configuré) :
   ```bash
   dig AXFR corp.meridian.com @10.10.0.10
   ```
   Succès = toute la cartographie interne (hôtes, services) divulguée.
2. **Localisation de DC via SRV** (toujours possible, par conception) :
   ```bash
   dig SRV _ldap._tcp.dc._msdcs.corp.meridian.com @10.10.0.10
   ```
3. **Mises à jour dynamiques non sécurisées** : si activées, création/écrasement d'un
   enregistrement (ex. un nom de service convoité) pour détourner le trafic.

## Ancrage réel
L'usurpation via ADIDNS / mises à jour dynamiques et le détournement de noms (type `wpad`) sont
des techniques documentées de mouvement latéral. Le transfert de zone ouvert reste une
divulgation fréquente en audit.

## Résultat attendu
Comprendre ce que le DNS laisse fuiter et comment une écriture non contrôlée détourne du trafic
— pour le fermer dans `defend.md`.
