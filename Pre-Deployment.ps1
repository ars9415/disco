# Taking parameters for the Pre-Deployment script
param
(
    [parameter(Mandatory = $true)] [String] $ResourceGroupName,
    [parameter(Mandatory = $true)] [String] $DataFactoryName
)

# Listing all the triggers in destination Data Factory
$Triggers = Get-AzDataFactoryV2Trigger -ResourceGroupName $ResourceGroupName -DataFactoryName $DataFactoryName

# Stopping all the triggers in destination data factory
foreach ($trigger in $Triggers) {
	Stop-AzDataFactoryV2Trigger -ResourceGroupName $ResourceGroupName -DataFactoryName $DataFactoryName -Name $trigger.Name -Force
  echo "$trigger.Name has been stopped."
}
