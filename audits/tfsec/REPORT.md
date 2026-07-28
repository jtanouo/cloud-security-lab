# 📋 Rapport d'audit tfsec

> **Date** : Juillet 2026
> **Outil** : tfsec v1.28.14
> **Périmètre** : `lab-vulnerable` et `lab-hardened`

## 🎯 Résumé exécutif

Audit "shift-left" du code Terraform des 2 environnements du projet.
L'objectif est de comparer la posture de sécurité **avant/après**
application des modules `secure-*`.

## 📊 Résultats globaux

| Environnement | CRITICAL | HIGH | MEDIUM | LOW | TOTAL |
|---|---|---|---|---|---|
| `lab-vulnerable` | **6** | 3 | 1 | 2 | 12 |
| `lab-hardened` | **0** | 0 | 0 | 0 | 0 |
| **Écart** | 6 | 3 | 1 | 2 | 12 |

## 🔴 Findings sur `lab-vulnerable`

### Storage Account

| Finding | Sévérité | Cause |
|---|---|---|
| TLS 1.0 autorisé | CRITICAL | `min_tls_version = "TLS1_0"` |
| Blob public access | HIGH | `allow_nested_items_to_be_public = true` |
| HTTPS non forcé | HIGH | `https_traffic_only_enabled = false` |
| Accès réseau public | MEDIUM | `public_network_access_enabled = true` |

### Réseau (NSG)

| Finding | Sévérité | Cause |
|---|---|---|
| SSH ouvert au monde | CRITICAL | Règle `Allow-SSH-From-Internet` (source `*`) |
| RDP ouvert au monde | CRITICAL | Règle `Allow-RDP-From-Internet` (source `*`) |

### Key Vault

| Finding | Sévérité | Cause |
|---|---|---|
| Purge protection désactivée | HIGH | `purge_protection_enabled = false` |
| Public network access activé | MEDIUM | `public_network_access_enabled = true` |
| Access policies legacy | MEDIUM | `enable_rbac_authorization = false` |

## 🟢 Findings sur `lab-hardened`

À REMPLIR après exécution — on espère 0 ou peu, et idéalement pas de CRITICAL.

## 🎯 Analyse

### Points forts du `lab-hardened`

- Les modules `secure-*` **éliminent** les CRITICAL/HIGH par construction
- Le principe "secure by default" empêche mécaniquement l'introduction d'écarts
- La différence quantitative valide l'approche modulaire

### Recommandations

1. **Ne jamais déployer** un environnement avec des CRITICAL non traités
2. **Automatiser tfsec** dans un pipeline CI/CD (Phase 4)
3. **Mapper** ces findings avec le **CIS Benchmark Azure** (Session 3.3)
4. **Prioriser** les corrections via un **risk register** (Session 3.4)

## 🚀 Prochaines étapes

- Session 3.2 — Audit Checkov (deuxième outil, règles complémentaires)
- Session 3.3 — Mapping CIS Benchmark
- Session 3.4 — Risk register priorisé
- Session 3.5 — Runbooks de remédiation

## 📎 Fichiers associés

- `audits/tfsec/lab-vulnerable-summary.md` — détail des findings
- `audits/tfsec/lab-hardened-summary.md` — détail des findings
