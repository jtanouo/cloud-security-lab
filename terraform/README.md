# Terraform — Code Infrastructure as Code

Code Terraform pour le projet **cloud-security-lab**.

## Structure
terraform/
├── modules/              # Briques réutilisables (secure by default)
│   ├── secure-storage/   # Storage Account hardened
│   ├── secure-keyvault/  # Key Vault hardened
│   └── secure-network/   # VNet avec NSG hardened
├── environments/         # Déploiements concrets
│   ├── lab-vulnerable/   # Infra volontairement vulnérable (cobaye)
│   └── lab-hardened/     # Version sécurisée (avec les modules)
└── policies/             # Azure Policy as Code

## Conventions

- Tous les modules respectent le pattern **secure by default**
- Variables sensibles dans des `.tfvars` (jamais commités, voir `.gitignore`)
- Tags obligatoires sur toute ressource : `project`, `environment`, `owner`, `purpose`

## Workflow type

```bash
cd terraform/environments/lab-hardened
terraform init
terraform plan
terraform apply
# ... usage ...
terraform destroy   # réflexe budget
```