#TODO Create script that will read the all users in STATION
#TODO Get those users Full Names, Usernames, Emails, Phone Numbers, Description, Dep and Company
#TODO RExport to CSV for editing. 
#TODO Push edited CSV back so that updates to user details can be made


param(
    # [Parameter(Mandatory = $true)]
    [string] $Station
)

#Avoid errors by forcing correct OU searches
switch ($Station) {
    "AIC" { $search = "OU=AIC,"}
    "BER" { $search = "OU=BER,"}
    "BEr (TXL)" { $search = "OU=BER (TXL)," }
    "BRE" { $search ="OU=BRE," }
    "CGN" {$search =  "OU=CGN," }
    "DUS" {$search =  "OU=DUS," }
    "FRA" {$search =  "OU=FRA," }
    "HAJ" {$search =  "OU=HAJ," }
    "HAM" {$search = "OU=HAM,"  }
    "HQ" { $search = "OU=HQ," }
    "MUC" { $search = "OU=MUC," }
    "STR" { Return Write-Host "Funktioniert Nicht! Bitte Sehe Andrew" -ForegroundColor Red }
    Default { Return Write-Host "Station nicht wird nicht gefunden. Bitte checken!" -ForegroundColor Red }
}
# * Search base built here
$base = "OU=Stations,OU=x,DC=intern,DC=ahs-de,DC=com"
$searchbase = $search+$base

#Gather Users from the Group
$Users = Get-ADUser -Filter * -SearchBase $searchbase -Properties samaccountname, displayName, telephoneNumber, mail, Description, Department, Company
# $Users.samaccountname
# $Users.displayName
# $Users.telephoneNumber
# $Users.mail
# $Users.Description
# $Users.Department
# $Users.Company

