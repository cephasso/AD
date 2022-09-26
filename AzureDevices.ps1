$devices=Get-AzureADDevice -All:$true | select *
$outputfile =@()
foreach ($d in $devices) {
$DeviceObjectID = $d.objectid
$DeviceID = $d.deviceid
$DeviceLastLogin = $d.ApproximateLastLogonTimeStamp
$AccountEnabled = $d.AccountEnabled
$DeviceDisplayName =$d.DisplayName
$DeviceOS = $d.DeviceOSType
try   {
     $user = Get-AzureADDeviceRegisteredOwner -ObjectId $DeviceObjectID | select DisplayName, UserPrincipalName, AccountEnabled
     $Name = $user.DisplayName
     $Email = $user.UserPrincipalName
     $AccountE = $user.AccountEnabled
>>
}
catch
{
   $Name = "No User Assigned"
      $Email = ""
      $AccountE = ""
}
$outputfile += ([pscustomobject]@{DeviceObjectID=$deviceobjectid;DeviceID=$DeviceID;LastLogon=$DeviceLastLogin;AccountEnabled=$AccountEnabled;DeviceName=$DeviceDisplayName;DeviceOS=$DeviceOS;User=$Name;Email=$Email;UserEnabled=$AccountE})}
$outputfile | export-csv -path "$env:userprofile\devices.csv" -NoTypeInformation -Encoding UTF8