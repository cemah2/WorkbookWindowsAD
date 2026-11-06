# Build — Évaluer et exploiter un EDR (lab), côté défense

## Pré-requis
- Un EDR de lab (Defender for Endpoint en essai, Elastic Defend via Ludus, ou équivalent open-source).

## Étape 1 — Cartographier les capteurs
- Identifier ce que l'EDR collecte (process, réseau, fichiers, registre, mémoire) et s'il a des
  capteurs **kernel/ETW-TI** (plus robustes) ou surtout des hooks user-mode.

## Étape 2 — Activer la protection de l'agent
- **Tamper protection** activée ; alertes sur l'arrêt/désinstallation de l'agent ; mode bloquant.

## Étape 3 — Tester la détection comportementale
Rejouer (module 74, Atomic) des chaînes réalistes :
- Office→PowerShell→LSASS (Sysmon 10 + EDR), Kerberoasting, DCSync, etc.
Vérifier que l'EDR **détecte** et/ou **répond**.

## Étape 4 — Tester les angles morts (compréhension)
- Comprendre qu'un **unhooking**/syscall direct contourne les hooks user-mode → vérifier si le capteur
  **kernel/ETW-TI** rattrape. (On ne fournit pas l'outil ; on mesure la couverture.)

## Étape 5 — Combiner les sources
- S'assurer que EDR + Sysmon + SIEM se recoupent : une évasion d'une couche doit laisser une trace
  dans une autre.

## Étape 6 — Réponse
- Tester une action de réponse (isolation d'un hôte, kill de process) dans le lab.

## Vérification
- Pour un ensemble de techniques (module 74), savoir dire : détecté par quoi (EDR kernel / user / Sysmon
  / SIEM), bloqué ou non, et quels angles morts subsistent.

## Pièges courants
- Se reposer sur un seul capteur (user-mode) contournable.
- Tamper protection désactivée → l'attaquant tue l'EDR.
- Ne pas tester en continu (les évasions évoluent).
