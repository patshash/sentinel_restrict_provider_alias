# Set configuration for Vault Provider Alias. 
# Declare this Alias profile name as "approle_priv_vault" 
provider "vault" {
    address = "https://vault.cloud:8200"
    namespace = ""

    auth_login {
      path = "auth/approle/login"

      parameters = {
        role_id = "b9280c4c"
        secret_id = ""
      }
    }
    alias = "approle_priv_vault"
}

# Read some data from Vault that is not accessible by default Vault provider config.
data "vault_kv_secret_v2" "nonprod" {
  provider = vault.approle_priv_vault
  mount = "kv"
  name  = "nonprod"
}

# Create a KV Entry to generate some more data. 
# Should only be accessible by "approle_priv_vault" configuration
resource "vault_kv_secret_v2" "example" {
  provider = vault.approle_priv_vault
  mount               = "kv"
  name                = "tf_secret"
  delete_all_versions = true
  data_json = jsonencode(
    {
      zip = "zap",
      foo = "bar"
    }
  )
}

# Read some more data from Vault that is not accessible by default Vault provider config.
data "vault_kv_secret_v2" "example" {
  provider = vault.approle_priv_vault
  mount = "kv"
  name  = vault_kv_secret_v2.example.name
}