# 🧩 Carte de dépendances

Quel module avant quel autre. On ne saute pas une dépendance : un module d'attaque suppose
que le service correspondant a d'abord été **compris** et **construit** dans CORP.

```mermaid
graph LR
    P0[P0 Socle] --> P1[P1 Fondations AD]
    P1 --> P2[P2 Administration]
    P2 --> P3[P3 Automatisation]
    P1 --> P4[P4 PKI/AD CS]
    P2 --> P4
    P2 --> P5[P5 Offensif on-prem]
    P4 --> P5
    P2 --> P6[P6 Hybride/Entra]
    P5 --> P6
    P5 --> P7[P7 Blue team]
    P6 --> P7
    P1 --> P8[P8 Internals]
    P5 --> P8
    P7 --> P9[P9 Capstone]
    P6 --> P9
    P8 --> P9
```

## Règles

- **P0 → P1** : rien ne commence sans le socle (réseau isolé + Ludus + templates).
- **Comprendre/Construire avant Attaquer** : un module `attack.md` n'est abordé qu'après la
  `fiche.md` + `build.md` du même sujet.
- **P5 avant P7** : on apprend à détecter ce qu'on a d'abord su exécuter.
- **P4 (PKI propre) avant P4-ESC (attaques ADCS)** : comprendre la PKI avant de l'attaquer.
- **P9** réutilise tout : il se fait en dernier.
