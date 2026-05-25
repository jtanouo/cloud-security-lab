# =============================================================
# outputs.tf — lab-hardened
# =============================================================

output "storage_account_name" {
  value       = module.secure_storage.name
  description = "Nom du storage sécurisé crée"
}

output "storage_account_id" {
  value       = module.secure_storage.id
  description = "ID du storage sécurisé"

}