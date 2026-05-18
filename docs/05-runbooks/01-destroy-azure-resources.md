# Runbook — Détruire toutes les ressources Azure du lab

> **Objectif** : libérer le subscription Azure à la fin d'une session
> **Durée** : 5-10 minutes
> **Prérequis** : Azure CLI configuré, accès au subscription "Azure subscription 1"

## Pourquoi ce runbook ?

Une ressource Azure non détruite consomme du crédit en continu. La règle du projet est :

> **Tout ce qui est créé pour tester doit être détruit avant de fermer le terminal.**

Ce runbook automatise la vérification et la destruction.

## Procédure

### Étape 1 — Vérifier le subscription actif

```bash
az account show --output table
```

Doit afficher `Azure subscription 1` et `IsDefault: True`.

### Étape 2 — Lister les ressources existantes

```bash
az resource list --resource-group rg-securitylab-dev --output table
```

Si la liste est **vide** → rien à faire, fin de procédure ✅

Sinon → continuer.

### Étape 3 — Détruire via Terraform (si géré par Terraform)

Si les ressources ont été créées via Terraform, **préférer toujours** la destruction Terraform :

```bash
cd terraform/environments/<environment>
terraform destroy
# Taper "yes" pour confirmer
```

### Étape 4 — Détruire manuellement (si pas géré par Terraform)

Cas par cas, exemple pour un Storage Account :

```bash
az storage account delete \
  --name <nom-storage> \
  --resource-group rg-securitylab-dev \
  --yes
```

### Étape 5 — Vérification finale

```bash
az resource list --resource-group rg-securitylab-dev --output table
```

Doit afficher une **liste vide**. ✅

### Étape 6 — Contrôle des coûts

Aller sur le **portail Azure** → **Cost Management** → vérifier que le **Current cost** reste bas.

## En cas de problème

| Symptôme | Cause probable | Solution |
|---|---|---|
| `SubscriptionNotFound` | Provider non enregistré | `az provider register --namespace Microsoft.<XXX>` |
| `Conflict: resource in use` | Ressource liée à une autre | Détruire les dépendantes d'abord |
| `Authorization failed` | Token Azure CLI expiré | `az logout && az login` |
| Terraform tente d'enregistrer des providers | Auto-registration activée | Vérifier `skip_provider_registration = true` dans le provider azurerm |

## Notes

- Le **Resource Group `rg-securitylab-dev`** n'est PAS détruit (il reste vide)
- En cas d'urgence (budget dépassé) : `az group delete --name rg-securitylab-dev --yes --no-wait` détruit TOUT en une commande