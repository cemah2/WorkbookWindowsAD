# 📖 Glossaire AD / Windows / Sécurité

Vocabulaire de base, enrichi au fil des modules. Classé par thème.

## Active Directory — structure
- **Forêt (forest)** : frontière de sécurité de plus haut niveau ; contient un ou plusieurs domaines.
- **Domaine (domain)** : unité de réplication et d'administration ; partage une base d'annuaire.
- **OU (Organizational Unit)** : conteneur pour organiser objets et appliquer des GPO/délégations.
- **GC (Global Catalog)** : index partiel de toute la forêt, pour les recherches inter-domaines.
- **Site** : regroupement de sous-réseaux « bien connectés » ; pilote réplication et localisation.
- **Site link** : lien logique entre sites, avec coût et planning de réplication.
- **DC (Domain Controller)** : serveur hébergeant AD DS.
- **RODC (Read-Only DC)** : DC en lecture seule pour sites moins sûrs.
- **FSMO** : 5 rôles à maître unique (Schema, Domain Naming, PDC Emulator, RID, Infrastructure).
- **KCC / ISTG** : composants qui calculent la topologie de réplication.

## Authentification
- **Kerberos** : protocole d'authentification par tickets (port 88).
- **TGT (Ticket Granting Ticket)** : ticket initial délivré par le KDC.
- **TGS / ST (Service Ticket)** : ticket pour accéder à un service.
- **KDC (Key Distribution Center)** : service Kerberos sur le DC.
- **KRBTGT** : compte dont la clé chiffre les TGT (cible du « Golden Ticket »).
- **SPN (Service Principal Name)** : identifiant d'un service pour Kerberos.
- **PAC (Privilege Attribute Certificate)** : données d'autorisation (SID, groupes) dans un ticket.
- **NTLM** : protocole d'authentification challenge/réponse hérité (en voie de dépréciation).
- **PRT (Primary Refresh Token)** : jeton d'authentification Entra sur un appareil joint.

## Protocoles & services
- **LDAP** : accès à l'annuaire (ports 389 / 636 LDAPS).
- **SMB** : partage de fichiers (port 445).
- **DNS** : résolution de noms ; AD en dépend fortement.
- **LSASS** : processus Windows qui gère les secrets d'authentification en mémoire.
- **SAM** : base des comptes locaux.
- **DPAPI** : API de protection des données (chiffrement de secrets utilisateur/machine).
- **WinRM / WMI** : administration à distance.

## Sécurité — modèle
- **Tier 0/1/2 (Enterprise Access Model)** : séparation des plans d'administration.
- **PAW (Privileged Access Workstation)** : poste dédié à l'admin privilégiée.
- **gMSA / dMSA** : comptes de service gérés (dMSA = nouveau en Server 2025).
- **LAPS** : rotation du mot de passe admin local.
- **AGDLP / IGDLA** : modèle d'imbrication des groupes.

## Offensif / détection
- **Kerberoasting** : extraction/cassage de tickets de service.
- **AS-REP roasting** : attaque sur comptes sans pré-authentification Kerberos.
- **RBCD (Resource-Based Constrained Delegation)** : délégation détournable.
- **Shadow Credentials** : abus de `msDS-KeyCredentialLink`.
- **DCSync / DCShadow** : réplication malveillante / injection dans l'annuaire.
- **ESC1-ESC16** : familles de mauvaises configurations AD CS.
- **MITRE ATT&CK** : taxonomie des techniques d'attaque.
- **Sigma** : format de règles de détection portable.
- **Sysmon** : agent de télémétrie endpoint détaillée.
