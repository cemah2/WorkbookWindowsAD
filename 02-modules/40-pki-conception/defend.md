# Defend — Principes défensifs dès la conception

## Durcissement (par conception)
1. **Root CA hors-ligne & standalone** ; Issuing CA = **Tier 0**, PAW, HSM si possible.
2. **Durées raisonnables** + **révocation fonctionnelle** (CDP/AIA joignables, CRL/OCSP).
3. **Mapping fort** des certificats (KB5014754 : OID de mapping fort, StrongCertificateBindingEnforcement).
4. **NTAuthCertificates** strictement contrôlé (seules les CA légitimes).
5. **Séparation des rôles** AD CS ; moindre privilège sur templates et CA (préparé modules 42-43).
6. **Journalisation** de l'émission dès le départ.

## Détection (préparer)
Activer l'audit AD CS (émission, changements de template/CA) dès le déploiement (module 41) pour
alimenter la détection des ESC (module 43).

### Contrôle de conception (checklist, pas une règle de log)
```text
[ ] Root hors-ligne   [ ] Issuing Tier 0   [ ] CDP/AIA HTTP joignables
[ ] Mapping fort activé   [ ] NTAuth maîtrisé   [ ] Audit AD CS prévu
```

## Preuve (purple team)
La validation réelle se fait aux modules 42-43 (templates/ESC) : ici, on vérifie que la conception
coche les cases ci-dessus avant tout déploiement.

## Rejouer contre CORP durci
Une PKI conçue selon ces principes réduit d'emblée la surface ESC (module 43).
