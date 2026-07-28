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


CRITICAL | AVD-AZU-0011 | Storage account uses an insecure TLS version. | C:\Users\OMEN\Documents\cloud-security-lab\terraform\environments\lab-vulnerable\main.tf:40
CRITICAL | AVD-AZU-0013 | Vault network ACL does not block access by default. | C:\Users\OMEN\Documents\cloud-security-lab\terraform\environments\lab-vulnerable\keyvault.tf:24
CRITICAL | AVD-AZU-0047 | Security group rule allows ingress from public internet. | C:\Users\OMEN\Documents\cloud-security-lab\terraform\environments\lab-vulnerable\network.tf:60
CRITICAL | AVD-AZU-0047 | Security group rule allows ingress from public internet. | C:\Users\OMEN\Documents\cloud-security-lab\terraform\environments\lab-vulnerable\network.tf:72
CRITICAL | AVD-AZU-0048 | Security group rule allows ingress to RDP port from multiple public internet addresses. | C:\Users\OMEN\Documents\cloud-security-lab\terraform\environments\lab-vulnerable\network.tf:72
CRITICAL | AVD-AZU-0050 | Security group rule allows ingress to SSH port from multiple public internet addresses. | C:\Users\OMEN\Documents\cloud-security-lab\terraform\environments\lab-vulnerable\network.tf:60
HIGH | AVD-AZU-0007 | Container allows public access. | C:\Users\OMEN\Documents\cloud-security-lab\terraform\environments\lab-vulnerable\main.tf:68
LOW | AVD-AZU-0015 | Secret does not have a content-type specified. | C:\Users\OMEN\Documents\cloud-security-lab\terraform\environments\lab-vulnerable\keyvault.tf:58
LOW | AVD-AZU-0017 | Secret should have an expiry date specified. | C:\Users\OMEN\Documents\cloud-security-lab\terraform\environments\lab-vulnerable\keyvault.tf:58
MEDIUM | AVD-AZU-0016 | Vault does not have purge protection enabled. | C:\Users\OMEN\Documents\cloud-security-lab\terraform\environments\lab-vulnerable\keyvault.tf:35

## Commande pour reproduire

\`\`\`bash
cd terraform/environments/lab-vulnerable
tfsec .
\`\`\`
