# 04 — Module : secure-keyvault

> **Chemin** : `terraform/modules/secure-keyvault/`

## Rôle

Provisionne un **Azure Key Vault** appliquant les bonnes pratiques
modernes (RBAC + purge protection).

## Sécurité appliquée

| Protection | Mécanisme |
|---|---|
| Modèle d'autorisation | RBAC forcé (pas d'access policies legacy) |
| Purge protection | Toujours activée (non contournable) |
| Soft-delete | 90 jours par défaut, min 7 |
| Public network access | Désactivé par défaut |
| Network ACLs | `Deny` par défaut, bypass AzureServices |

## Inputs principaux

| Variable | Type | Défaut | Sécurité |
|---|---|---|---|
| `key_vault_name` | string | — | validation regex |
| `resource_group_name` | string | — | — |
| `location` | string | — | — |
| `tenant_id` | string | — | — |
| `public_network_access_enabled` | bool | `false` | ✅ |
| `soft_delete_retention_days` | number | `90` | validation 7-90 |

## Outputs

| Output | Description |
|---|---|
| `id` | ID du Key Vault |
| `name` | Nom du Key Vault |
| `vault_uri` | URI du Key Vault |

## À noter

- **Pas de secret créé par le module** : les secrets sont injectés
  séparément via `azurerm_key_vault_secret`, jamais hard-codés.
- La configuration RBAC nécessite d'attribuer explicitement les rôles
  (`Key Vault Secrets User`, etc.) via `azurerm_role_assignment`.
