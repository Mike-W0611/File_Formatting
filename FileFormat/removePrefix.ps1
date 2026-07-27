# Folder containing the files
$folderPath = "C:\Users\MikeWONG\OneDrive\Desktop\toFix"

# List of target symbols that indicate where to cut
$targetSymbols = @(".", "-")  # You can add more symbols here

# Get all files in the folder
$files = Get-ChildItem -Path $folderPath -File

foreach ($file in $files) {
    $baseName = $file.BaseName
    $cutIndex = $null

    # Find the earliest occurrence of any target symbol
    foreach ($symbol in $targetSymbols) {
        $index = $baseName.IndexOf($symbol)
        if ($index -ge 0) {
            if ($cutIndex -eq $null -or $index -lt $cutIndex) {
                $cutIndex = $index
            }
        }
    }

    # If a target symbol was found and it's not the first character
    if ($cutIndex -ne $null -and $cutIndex -lt ($baseName.Length - 1)) {
        # Remove everything before and including the symbol
        $newBaseName = $baseName.Substring($cutIndex + 1).TrimStart()

        # Keep the original extension
        $newName = $newBaseName + $file.Extension

        # Show preview
        Write-Host "Renaming: '$($file.Name)' -> '$newName'"

        try {
	# Comment out when testing
            Rename-Item -Path $file.FullName -NewName $newName -ErrorAction Stop
        }
        catch {
            Write-Warning "Failed to rename '$($file.Name)': $_"
        }
    }
}