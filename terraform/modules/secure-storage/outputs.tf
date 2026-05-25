# =============================================================
# outputs.tf — Module secure-storage
# =============================================================
# Valeurs exposées aux utilisateurs du module.
# ============================================================

output "id" {
    value = azurerm_storage_account.this.id
    description = "ID Azure du Storage Account"
  
}

output "name" {
    value = azurerm_storage_account.this.name
    description = "Nom du Storage Account"
  
}

output "primary_blob_endpoint" {
    value = azurerm_storage_account.this.primary_blob_endpoint
  
}

