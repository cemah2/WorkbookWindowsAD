# Attack — La chaîne complète (lab isolé)

> ⚠️ Lab isolé (CORP + GOAD-X) uniquement, voir LEGAL.md. Le capstone orchestre les techniques des
> phases 4-8 en une chaîne réaliste, documentée et rejouable.

## Objectif
D'un compte standard au contrôle du domaine (et au pivot cloud), en **documentant** et **mappant ATT&CK**
chaque étape — puis en prouvant la remédiation.

## Chaîne de référence (exemple)
1. T1087/T1069 — Recon BloodHound (51)
2. T1558.003/.004 — Kerberoasting / AS-REP (52)
3. T1098/T1649 — ACL abuse / Shadow Creds / ESC1 (21/55/43)
4. T1557.001/T1649 — Coercition + relais ESC8 (54/43)
5. T1003.006 — DCSync krbtgt (56)
6. T1558.001 — Golden Ticket (57)
7. T1556/T1550.001 — Pivot hybride (63), (option) T1134.005 cross-forest (58)

## Ancrage réel
Cette chaîne reflète des intrusions réelles (de l'accès initial à la dominance + persistance + cloud).
C'est le scénario que doit savoir reproduire — et détecter/stopper — un expert.

## Résultat attendu
Chaîne complète jouée + journal + matrice ATT&CK → base des rapports et du re-test (`defend.md`).
