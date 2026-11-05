# ⚖️ LEGAL.md — Cadre d'isolation & d'éthique

Ce dépôt sert **exclusivement** à l'apprentissage défensif et offensif **dans un lab privé**.

## Règles non négociables

1. **GOAD-X est volontairement vulnérable.** Il n'est **jamais** exposé à Internet ni à un
   réseau de production. Isolation réseau obligatoire (VLAN dédié + OPNsense, voir
   `01-labs/corp/architecture.md` §12).
2. **Les techniques offensives** ne sont appliquées **que** contre les machines de ce lab,
   que tu possèdes et contrôles. Jamais contre un système tiers sans autorisation écrite.
3. **Aucun secret réel** dans le dépôt : pas de mots de passe, clés, dumps, `.tfvars`,
   configs WireGuard, bases NTDS (voir `.gitignore`). Coffre KeePass local, hors Git.
4. **Aucun contenu sous droit d'auteur** (PDF de livres) dans le dépôt.
5. **Licences Windows** : les VM d'évaluation (180 j) sont réinitialisées/reconstruites via
   IaC ; ne pas détourner de licence.

## Avertissement

L'usage de ces connaissances en dehors d'un environnement autorisé peut être **illégal**.
L'auteur assume la responsabilité de n'utiliser ce matériel que dans un cadre légal et isolé.
