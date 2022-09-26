Connect-MSGraph
Write-Host Please save your CSV for import in your $env:USERPROFILE folder -foreground green
Write-Host ************************************************
Write-Host * Make sure your CSV has one column with the     *
Write-Host * name of the column SerialNumber              *
Write-Host ************************************************

$filename = Read-Host "Name of your saved CSV file for import? (You must include the .csv)"
$path = "$env:USERPROFILE\"+$filename
$outputpath = "$env:USERPROFILE\serialoutput.csv"

$file = import-csv -path $path
$fileout = @()

##$file = @("SerialNumber","MJ0C8W52")
Foreach ($snum in $file){
	$tempdata=Get-IntuneManagedDevice -Filter ("SerialNumber eq '$serialnumber'") | select deviceName, enrolledDateTime, deviceCategoryDisplayName, model, Manufacturer, userPrincipalName
	$fileout += ([pscustomobject]@{deviceName=$tempdata.deviceName;enrollDate=$tempdata.enrolledDateTime;DeviceCategory=$tempdata.deviceCategoryDisplayName;Model=$tempdata.Model;Manufacturer=$tempdata.Manufacturer;User=$tempdata.UserPrincipalName})
}
$fileout | export-csv -path $outputpath -NoTypeInformation -Encoding UTF8
Write-Host File Exported as $outputpath -foreground green