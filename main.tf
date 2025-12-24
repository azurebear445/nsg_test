# =============================================================================
# Azure NSG Module - Example Test Configuration
# =============================================================================
# This example demonstrates using the NSG module with Terraform Enterprise
# workspace and Azure sandbox subscription
# =============================================================================

# Create Resource Group for testing
resource "azurerm_resource_group" "test" {
  name     = "rg-nsg-module-test"
  location = "eastus"
}

# =============================================================================
# Test NSG 1: Web Tier with Multiple Rules
# =============================================================================
module "nsg_web" {
  source = "../../"  # Points to root module (adjust path based on your structure)

  name                = "web-tier"
  resource_group_name = azurerm_resource_group.test.name
  location            = azurerm_resource_group.test.location
  environment         = "dev"
  namespace           = "test-app"

  # Ingress rules - TCP, UDP, ICMP
  ingress_rules = {
    from_cidrs = {
      tcp = {
        "443" = {
          cidrs   = ["0.0.0.0/0"]
          to_port = 443
        }
        "80" = {
          cidrs   = ["0.0.0.0/0"]
          to_port = 80
        }
        "22" = {
          cidrs   = ["10.0.0.0/8"]
          to_port = 22
        }
      }
      udp = {
        "53" = {
          cidrs   = ["10.0.0.0/8"]
          to_port = 53
        }
      }
      icmp = {}
    }
    from_nsgs = {
      tcp = {}
      udp = {}
    }
  }

  # Egress rules
  egress_rules = {
    to_cidrs = {}
    to_nsgs  = {}
  }

  # Enable all egress
  enable_any_egress = true

  # Enable self-to-self communication
  enable_any_nsg_to_self = true

  # Tags - matching AWS module structure
  tags = {
    architecture       = "native"
    owner              = "platform_team"
    purpose            = "Network security group for web tier applications handling HTTP and HTTPS traffic for testing."
    terraform_resource = "true"
    appid              = "app-test-001"
    custom_tags = {
      team        = "infrastructure"
      cost_center = "engineering"
      test_id     = "sandbox-001"
    }
  }
}

# =============================================================================
# Test NSG 2: Database Tier (Restrictive)
# =============================================================================
module "nsg_database" {
  source = "../../"

  name                = "database-tier"
  resource_group_name = azurerm_resource_group.test.name
  location            = azurerm_resource_group.test.location
  environment         = "dev"
  namespace           = "test-app"

  # Only specific ingress from private networks
  ingress_rules = {
    from_cidrs = {
      tcp = {
        "3306" = {
          cidrs   = ["10.0.1.0/24", "10.0.2.0/24"]
          to_port = 3306
        }
        "5432" = {
          cidrs   = ["10.0.1.0/24"]
          to_port = 5432
        }
      }
      udp  = {}
      icmp = {}
    }
    from_nsgs = {
      tcp = {}
      udp = {}
    }
  }

  egress_rules = {
    to_cidrs = {}
    to_nsgs  = {}
  }

  # No allow-all egress for security
  enable_any_egress = false

  # Allow self-to-self for cluster communication
  enable_any_nsg_to_self = true

  tags = {
    architecture       = "native"
    owner              = "database_team"
    purpose            = "Network security group for database tier with restricted access from application subnets only."
    terraform_resource = "true"
    project            = "database-infrastructure"
    custom_tags = {
      environment_type = "sandbox"
      data_tier        = "database"
    }
  }
}

# =============================================================================
# Test NSG 3: Management/Jump Box
# =============================================================================
module "nsg_management" {
  source = "../../"

  name                = "management"
  resource_group_name = azurerm_resource_group.test.name
  location            = azurerm_resource_group.test.location
  environment         = "dev"
  namespace           = "test-app"

  ingress_rules = {
    from_cidrs = {
      tcp = {
        "22" = {
          cidrs   = ["203.0.113.0/24"]  # Replace with your IP
          to_port = 22
        }
        "3389" = {
          cidrs   = ["203.0.113.0/24"]  # Replace with your IP
          to_port = 3389
        }
      }
      udp  = {}
      icmp = {}
    }
    from_nsgs = {
      tcp = {}
      udp = {}
    }
  }

  egress_rules = {
    to_cidrs = {}
    to_nsgs  = {}
  }

  enable_any_egress      = true
  enable_any_nsg_to_self = false

  tags = {
    architecture       = "native"
    owner              = "security_team"
    purpose            = "Network security group for management and bastion hosts with restricted administrative access."
    terraform_resource = "true"
    serviceid          = "svc-management-001"
  }
}

# =============================================================================
# Outputs
# =============================================================================
output "nsg_web_id" {
  description = "Web tier NSG ID"
  value       = module.nsg_web.id
}

output "nsg_web_name" {
  description = "Web tier NSG name"
  value       = module.nsg_web.name
}

output "nsg_database_id" {
  description = "Database tier NSG ID"
  value       = module.nsg_database.id
}

output "nsg_database_name" {
  description = "Database tier NSG name"
  value       = module.nsg_database.name
}

output "nsg_management_id" {
  description = "Management NSG ID"
  value       = module.nsg_management.id
}

output "nsg_management_name" {
  description = "Management NSG name"
  value       = module.nsg_management.name
}

output "resource_group_name" {
  description = "Test resource group name"
  value       = azurerm_resource_group.test.name
}
