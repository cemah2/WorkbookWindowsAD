# Drills — Persistance

## Drill 1 — Golden Ticket (15 min)
- **Étapes** : forge un TGT avec le hash krbtgt, accède au DC.
- **Observer** : accès « légitime » via un ticket forgé.
- **Pourquoi** : comprendre la puissance du krbtgt.

## Drill 2 — Éradication krbtgt x2 (15 min)
- **Étapes** : rote krbtgt 2x (avec délai), re-teste le Golden Ticket.
- **Observer** : le ticket forgé ne marche plus.
- **Pourquoi** : la bonne procédure d'éradication.

## Drill 3 — Silver vs Golden (10 min)
- **Étapes** : forge un Silver Ticket ciblé, compare la portée/furtivité avec le Golden.
- **Pourquoi** : comprendre les compromis.

## Drill 4 — AdminSDHolder (10 min)
- **Étapes** : pose puis retire une ACE sur AdminSDHolder, observe SDProp.
- **Pourquoi** : persistance par ACL (et son nettoyage).

## Drill break-fix — Golden persiste après 1 rotation (10 min)
- **Casse** : rote krbtgt une seule fois.
- **Diagnostique** : l'ancien Golden peut encore fonctionner.
- **Répare** : 2e rotation (après réplication) ; re-teste.
