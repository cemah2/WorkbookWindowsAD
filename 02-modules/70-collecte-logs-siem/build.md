# Build — Déployer un SIEM et centraliser les logs (lab)

> On met en place la collecte (DC + endpoints + Sysmon) vers un SIEM (ex. Wazuh ou Elastic).

## Pré-requis
- Une VM SIEM (Wazuh/Elastic) dans le lab de supervision. Audit policy activée (GPO, module 20).

## Étape 1 — Activer les bonnes audit policies (GPO)
Baseline d'audit (Advanced Audit Policy) : Account Logon, Logon/Logoff, **Directory Service Access**
(5136/4662), **Kerberos** (4768/4769/4771), Process Creation (4688 + ligne de commande), Object Access
(fichiers sensibles). (Voir modules 16, 20, 21.)

## Étape 2 — Déployer le SIEM (exemple Wazuh)
```bash
# Serveur Wazuh (all-in-one) — lab
curl -sO https://packages.wazuh.com/4.x/wazuh-install.sh && sudo bash ./wazuh-install.sh -a
# -> interface + indexer + manager
```
(ou Elastic : déployer Elasticsearch + Kibana + Fleet, puis Elastic Agent.)

## Étape 3 — Enrôler les endpoints/DC
```bash
# Agent Wazuh sur un DC/serveur Windows (installer le MSI + pointer le manager)
# ou WEF natif : configurer un collecteur + abonnements (wecutil), source-initiated
```

## Étape 4 — Ingestion de Sysmon (module 71)
Faire remonter le canal `Microsoft-Windows-Sysmon/Operational` via l'agent/WEF.

## Étape 5 — Vérifier l'ingestion
```bash
# Côté SIEM : rechercher des 4624/4688/Sysmon récents venant du DC
# Générer un événement test (une ouverture de session) et le retrouver dans le SIEM
```

## Étape 6 — Alerter sur l'effacement de logs
Créer une alerte sur **1102** (Security log cleared) — signal fort de compromission.

## Vérification
- Les événements des DC/endpoints + Sysmon arrivent dans le SIEM, cherchables, avec une alerte sur 1102.

## Pièges courants
- Audit policy **non activée** → les événements n'existent pas (rien à collecter).
- Pas de forward immédiat → l'attaquant efface avant collecte.
- SIEM sous-dimensionné (4662/4769 = gros volumes).
