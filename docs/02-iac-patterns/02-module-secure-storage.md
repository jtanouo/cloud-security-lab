# 02 — Module : secure-storage

> **Chemin** : `terraform/modules/secure-storage/`

## Rôle

Provisionne un **Azure Storage Account** appliquant les bonnes pratiques
de sécurité par défaut (secure by default).

## Sécurité appliquée

| Protection | Mécanisme |
|---|---|
| TLS 1.2 minimum | Validation Terraform (interdit `TLS1_0`, `TLS1_1`) |
| HTTPS obligatoire | Codé en dur dans `main.tf`, non désactivable |
| Accès réseau public | Désactivé par défaut (`false`) |
| Blob public | Désactivé par défaut (`false`) |
| Soft-delete (blob + container) | Toujours 7 jours minimum |

## Inputs principaux

| Variable | Type | Défaut | Sécurité |
|---|---|---|---|
| `storage_account_name` | string | — | validation regex |
| `resource_group_name` | string | — | — |
| `location` | string | — | — |
| `min_tls_version` | string | `TLS1_2` | validation stricte |
| `public_network_access_enabled` | bool | `false` | ✅ |
| `allow_blob_public_access` | bool | `false` | ✅ |

## Outputs

| Output | Description |
|---|---|
| `id` | ID Azure du Storage |
| `name` | Nom du Storage |
| `primary_blob_endpoint` | Endpoint Blob principal |

## Exemple d'utilisation

\`\`\`hcl
module "storage" {
  source = "../../modules/secure-storage"

  storage_account_name = "stmyapp001"
  resource_group_name  = "rg-myapp"
  location             = "westeurope"

  tags = { project = "myapp" }
}
\`\`\`
