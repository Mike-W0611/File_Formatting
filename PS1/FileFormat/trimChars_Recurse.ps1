$FolderPath = "C:\Users\MikeWONG\OneDrive\Desktop\toFix"

# User-configurable parameters
$CharsToRemoveFromStart = 0
$CharsToRemoveFromEnd   = 1

# Process deepest items first
Get-ChildItem -Path $FolderPath -Recurse -Force |
Sort-Object { $_.FullName.Length } -Descending |
ForEach-Object {

    $OldName = $_.Name

    if ($_.PSIsContainer) {
        $BaseName = $_.Name
        $Extension = ""
    }
    else {
        $BaseName = $_.BaseName
        $Extension = $_.Extension
    }

    $NewLength = $BaseName.Length - $CharsToRemoveFromStart - $CharsToRemoveFromEnd

    if ($NewLength -le 0) {
        Write-Warning "Skipped '$OldName' because trimming would result in an empty name."
        return
    }

    $NewBaseName = $BaseName.Substring($CharsToRemoveFromStart, $NewLength)
    $NewName = $NewBaseName + $Extension

    if ($NewName -ne $OldName) {

        $ParentFolder = Split-Path $_.FullName -Parent
        $CandidateName = $NewName
        $Counter = 1

        while (Test-Path (Join-Path $ParentFolder $CandidateName)) {
            if ($CandidateName -eq $OldName) { break }

            $CandidateName = if ($Extension) {
                "${NewBaseName}_$Counter$Extension"
            }
            else {
                "${NewBaseName}_$Counter"
            }

            $Counter++
        }

        if ($CandidateName -ne $OldName) {
            Rename-Item -Path $_.FullName -NewName $CandidateName
            Write-Host "Renamed: $OldName -> $CandidateName"
        }
    }
}
