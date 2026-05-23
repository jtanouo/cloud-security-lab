# =============================================================
# variables.tf — Paramètres d'entrée (lab-vulnerable)
# =============================================================

variable "resource_group_name" {
  type        = string
  description = "Nom du Resource Group existant où déployer"

  validation {
    condition     = can(regex("^rg-", var.resource_group_name))
    error_message = "Le nom du Resource groupe doit commencer par 'rg-' ."
  }

}

variable "location" {
  type        = string
  description = "Région Azure"
  default     = "westeurope"

  validation {
    condition     = contains(["westeurope", "notheurope", "francecentral"], var.location)
    error_message = "La région doit être westeurope, northeurope ou francecentral."
  }
}

variable "environment" {
  type        = string
  description = "Environment (dev, staging, prod)"

  validation {
    condition     = contains(["dev", "staging", "prod"], var.environment)
    error_message = "L'environnement doit être dev, staging ou prod"
  }
}

variable "project" {
  type        = string
  description = "Nom du projet (pour tagging)"
  default     = "cloud-security-lab"

}

variable "owner" {
  type        = string
  description = "Propriétaire (pour tagging)"

}

# --- Type list : noms des containers blob ---
variable "container_names" {
  type        = list(string)
  description = "Liste des containers blob à créer"
  default     = ["documents", "images", "logs"]
}

# --- Type object : configuration du storage account ---

variable "storage_config" {
  type = object({
    account_tier             = string
    account_replication_type = string
    min_tls_version          = string
    public_network_access    = bool
  })

  description = "Configuration du Storage Account"

  default = {
    account_tier             = "Standard"
    account_replication_type = "LRS"
    min_tls_version          = "TLS1_0"
    public_network_access    = true
  }

}