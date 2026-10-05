param (
    [Parameter(Mandatory = $true)]
    [string]$FolderPath
)

# CSV containing the new names
$nameListPath = "C:\Users\MikeWONG\OneDrive\Desktop\PS1\RenameFileFolder\out\outputedFileName.csv"

# Get files in original sequence (no sorting)
$files = Get-ChildItem -Path $FolderPath -File

# Import new names from CSV column "Name"
$newNames = Import-Csv $nameListPath |
            Select-Object -ExpandProperty Name

# Validation
if ($files.Count -ne $newNames.Count) {
    Write-Host ""
    Write-Host "ERROR: Number of files does not match number of names in CSV." -ForegroundColor Red
    Write-Host "Files found : $($files.Count)"
    Write-Host "Names found : $($newNames.Count)"
    exit
}

Write-Host ""
Write-Host "========== PREVIEW ==========" -ForegroundColor Yellow

# Generate preview
$renameList = @()

for ($i = 0; $i -lt $files.Count; $i++) {

    $oldFile = $files[$i]
    $newBaseName = $newNames[$i]

    $newFileName = "$newBaseName$($oldFile.Extension)"

    $renameList += [PSCustomObject]@{
        OldName = $oldFile.Name
        NewName = $newFileName
    }
}

$renameList | Format-Table -AutoSize

Write-Host ""
$confirmation = Read-Host "Proceed with renaming? (Y/N)"

if ($confirmation -ne "Y") {
    Write-Host "Operation cancelled."
    exit
}

Write-Host ""
Write-Host "========== RENAMING ==========" -ForegroundColor Green

for ($i = 0; $i -lt $files.Count; $i++) {

    $oldFile = $files[$i]
    $newBaseName = $newNames[$i]

    $newFileName = "$newBaseName$($oldFile.Extension)"

    Rename-Item -Path $oldFile.FullName -NewName $newFileName

    Write-Host "$($oldFile.Name)  -->  $newFileName"
}

Write-Host ""
Write-Host "Renaming completed successfully." -ForegroundColor Green