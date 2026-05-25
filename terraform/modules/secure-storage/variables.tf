# =============================================================
# variables.tf — Module secure-storage
# =============================================================
# Interface d'entrée du module.
# Tous les défauts sont SECURE BY DEFAULT.
# =============================================================

variable "storage_account_name" {
    type = string 
    description = "Nom du Storage Account (3-24 caractères, minuscules + chiffres)"

    validation {
        condition = can(regex("[a-z0-9]{3,24}$", var.storage_account_name))
        error_message = "Le nom doit faire 3-24 caractères, en minuscules et chiffres uniquement."
    }
}

variable "resource_group_name" {
    type = string
    description = "Nom du Resource Group cible"
}

variable "location" {
    type = string
    description = "Region Azure"
}

variable "account_tier" {
    type = string
    description = "Tier du compte (Standard ou Premium)"
    default = "Standard"
}

variable "account_replication_type" {
  type = string
  description = "Type de réplication"
  default = "LRS"
}

# --- Paramètres de sécurité : SECURE BY DEFAULT ---

variable "min_tls_version" {
  type = string
  description = "Version TLS minimum"
  default = "TLS1_2"

  validation {
    condition = var.min_tls_version == "TLS1_2"
    error_message = "Pour des raisons de sécurité, seul TLS1_2 est autorisé."
  }
}

variable "public_network_access_enabled" {
    type = bool
    description = "Autoriser l'accès réseau public"
    default = false  
}

variable "allow_blob_public_access" {
  type = bool
  description = "Autoriser l'accès public aux blobs"
  default = false
}

variable "tags" {
  type = map(string)
  description = "Tags à appliquer"
  default = {}
}