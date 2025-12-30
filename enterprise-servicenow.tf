# =============================================================================
# ServiceNow Enterprise Security Group Rules
# =============================================================================
# This file contains enterprise-managed ServiceNow rules that are automatically
# applied to NSGs based on the deployment region.
#
# Region Mapping:
#   - AWS us-east-1 (Virginia)    → Azure eastus (East US - Virginia Primary)
#   - AWS us-east-2 (Ohio)        → Azure eastus2 (East US 2 - Virginia Secondary)
#
# Note: Azure doesn't have an Ohio datacenter. Both eastus and eastus2 are in
#       Virginia, but we maintain the AWS us-east-1 vs us-east-2 rule separation
#       for compatibility with your existing AWS setup.
#
# You can adjust the region mapping by changing the conditional logic below.
# =============================================================================

locals {
  # =========================================================================
  # Region Mapping Configuration
  # =========================================================================
  # Define which Azure regions should get which set of rules.
  # Adjust these lists based on your actual Azure region deployment strategy.
  
  # Regions that should get "Virginia Primary" rules (from AWS us-east-1)
  virginia_primary_regions = ["eastus"]
  
  # Regions that should get "Virginia Secondary" rules (from AWS us-east-2)
  # Note: These were originally from AWS Ohio (us-east-2) but map to Azure eastus2
  virginia_secondary_regions = ["eastus2"]
  
  # Determine which rule set to apply based on var.location
  is_virginia_primary = contains(local.virginia_primary_regions, var.location)
  is_virginia_secondary = contains(local.virginia_secondary_regions, var.location)
  
  # =========================================================================
  # Virginia Primary Rules (from AWS us-east-1) - 60 Rules
  # =========================================================================
  # These rules are applied when deploying to regions in virginia_primary_regions
  # Source: AWS Security Group in us-east-1 (Virginia)
  
  servicenow_rules_virginia_primary = local.is_virginia_primary ? {

    "udp-138-10-1-248-0-24-inbound" = {
      protocol                   = "Udp"
      source_port_range          = "*"
      destination_port_range     = "138"
      source_address_prefix      = "10.1.248.0/24"
      destination_address_prefix = "*"
      direction                  = "Inbound"
      access                     = "Allow"
      priority                   = 100
      description                = "ServiceNow Enterprise Rule"
    }
    "udp-138-10-20-60-101-32-inbound" = {
      protocol                   = "Udp"
      source_port_range          = "*"
      destination_port_range     = "138"
      source_address_prefix      = "10.20.60.101/32"
      destination_address_prefix = "*"
      direction                  = "Inbound"
      access                     = "Allow"
      priority                   = 101
      description                = "ServiceNow Enterprise Rule"
    }
    "udp-138-10-111-19-0-24-inbound" = {
      protocol                   = "Udp"
      source_port_range          = "*"
      destination_port_range     = "138"
      source_address_prefix      = "10.111.19.0/24"
      destination_address_prefix = "*"
      direction                  = "Inbound"
      access                     = "Allow"
      priority                   = 102
      description                = "ServiceNow Enterprise Rule"
    }
    "tcp-13724-10-20-60-182-32-inbound" = {
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "13724"
      source_address_prefix      = "10.20.60.182/32"
      destination_address_prefix = "*"
      direction                  = "Inbound"
      access                     = "Allow"
      priority                   = 103
      description                = "ServiceNow Enterprise Rule"
    }
    "tcp-13724-10-20-60-203-32-inbound" = {
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "13724"
      source_address_prefix      = "10.20.60.203/32"
      destination_address_prefix = "*"
      direction                  = "Inbound"
      access                     = "Allow"
      priority                   = 104
      description                = "ServiceNow Enterprise Rule"
    }
    "tcp-49152-10-110-34-0-24-inbound" = {
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "49152"
      source_address_prefix      = "10.110.34.0/24"
      destination_address_prefix = "*"
      direction                  = "Inbound"
      access                     = "Allow"
      priority                   = 105
      description                = "ServiceNow Enterprise Rule"
    }
    "tcp-49152-10-111-32-0-24-inbound" = {
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "49152"
      source_address_prefix      = "10.111.32.0/24"
      destination_address_prefix = "*"
      direction                  = "Inbound"
      access                     = "Allow"
      priority                   = 106
      description                = "ServiceNow Enterprise Rule"
    }
    "tcp-3389-10-71-44-0-24-inbound" = {
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "3389"
      source_address_prefix      = "10.71.44.0/24"
      destination_address_prefix = "*"
      direction                  = "Inbound"
      access                     = "Allow"
      priority                   = 107
      description                = "ServiceNow Enterprise Rule"
    }
    "tcp-3389-10-72-44-0-24-inbound" = {
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "3389"
      source_address_prefix      = "10.72.44.0/24"
      destination_address_prefix = "*"
      direction                  = "Inbound"
      access                     = "Allow"
      priority                   = 108
      description                = "ServiceNow Enterprise Rule"
    }
    "tcp-445-10-20-60-101-32-inbound" = {
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "445"
      source_address_prefix      = "10.20.60.101/32"
      destination_address_prefix = "*"
      direction                  = "Inbound"
      access                     = "Allow"
      priority                   = 109
      description                = "ServiceNow Enterprise Rule"
    }
    "tcp-445-10-1-248-0-24-inbound" = {
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "445"
      source_address_prefix      = "10.1.248.0/24"
      destination_address_prefix = "*"
      direction                  = "Inbound"
      access                     = "Allow"
      priority                   = 110
      description                = "ServiceNow Enterprise Rule"
    }
    "tcp-445-10-111-19-0-24-inbound" = {
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "445"
      source_address_prefix      = "10.111.19.0/24"
      destination_address_prefix = "*"
      direction                  = "Inbound"
      access                     = "Allow"
      priority                   = 111
      description                = "ServiceNow Enterprise Rule"
    }
    "tcp-445-10-110-34-0-24-inbound" = {
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "445"
      source_address_prefix      = "10.110.34.0/24"
      destination_address_prefix = "*"
      direction                  = "Inbound"
      access                     = "Allow"
      priority                   = 112
      description                = "ServiceNow Enterprise Rule"
    }
    "tcp-445-10-111-32-0-24-inbound" = {
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "445"
      source_address_prefix      = "10.111.32.0/24"
      destination_address_prefix = "*"
      direction                  = "Inbound"
      access                     = "Allow"
      priority                   = 113
      description                = "ServiceNow Enterprise Rule"
    }
    "tcp-443-10-71-44-0-24-inbound" = {
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "443"
      source_address_prefix      = "10.71.44.0/24"
      destination_address_prefix = "*"
      direction                  = "Inbound"
      access                     = "Allow"
      priority                   = 114
      description                = "ServiceNow Enterprise Rule"
    }
    "tcp-443-10-72-44-0-24-inbound" = {
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "443"
      source_address_prefix      = "10.72.44.0/24"
      destination_address_prefix = "*"
      direction                  = "Inbound"
      access                     = "Allow"
      priority                   = 115
      description                = "ServiceNow Enterprise Rule"
    }
    "tcp-5985-10-110-34-0-24-inbound" = {
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "5985"
      source_address_prefix      = "10.110.34.0/24"
      destination_address_prefix = "*"
      direction                  = "Inbound"
      access                     = "Allow"
      priority                   = 116
      description                = "ServiceNow Enterprise Rule"
    }
    "tcp-5985-10-111-32-0-24-inbound" = {
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "5985"
      source_address_prefix      = "10.111.32.0/24"
      destination_address_prefix = "*"
      direction                  = "Inbound"
      access                     = "Allow"
      priority                   = 117
      description                = "ServiceNow Enterprise Rule"
    }
    "tcp-4974-10-20-60-101-32-inbound" = {
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "4974"
      source_address_prefix      = "10.20.60.101/32"
      destination_address_prefix = "*"
      direction                  = "Inbound"
      access                     = "Allow"
      priority                   = 118
      description                = "ServiceNow Enterprise Rule"
    }
    "tcp-4974-10-1-248-0-24-inbound" = {
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "4974"
      source_address_prefix      = "10.1.248.0/24"
      destination_address_prefix = "*"
      direction                  = "Inbound"
      access                     = "Allow"
      priority                   = 119
      description                = "ServiceNow Enterprise Rule"
    }
    "tcp-4974-10-111-19-0-24-inbound" = {
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "4974"
      source_address_prefix      = "10.111.19.0/24"
      destination_address_prefix = "*"
      direction                  = "Inbound"
      access                     = "Allow"
      priority                   = 120
      description                = "ServiceNow Enterprise Rule"
    }
    "tcp-5500-10-71-44-0-24-inbound" = {
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "5500"
      source_address_prefix      = "10.71.44.0/24"
      destination_address_prefix = "*"
      direction                  = "Inbound"
      access                     = "Allow"
      priority                   = 121
      description                = "ServiceNow Enterprise Rule"
    }
    "tcp-5500-10-72-44-0-24-inbound" = {
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "5500"
      source_address_prefix      = "10.72.44.0/24"
      destination_address_prefix = "*"
      direction                  = "Inbound"
      access                     = "Allow"
      priority                   = 122
      description                = "ServiceNow Enterprise Rule"
    }
    "-1-all-10-111-14-251-32-inbound" = {
      protocol                   = "*"
      source_port_range          = "*"
      destination_port_range     = "*"
      source_address_prefix      = "10.111.14.251/32"
      destination_address_prefix = "*"
      direction                  = "Inbound"
      access                     = "Allow"
      priority                   = 123
      description                = "ServiceNow Enterprise Rule"
    }
    "udp-137-10-20-60-101-32-inbound" = {
      protocol                   = "Udp"
      source_port_range          = "*"
      destination_port_range     = "137"
      source_address_prefix      = "10.20.60.101/32"
      destination_address_prefix = "*"
      direction                  = "Inbound"
      access                     = "Allow"
      priority                   = 124
      description                = "ServiceNow Enterprise Rule"
    }
    "udp-137-10-1-248-0-24-inbound" = {
      protocol                   = "Udp"
      source_port_range          = "*"
      destination_port_range     = "137"
      source_address_prefix      = "10.1.248.0/24"
      destination_address_prefix = "*"
      direction                  = "Inbound"
      access                     = "Allow"
      priority                   = 125
      description                = "ServiceNow Enterprise Rule"
    }
    "udp-137-10-111-19-0-24-inbound" = {
      protocol                   = "Udp"
      source_port_range          = "*"
      destination_port_range     = "137"
      source_address_prefix      = "10.111.19.0/24"
      destination_address_prefix = "*"
      direction                  = "Inbound"
      access                     = "Allow"
      priority                   = 126
      description                = "ServiceNow Enterprise Rule"
    }
    "tcp-1556-10-20-60-203-32-inbound" = {
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "1556"
      source_address_prefix      = "10.20.60.203/32"
      destination_address_prefix = "*"
      direction                  = "Inbound"
      access                     = "Allow"
      priority                   = 127
      description                = "ServiceNow Enterprise Rule"
    }
    "tcp-1556-10-20-60-182-32-inbound" = {
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "1556"
      source_address_prefix      = "10.20.60.182/32"
      destination_address_prefix = "*"
      direction                  = "Inbound"
      access                     = "Allow"
      priority                   = 128
      description                = "ServiceNow Enterprise Rule"
    }
    "tcp-22-10-71-44-0-24-inbound" = {
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "22"
      source_address_prefix      = "10.71.44.0/24"
      destination_address_prefix = "*"
      direction                  = "Inbound"
      access                     = "Allow"
      priority                   = 129
      description                = "ServiceNow Enterprise Rule"
    }
    "tcp-22-10-72-44-0-24-inbound" = {
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "22"
      source_address_prefix      = "10.72.44.0/24"
      destination_address_prefix = "*"
      direction                  = "Inbound"
      access                     = "Allow"
      priority                   = 130
      description                = "ServiceNow Enterprise Rule"
    }
    "tcp-22-10-111-32-0-24-inbound" = {
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "22"
      source_address_prefix      = "10.111.32.0/24"
      destination_address_prefix = "*"
      direction                  = "Inbound"
      access                     = "Allow"
      priority                   = 131
      description                = "ServiceNow Enterprise Rule"
    }
    "tcp-22-10-110-34-0-24-inbound" = {
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "22"
      source_address_prefix      = "10.110.34.0/24"
      destination_address_prefix = "*"
      direction                  = "Inbound"
      access                     = "Allow"
      priority                   = 132
      description                = "ServiceNow Enterprise Rule"
    }
    "udp-1813-10-72-44-0-24-inbound" = {
      protocol                   = "Udp"
      source_port_range          = "*"
      destination_port_range     = "1813"
      source_address_prefix      = "10.72.44.0/24"
      destination_address_prefix = "*"
      direction                  = "Inbound"
      access                     = "Allow"
      priority                   = 133
      description                = "ServiceNow Enterprise Rule"
    }
    "udp-1813-10-71-44-0-24-inbound" = {
      protocol                   = "Udp"
      source_port_range          = "*"
      destination_port_range     = "1813"
      source_address_prefix      = "10.71.44.0/24"
      destination_address_prefix = "*"
      direction                  = "Inbound"
      access                     = "Allow"
      priority                   = 134
      description                = "ServiceNow Enterprise Rule"
    }
    "tcp-4972-10-20-60-101-32-inbound" = {
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "4972"
      source_address_prefix      = "10.20.60.101/32"
      destination_address_prefix = "*"
      direction                  = "Inbound"
      access                     = "Allow"
      priority                   = 135
      description                = "ServiceNow Enterprise Rule"
    }
    "tcp-4972-10-1-248-0-24-inbound" = {
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "4972"
      source_address_prefix      = "10.1.248.0/24"
      destination_address_prefix = "*"
      direction                  = "Inbound"
      access                     = "Allow"
      priority                   = 136
      description                = "ServiceNow Enterprise Rule"
    }
    "tcp-4972-10-111-19-0-24-inbound" = {
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "4972"
      source_address_prefix      = "10.111.19.0/24"
      destination_address_prefix = "*"
      direction                  = "Inbound"
      access                     = "Allow"
      priority                   = 137
      description                = "ServiceNow Enterprise Rule"
    }
    "tcp-15671-10-111-19-0-24-inbound" = {
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "15671"
      source_address_prefix      = "10.111.19.0/24"
      destination_address_prefix = "*"
      direction                  = "Inbound"
      access                     = "Allow"
      priority                   = 138
      description                = "ServiceNow Enterprise Rule"
    }
    "tcp-1858-10-72-44-0-24-inbound" = {
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "1858"
      source_address_prefix      = "10.72.44.0/24"
      destination_address_prefix = "*"
      direction                  = "Inbound"
      access                     = "Allow"
      priority                   = 139
      description                = "ServiceNow Enterprise Rule"
    }
    "tcp-1858-10-71-44-0-24-inbound" = {
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "1858"
      source_address_prefix      = "10.71.44.0/24"
      destination_address_prefix = "*"
      direction                  = "Inbound"
      access                     = "Allow"
      priority                   = 140
      description                = "ServiceNow Enterprise Rule"
    }
    "tcp-139-10-1-248-0-24-inbound" = {
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "139"
      source_address_prefix      = "10.1.248.0/24"
      destination_address_prefix = "*"
      direction                  = "Inbound"
      access                     = "Allow"
      priority                   = 141
      description                = "ServiceNow Enterprise Rule"
    }
    "tcp-139-10-20-60-101-32-inbound" = {
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "139"
      source_address_prefix      = "10.20.60.101/32"
      destination_address_prefix = "*"
      direction                  = "Inbound"
      access                     = "Allow"
      priority                   = 142
      description                = "ServiceNow Enterprise Rule"
    }
    "tcp-139-10-111-19-0-24-inbound" = {
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "139"
      source_address_prefix      = "10.111.19.0/24"
      destination_address_prefix = "*"
      direction                  = "Inbound"
      access                     = "Allow"
      priority                   = 143
      description                = "ServiceNow Enterprise Rule"
    }
    "tcp-135-10-20-60-101-32-inbound" = {
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "135"
      source_address_prefix      = "10.20.60.101/32"
      destination_address_prefix = "*"
      direction                  = "Inbound"
      access                     = "Allow"
      priority                   = 144
      description                = "ServiceNow Enterprise Rule"
    }
    "tcp-135-10-1-248-0-24-inbound" = {
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "135"
      source_address_prefix      = "10.1.248.0/24"
      destination_address_prefix = "*"
      direction                  = "Inbound"
      access                     = "Allow"
      priority                   = 145
      description                = "ServiceNow Enterprise Rule"
    }
    "tcp-135-10-111-19-0-24-inbound" = {
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "135"
      source_address_prefix      = "10.111.19.0/24"
      destination_address_prefix = "*"
      direction                  = "Inbound"
      access                     = "Allow"
      priority                   = 146
      description                = "ServiceNow Enterprise Rule"
    }
    "tcp-135-10-110-34-0-24-inbound" = {
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "135"
      source_address_prefix      = "10.110.34.0/24"
      destination_address_prefix = "*"
      direction                  = "Inbound"
      access                     = "Allow"
      priority                   = 147
      description                = "ServiceNow Enterprise Rule"
    }
    "tcp-135-10-111-32-0-24-inbound" = {
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "135"
      source_address_prefix      = "10.111.32.0/24"
      destination_address_prefix = "*"
      direction                  = "Inbound"
      access                     = "Allow"
      priority                   = 148
      description                = "ServiceNow Enterprise Rule"
    }
    "tcp-636-10-72-44-0-24-inbound" = {
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "636"
      source_address_prefix      = "10.72.44.0/24"
      destination_address_prefix = "*"
      direction                  = "Inbound"
      access                     = "Allow"
      priority                   = 149
      description                = "ServiceNow Enterprise Rule"
    }
    "tcp-636-10-71-44-0-24-inbound" = {
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "636"
      source_address_prefix      = "10.71.44.0/24"
      destination_address_prefix = "*"
      direction                  = "Inbound"
      access                     = "Allow"
      priority                   = 150
      description                = "ServiceNow Enterprise Rule"
    }
    "tcp-13782-10-20-60-182-32-inbound" = {
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "13782"
      source_address_prefix      = "10.20.60.182/32"
      destination_address_prefix = "*"
      direction                  = "Inbound"
      access                     = "Allow"
      priority                   = 151
      description                = "ServiceNow Enterprise Rule"
    }
    "tcp-13782-10-20-60-203-32-inbound" = {
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "13782"
      source_address_prefix      = "10.20.60.203/32"
      destination_address_prefix = "*"
      direction                  = "Inbound"
      access                     = "Allow"
      priority                   = 152
      description                = "ServiceNow Enterprise Rule"
    }
    "tcp-5986-10-110-34-0-24-inbound" = {
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "5986"
      source_address_prefix      = "10.110.34.0/24"
      destination_address_prefix = "*"
      direction                  = "Inbound"
      access                     = "Allow"
      priority                   = 153
      description                = "ServiceNow Enterprise Rule"
    }
    "tcp-5986-10-111-32-0-24-inbound" = {
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "5986"
      source_address_prefix      = "10.111.32.0/24"
      destination_address_prefix = "*"
      direction                  = "Inbound"
      access                     = "Allow"
      priority                   = 154
      description                = "ServiceNow Enterprise Rule"
    }
    "tcp-60777-10-1-248-0-24-inbound" = {
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "60777"
      source_address_prefix      = "10.1.248.0/24"
      destination_address_prefix = "*"
      direction                  = "Inbound"
      access                     = "Allow"
      priority                   = 155
      description                = "ServiceNow Enterprise Rule"
    }
    "tcp-60777-10-20-60-101-32-inbound" = {
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "60777"
      source_address_prefix      = "10.20.60.101/32"
      destination_address_prefix = "*"
      direction                  = "Inbound"
      access                     = "Allow"
      priority                   = 156
      description                = "ServiceNow Enterprise Rule"
    }
    "tcp-60777-10-111-19-0--44-inbound" = {
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "60777"
      source_address_prefix      = "10.111.19.0/.44"
      destination_address_prefix = "*"
      direction                  = "Inbound"
      access                     = "Allow"
      priority                   = 157
      description                = "ServiceNow Enterprise Rule"
    }
    "tcp-4699-10-111-19-0-24-inbound" = {
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "4699"
      source_address_prefix      = "10.111.19.0/24"
      destination_address_prefix = "*"
      direction                  = "Inbound"
      access                     = "Allow"
      priority                   = 158
      description                = "ServiceNow Enterprise Rule"
    }
    "-1-all-0-0-0-0-0-outbound" = {
      protocol                   = "*"
      source_port_range          = "*"
      destination_port_range     = "*"
      source_address_prefix      = "0.0.0.0/0"
      destination_address_prefix = "*"
      direction                  = "Outbound"
      access                     = "Allow"
      priority                   = 159
      description                = "ServiceNow Enterprise Rule"
    }
  } : {}
  
  # =========================================================================
  # Virginia Secondary Rules (from AWS us-east-2) - 60 Rules
  # =========================================================================
  # These rules are applied when deploying to regions in virginia_secondary_regions
  # Source: AWS Security Group in us-east-2 (Ohio) - mapped to Azure eastus2
  # Note: Originally from AWS Ohio, but deployed to Azure Virginia eastus2 datacenter
  
  servicenow_rules_virginia_secondary = local.is_virginia_secondary ? {

    "udp-138-10-1-248-0-24-inbound" = {
      protocol                   = "Udp"
      source_port_range          = "*"
      destination_port_range     = "138"
      source_address_prefix      = "10.1.248.0/24"
      destination_address_prefix = "*"
      direction                  = "Inbound"
      access                     = "Allow"
      priority                   = 100
      description                = "ServiceNow Enterprise Rule"
    }
    "udp-138-10-20-60-101-32-inbound" = {
      protocol                   = "Udp"
      source_port_range          = "*"
      destination_port_range     = "138"
      source_address_prefix      = "10.20.60.101/32"
      destination_address_prefix = "*"
      direction                  = "Inbound"
      access                     = "Allow"
      priority                   = 101
      description                = "ServiceNow Enterprise Rule"
    }
    "udp-138-10-111-19-0-24-inbound" = {
      protocol                   = "Udp"
      source_port_range          = "*"
      destination_port_range     = "138"
      source_address_prefix      = "10.111.19.0/24"
      destination_address_prefix = "*"
      direction                  = "Inbound"
      access                     = "Allow"
      priority                   = 102
      description                = "ServiceNow Enterprise Rule"
    }
    "tcp-13724-10-20-60-182-32-inbound" = {
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "13724"
      source_address_prefix      = "10.20.60.182/32"
      destination_address_prefix = "*"
      direction                  = "Inbound"
      access                     = "Allow"
      priority                   = 103
      description                = "ServiceNow Enterprise Rule"
    }
    "tcp-13724-10-20-60-203-32-inbound" = {
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "13724"
      source_address_prefix      = "10.20.60.203/32"
      destination_address_prefix = "*"
      direction                  = "Inbound"
      access                     = "Allow"
      priority                   = 104
      description                = "ServiceNow Enterprise Rule"
    }
    "tcp-49152-65535-10-111-32-0-24-inbound" = {
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "49152-65535"
      source_address_prefix      = "10.111.32.0/24"
      destination_address_prefix = "*"
      direction                  = "Inbound"
      access                     = "Allow"
      priority                   = 105
      description                = "ServiceNow Enterprise Rule"
    }
    "tcp-49152-65535-10-110-34-0-24-inbound" = {
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "49152-65535"
      source_address_prefix      = "10.110.34.0/24"
      destination_address_prefix = "*"
      direction                  = "Inbound"
      access                     = "Allow"
      priority                   = 106
      description                = "ServiceNow Enterprise Rule"
    }
    "tcp-3389-10-71-44-0-24-inbound" = {
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "3389"
      source_address_prefix      = "10.71.44.0/24"
      destination_address_prefix = "*"
      direction                  = "Inbound"
      access                     = "Allow"
      priority                   = 107
      description                = "ServiceNow Enterprise Rule"
    }
    "tcp-3389-10-72-44-0-24-inbound" = {
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "3389"
      source_address_prefix      = "10.72.44.0/24"
      destination_address_prefix = "*"
      direction                  = "Inbound"
      access                     = "Allow"
      priority                   = 108
      description                = "ServiceNow Enterprise Rule"
    }
    "tcp-445-10-20-60-101-32-inbound" = {
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "445"
      source_address_prefix      = "10.20.60.101/32"
      destination_address_prefix = "*"
      direction                  = "Inbound"
      access                     = "Allow"
      priority                   = 109
      description                = "ServiceNow Enterprise Rule"
    }
    "tcp-445-10-111-19-0-24-inbound" = {
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "445"
      source_address_prefix      = "10.111.19.0/24"
      destination_address_prefix = "*"
      direction                  = "Inbound"
      access                     = "Allow"
      priority                   = 110
      description                = "ServiceNow Enterprise Rule"
    }
    "tcp-445-10-1-248-0-24-inbound" = {
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "445"
      source_address_prefix      = "10.1.248.0/24"
      destination_address_prefix = "*"
      direction                  = "Inbound"
      access                     = "Allow"
      priority                   = 111
      description                = "ServiceNow Enterprise Rule"
    }
    "tcp-445-10-110-34-0-24-inbound" = {
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "445"
      source_address_prefix      = "10.110.34.0/24"
      destination_address_prefix = "*"
      direction                  = "Inbound"
      access                     = "Allow"
      priority                   = 112
      description                = "ServiceNow Enterprise Rule"
    }
    "tcp-445-10-111-32-0-24-inbound" = {
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "445"
      source_address_prefix      = "10.111.32.0/24"
      destination_address_prefix = "*"
      direction                  = "Inbound"
      access                     = "Allow"
      priority                   = 113
      description                = "ServiceNow Enterprise Rule"
    }
    "tcp-443-10-71-44-0-24-inbound" = {
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "443"
      source_address_prefix      = "10.71.44.0/24"
      destination_address_prefix = "*"
      direction                  = "Inbound"
      access                     = "Allow"
      priority                   = 114
      description                = "ServiceNow Enterprise Rule"
    }
    "tcp-443-10-72-44-0-24-inbound" = {
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "443"
      source_address_prefix      = "10.72.44.0/24"
      destination_address_prefix = "*"
      direction                  = "Inbound"
      access                     = "Allow"
      priority                   = 115
      description                = "ServiceNow Enterprise Rule"
    }
    "tcp-5985-10-110-34-0-24-inbound" = {
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "5985"
      source_address_prefix      = "10.110.34.0/24"
      destination_address_prefix = "*"
      direction                  = "Inbound"
      access                     = "Allow"
      priority                   = 116
      description                = "ServiceNow Enterprise Rule"
    }
    "tcp-5985-10-111-32-0-24-inbound" = {
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "5985"
      source_address_prefix      = "10.111.32.0/24"
      destination_address_prefix = "*"
      direction                  = "Inbound"
      access                     = "Allow"
      priority                   = 117
      description                = "ServiceNow Enterprise Rule"
    }
    "tcp-4974-10-20-60-101-32-inbound" = {
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "4974"
      source_address_prefix      = "10.20.60.101/32"
      destination_address_prefix = "*"
      direction                  = "Inbound"
      access                     = "Allow"
      priority                   = 118
      description                = "ServiceNow Enterprise Rule"
    }
    "tcp-4974-10-1-248-0-24-inbound" = {
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "4974"
      source_address_prefix      = "10.1.248.0/24"
      destination_address_prefix = "*"
      direction                  = "Inbound"
      access                     = "Allow"
      priority                   = 119
      description                = "ServiceNow Enterprise Rule"
    }
    "tcp-4974-10-111-19-0-24-inbound" = {
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "4974"
      source_address_prefix      = "10.111.19.0/24"
      destination_address_prefix = "*"
      direction                  = "Inbound"
      access                     = "Allow"
      priority                   = 120
      description                = "ServiceNow Enterprise Rule"
    }
    "tcp-5500-10-71-44-0-24-inbound" = {
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "5500"
      source_address_prefix      = "10.71.44.0/24"
      destination_address_prefix = "*"
      direction                  = "Inbound"
      access                     = "Allow"
      priority                   = 121
      description                = "ServiceNow Enterprise Rule"
    }
    "tcp-5500-10-72-44-0-24-inbound" = {
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "5500"
      source_address_prefix      = "10.72.44.0/24"
      destination_address_prefix = "*"
      direction                  = "Inbound"
      access                     = "Allow"
      priority                   = 122
      description                = "ServiceNow Enterprise Rule"
    }
    "-1-all-10-111-14-251-32-inbound" = {
      protocol                   = "*"
      source_port_range          = "*"
      destination_port_range     = "*"
      source_address_prefix      = "10.111.14.251/32"
      destination_address_prefix = "*"
      direction                  = "Inbound"
      access                     = "Allow"
      priority                   = 123
      description                = "ServiceNow Enterprise Rule"
    }
    "udp-137-10-20-60-101-32-inbound" = {
      protocol                   = "Udp"
      source_port_range          = "*"
      destination_port_range     = "137"
      source_address_prefix      = "10.20.60.101/32"
      destination_address_prefix = "*"
      direction                  = "Inbound"
      access                     = "Allow"
      priority                   = 124
      description                = "ServiceNow Enterprise Rule"
    }
    "udp-137-10-111-19-0-24-inbound" = {
      protocol                   = "Udp"
      source_port_range          = "*"
      destination_port_range     = "137"
      source_address_prefix      = "10.111.19.0/24"
      destination_address_prefix = "*"
      direction                  = "Inbound"
      access                     = "Allow"
      priority                   = 125
      description                = "ServiceNow Enterprise Rule"
    }
    "udp-137-10-1-248-0-24-inbound" = {
      protocol                   = "Udp"
      source_port_range          = "*"
      destination_port_range     = "137"
      source_address_prefix      = "10.1.248.0/24"
      destination_address_prefix = "*"
      direction                  = "Inbound"
      access                     = "Allow"
      priority                   = 126
      description                = "ServiceNow Enterprise Rule"
    }
    "tcp-1556-10-20-60-203-32-inbound" = {
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "1556"
      source_address_prefix      = "10.20.60.203/32"
      destination_address_prefix = "*"
      direction                  = "Inbound"
      access                     = "Allow"
      priority                   = 127
      description                = "ServiceNow Enterprise Rule"
    }
    "tcp-1556-10-20-60-182-32-inbound" = {
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "1556"
      source_address_prefix      = "10.20.60.182/32"
      destination_address_prefix = "*"
      direction                  = "Inbound"
      access                     = "Allow"
      priority                   = 128
      description                = "ServiceNow Enterprise Rule"
    }
    "tcp-22-10-72-44-0-24-inbound" = {
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "22"
      source_address_prefix      = "10.72.44.0/24"
      destination_address_prefix = "*"
      direction                  = "Inbound"
      access                     = "Allow"
      priority                   = 129
      description                = "ServiceNow Enterprise Rule"
    }
    "tcp-22-10-71-44-0-24-inbound" = {
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "22"
      source_address_prefix      = "10.71.44.0/24"
      destination_address_prefix = "*"
      direction                  = "Inbound"
      access                     = "Allow"
      priority                   = 130
      description                = "ServiceNow Enterprise Rule"
    }
    "tcp-22-10-110-34-0-24-inbound" = {
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "22"
      source_address_prefix      = "10.110.34.0/24"
      destination_address_prefix = "*"
      direction                  = "Inbound"
      access                     = "Allow"
      priority                   = 131
      description                = "ServiceNow Enterprise Rule"
    }
    "tcp-22-10-111-32-0-24-inbound" = {
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "22"
      source_address_prefix      = "10.111.32.0/24"
      destination_address_prefix = "*"
      direction                  = "Inbound"
      access                     = "Allow"
      priority                   = 132
      description                = "ServiceNow Enterprise Rule"
    }
    "udp-1813-10-72-44-0-24-inbound" = {
      protocol                   = "Udp"
      source_port_range          = "*"
      destination_port_range     = "1813"
      source_address_prefix      = "10.72.44.0/24"
      destination_address_prefix = "*"
      direction                  = "Inbound"
      access                     = "Allow"
      priority                   = 133
      description                = "ServiceNow Enterprise Rule"
    }
    "udp-1813-10-71-44-0-24-inbound" = {
      protocol                   = "Udp"
      source_port_range          = "*"
      destination_port_range     = "1813"
      source_address_prefix      = "10.71.44.0/24"
      destination_address_prefix = "*"
      direction                  = "Inbound"
      access                     = "Allow"
      priority                   = 134
      description                = "ServiceNow Enterprise Rule"
    }
    "tcp-4972-10-111-19-0-24-inbound" = {
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "4972"
      source_address_prefix      = "10.111.19.0/24"
      destination_address_prefix = "*"
      direction                  = "Inbound"
      access                     = "Allow"
      priority                   = 135
      description                = "ServiceNow Enterprise Rule"
    }
    "tcp-4972-10-20-60-101-32-inbound" = {
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "4972"
      source_address_prefix      = "10.20.60.101/32"
      destination_address_prefix = "*"
      direction                  = "Inbound"
      access                     = "Allow"
      priority                   = 136
      description                = "ServiceNow Enterprise Rule"
    }
    "tcp-4972-10-1-248-0-24-inbound" = {
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "4972"
      source_address_prefix      = "10.1.248.0/24"
      destination_address_prefix = "*"
      direction                  = "Inbound"
      access                     = "Allow"
      priority                   = 137
      description                = "ServiceNow Enterprise Rule"
    }
    "tcp-15671-10-111-19-0-24-inbound" = {
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "15671"
      source_address_prefix      = "10.111.19.0/24"
      destination_address_prefix = "*"
      direction                  = "Inbound"
      access                     = "Allow"
      priority                   = 138
      description                = "ServiceNow Enterprise Rule"
    }
    "tcp-1858-10-72-44-0-24-inbound" = {
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "1858"
      source_address_prefix      = "10.72.44.0/24"
      destination_address_prefix = "*"
      direction                  = "Inbound"
      access                     = "Allow"
      priority                   = 139
      description                = "ServiceNow Enterprise Rule"
    }
    "tcp-1858-10-71-44-0-24-inbound" = {
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "1858"
      source_address_prefix      = "10.71.44.0/24"
      destination_address_prefix = "*"
      direction                  = "Inbound"
      access                     = "Allow"
      priority                   = 140
      description                = "ServiceNow Enterprise Rule"
    }
    "tcp-139-10-1-248-0-24-inbound" = {
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "139"
      source_address_prefix      = "10.1.248.0/24"
      destination_address_prefix = "*"
      direction                  = "Inbound"
      access                     = "Allow"
      priority                   = 141
      description                = "ServiceNow Enterprise Rule"
    }
    "tcp-139-10-20-60-101-32-inbound" = {
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "139"
      source_address_prefix      = "10.20.60.101/32"
      destination_address_prefix = "*"
      direction                  = "Inbound"
      access                     = "Allow"
      priority                   = 142
      description                = "ServiceNow Enterprise Rule"
    }
    "tcp-139-10-111-19-0-24-inbound" = {
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "139"
      source_address_prefix      = "10.111.19.0/24"
      destination_address_prefix = "*"
      direction                  = "Inbound"
      access                     = "Allow"
      priority                   = 143
      description                = "ServiceNow Enterprise Rule"
    }
    "tcp-135-10-111-19-0-24-inbound" = {
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "135"
      source_address_prefix      = "10.111.19.0/24"
      destination_address_prefix = "*"
      direction                  = "Inbound"
      access                     = "Allow"
      priority                   = 144
      description                = "ServiceNow Enterprise Rule"
    }
    "tcp-135-10-20-60-101-32-inbound" = {
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "135"
      source_address_prefix      = "10.20.60.101/32"
      destination_address_prefix = "*"
      direction                  = "Inbound"
      access                     = "Allow"
      priority                   = 145
      description                = "ServiceNow Enterprise Rule"
    }
    "tcp-135-10-1-248-0-24-inbound" = {
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "135"
      source_address_prefix      = "10.1.248.0/24"
      destination_address_prefix = "*"
      direction                  = "Inbound"
      access                     = "Allow"
      priority                   = 146
      description                = "ServiceNow Enterprise Rule"
    }
    "tcp-135-10-111-32-0-24-inbound" = {
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "135"
      source_address_prefix      = "10.111.32.0/24"
      destination_address_prefix = "*"
      direction                  = "Inbound"
      access                     = "Allow"
      priority                   = 147
      description                = "ServiceNow Enterprise Rule"
    }
    "tcp-135-10-110-34-0-24-inbound" = {
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "135"
      source_address_prefix      = "10.110.34.0/24"
      destination_address_prefix = "*"
      direction                  = "Inbound"
      access                     = "Allow"
      priority                   = 148
      description                = "ServiceNow Enterprise Rule"
    }
    "tcp-636-10-71-44-0-24-inbound" = {
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "636"
      source_address_prefix      = "10.71.44.0/24"
      destination_address_prefix = "*"
      direction                  = "Inbound"
      access                     = "Allow"
      priority                   = 149
      description                = "ServiceNow Enterprise Rule"
    }
    "tcp-636-10-72-44-0-24-inbound" = {
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "636"
      source_address_prefix      = "10.72.44.0/24"
      destination_address_prefix = "*"
      direction                  = "Inbound"
      access                     = "Allow"
      priority                   = 150
      description                = "ServiceNow Enterprise Rule"
    }
    "tcp-13782-10-20-60-182-32-inbound" = {
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "13782"
      source_address_prefix      = "10.20.60.182/32"
      destination_address_prefix = "*"
      direction                  = "Inbound"
      access                     = "Allow"
      priority                   = 151
      description                = "ServiceNow Enterprise Rule"
    }
    "tcp-13782-10-20-60-203-32-inbound" = {
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "13782"
      source_address_prefix      = "10.20.60.203/32"
      destination_address_prefix = "*"
      direction                  = "Inbound"
      access                     = "Allow"
      priority                   = 152
      description                = "ServiceNow Enterprise Rule"
    }
    "tcp-5986-10-110-34-0-24-inbound" = {
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "5986"
      source_address_prefix      = "10.110.34.0/24"
      destination_address_prefix = "*"
      direction                  = "Inbound"
      access                     = "Allow"
      priority                   = 153
      description                = "ServiceNow Enterprise Rule"
    }
    "tcp-5986-10-111-32-0-24-inbound" = {
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "5986"
      source_address_prefix      = "10.111.32.0/24"
      destination_address_prefix = "*"
      direction                  = "Inbound"
      access                     = "Allow"
      priority                   = 154
      description                = "ServiceNow Enterprise Rule"
    }
    "tcp-60777-10-1-248-0-24-inbound" = {
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "60777"
      source_address_prefix      = "10.1.248.0/24"
      destination_address_prefix = "*"
      direction                  = "Inbound"
      access                     = "Allow"
      priority                   = 155
      description                = "ServiceNow Enterprise Rule"
    }
    "tcp-60777-10-111-19-0-24-inbound" = {
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "60777"
      source_address_prefix      = "10.111.19.0/24"
      destination_address_prefix = "*"
      direction                  = "Inbound"
      access                     = "Allow"
      priority                   = 156
      description                = "ServiceNow Enterprise Rule"
    }
    "tcp-60777-10-20-60-101-32-inbound" = {
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "60777"
      source_address_prefix      = "10.20.60.101/32"
      destination_address_prefix = "*"
      direction                  = "Inbound"
      access                     = "Allow"
      priority                   = 157
      description                = "ServiceNow Enterprise Rule"
    }
    "tcp-4699-10-111-19-0-24-inbound" = {
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "4699"
      source_address_prefix      = "10.111.19.0/24"
      destination_address_prefix = "*"
      direction                  = "Inbound"
      access                     = "Allow"
      priority                   = 158
      description                = "ServiceNow Enterprise Rule"
    }
    "-1-all-0-0-0-0-0-outbound" = {
      protocol                   = "*"
      source_port_range          = "*"
      destination_port_range     = "*"
      source_address_prefix      = "0.0.0.0/0"
      destination_address_prefix = "*"
      direction                  = "Outbound"
      access                     = "Allow"
      priority                   = 159
      description                = "ServiceNow Enterprise Rule"
    }
  } : {}
  
  # =========================================================================
  # Final Merge
  # =========================================================================
  # Merge Virginia Primary and Secondary rules (only one will be populated based on region)
  # This ensures that:
  #   - eastus (Virginia Primary) gets 60 rules from AWS us-east-1
  #   - eastus2 (Virginia Secondary) gets 60 rules from AWS us-east-2 (originally Ohio)
  #   - Other regions get neither (empty)
  
  enterprise_servicenow_rules = merge(
    local.servicenow_rules_virginia_primary,
    local.servicenow_rules_virginia_secondary
  )
}
