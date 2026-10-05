$FolderPath = "C:\Users\MikeWONG\OneDrive\Desktop\toFix"

# User-configurable parameters (Edit number to trim here)
$CharsToRemoveFromStart = 0
$CharsToRemoveFromEnd   = 1

Get-ChildItem -Path $FolderPath -File | ForEach-Object {

    $BaseName = $_.BaseName

    # Calculate remaining length
    $NewLength = $BaseName.Length - $CharsToRemoveFromStart - $CharsToRemoveFromEnd

    if ($NewLength -gt 0) {

        $NewBaseName = $BaseName.Substring(
            $CharsToRemoveFromStart,
            $NewLength
        )

        $NewName = $NewBaseName + $_.Extension

        Rename-Item -Path $_.FullName -NewName $NewName

        Write-Host "Renamed: $($_.Name) -> $NewName"
    }
    else {
        Write-Warning "Skipped: $($_.Name) (filename too short)"
    }
}