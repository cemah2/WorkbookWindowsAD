# Drills — GPO

## Drill 1 — Ordre LSDOU (10 min)
- **Étapes** : crée 2 GPO qui règlent le même paramètre (ex. fond d'écran), lie l'une au domaine,
  l'autre à une OU ; observe laquelle gagne.
- **Observer** : la GPO la plus proche (OU) l'emporte.
- **Pourquoi** : comprendre la résolution de conflits.

## Drill 2 — Enforced vs Block Inheritance (10 min)
- **Étapes** : bloque l'héritage sur une OU, puis marque la GPO parente "Enforced".
- **Observer** : Enforced passe outre le blocage.
- **Pourquoi** : maîtriser les exceptions d'héritage.

## Drill 3 — Filtrage par groupe (10 min)
- **Étapes** : applique une GPO à un seul groupe via le filtrage de sécurité ; teste avec un
  membre et un non-membre.
- **Pourquoi** : cibler finement sans multiplier les OU.

## Drill 4 — Lire un RSoP (10 min)
- **Étapes** : `gpresult /h rsop.html` sur un client ; identifie quelle GPO a posé quel paramètre.
- **Pourquoi** : diagnostiquer "pourquoi ce réglage s'applique".

## Drill break-fix — GPO qui ne s'applique pas (10 min)
- **Casse** : retire "Authenticated Users" (Read+Apply) d'une GPO sans rien remettre.
- **Diagnostique** : `gpresult` montre la GPO "Denied (Inaccessible/Security)".
- **Répare** : rends le Read aux cibles, `gpupdate /force`, re-vérifie.
