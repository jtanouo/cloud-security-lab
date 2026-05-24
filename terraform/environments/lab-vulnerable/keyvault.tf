# =============================================================
# keyvault.tf — Key Vault (lab-vulnerable)
# =============================================================
# ATTENTION : ce Key Vault est volontairement mal configuré
# pour servir de cobaye aux audits de sécurité.
#
# NE PAS COPIER tel quel en environnement réel.
# =============================================================

# Référence à l'identité courante (pour les access policies)

data "azurerm_client_config" "current" {}

# -------------------------------------------------------------
# Key Vault VOLONTAIREMENT vulnérable
# -------------------------------------------------------------
# Écarts CIS introduits volontairement :
#   - public_network_access_enabled = true  (devrait être restreint)
#   - purge_protection_enabled = false       (devrait être true)
#   - soft_delete_retention_days = 7         (minimum, devrait être plus long)
#   - enable_rbac_authorization = false      (utilise les vieux access policies)
# -------------------------------------------------------------

resource "azurerm_key_vault" "vulnerable" {
  name                = "kv-seclab-${random_string.suffix.result}"
  resource_group_name = data.azurerm_resource_group.main.name
  location            = data.azurerm_resource_group.main.location
  tenant_id           = data.azurerm_client_config.current.tenant_id

  sku_name = "standard"

  #config vulnerable intentionnelles

  public_network_access_enabled = true
  purge_protection_enabled      = false
  soft_delete_retention_days    = 7
  enable_rbac_authorization     = false

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    secret_permissions = [
      "Get", "List", "Set", "Delete", "Purge", "Recover"
    ]
    key_permissions = ["Get", "List", "Create", "Delete", "Purge", "Recover"
    ]
    certificate_permissions = [
      "Get", "List", "Create", "Delete", "Purge", "Recover"
    ]
  }
  tags = local.common_tags
}

# -------------------------------------------------------------
# Un secret de démonstration stocké dans le Key Vault
# -------------------------------------------------------------
resource "azurerm_key_vault_secret" "demo" {
  name         = "demo-db-password"
  value        = "P@ssw0rd-NeverDoThis-123!" # 🚨 secret en clair dans le code !
  key_vault_id = azurerm_key_vault.vulnerable.id

  tags = local.common_tags

}