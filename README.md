# Bulk User Detail Editor
Script will gather a stations users and some details about them. This will produce a csv. This CSV can be edited and pushed back to AD to edit the details.  Allowing the secretaries/HR to easily modify user details without asking for individual requests.

## Usage

    PS > .\bulkUserEditor.ps1 -Station<string[MANDATORY]> -Gather -Export

Example
Powershell: `PS > .\bulkUserEditor.ps1 cgn -Gather`
This will gather all users from Köln and export them to a file in the same location called cgn.csv
You can make changes to details like Numbers and email addresses or phone numbers etc. Then to push this back to the Server
Powershell: `PS > .\bulkUserEditor.ps1 cgn -Export`
The script will then look in the same directory for a cng.csv and read the data and push the changes to the server. 

## Flags
The following flags are available
### `-Stations`

Mandatory flag. A station must be given.

 - AIC 
 - BER 
 - BER (TXL) 
 - BRE 
 - CGN
 - DUS 
 - FRA 
 - HAJ 
 - HAM 
 - HQ 
 - MUC

 
### `-Gather`
This gathers all the user data and places it into a CSV file
### `-Export`
This flag Reads the CSV file and will update the data based on the CSV file







