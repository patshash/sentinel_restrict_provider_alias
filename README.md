Example Terraform Sentinel Policy. 

This is only an example policy, designed to showcase how Sentinel can be used to restrict Provider Alias configuration parameters. 

The main.tf file contains a Provider configuration that will authenticate to a Vault cluster and read some data. 
This is the "root" Vault module and is used by default unless a Terraform resources is configured to use an alias Vault provider.

The `vault_alias` module declares a Vault Provider Alias configuration. This configuration uses a different Vault user to authenticate to the Vault cluster. 

There is a Sentinel policy `sentinel/restrict_vault_approle_users.sentinel` that will check for any Provider Aliases configuration for the Vault provider in a module.
It will then check the AppRole Authentication Role-id used in the Provider Alias and check this against a list of approved Roles.
