# Build — Monter un terrain d'entraînement ESC (dans GOAD-X / lab isolé)

> ⚠️ On crée volontairement des configurations vulnérables **uniquement dans le lab offensif isolé**
> (jamais dans CORP de prod). But : s'entraîner à détecter/exploiter/réparer. Voir LEGAL.md.

## Pré-requis
- Une PKI de lab (modules 41-42) dans l'environnement **isolé** (GOAD-X ou copie jetable de CORP).
- Attaquant Linux avec Certipy (`pipx install certipy-ad`).

## Étape 1 — Fabriquer des templates vulnérables (lab only)
- **ESC1** : template avec *Supply in request* (ESS) + EKU *Client Authentication* + Enroll pour
  "Authenticated Users".
- **ESC2** : template avec EKU *Any Purpose*.
- **ESC4** : donner *Write* sur un template à un utilisateur standard.
Publier ces templates sur l'Issuing CA.

## Étape 2 — (ESC8) Laisser Web Enrollment en HTTP
Installer `ADCS-Web-Enrollment` et laisser l'endpoint `http://CA/certsrv/` sans EPA (lab).

## Étape 3 — (ESC6) Activer le flag dangereux sur la CA (lab)
```powershell
certutil -setreg policy\EditFlags +EDITF_ATTRIBUTESUBJECTALTNAME2
Restart-Service certsvc
```

## Étape 4 — Énumérer avec Certipy (confirme la cible)
```bash
certipy find -u user@corp.meridian.com -p '***' -dc-ip <dc> -vulnerable -stdout
```

## Étape 5 — Réparer (c'est l'objectif pédagogique)
Pour chaque ESC fabriqué, appliquer le durcissement de `defend.md`, puis re-`certipy find` et
constater qu'il n'est plus listé comme vulnérable.

## Vérification
```bash
certipy find ... -vulnerable    # avant : listé ; après durcissement : vide
```

## Pièges courants
- Faire ces manips hors du lab isolé (interdit).
- Oublier de réparer après l'exercice (laisser une PKI vulnérable).
