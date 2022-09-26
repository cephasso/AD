Connect-MSGraph
Connect-AzureAD
Write-Host Please save your CSV for import in your $env:USERPROFILE folder -foreground green
Write-Host ************************************************
Write-Host * Make sure your CSV has one column with the     *
Write-Host * name of the column displayname              *
Write-Host ************************************************

$filename = Read-Host "Name of your saved CSV file for import? (You must include the .csv)"
$path = "$env:USERPROFILE\"+$filename
$outputpath = "$env:USERPROFILE\serialoutput.csv"

$file = import-csv -path $path
$fileout = @()

##$file = @("SerialNumber","MJ0C8W52")
Foreach ($snum in $file){
	$snum1 = $snum.displayname
	$tempdata=Get-IntuneManagedDevice -Filter ("deviceName eq '$snum1'") | select deviceName, enrolledDateTime, deviceCategoryDisplayName, model, Manufacturer, emailAddress, lastSyncDateTime
    if ($null -eq $tempdata.emailAddress) {
        
        write-host No Email Address }
    else {
       $userinfo = Get-AzureADUser -objectid $tempdata.emailAddress | select *
    }

	#$fileout += ([pscustomobject]@{deviceName=$tempdata.deviceName;enrollDate=$tempdata.enrolledDateTime;DeviceCategory=$tempdata.deviceCategoryDisplayName;Model=$tempdata.Model;Manufacturer=$tempdata.Manufacturer;User=$tempdata.emailAddress;UserStatus=$userinfo.AccountEnabled})
}
$fileout | export-csv -path $outputpath -NoTypeInformation -Encoding UTF8
Write-Host File Exported as $outputpath -foreground green