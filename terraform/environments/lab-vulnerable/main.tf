# =============================================================
# main.tf — lab-vulnerable
# =============================================================
# ATTENTION : ce code crée volontairement une infrastructure
# AVEC DES ÉCARTS DE SÉCURITÉ pour servir de cobaye à l'audit.
#
# NE PAS COPIER tel quel en environnement réel.
# =============================================================


data "azurerm_resource_group" "main" {
  name = var.resource_group_name
}

# Tags communs à toutes les ressources
locals {
  common_tags = {
    project     = var.project
    environment = var.environment
    owner       = var.owner
    purpose     = "lab-vulnerable"
    managed_by  = "terraform"
  }
}

# -------------------------------------------------------------
# Storage Account VOLONTAIREMENT vulnérable
# -------------------------------------------------------------
# Écarts CIS introduits volontairement :
#   - min_tls_version = "TLS1_0"           (devrait être TLS1_2)
#   - public_network_access_enabled = true (devrait être restreint)
#   - https_traffic_only_enabled = false   (devrait être true)
#   - allow_nested_items_to_be_public = true (devrait être false)
# -------------------------------------------------------------

resource "azurerm_storage_account" "vulnerable" {
  name                = "stseclabvuln${random_string.suffix.result}"
  resource_group_name = data.azurerm_resource_group.main.name
  location            = data.azurerm_resource_group.main.location

  account_tier             = "Standard"
  account_replication_type = "LRS"
  account_kind             = "StorageV2"

  # ⚠️ Configurations vulnérables (intentionnelles) :
  min_tls_version                 = "TLS1_0"
  https_traffic_only_enabled      = false
  public_network_access_enabled   = true
  allow_nested_items_to_be_public = true

  tags = local.common_tags
}

# Suffix aléatoire pour garantir l'unicité du nom du Storage
resource "random_string" "suffix" {
  length  = 6
  special = false
  upper   = false
}

# -------------------------------------------------------------
# Containers Blob VOLONTAIREMENT publics
# -------------------------------------------------------------
# Écarts CIS introduits volontairement :
#   - container_access_type = "blob" → tout le monde peut lire les fichiers
#   - Recommandé : "private" (aucun accès anonyme)
# -------------------------------------------------------------

resource "azurerm_storage_container" "vulnerable" {
  for_each = toset(["documents", "images", "logs", "backups"])

  name                  = each.value
  storage_account_name  = azurerm_storage_account.vulnerable.name
  container_access_type = "blob"

}