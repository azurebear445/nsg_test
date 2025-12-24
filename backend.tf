# =============================================================================
# Terraform Enterprise Backend Configuration
# =============================================================================
# This configures the backend to use Terraform Enterprise workspace
# Update the organization and workspace names to match your setup
# =============================================================================

terraform {
  backend "remote" {
    organization = "your-organization-name"  # Replace with your TFE organization

    workspaces {
      name = "azure-nsg-module-test"  # Replace with your workspace name
    }
  }
}
