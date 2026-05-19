output "container_names" {
  value       = [for c in azurerm_storage_container.vulnerable : c.name]
  description = "Liste des containers blob créés"

}

output "vulnerable_containers_urls" {
  value = {
    for k, c in azurerm_storage_container.vulnerable :
    k => "https://${azurerm_storage_account.vulnerable.name}.blob.core.windows.net/${c.name}"
  }
  description = "URLs publiques des conatiners (testables au navigateur, démonstrationde vulnérabilité)"
}