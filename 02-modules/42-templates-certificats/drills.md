# Drills — Templates de certificats

## Drill 1 — Lire les paramètres d'un template (10 min)
- **Étapes** : `Get-CertificateTemplate` (PSPKI) ; repère EKU, ESS, permissions.
- **Pourquoi** : savoir "lire" un template comme un auditeur.

## Drill 2 — Fabriquer (volontairement) un template ESC1 puis le réparer (15 min)
- **Étapes** : en lab, crée un template avec ESS + Client Auth + Enroll "Authenticated Users".
  Observe qu'il est vulnérable (Certipy `find -vulnerable`). Puis corrige (Build from AD).
- **Pourquoi** : comprendre ESC1 par construction/réparation. (Lab isolé uniquement !)

## Drill 3 — Enrôler un certificat (10 min)
- **Étapes** : demande un cert depuis un template sûr, vérifie-le (`certutil -store My`).
- **Pourquoi** : le flux d'enrôlement normal.

## Drill 4 — Auto-enrollment (10 min)
- **Étapes** : active l'auto-enroll par GPO pour un groupe, force `gpupdate`, vérifie l'émission auto.
- **Pourquoi** : déploiement à l'échelle maîtrisé.

## Drill break-fix — Enrôlement refusé (10 min)
- **Casse** : retire le droit Enroll du groupe sur un template.
- **Diagnostique** : la demande échoue (access denied) ; vérifie l'ACL du template.
- **Répare** : rends Enroll au groupe, re-teste.
