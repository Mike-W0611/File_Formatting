param (
    [Parameter(Mandatory = $true)]
    [string]$FolderPath
)

$OutputFile = "C:\Users\MikeWONG\OneDrive\Desktop\PS1\RenameFileFolder\out\outputedFileName.csv"

# Version with Name and file type only :
Get-ChildItem -Path $FolderPath |
   Select-Object Name,
		  @{
                      Name = "Type"
                      Expression = {
                          if ($_.PSIsContainer) { "Folder" } else { "File" }
                      }
                  } |
   Export-Csv -Path $OutputFile -NoTypeInformation

<#
# Version of full extract
Get-ChildItem -Path $FolderPath |
    Select-Object Name,
                  FullName,
                  @{
                      Name = "Type"
                      Expression = {
                          if ($_.PSIsContainer) { "Folder" } else { "File" }
                      }
                  },
                  Length,
                  LastWriteTime |
    Export-Csv -Path $OutputFile -NoTypeInformation
#>


Write-Host "CSV file has been generated: $OutputFile"