# =============================================================
# main.tf — Environnement "lab-hardened"
# =============================================================
# Ce fichier est un placeholder. Le vrai code arrivera en Phase 2.
# Pour l'instant, on configure juste le provider Azure.
# =============================================================

terraform {
  required_version = ">= 1.5.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.100"
    }
  }
}

# Configuration du provider Azure
provider "azurerm" {
  features {}

  # On gère manuellement l'enregistrement des providers
  # (via "az provider register" - voir session 1.4)
  # Note : Terraform suggère "resource_provider_registrations" dans son
  # message d'erreur, mais c'est un bug connu (issue #27110).
  # Le vrai nom est skip_provider_registration.
  skip_provider_registration = true
}


# Pour l'instant, on lit juste les infos du subscription actif.
# (data = lecture seule, pas de création)
data "azurerm_client_config" "current" {}

# Output : affiche le subscription ID après terraform apply
output "current_subscription_id" {
  value       = data.azurerm_client_config.current.subscription_id
  description = "ID du subscription Azure actif"
}