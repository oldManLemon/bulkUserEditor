
#TODO RExport to CSV for editing. 
#TODO Push edited CSV back so that updates to user details can be made


param(
    # [Parameter(Mandatory = $true)]
    [string] $Station,
    [switch] $Gather,
    [switch] $Export
)

#Avoid errors by forcing correct OU searches
switch ($Station) {
    "AIC" { $search = "OU=AIC," }
    "BER" { $search = "OU=BER," }
    "BER (TXL)" { $search = "OU=BER (TXL)," }
    "BRE" { $search = "OU=BRE," }
    "CGN" { $search = "OU=CGN," }
    "DUS" { $search = "OU=DUS," }
    "FRA" { $search = "OU=FRA," }
    "HAJ" { $search = "OU=HAJ," }
    "HAM" { $search = "OU=HAM," }
    "HQ" { $search = "OU=HQ," }
    "MUC" { $search = "OU=MUC," }
    "STR" { Return Write-Host "Funktioniert Nicht! Bitte Andrew Fragen" -ForegroundColor Red }
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
    # $Users.displayName
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

    } | Select Benutzer, "Vollstaendiger Name", Nummer, Email, Beschreibung, Abteilung, Betreib | Export-Csv $Station".csv" -Encoding Unicode
}

if($Export){
    $file = $Station+".csv"
    $data = Import-Csv -Path $file
    foreach($d in $data){
      $cUser =Get-ADUser -Identity $d.Benutzer -Properties telephoneNumber, mail, Description, Department, Company
      Set-ADUser -Identity $cUser -officephone $d.Nummer -Description $d.Beschreibung, -mail $d.Email, -Department $d.Abteilung, -Company -Betreib $d.Betreib, -DisplayName $d."Vollstaendiger Name"
    }
    

}