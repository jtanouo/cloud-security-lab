# =============================================================
# network.tf — Couche réseau (lab-vulnerable)
# =============================================================
# ATTENTION : ce réseau contient des règles NSG volontairement
# dangereuses pour servir de cobaye aux audits de sécurité.
#
# NE PAS COPIER tel quel en environnement réel.
# =============================================================

# -------------------------------------------------------------
# Virtual Network
# -------------------------------------------------------------

resource "azurerm_virtual_network" "vulnerable" {
  name                = "vnet-seclab-vuln"
  resource_group_name = data.azurerm_resource_group.main.name
  location            = data.azurerm_resource_group.main.location
  address_space       = ["10.0.0.0/16"]

  tags = local.common_tags
}

# -------------------------------------------------------------
# Subnet
# -------------------------------------------------------------

resource "azurerm_subnet" "vulnerable" {
  name                 = "snet-seclab-vuln"
  resource_group_name  = data.azurerm_resource_group.main.name
  virtual_network_name = azurerm_virtual_network.vulnerable.name
  address_prefixes     = ["10.0.1.0/24"]

}

# -------------------------------------------------------------
# Network Security Group VOLONTAIREMENT vulnérable
# -------------------------------------------------------------
# Écarts CIS introduits volontairement :
#   - SSH (22) ouvert depuis Internet entier
#   - RDP (3389) ouvert depuis Internet entier
#   - Recommandé : restreindre la source à des IP connues,
#     ou mieux, supprimer l'accès public (Bastion)
# -------------------------------------------------------------

resource "azurerm_network_security_group" "vulnerable" {
  name                = "nsg-seclab-vuln"
  resource_group_name = data.azurerm_resource_group.main.name
  location            = data.azurerm_resource_group.main.location

  # 🚨 Règle vulnérable n°1 : SSH ouvert au monde

  security_rule {
    name                       = "Allow-SSH-From-Internet"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*" # N'importe qui sur Internet
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "Allow-RDP-From-Internet"
    priority                   = 110
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  tags = local.common_tags

}

# -------------------------------------------------------------
# Association NSG <-> Subnet
# -------------------------------------------------------------

resource "azurerm_subnet_network_security_group_association" "vulnerable" {
  subnet_id                 = azurerm_subnet.vulnerable.id
  network_security_group_id = azurerm_network_security_group.vulnerable.id
}