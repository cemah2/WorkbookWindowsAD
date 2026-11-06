# Fiche — DFS (Distributed File System) : Namespaces & Replication

> Volet académique. DFS fournit des **chemins d'accès unifiés** aux partages et **réplique** les
> données entre sites — essentiel pour une entreprise multi-sites comme CORP.

## 1. Rôle & utilité
- **DFS Namespaces (DFS-N)** : expose un espace de noms logique unique
  (`\\corp.meridian.com\shares\Finance`) qui masque les serveurs physiques réels. Les utilisateurs
  ont un chemin stable même si le serveur change.
- **DFS Replication (DFS-R)** : réplique les dossiers entre serveurs (multi-sites, résilience).

## 2. Fonctionnement DFS-N
```mermaid
graph TD
    U[Utilisateur] -->|\\corp\shares\Finance| NS[Namespace DFS]
    NS -->|référral trié par site| T1[\\PAR-FS-01\Finance]
    NS -->|repli| T2[\\NYC-FS-01\Finance]
    note[Le client est dirigé vers la cible de SON site - 'site awareness']
```
- **Namespace** : *domain-based* (`\\domaine\...`, hautement dispo, recommandé) ou *standalone*.
- **Folder targets** : plusieurs serveurs peuvent héberger la même donnée ; le client est dirigé
  vers la cible de **son site** (ordre de référral basé sur le coût AD).
- **Referral ordering** : exploite les Sites AD (module 26) pour la localité.

## 3. Fonctionnement DFS-R
- Réplication **multi-maître** basée sur **RDC** (Remote Differential Compression) : ne transfère
  que les blocs modifiés.
- **Replication group** + **replicated folders** + **topologie** (full-mesh, hub-spoke) + planning.
- SYSVOL lui-même utilise DFS-R (sur domaines modernes).

## 4. Concepts clés
- **Backlog** : fichiers en attente de réplication (à surveiller).
- **Conflits** : résolus "dernier écrivain gagne" (perdant déplacé dans ConflictAndDeleted).
- **Staging** : zone tampon (dimensionner selon les gros fichiers).

## 5. Implémentation Windows
- Rôles *DFS Namespaces* et *DFS Replication*. Consoles **dfsmgmt.msc**, modules PowerShell
  **`DFSN`** et **`DFSR`**.

## 6. Objets & attributs AD liés
- DFS domain-based stocke sa config dans AD (partition de domaine) ; DFS-R a ses objets de config.

## 7. Surface d'attaque (aperçu)
- **Permissions de partage/NTFS trop larges** (Everyone) → fuite/altération de données.
- **Écriture sur un partage répliqué** → la modification se propage partout (impact rançongiciel).
- DFS-N n'applique pas de droits lui-même : ce sont les **ACL NTFS** des cibles qui protègent.

## 8. Détection (aperçu)
Audit d'accès aux fichiers (4663), événements DFS-R (santé/backlog), modifications massives
(rançongiciel). Voir `defend.md`.

## 9. Versioning
Stable ; DFS-R a remplacé FRS pour SYSVOL. Pour certains gros volumes, Storage Replica est une
alternative (bloc) — DFS-R reste la réplication de fichiers standard.

## 10. Pour aller plus loin
Microsoft Learn — DFS Namespaces / Replication. Voir `99-ressources/bibliographie.md` (P2).
