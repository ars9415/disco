# Taking parameters for the Post-Deployment script
param
(
    [parameter(Mandatory = $true)] [String] $ResourceGroupName,
    [parameter(Mandatory = $true)] [String] $DataFactoryName
)

# Listing all the triggers in destination Data Factory
$Triggers = Get-AzDataFactoryV2Trigger -ResourceGroupName $ResourceGroupName -DataFactoryName $DataFactoryName

# Stopping all the triggers in destination data factory
foreach ($trigger in $Triggers) {
	if(($trigger.Properties.Annotations[0] -eq $DataFactoryName) -and ($trigger.RuntimeState -eq "Stopped")){
		Start-AzDataFactoryV2Trigger -ResourceGroupName demo -DataFactoryName destination-adf -Name $trigger.Name -Force
		echo "$trigger.Name has started now."
 }
}
