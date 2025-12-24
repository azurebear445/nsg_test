# NSG Module - Example Test Configuration

This example tests the Azure NSG module with Terraform Enterprise workspace.

## What This Tests

✅ **3 Different NSGs:**
1. **Web Tier** - Public-facing with HTTPS, HTTP, SSH
2. **Database Tier** - Private with MySQL, PostgreSQL
3. **Management** - Bastion/jump box with SSH, RDP

✅ **Features Tested:**
- Resource group creation
- Multiple ingress rules (TCP, UDP, ICMP)
- Multiple CIDR blocks
- Single ports and port ranges
- Egress rules
- Self-to-self communication
- Allow-all egress
- Tag validation
- Priority auto-assignment
- Different environments

## Prerequisites

1. **Terraform Enterprise Workspace** configured
2. **Azure Sandbox Subscription** access
3. **Service Principal** credentials
4. **VS Code** with Terraform extension (or CLI)

## File Structure

```
examples/nsg/
├── backend.tf          # Terraform Enterprise backend config
├── main.tf             # Example NSG configurations
├── providers.tf        # Azure provider configuration
├── variables.tf        # Input variables
├── terraform.tfvars    # Variable values (update with your details)
├── versions.tf         # Provider version constraints
└── README.md           # This file
```

## Setup Instructions

### Step 1: Update Configuration Files

#### 1.1 Update `backend.tf`
```hcl
terraform {
  backend "remote" {
    organization = "your-org-name"        # ← Update this
    workspaces {
      name = "azure-nsg-module-test"      # ← Update this
    }
  }
}
```

#### 1.2 Update `terraform.tfvars`
```hcl
subscription_id = "your-sandbox-subscription-id"  # ← Update this
```

#### 1.3 Set Sensitive Variables in TFE Workspace
In your Terraform Enterprise workspace, set these as **sensitive** environment variables:
- `TF_VAR_tenant_id` = your-azure-tenant-id
- `TF_VAR_client_id` = your-service-principal-client-id
- `TF_VAR_client_secret` = your-service-principal-secret

**OR** set them in `terraform.tfvars` (not recommended for security):
```hcl
tenant_id     = "your-tenant-id"
client_id     = "your-client-id"
client_secret = "your-client-secret"
```

### Step 2: Run from VS Code

```bash
# Navigate to examples folder
cd terraform-azurerm-network_security_group/examples/nsg

# Initialize (connects to TFE workspace)
terraform init

# Plan (runs in TFE workspace)
terraform plan

# Apply (creates resources in Azure sandbox)
terraform apply

# Verify in Azure Portal
# Navigate to: Resource Groups → rg-nsg-module-test

# Cleanup
terraform destroy
```

## Module Source Path

The example uses:
```hcl
source = "../../"
```

This assumes your folder structure is:
```
terraform-azurerm-network_security_group/
├── main.tf                    # Module root
├── variables.tf
├── locals.tf
├── tags.tf
├── outputs.tf
├── versions.tf
└── examples/
    └── nsg/
        └── main.tf            # This example
```

If your structure is different, update the `source` path in `main.tf`.

## Expected Results

After `terraform apply`, you should see in Azure Portal:

### Resource Group: `rg-nsg-module-test`
Located in: **East US**

### NSG 1: `test-app-dev-web-tier-<random>`
**Inbound Rules:**
- Priority 100: Allow TCP/443 from 0.0.0.0/0
- Priority 101: Allow TCP/80 from 0.0.0.0/0
- Priority 102: Allow TCP/22 from 10.0.0.0/8
- Priority 103: Allow UDP/53 from 10.0.0.0/8
- Priority 104: Allow all from VirtualNetwork to VirtualNetwork (self-to-self)

**Outbound Rules:**
- Priority 300: Allow all to 0.0.0.0/0

**Tags:**
- architecture: native
- owner: platform_team
- environment: dev
- Name: test-app-dev-web-tier-<random>
- (plus custom tags)

### NSG 2: `test-app-dev-database-tier-<random>`
**Inbound Rules:**
- Priority 100: Allow TCP/3306 from 10.0.1.0/24, 10.0.2.0/24
- Priority 101: Allow TCP/5432 from 10.0.1.0/24
- Priority 102: Allow all from VirtualNetwork to VirtualNetwork

**Outbound Rules:**
- (No allow-all egress - more restrictive)

### NSG 3: `test-app-dev-management-<random>`
**Inbound Rules:**
- Priority 100: Allow TCP/22 from 203.0.113.0/24
- Priority 101: Allow TCP/3389 from 203.0.113.0/24

**Outbound Rules:**
- Priority 300: Allow all to 0.0.0.0/0

## Customization

### Update CIDR Blocks
In `main.tf`, update the CIDR blocks to match your network:
```hcl
ingress_rules = {
  from_cidrs = {
    tcp = {
      "22" = {
        cidrs   = ["YOUR.IP.ADDRESS/32"]  # ← Update this
        to_port = 22
      }
    }
  }
}
```

### Add More Rules
```hcl
ingress_rules = {
  from_cidrs = {
    tcp = {
      "443" = { cidrs = ["0.0.0.0/0"], to_port = 443 }
      "8080" = { cidrs = ["10.0.0.0/8"], to_port = 8080 }  # ← Add new rule
    }
  }
}
```

### Change Environment
```hcl
environment = "qa"  # or "prod", "stage", etc.
```

### Disable Allow-All Egress
```hcl
enable_any_egress = false
```

## Troubleshooting

### Error: "Backend initialization required"
```bash
terraform init -reconfigure
```

### Error: "Unauthorized" or "Invalid credentials"
- Check service principal credentials in TFE workspace
- Verify subscription_id in terraform.tfvars
- Ensure service principal has Contributor role on subscription

### Error: "Tag validation failed"
- Ensure `purpose` is >40 characters
- Ensure it starts with capital letter and ends with period
- Ensure `architecture` is "native", "legacy", or "migrations"

### Error: "Module not found"
- Verify `source = "../../"` path is correct
- Check folder structure matches expected layout

### Error: "Resource group already exists"
- Change resource group name in main.tf
- Or delete existing resource group: `az group delete -n rg-nsg-module-test`

## Validation Checklist

After running `terraform apply`, verify:

- [ ] Resource group created in East US
- [ ] 3 NSGs created with correct names
- [ ] All tags present on each NSG
- [ ] Inbound rules created with correct priorities
- [ ] Outbound rules created
- [ ] CIDR blocks correct
- [ ] Port numbers correct
- [ ] Self-to-self rules present (web and database)
- [ ] Allow-all egress present (web and management)

## Cleanup

**IMPORTANT:** Always destroy test resources to avoid costs:

```bash
terraform destroy
```

Confirm by typing `yes` when prompted.

Verify in Azure Portal that the resource group is deleted.

## Next Steps

1. ✅ Test this example in sandbox
2. ✅ Verify all resources created correctly
3. ✅ Update with your actual network CIDRs
4. ✅ Adapt for your production environment names
5. ✅ Add Application Security Group examples (advanced)

## Support

For issues with the module, refer to:
- Main README: `../../README.md`
- Migration Guide: `../../MIGRATION.md`
- Implementation Guide: `../../IMPLEMENTATION.md`
