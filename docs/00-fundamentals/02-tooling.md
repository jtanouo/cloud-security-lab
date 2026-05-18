# 02 — Trousse à outils du projet

> **Dernière mise à jour** : mai 2026
> **Testé sur** : Windows 11, Git Bash (MINGW64), Python 3.10+

## Vue d'ensemble

| Outil | Rôle | Version installée |
|---|---|---|
| **Azure CLI** | Piloter Azure depuis le terminal | 2.62+ |
| **Terraform** | Infrastructure as Code (multi-cloud) | 1.8.4 |
| **tfsec** | Scanner de sécurité IaC (Terraform) | 1.28.14 |
| **Checkov** | Scanner multi-IaC (TF, K8s, Docker, ARM) | 3.2.529 |
| **Git** | Versionning du code | 2.x |
| **VS Code** | Éditeur de code | — |

---

## Azure CLI

**Installation Windows** : <https://aka.ms/installazurecliwindows>
**Documentation** : <https://learn.microsoft.com/cli/azure/>

### Commandes essentielles

```bash
# Se connecter à Azure
az login

# Lister les abonnements disponibles
az account list --output table

# Définir l'abonnement actif
az account set --subscription "<subscription-id>"

# Lister les Resource Groups
az group list --output table

# Lister toutes les ressources (de tous les RG)
az resource list --output table
```

> 💡 **Astuce** : `--output table` rend l'affichage lisible. Sans ça, la sortie est en JSON brut.

---

## Terraform

**Installation** : <https://developer.hashicorp.com/terraform/install>
**Documentation** : <https://developer.hashicorp.com/terraform/docs>

### Workflow de base

```bash
# Télécharger les providers (1ère fois ou après modif)
terraform init

# Voir ce qui va changer (dry-run, sans risque)
terraform plan

# Appliquer les changements (création réelle)
terraform apply

# Tout détruire (réflexe budget en lab)
terraform destroy
```

---

## tfsec

**Source** : <https://github.com/aquasecurity/tfsec/releases>
**Documentation** : <https://aquasecurity.github.io/tfsec/>

> ⚠️ **Note** : tfsec rejoint la famille **Trivy** (même éditeur Aqua Security). tfsec reste utilisable, mais à terme c'est Trivy qui sera la solution unifiée.

### Usage de base

```bash
# Scanner le dossier courant
tfsec .

# Sortie JSON pour intégration CI/CD
tfsec . --format json

# Scanner avec niveau de sévérité minimum
tfsec . --minimum-severity HIGH
```

---

## Checkov

**Installation** : `pip install checkov`
**Documentation** : <https://www.checkov.io/>

### Usage de base

```bash
# Scanner un dossier Terraform complet
checkov -d ./terraform

# Scanner un fichier précis
checkov -f main.tf

# Sortie compacte (sans détails verbeux)
checkov -d ./terraform --compact
```

---

## 🪟 Pièges rencontrés sur Windows

Les difficultés que j'ai personnellement rencontrées en installant ces outils, et comment les contourner.

### Piège n°1 — Le PATH système ne se propage pas à Git Bash

**Symptôme** : après avoir ajouté `C:\Tools\terraform` aux variables d'environnement Windows, `terraform --version` répond bien mais Git Bash continue à dire `command not found`.

**Solution** : ajouter le chemin via `.bashrc` :

```bash
echo 'export PATH="/c/Tools/terraform:$PATH"' >> ~/.bashrc
source ~/.bashrc
```

> 💡 **Pourquoi** : Git Bash a son propre fichier de config (`.bashrc`) qui surcharge le PATH système Windows. C'est plus fiable de le modifier directement.

### Piège n°2 — Mauvais binaire téléchargé pour tfsec

**Symptôme** : `tfsec --version` répond avec `Error: unknown flag: --version` et liste des commandes `tfsec-checkgen` étranges.

**Cause** : sur la page des releases tfsec, il y a **deux binaires** Windows :
- ✅ `tfsec-windows-amd64.exe` → le scanner (celui qu'on veut)
- ❌ `tfsec-checkgen-windows-amd64.exe` → outil annexe pour créer des règles custom

**Solution** : télécharger le bon binaire et le renommer en `tfsec.exe`.

### Piège n°3 — Terminal pas redémarré après modif du PATH

**Symptôme** : la modif du PATH ne semble pas prise en compte.

**Solution** : **fermer TOUTES** les fenêtres Git Bash, VS Code, etc., puis rouvrir. Une modif PATH n'est lue qu'à l'**ouverture** d'un nouveau terminal.

---

## ✅ Bonnes pratiques

- **Ne jamais committer** un fichier `.tfvars` ou un token (le `.gitignore` du repo bloque déjà ces patterns)
- **Toujours `terraform plan`** avant `terraform apply`, surtout en environnement partagé
- **Scanner avec tfsec ET Checkov** : ils trouvent des règles différentes, ils sont complémentaires
- **Versionner les versions d'outils** à terme via un fichier `.tool-versions` (asdf, tfenv)

---

## 📚 Sources

- [Azure CLI documentation](https://learn.microsoft.com/cli/azure/)
- [Terraform documentation](https://developer.hashicorp.com/terraform/docs)
- [tfsec docs](https://aquasecurity.github.io/tfsec/)
- [Checkov docs](https://www.checkov.io/)
- [Trivy (successeur tfsec)](https://aquasecurity.github.io/trivy/)