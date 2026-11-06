# Drills — DSC

## Drill 1 — Déclaratif vs impératif (10 min)
- **Étapes** : compile une config qui garantit `WindowsFeature` + `Service` ; applique 2x.
- **Observer** : la 2e application ne change rien (idempotence native).
- **Pourquoi** : la différence de paradigme avec un script.

## Drill 2 — Anti-dérive (10 min)
- **Étapes** : casse un réglage à la main, `Test-DscConfiguration` (False), ré-applique (corrigé).
- **Pourquoi** : le cœur de la valeur de DSC.

## Drill 3 — ActiveDirectoryDsc (15 min)
- **Étapes** : avec `ActiveDirectoryDsc`, déclare une OU + un groupe ; applique ; vérifie dans ADUC.
- **Pourquoi** : configurer AD en déclaratif.

## Drill 4 — LCM auto-correct (10 min)
- **Étapes** : passe le LCM en `ApplyAndAutoCorrect`, casse un réglage, attends/force le cycle.
- **Observer** : correction automatique.

## Drill break-fix — MOF incompatible (10 min)
- **Casse** : lance une config utilisant une ressource 5.1 depuis PS7.
- **Diagnostique** : erreur de ressource/édition ; vérifie `$PSVersionTable`.
- **Répare** : exécute en 5.1 (ou WindowsCompatibility), recompile, applique.
