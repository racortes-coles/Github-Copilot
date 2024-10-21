# Import the Azure module
Import-Module Az

# Authenticate to Azure
Connect-AzAccount

# Define variables
$resourceGroupName = "example-resources"
$location = "West Europe"
$keyVaultName = "examplekeyvault"

# Create the resource group if it doesn't exist
if (-not (Get-AzResourceGroup -Name $resourceGroupName -ErrorAction SilentlyContinue)) {
    New-AzResourceGroup -Name $resourceGroupName -Location $location
}

# Create the Key Vault
New-AzKeyVault -ResourceGroupName $resourceGroupName -VaultName $keyVaultName -Location $location -Sku Standard

# Optionally, set access policies (example for current user)
$currentUser = Get-AzADUser -UserPrincipalName (Get-AzContext).Account.Id
Set-AzKeyVaultAccessPolicy -VaultName $keyVaultName -ObjectId $currentUser.Id -PermissionsToKeys get,list -PermissionsToSecrets get,list -PermissionsToCertificates get,list