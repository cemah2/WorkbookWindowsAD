# Attack — Rejeu contrôlé (Atomic / Caldera)

> ⚠️ Lab isolé uniquement (voir LEGAL.md). Le rejeu sert à valider la détection, pas à compromettre.

## Techniques
- Couvre l'ensemble ATT&CK rejouable (phases 4-6). Outils : **Atomic Red Team**, **Caldera**, scripts
  du workbook.

## Démarche
1. Sélectionner les techniques prioritaires (impact/prévalence).
2. Rejouer de façon **atomique** (une technique) puis en **chaîne** (Caldera) pour tester la corrélation.
3. Toujours **nettoyer** (cleanup) ; rejouer après chaque changement (régression).

## Avantages du rejeu contrôlé
- Répétable, documenté, réversible (vs attaque libre).
- Mesure objective de la détection (vs supposition).

## Ancrage réel
Le purple teaming est une pratique SOC standard pour valider en continu la détection face à des TTP
réels (threat-informed defense).

## Résultat attendu
Chaque technique rejouée a un verdict de détection → matrice de couverture à jour (`defend.md`).
