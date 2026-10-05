# PowerShell Script: Add a prefix to all files in a folder
# If Prefix is not provided, it will auto-generate "01. ", "02. ", etc.

param (
    [Parameter(Mandatory = $true)]
    [string]$FolderPath,   # Path to the folder containing files

    [string]$Prefix        # Optional prefix; if empty, sequential numbers will be used
)

try {
    # Validate folder path
    if (-not (Test-Path -Path $FolderPath -PathType Container)) {
        throw "The folder path '$FolderPath' does not exist or is not a directory."
    }

    # Get all files (non-recursive), sorted alphabetically
    $files = Get-ChildItem -Path $FolderPath -File | Sort-Object Name
    if ($files.Count -eq 0) {
        Write-Host "No files found in '$FolderPath'."
        exit
    }

    # If Prefix is null or empty, generate sequential numbering
    if ([string]::IsNullOrWhiteSpace($Prefix)) {
        $counter = 1
        foreach ($file in $files) {
            $autoPrefix = "{0:D2}. " -f $counter  # Format: 01. , 02. , etc.
            $newName = "$autoPrefix$($file.Name)"
            $newPath = Join-Path -Path $FolderPath -ChildPath $newName

            if (Test-Path $newPath) {
                Write-Warning "Skipping '$($file.Name)' because '$newName' already exists."
                continue
            }

            Rename-Item -Path $file.FullName -NewName $newName
            Write-Host "Renamed: $($file.Name) -> $newName"
            $counter++
        }
    }
    else {
        # Use provided prefix for all files
        foreach ($file in $files) {
            $newName = "$Prefix$($file.Name)"
            $newPath = Join-Path -Path $FolderPath -ChildPath $newName

            if (Test-Path $newPath) {
                Write-Warning "Skipping '$($file.Name)' because '$newName' already exists."
                continue
            }

            Rename-Item -Path $file.FullName -NewName $newName
            Write-Host "Renamed: $($file.Name) -> $newName"
        }
    }

    Write-Host "✅ Renaming completed."
}
catch {
    Write-Error "Error: $_"
}