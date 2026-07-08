# 01 — lab-vulnerable vs lab-hardened

> **Objectif** : illustrer concrètement l'apport du principe *secure by default*
> à travers 2 environnements Azure fonctionnellement identiques, mais avec des
> postures de sécurité opposées.

## Vue d'ensemble

Les deux environnements provisionnent les **mêmes types de ressources** :
- 1 Storage Account (avec containers Blob)
- 1 Virtual Network (VNet + Subnet + NSG)
- 1 Key Vault

Seule la configuration change.

| Environnement | Approche | Ressources | Vulnérabilités |
|---|---|---|---|
| `lab-vulnerable` | Code plat, valeurs vulnérables en dur | 11 | ~10 écarts CIS |
| `lab-hardened` | 3 modules `secure-*` réutilisables | 7 | 0 écart CIS visé |

## Comparaison détaillée

### 💾 Storage Account

| Contrôle | lab-vulnerable | lab-hardened |
|---|---|---|
| Version TLS min | `TLS1_0` 🚨 | `TLS1_2` ✅ |
| HTTPS obligatoire | `false` 🚨 | `true` ✅ |
| Accès réseau public | `Enabled` 🚨 | `Disabled` ✅ |
| Blobs anonymes | `Enabled` 🚨 | `Disabled` ✅ |
| Soft-delete blob | Aucun 🚨 | 7 jours ✅ |
| Soft-delete container | Aucun 🚨 | 7 jours ✅ |
| Containers publics | `blob` (public) 🚨 | Aucun container créé ✅ |

### 🌐 Réseau (NSG)

| Contrôle | lab-vulnerable | lab-hardened |
|---|---|---|
| SSH (port 22) | Ouvert depuis `*` 🚨 | Créé uniquement si IP source ✅ |
| RDP (port 3389) | Ouvert depuis `*` 🚨 | Aucune règle ✅ |
| Deny-All-Inbound | Absent 🚨 | Règle explicite (prio 4096) ✅ |
| Source `*` autorisée | Oui 🚨 | Interdit par validation ✅ |

### 🔐 Key Vault

| Contrôle | lab-vulnerable | lab-hardened |
|---|---|---|
| Modèle d'autorisation | Access policies (legacy) 🚨 | RBAC (moderne) ✅ |
| Purge protection | Désactivée 🚨 | Toujours activée ✅ |
| Public network access | Activé 🚨 | Désactivé ✅ |
| Network ACLs | Aucune 🚨 | `Deny` par défaut ✅ |
| Soft-delete retention | 7 jours (min) 🚨 | 90 jours (max) ✅ |
| Secret en clair dans le code | Oui (démo) 🚨 | Pas de secret hard-codé ✅ |

## Écarts CIS couverts

Les principaux contrôles couverts par le `lab-hardened` (à croiser avec CIS Azure) :

- CIS 3.1 — Ensure that 'Secure transfer required' is set to 'Enabled' ✅
- CIS 3.5 — Ensure that 'Public access level' is set to Private ✅
- CIS 3.15 — Ensure the minimum TLS version for storage is 1.2 ✅
- CIS 6.1 — Ensure RDP access is restricted from Internet ✅

Au-delà de la sécurité, la modularisation apporte :

- **DRY** : le code du storage est écrit une fois, réutilisable N fois
- **Cohérence** : impossible de créer un storage non conforme via le module
- **Auditabilité** : le code du module = la définition du standard


# Déployer le lab vulnérable
terraform init && terraform apply


# Détruire
terraform destroy

# Déployer le lab durci (même RG, ressources différentes)
cd ../lab-hardened
terraform init && terraform apply
```

## Prochaines étapes (Phase 3)

- Auditer les 2 environnements avec **tfsec** et **Checkov**
- Croiser les résultats avec le **CIS Benchmark Azure**
- Générer un **risk register** priorisé
- Documenter le processus d'audit dans un runbook# Le comparer visuellement dans le portail Azure
cd terraform/environments/lab-vulnerable
```bash
## Comment reproduire
- **Maintenabilité** : un changement de politique = 1 seul fichier à modifier
- CIS 8.2 — Ensure Key Vault purge protection is enabled ✅

## Bénéfices architecturaux
- CIS 6.2 — Ensure SSH access is restricted from Internet ✅
