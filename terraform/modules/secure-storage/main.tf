# =============================================================
# main.tf — Module secure-storage
# =============================================================
# Crée un Storage Account sécurisé (secure by default).
# =============================================================

resource "azurerm_storage_account" "this" {
  name = var.storage_account_name
  resource_group_name = var.resource_group_name
  location = var.location

  account_tier = var.account_tier
  account_replication_type = var.account_replication_type
  account_kind = "StorageV2"

  # --- Configurations de sécurité ---
  min_tls_version = var.min_tls_version
  https_traffic_only_enabled = true
  public_network_access_enabled = var.public_network_access_enabled
  allow_nested_items_to_be_public = var.allow_blob_public_access

  # --- Sécurité renforcée (toujours active) ---
blob_properties {
  delete_retention_policy {
    days = 7  # soft-delete activé
    }
    container_delete_retention_policy {
        days = 7 # soft-delete conatainers
         }
}
tags = var.tags
}