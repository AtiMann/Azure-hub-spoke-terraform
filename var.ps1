$resourcegroupname = "rg-terraform-state"
$location = "northeurope"
$storageaccountname = "tfstateaccounttestati01"
$containername = "tfstate"

New-AzResourceGroup -Name $resourcegroupname -Location $location

$storageaccount = New-AzStorageAccount `
    -Name $storageaccountname `
    -Location $location `
    -ResourceGroupName $resourcegroupname `
    -SkuName Standard_LRS `
    -AllowBlobPublicAccess $false

$context = $storageaccount.Context
New-AzStorageContainer -Name $containername -Context $context

Write-Host "Kész a storageaccount. A neve: $($storageaccount.StorageAccountName)" -ForegroundColor Blue
