# tfsec — lab-vulnerable — détail des findings

> Date : mai 2026 | Outil : tfsec v1.28.14

## Total : REMPLIR findings

## Findings par sévérité

### 🔥 CRITICAL

| ID tfsec | Description | Fichier:Ligne |
|---|---|---|
| azure-keyvault-specify-network-acl
 | Vault network ACL does not block access by default.
 | 24-32 |

 | azure-storage-use-secure-tls-policy | Storage account uses an insecure TLS version. | 40 |

### 🟠 HIGH

| ID tfsec | Description | Fichier:Ligne |
|---|---|---|
| azurerm_storage_container | Manages a Container within an Azure Storage Account. | 68 |

### 🟡 MEDIUM

| ID tfsec | Description | Fichier:Ligne |
|---|---|---|
| azurerm_key_vault | securely store, manage, and tightly control access to sensitive data | 35 |
| azurerm_key_vault_secret | securely store, manage, and tightly control access to sensitive data | 58-65 |

## Commande pour reproduire

\`\`\`bash
cd terraform/environments/lab-vulnerable
tfsec .
\`\`\`
