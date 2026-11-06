# Attack — Rogue DHCP & starvation

> ⚠️ Lab isolé uniquement (voir LEGAL.md).

## Techniques
- **MITRE ATT&CK** : T1557 (Adversary-in-the-Middle), T1498 (Network DoS).
- **Outils** : scripts de starvation, faux serveur DHCP (lab réseau).

## Déroulé
1. **Starvation** : inonder le serveur de DISCOVER avec des MAC aléatoires pour épuiser le pool.
2. **Rogue DHCP** : lancer un serveur DHCP pirate qui répond plus vite, distribuant une
   **passerelle/DNS contrôlés** → interception du trafic.

## Ancrage réel
Le rogue DHCP est une technique MITM classique en réseau interne (souvent couplée à Responder
pour la suite). La starvation sert de préparation (forcer les clients vers le rogue).

## Résultat attendu
Comprendre pourquoi un réseau plat sans protection DHCP est vulnérable — fermé par `defend.md`.
