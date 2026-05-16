# 01 — Concepts cloud essentiels

## Qu'est-ce que le cloud ?

Louer de la puissance informatique chez un fournisseur (compute, stockage, réseau, services managés) plutôt que d'acheter et gérer ses propres serveurs physiques.

## Les modèles de services

| Modèle | On gère quoi ? | Exemple Azure |
|---|---|---|
| **IaaS** (Infrastructure as a Service) | OS + applications | Azure Virtual Machine |
| **PaaS** (Platform as a Service) | Applications uniquement | Azure App Service |
| **SaaS** (Software as a Service) | Données utilisateur | Microsoft 365 |

## Les 3 principaux fournisseurs publics

- **AWS** (Amazon Web Services) — leader historique
- **Azure** (Microsoft) — fort en entreprise
- **GCP** (Google Cloud Platform) — fort en data/IA

Note : OCI (Oracle Cloud Infrastructure) est un 4ème acteur, souvent rencontré en banque/finance.

## Hiérarchie Azure

\`\`\`
Tenant (Microsoft Entra ID)
└── Subscription (unité de facturation)
    └── Resource Group (dossier logique régional)
        └── Resources (VM, Storage, etc.)
\`\`\`

## Conventions de nommage (CAF Microsoft)

| Type | Préfixe | Exemple |
|---|---|---|
| Resource Group | `rg-` | `rg-securitylab-dev` |
| Storage Account | `st` | `stsecuritylab001` |
| Virtual Machine | `vm-` | `vm-web-prod-01` |
| Key Vault | `kv-` | `kv-securitylab-dev` |
| Virtual Network | `vnet-` | `vnet-securitylab-dev` |

## Tagging : indispensable

Tout RG / ressource doit porter des tags pour la gouvernance :

- `project`
- `environment` (dev / staging / prod)
- `owner`
- `purpose`

## Sources

- [Microsoft Cloud Adoption Framework](https://learn.microsoft.com/azure/cloud-adoption-framework/)
- [Azure Naming Conventions](https://learn.microsoft.com/azure/cloud-adoption-framework/ready/azure-best-practices/resource-naming)