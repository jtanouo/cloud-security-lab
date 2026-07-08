# 03 — Module : secure-network

> **Chemin** : `terraform/modules/secure-network/`

## Rôle

Provisionne un **VNet + Subnet + NSG** sécurisé par défaut. Applique
le principe **deny by default** au niveau du NSG.

## Sécurité appliquée

| Protection | Mécanisme |
|---|---|
| Deny-All-Inbound | Règle explicite priorité 4096 |
| SSH ouvert au monde (`*`) | Interdit par validation Terraform |
| Règle SSH conditionnelle | Créée uniquement si IP source fournie |
| RDP (3389) | Aucune règle publique |

## Inputs principaux

| Variable | Type | Défaut | Sécurité |
|---|---|---|---|
| `vnet_name` | string | — | — |
| `subnet_name` | string | — | — |
| `nsg_name` | string | — | — |
| `address_space` | list(string) | `["10.0.0.0/16"]` | — |
| `subnet_prefixes` | list(string) | `["10.0.1.0/24"]` | — |
| `allowed_ssh_source` | string | `""` | `"*"` interdit ✅ |

## Outputs

| Output | Description |
|---|---|
| `vnet_id`, `vnet_name` | Identifiants du VNet |
| `subnet_id` | ID du Subnet |
| `nsg_id` | ID du NSG |

## Concept technique : `dynamic` block

La règle SSH est un bloc **conditionnel** :

\`\`\`hcl
dynamic "security_rule" {
  for_each = var.allowed_ssh_source != "" ? [1] : []
  content { ... }
}
\`\`\`

Si `allowed_ssh_source` est vide → aucune règle SSH créée.
Sinon → règle avec source restreinte.
