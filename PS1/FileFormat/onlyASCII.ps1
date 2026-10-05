$FolderPath = "C:\Users\MikeWONG\OneDrive\Desktop\toFix"

# Process files and folders from deepest level to top
Get-ChildItem -Path $FolderPath -Recurse -Force |
Sort-Object { $_.FullName.Length } -Descending |
ForEach-Object {

    $ParentFolder = Split-Path $_.FullName -Parent

    $BaseName = $_.BaseName -replace '[^\x20-\x7E]', ''

    # For folders, BaseName may be empty
    if ($_.PSIsContainer) {
        $BaseName = $_.Name -replace '[^\x20-\x7E]', ''
    }

    if (:IsNullOrWhiteSpace($BaseName)) {
        $BaseName = if ($_.PSIsContainer) { "Folder" } else { "File" }
    }

    $Extension = if ($_.PSIsContainer) { "" } else { $_.Extension }
    $NewName = $BaseName + $Extension

    $Counter = 1
    while ((Test-Path (Join-Path $ParentFolder $NewName)) -and ($NewName -ne $_.Name)) {
        $NewName = "${BaseName}_$Counter$Extension"
        $Counter++
    }

    if ($NewName -ne $_.Name) {
        Rename-Item -Path $_.FullName -NewName $NewName
        Write-Host "Renamed: $($_.Name) -> $NewName"
    }
}