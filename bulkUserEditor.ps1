
#TODO RExport to CSV for editing. 
#TODO Push edited CSV back so that updates to user details can be made


param(
    # [Parameter(Mandatory = $true)]
    [string] $Station,
    [switch] $Gather = $true,
    [switch] $Export
)

#Avoid errors by forcing correct OU searches
switch ($Station) {
    "AIC" { $search = "OU=AIC," }
    "BER" { $search = "OU=BER," }
    "BEr (TXL)" { $search = "OU=BER (TXL)," }
    "BRE" { $search = "OU=BRE," }
    "CGN" { $search = "OU=CGN," }
    "DUS" { $search = "OU=DUS," }
    "FRA" { $search = "OU=FRA," }
    "HAJ" { $search = "OU=HAJ," }
    "HAM" { $search = "OU=HAM," }
    "HQ" { $search = "OU=HQ," }
    "MUC" { $search = "OU=MUC," }
    "STR" { Return Write-Host "Funktioniert Nicht! Bitte Sehe Andrew" -ForegroundColor Red }
    Default { Return Write-Host "Station nicht wird nicht gefunden. Bitte checken!" -ForegroundColor Red }
}
# * Search base built here
$base = "OU=Stations,OU=x,DC=intern,DC=ahs-de,DC=com"
$searchbase = $search + $base



if ($Gather) {
    #Gather Users from the Group
    $Users = Get-ADUser -Filter * -SearchBase $searchbase -Properties samaccountname, displayName, telephoneNumber, mail, Description, Department, Company
    # *This below changes the default Names as the Secerataries will edit these. Might as well make it easy to understand. 
    # *Plus I knew not doing this would result in problems later. 
    $Users | foreach {
        new-object psobject -Property @{
            Benutzer             = $_.sAMAccountName
            "Vollstaendiger Name" = $_.displayName
            Nummer               = $_.telephoneNumber
            Email                = $_.mail
            Beschreibung         = $_.description
            Abteilung            = $_.Department
            Betreib              = $_.Company
        }

    } | Select Benutzer, "Vollständiger Name", Nummer, Email, Beschreibung, Abteilung | Export-Csv $Station".csv" -Encoding UTF8
}

if($Export){

}