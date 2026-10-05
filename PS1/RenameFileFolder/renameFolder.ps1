param (
    [Parameter(Mandatory = $true)]
    [string]$FolderPath
)

# CSV containing the new folder names
$nameListPath = "C:\Users\MikeWONG\OneDrive\Desktop\rename\RenameFileFolder\out\newName.csv"

# Get folders only (no sorting)
$folders = Get-ChildItem -Path $FolderPath -Directory

# Import new names from CSV column "Name"
$newNames = Import-Csv $nameListPath |
            Select-Object -ExpandProperty Name

# Validation
if ($folders.Count -ne $newNames.Count) {
    Write-Host ""
    Write-Host "ERROR: Number of folders does not match number of names in CSV." -ForegroundColor Red
    Write-Host "Folders found : $($folders.Count)"
    Write-Host "Names found   : $($newNames.Count)"
    exit
}

Write-Host ""
Write-Host "========== PREVIEW ==========" -ForegroundColor Yellow

# Build preview list
$renameList = @()

for ($i = 0; $i -lt $folders.Count; $i++) {

    $oldFolder = $folders[$i]
    $newFolderName = $newNames[$i]

    $renameList += [PSCustomObject]@{
        OldName = $oldFolder.Name
        NewName = $newFolderName
    }
}

$renameList | Format-Table -AutoSize

Write-Host ""
$confirmation = Read-Host "Proceed with renaming folders? (Y/N)"

if ($confirmation -ne "Y") {
    Write-Host "Operation cancelled."
    exit
}

Write-Host ""
Write-Host "========== RENAMING ==========" -ForegroundColor Green

for ($i = 0; $i -lt $folders.Count; $i++) {

    $oldFolder = $folders[$i]
    $newFolderName = $newNames[$i]

    # Skip if target name already exists
    if (Test-Path (Join-Path $FolderPath $newFolderName)) {
        Write-Host "SKIPPED: '$newFolderName' already exists." -ForegroundColor Red
        continue
    }

    Rename-Item -Path $oldFolder.FullName -NewName $newFolderName

    Write-Host "$($oldFolder.Name) --> $newFolderName"
}

Write-Host ""
Write-Host "Folder renaming completed successfully." -ForegroundColor Green