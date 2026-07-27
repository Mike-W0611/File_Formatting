$FolderPath = "C:\Users\MikeWONG\OneDrive\Desktop\toFix"

# Process deepest items first
Get-ChildItem -Path $FolderPath -Recurse -Force |
Sort-Object { $_.FullName.Length } -Descending |
ForEach-Object {

    if ($_.PSIsContainer) {
        $newName = (Get-Culture).TextInfo.ToTitleCase($_.Name.ToLower())
    }
    else {
        $nameWithoutExt = (Get-Culture).TextInfo.ToTitleCase($_.BaseName.ToLower())
        $newName = "$nameWithoutExt$($_.Extension)"
    }

    if ($_.Name -ne $newName) {
        Rename-Item -LiteralPath $_.FullName -NewName $newName
    }
}