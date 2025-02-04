terraform { 
  cloud { 
    organization = "my-org" 
    workspaces { 
      name = "vault-sentinel-policy" 
    } 
  } 
}

provider "vault" {
    address = "https://vault.cloud:8200"
    namespace = ""  
}
# Test access to Vault by reading some secret data.
# Can only be read by Default Provider with elevated access.
data "vault_kv_secret_v2" "prod" {
  mount = "kv"
  name  = "my-prod"
}

# Call module that uses provider alias configuration
module "vault_alias" {
    source = "./modules/vault_alias"
}