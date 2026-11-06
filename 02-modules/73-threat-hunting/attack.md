# Attack — Ce que le hunt cherche (perspective rouge)

> ⚠️ Lab isolé. Le hunting suppose qu'une attaque a eu lieu : on rejoue la phase 5 pour fournir la
> matière à chasser.

## Principe
Le hunter part de TTP d'attaquant (ATT&CK) et cherche leurs traces. Pour s'entraîner, on **rejoue**
des attaques (modules 52-58) puis on les **retrouve** par le hunt — y compris des variantes furtives
que les règles naïves ratent.

## Variantes furtives à chasser
- **AES Kerberoasting** (pas de RC4) : la règle 0x17 ne matche pas → hunt par volume/comptes de service.
- **Dump LSASS discret** (handle minimal) : affiner Sysmon 10.
- **Living-off-the-land** : LOLBins légitimes détournés → rareté/contexte.

## Ancrage réel
Les attaquants évolués minimisent leur empreinte ; le hunting humain reste nécessaire là où les règles
échouent. The DFIR Report illustre régulièrement des chaînes retrouvées par hunting.

## Résultat attendu
Des trouvailles → de nouvelles règles (module 72) → couverture ATT&CK améliorée (`defend.md`).
