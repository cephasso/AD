$users=Get-AzureADGroupMember -ObjectId "d3d92da5-8bb8-4ac3-9aea-cd9c2d0fcf28" | select ObjectID, DisplayName, UserPrincipalName

$fileoutput = @()

foreach ($u in $users){
$fileoutput += Get-AzureADUserRegisteredDevice -ObjectId $u.objectID | Where {$_.DeviceOSType -eq "Windows" } |Select-object DisplayName,ObjectID, @{N="User"; e={$u.DisplayName}},@{N="Email"; e={$u.UserPrincipalName}}
}

$fileoutput | export-csv -path "$env:UserProfile\usersandwindowsdevices.csv" -Encoding UTF8 -NoTypeInformation

Write-host "File exported to: $env:UserProfile\usersandwindowsdevices.csv" -foreground green