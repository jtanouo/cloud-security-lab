# =============================================================
# main.tf — lab-hardened
# =============================================================
# Environnement sécurisé, construit avec les modules secure-*.
# =============================================================

data "azurerm_resource_group" "main" {
  name = "rg-securitylab-dev"

}

resource "random_string" "suffix" {
  length  = 6
  special = false
  upper   = false

}

locals {
  common_tags = {
    project       = "cloud-security-lab"
    environnement = "dev"
    owner         = "japhet.tanouo"
    purpose       = "lab-hardened"
    managed_by    = "terraform"
  }
}

# --- Appel du module secure-storage ---
module "secure_storage" {
  source = "../../modules/secure-storage"

  storage_account_name = "stseclabhard${random_string.suffix.result}"
  resource_group_name  = data.azurerm_resource_group.main.name
  location             = data.azurerm_resource_group.main.location

  tags = local.common_tags
}