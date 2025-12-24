# Quick Setup Guide - Examples Folder

## What You Got

New example files that work with the **updated NSG module** structure.

## Files for `examples/nsg/` folder:

1. ✅ **main.tf** - 3 NSG examples (web, database, management)
2. ✅ **main-simple.tf.example** - Simple 1-NSG version
3. ✅ **providers.tf** - Azure provider config
4. ✅ **variables.tf** - Input variables
5. ✅ **terraform.tfvars** - Your values (update subscription ID)
6. ✅ **versions.tf** - Provider versions
7. ✅ **backend.tf** - Terraform Enterprise config
8. ✅ **README.md** - Complete instructions

## Key Changes from Your Old Example

### ❌ OLD (Your current):
```hcl
module "nsg" {
  source = "git::ssh://..."  # Git source
  
  tags = {
    owner   = "AG"
    purpose = "nsg-test"  # Too short!
  }
  
  security_rules = {  # Old structure
    allow_ssh = { ... }
  }
}
```

### ✅ NEW (Updated):
```hcl
module "nsg" {
  source = "../../"  # Local module for testing
  
  name                = "web-tier"  # NEW: Required
  resource_group_name = azurerm_resource_group.test.name
  location            = azurerm_resource_group.test.location
  environment         = "dev"  # NEW: Required
  namespace           = "test-app"  # NEW: Required
  
  ingress_rules = {  # NEW: Structured like AWS
    from_cidrs = {
      tcp = {
        "443" = { cidrs = ["0.0.0.0/0"], to_port = 443 }
      }
      udp  = {}
      icmp = {}
    }
    from_nsgs = { tcp = {}, udp = {} }
  }
  
  egress_rules = {
    to_cidrs = {}
    to_nsgs  = {}
  }
  
  enable_any_egress = true
  
  tags = {
    architecture       = "native"
    owner              = "platform_team"
    purpose            = "Network security group for web tier applications handling HTTP and HTTPS traffic for testing."  # >40 chars!
    terraform_resource = "true"
    appid              = "app-test-001"
  }
}
```

## Quick Start

### Step 1: Copy Files to Your Repo

Copy these downloaded files to your repo:
```
your-repo/
└── terraform-azurerm-network_security_group/
    └── examples/
        └── nsg/
            ├── backend.tf          ← Copy
            ├── main.tf             ← Copy (replaces your old one)
            ├── main-simple.tf.example  ← Optional
            ├── providers.tf        ← Copy (replaces your old one)
            ├── terraform.tfvars    ← Update subscription_id
            ├── variables.tf        ← Copy
            ├── versions.tf         ← Copy
            └── README.md           ← Copy
```

### Step 2: Update Configuration

#### 2.1 Update `backend.tf`:
```hcl
terraform {
  backend "remote" {
    organization = "your-tfe-org"           # ← Update
    workspaces {
      name = "azure-nsg-module-test"         # ← Update
    }
  }
}
```

#### 2.2 Update `terraform.tfvars`:
```hcl
subscription_id = "0d98a043-e118-4663-9af7-967445480f49"  # Your sandbox sub
```

#### 2.3 Set in TFE Workspace (sensitive):
- `TF_VAR_tenant_id`
- `TF_VAR_client_id`
- `TF_VAR_client_secret`

### Step 3: Test

```bash
cd examples/nsg
terraform init
terraform plan
terraform apply
```

## What Gets Created

After `terraform apply`:

### Resource Group
- **Name**: `rg-nsg-module-test`
- **Location**: `eastus`

### 3 NSGs with Rules

#### 1. Web Tier NSG
- Name: `test-app-dev-web-tier-<random>`
- Rules: HTTPS (443), HTTP (80), SSH (22), DNS (53)
- Egress: Allow all
- Self-to-self: Enabled

#### 2. Database Tier NSG
- Name: `test-app-dev-database-tier-<random>`
- Rules: MySQL (3306), PostgreSQL (5432)
- Egress: Restricted (no allow-all)
- Self-to-self: Enabled

#### 3. Management NSG
- Name: `test-app-dev-management-<random>`
- Rules: SSH (22), RDP (3389)
- Egress: Allow all
- Self-to-self: Disabled

## Verify in Azure Portal

1. Login to Azure Portal
2. Go to Resource Groups
3. Find `rg-nsg-module-test`
4. Check each NSG
5. Verify:
   - ✅ Inbound rules
   - ✅ Outbound rules
   - ✅ Tags
   - ✅ Priorities

## Simple Version (For Quick Test)

If you want just ONE NSG for quick testing:

```bash
# Rename the simple version
mv main-simple.tf.example main-simple.tf

# Rename the full version
mv main.tf main-full.tf

# Use simple version
mv main-simple.tf main.tf

# Test
terraform init
terraform plan
terraform apply
```

This creates just 1 NSG instead of 3.

## Cleanup

**Always destroy after testing!**

```bash
terraform destroy
```

## Troubleshooting

### Module not found
- Check `source = "../../"` path
- Your structure should be:
  ```
  terraform-azurerm-network_security_group/
  ├── main.tf (module)
  ├── variables.tf (module)
  └── examples/
      └── nsg/
          └── main.tf (this example)
  ```

### Tag validation error
- Ensure `purpose` is >40 characters
- Starts with capital letter
- Ends with period

### Authentication error
- Check TFE workspace variables
- Verify service principal has permissions

## Next Steps

1. ✅ Copy files to your repo
2. ✅ Update backend.tf and terraform.tfvars
3. ✅ Run terraform init
4. ✅ Run terraform plan
5. ✅ Verify the plan looks good
6. ✅ Run terraform apply
7. ✅ Check Azure Portal
8. ✅ Run terraform destroy

---

**You're ready to test!** 🚀
