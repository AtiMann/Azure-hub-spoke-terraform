param (
    [string]$ResourceGroupName = "rg-terraform-state",
    [string]$Location = "northeurope",
    [string]$StorageAccountName = "tfstate$(Get-Random -Minimum 10000 -Maximum 99999)",
    [string]$ContainerName = "tfstate"
)

New-AzResourceGroup -Name $ResourceGroupName -Location $Location

$storageAccount = New-AzStorageAccount `
    -Name $StorageAccountName `
    -Location $Location `
    -ResourceGroupName $ResourceGroupName `
    -SkuName Standard_LRS `
    -AllowBlobPublicAccess $false `
    -MinimumTlsVersion TLS1_2

New-AzStorageContainer -Name $ContainerName -Context $storageAccount.Context

Write-Host "Remote state backend ready. Storage Account: $($storageAccount.StorageAccountName)" -ForegroundColor Green