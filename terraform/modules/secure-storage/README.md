# Module — secure-storage

Crée un Azure Storage Account **secure by default**.

## Sécurité appliquée

| Protection | Comportement |
|---|---|
| TLS 1.2 minimum | Forcé (validation, non contournable) |
| HTTPS only | Toujours activé (non configurable) |
| Public network access | Désactivé par défaut |
| Blob public access | Désactivé par défaut |
| Soft-delete (blob + container) | Toujours activé, 7 jours |

## Utilisation

\`\`\`hcl
module "storage" {
  source = "../../modules/secure-storage"

  storage_account_name = "stmyappprod001"
  resource_group_name  = "rg-myapp-prod"
  location             = "westeurope"

  tags = {
    project     = "myapp"
    environment = "prod"
  }
}
\`\`\`

## Inputs principaux

| Variable | Type | Défaut | Description |
|---|---|---|---|
| `storage_account_name` | string | — | Nom (3-24 car., minuscules+chiffres) |
| `resource_group_name` | string | — | RG cible |
| `location` | string | — | Région Azure |
| `public_network_access_enabled` | bool | `false` | Accès réseau public |
| `min_tls_version` | string | `TLS1_2` | Version TLS (TLS1_2 forcé) |

## Outputs

| Output | Description |
|---|---|
| `id` | ID Azure du Storage Account |
| `name` | Nom du Storage Account |
| `primary_blob_endpoint` | Endpoint Blob principal |