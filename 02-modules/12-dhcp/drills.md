# Drills — DHCP

## Drill 1 — Observer le DORA (10 min)
- **Étapes** : sur un client, `ipconfig /release` puis `/renew` en capturant avec Wireshark.
- **Observer** : les 4 paquets DISCOVER/OFFER/REQUEST/ACK.
- **Pourquoi** : comprendre concrètement l'attribution.

## Drill 2 — Réservation (10 min)
- **Étapes** : crée une réservation pour la MAC d'un client, renouvelle le bail.
- **Observer** : le client reçoit toujours la même IP.

## Drill 3 — Autorisation AD (5 min)
- **Étapes** : `Get-DhcpServerInDC` ; dés-autorise puis ré-autorise, observe l'effet sur le service.
- **Pourquoi** : comprendre la protection anti-rogue intégrée.

## Drill break-fix — Scope épuisé / pas d'IP (10 min)
- **Casse** : réduis la plage à 2 adresses, connecte 3 clients.
- **Diagnostique** : un client reste en APIPA (169.254.x.x) ; `Get-DhcpServerv4ScopeStatistics`.
- **Répare** : agrandis la plage ou baisse la durée de bail, re-teste.
