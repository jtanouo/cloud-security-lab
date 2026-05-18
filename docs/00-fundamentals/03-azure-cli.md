# 03 — Explorer Azure depuis le terminal

> **Dernière mise à jour** : mai 2026
> **Testé sur** : Azure CLI 2.62+, Git Bash, jq 1.7.1

## Pattern universel d'une commande Azure CLI

```
az <service> <action> [paramètres] [options]
```

Les **5 verbes universels** : `list`, `show`, `create`, `delete`, `update`.

## Options indispensables

| Option | Effet |
|---|---|
| `--output table` (ou `-o table`) | Affichage tabulaire lisible |
| `--output tsv` | Une valeur par ligne, idéal pour scripts |
| `--query "..."` | Filtrer avec JMESPath |
| `--help` (ou `-h`) | Aide intégrée |

## Commandes d'exploration

```bash
# État de la connexion
az account show --output table

# Lister les Resource Groups
az group list --output table

# Détails d'un RG précis
az group show --name <rg-name> --output table

# Lister les ressources d'un RG
az resource list --resource-group <rg-name> --output table
```

## Filtrage avec --query (JMESPath)

```bash
# Juste les noms des RG
az group list --query "[].name" --output tsv

# Sélection multi-champs
az group list --query "[].{Nom:name, Region:location}" --output table
```

## Filtrage avec jq

`jq` est un outil de parsing JSON installé via :

```bash
curl -L -o /c/Tools/terraform/jq.exe \
  https://github.com/jqlang/jq/releases/download/jq-1.7.1/jq-windows-amd64.exe
```

Usage :

```bash
# Extraire un champ
az account show | jq '.name'

# Boucler sur une liste et extraire un champ
az group list | jq '.[].name'
```

## Cycle de vie d'une ressource (Storage Account)

```bash
# Suffixe aléatoire pour garantir l'unicité du nom
RANDOM_SUFFIX=$(openssl rand -hex 3)

# Création
az storage account create \
  --name "stseclab${RANDOM_SUFFIX}" \
  --resource-group rg-securitylab-dev \
  --location westeurope \
  --sku Standard_LRS \
  --kind StorageV2 \
  --tags project=cloud-security-lab environment=dev

# Vérification
az storage account list --resource-group rg-securitylab-dev --output table

# Destruction (réflexe budget)
az storage account delete \
  --name "stseclab${RANDOM_SUFFIX}" \
  --resource-group rg-securitylab-dev \
  --yes
```

## 🪟 Pièges rencontrés

### Piège n°1 — Resource provider non enregistré

**Symptôme** : `az storage account create` échoue avec `SubscriptionNotFound` alors que le subscription existe bien.

**Cause** : sur un compte Azure Free Trial neuf, le provider `Microsoft.Storage` n'est pas activé par défaut.

**Diagnostic** :
```bash
az provider list --query "[?namespace=='Microsoft.Storage']" --output table
# RegistrationState: NotRegistered → coupable trouvé
```

**Solution** :
```bash
az provider register --namespace Microsoft.Storage --wait
```

**Bonnes pratiques** : pré-enregistrer tous les providers nécessaires au projet dès le début :
```bash
az provider register --namespace Microsoft.Network --wait
az provider register --namespace Microsoft.Compute --wait
az provider register --namespace Microsoft.KeyVault --wait
az provider register --namespace Microsoft.Authorization --wait
az provider register --namespace Microsoft.Security --wait
```

### Piège n°2 — Cache Azure CLI corrompu

**Symptôme** : `az account show` montre le bon subscription, mais les opérations échouent quand même.

**Solution** :
```bash
az account clear
az login
```

## 🚨 Constat sécurité : un Storage Account créé "par défaut" est vulnérable

À la création d'un Storage Account sans options de sécurité explicites, on obtient ces paramètres par défaut **non conformes** au CIS Benchmark Azure :

| Paramètre | Valeur par défaut | Risque | Remédiation |
|---|---|---|---|
| **Public network access** | `Enabled` | Accessible depuis Internet | Restreindre à un VNet ou private endpoint |
| **Minimum TLS version** | `1.0` | Chiffrement obsolète | Forcer TLS 1.2 minimum |
| **Infrastructure encryption** | `Disabled` | Pas de double chiffrement | Activer à la création (irréversible) |
| **Blob soft delete** | `Disabled` | Pas de récupération | Activer avec rétention de 7-90 jours |
| **Blob anonymous access** | Réglé au compte | À désactiver | `allowBlobPublicAccess=false` |

> 💡 C'est exactement le type d'écart qu'on doit identifier puis remédier en Phase 3 (Posture Sécurité).
> Les outils tfsec et Checkov détecteront automatiquement ces points en Phase 4.

## Bonnes pratiques

- **Toujours tagger** les ressources (`project`, `environment`, `owner`, `purpose`)
- **Détruire systématiquement** les ressources de test (réflexe budget)
- **Pré-enregistrer les resource providers** dès le début du projet
- **`--help` avant Google** : la doc intégrée est souvent suffisante

## Sources

- [Azure CLI reference](https://learn.microsoft.com/cli/azure/reference-index)
- [JMESPath tutorial](https://jmespath.org/tutorial.html)
- [Azure resource providers](https://learn.microsoft.com/azure/azure-resource-manager/management/resource-providers-and-types)
- [CIS Benchmark Azure](https://www.cisecurity.org/benchmark/azure)