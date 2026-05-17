# 02 — Trousse à outils du projet

## Vue d'ensemble

| Outil | Rôle | Version installée |
|---|---|---|
| **Azure CLI** | Piloter Azure depuis le terminal | `az --version` |
| **Terraform** | Infrastructure as Code (multi-cloud) | `terraform --version` |
| **tfsec** | Scanner de sécurité IaC (Terraform) | `tfsec --version` |
| **Checkov** | Scanner multi-IaC (TF, K8s, Docker, ARM) | `checkov --version` |
| **Git** | Versionning du code | `git --version` |
| **VS Code** | Éditeur de code | — |

## Azure CLI

### Installation
- **Windows** : https://aka.ms/installazurecliwindows
- **Documentation** : https://learn.microsoft.com/cli/azure/

### Commandes utiles

\`\`\`bash
# Se connecter
az login

# Lister les abonnements
az account list --output table

# Changer d'abonnement actif
az account set --subscription "<subscription-id>"

# Lister les Resource Groups
az group list --output table

# Lister toutes les ressources
az resource list --output table
\`\`\`

## Terraform

### Installation
- **Téléchargement** : https://developer.hashicorp.com/terraform/install
- **Documentation** : https://developer.hashicorp.com/terraform/docs

### Workflow de base
\`\`\`bash
terraform init    # Télécharger les providers
terraform plan    # Voir ce qui va changer (dry-run)
terraform apply   # Appliquer les changements
terraform destroy # Tout supprimer
\`\`\`

## tfsec

### Installation
- **Source** : https://github.com/aquasecurity/tfsec/releases
- **Documentation** : https://aquasecurity.github.io/tfsec/

### Usage de base
\`\`\`bash
# Scanner le dossier courant
tfsec .

# Scanner avec sortie JSON
tfsec . --format json
\`\`\`

## Checkov

### Installation
\`\`\`bash
pip install checkov
\`\`\`

### Usage de base
\`\`\`bash
# Scanner un dossier Terraform
checkov -d ./terraform

# Scanner un fichier précis
checkov -f main.tf
\`\`\`

### Documentation
- https://www.checkov.io/

## Bonnes pratiques

- **Ne jamais committer** un fichier `.tfvars` ou un token d'authentification
- **Toujours `terraform plan`** avant `terraform apply` en environnement partagé
- **Scanner avec tfsec ET checkov** : ils trouvent des choses différentes
- **Versionner les versions d'outils** : ajouter un fichier `.tool-versions` à terme

## Sources

- [Azure CLI documentation](https://learn.microsoft.com/cli/azure/)
- [Terraform documentation](https://developer.hashicorp.com/terraform/docs)
- [tfsec docs](https://aquasecurity.github.io/tfsec/)
- [Checkov docs](https://www.checkov.io/)