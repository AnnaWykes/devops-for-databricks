# Terraform Guidance

## Terraform Service Principal (SPN)

1) Create a new Service Principal in Azure.

   The Service Principal will need to assigns roles and set permissions (i.e. create a Key Vault Access Policy) therefore needs elevated permissions.

   1a) Create role using Azure CLI and assign one of the following permissions:
      - **`Owner`** if the service principal **`will`** assigns roles and set permissions
      - **`Contributor`** if the service principal **`will not`** assigns roles and set permissions
      <br/>

      *NOTE: this template assigns roles and set permissions for some resources*

      **Azure CLI snippet to create Service Principal:**

      ```
      $subscriptionId = "00000000-0000-0000-0000-000000000000"
      $appName        = "terraform-spn-<env>"

      az ad sp create-for-rbac `
         --name $appName `
         --role="<Owner/Contributor>" `
         --scopes="/subscriptions/$subscriptionId"
      ```

   1b) Create role using Azure CLI and assign custom role

      An equivalent to providing `Owner` role, is to create a service principal with custom role.

      To assigns roles and set permissions, the service principal will need `Microsoft.Authorization/*/Write` permissions.

2) Set and map the Service Principal values to the Local Environment variables for development purpose.

   | SPN values      |  | Environment Variable |
   | --------------- |--| -------------------- |
   | appId           |>>| ARM_CLIENT_ID        |
   | password        |>>| ARM_CLIENT_SECRET    |
   | tenant          |>>| ARM_TENANT_ID        |
   | subscription_id |>>| ARM_SUBSCRIPTION_ID  |


3. Add and map the Service Principal values to the Terraform variables in the `terraform.tfvars` for development purpose.

   | SPN values      |    | Terraform Variable |
   | --------------- | -- | ------------------ |
   | appId           | >> | client_id          |
   | password        | >> | client_secret      |
   | tenant          | >> | tenant_id          |
   | subscription_id | >> | subscription_id    |

<br>

## Backend Config
### Set up local machine

To execuate the Terraform on local machine you will need to add a `backend_config` folder with the following files but MUST not check into DevOps.
#### 1) backend_config/`backend_config.tfvars`
    ```
    ## Terraform Backend State
    tf_state_backend_key_name             = "<app_name>.<evn>.terraform.tfstate"
    tf_state_backend_resource_group_name  = "<backend_resource_group_name>"
    tf_state_backend_storage_account_name = "<backend_storage_account_name>"
    tf_state_backend_container_name       = "<backend_container_name>"

    ## Terraform Service Principal
    client_id           = "00000000-0000-0000-0000-000000000000"  # <<<< DO NOT CHECK IN  >>>>
    client_secret       = "00000000-0000-0000-0000-000000000000"  # <<<< DO NOT CHECK IN  >>>>
    tenant_id           = "00000000-0000-0000-0000-000000000000"  # <<<< DO NOT CHECK IN  >>>>
    subscription_id     = "00000000-0000-0000-0000-000000000000"  # <<<< DO NOT CHECK IN  >>>>
    ```

#### 2) backend_config/`tf_state_config.hcl`
    ```
    resource_group_name  = "<resource_group_name>"
    storage_account_name = "<storage_account_name>"
    container_name       = "<container_name>"
    ```

### Change Terraform Backend State
1) Amend the 'backend azurerm key' in `providers_azure.tf` file.

2) For local execution amend the 'tf_state_backend_key_name' in `backend_config.tfvars` file 

<br>

## Terraform Definition
- `.var` come from `variables.tf` files <br/>
- `.local` come from `local.tf` files

<br>

## Adding `Resource Modules`

To add new `Resource Module` folder:

1) `main.tf`
   - Add the resources with values or variables

2) `output.tf`
   - Add name of resources and any other value required for output

3) `variables.tf`
   - Add variables that were used in `main.tf`

<br>

## Adding Modules to `Environment` folder

To add new module to `Environment` folder:

1) `main.tf`
   - Add the new `Resource Module` block to the bottom of existing resources.
   - Enter the variable names that is used in the module rather then the values.

2) `output.tf`
   - Add name of resources and any other value required for output

3) `variables.tf`
   - Add variables that were used in `main.tf`, exclude any that is returned by the `local.tf` (i.e. any resource names)

4) `locals.tf`
   - Add variables that can be reused multiple times (i.e. names of resources)

5) `terraform.tfvars`
   - Add any new user input variables that required entering manually
   - Update any existing user input variables

## Removing Modules

When removing components or modules ensure they do not have dependencies.

1) Remove `Resource Module` block from the `Environment` folder
2) Remove any variables from the `variables.tf`, `locals.tf`, `output.tf` and `terraform.tfvars` files
3) Remove `Resource Module` folder
