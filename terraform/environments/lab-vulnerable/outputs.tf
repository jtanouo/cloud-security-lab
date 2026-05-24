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

# --- Outputs réseau ---
output "vnet_name" {
  value       = azurerm_virtual_network.vulnerable.name
  description = "Nom du Virtual Network"

}

output "vnet_address_space" {
  value       = azurerm_virtual_network.vulnerable.address_space
  description = "Plage d'adresses du VNet"

}

output "nsg_dangerous_rules" {
  value = [
    for rule in azurerm_network_security_group.vulnerable.security_rule :
    "${rule.name} : port ${rule.destination_port_range} ouvert depuis ${rule.source_address_prefix}"
  ]
  description = "Liste des règles NSG dangereuses (pour audit)"
}

output "key_vault_name" {
  value       = azurerm_key_vault.vulnerable.name
  description = "Nom du Key Vault"
}

output "key_vault_uri" {
  value       = azurerm_key_vault.vulnerable.vault_uri
  description = "URI du Keu Vault"

}

output "key_vault_rbac_enabled" {
  value       = azurerm_key_vault.vulnerable.enable_rbac_authorization
  description = "Indique si le Key Vault utilise RBAC (false = access policies legacy)"

}