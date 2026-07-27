$FolderPath = "C:\Users\MikeWONG\OneDrive\Desktop\toFix"

Get-ChildItem -Path $FolderPath -File | ForEach-Object {

    # Keep only English letters and numbers
    $BaseName = $_.BaseName -replace '[^A-Za-z0-9]', ''

    # If filename becomes empty, assign a default name
    if (:IsNullOrWhiteSpace($BaseName)) {
        $BaseName = "File"
    }

    $Extension = $_.Extension
    $NewName = $BaseName + $Extension

    # Handle duplicate filenames
    $Counter = 1
    while ((Test-Path (Join-Path $FolderPath $NewName)) -and ($NewName -ne $_.Name)) {
        $NewName = "${BaseName}_$Counter$Extension"
        $Counter++
    }

    if ($NewName -ne $_.Name) {
        Rename-Item -Path $_.FullName -NewName $NewName
        Write-Host "Renamed: $($_.Name) -> $NewName"
    }
}