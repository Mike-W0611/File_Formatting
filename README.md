Explanation of calling .ps1 files

1.Download the .ps1 files.
2.Open PowerShell on the folder that the files located.
3.Use the command to call the function.
4.Paste the document you need to rename in the folder "toFix".
5.Copy the path of the folder "toFix" and 
edit each of the .ps1 files that has parameter $FolderPath.
6. call the function as below.

- makeProper.ps1	: .\makeProper.ps1

- onlyASCII.ps1		: .\onlyASCII.ps1

- onlyEngNum.ps1 	: .\onlyEngNum.ps1

- removePrefix.ps1	: .\removePrefix.ps1

This script detects the first symbol of the list $targetSymbols and remove the content before it.
You can add more symbols in $targetSymbols.

- renamePrefix.ps1 	:
a. If you have specific prefix, use
.\renamePrefix.ps1 -FolderPath "C:\MyFolder" -Prefix "NEW_"
b. If you want to add the prefix of ascending number, use
.\renamePrefix.ps1 -FolderPath "C:\MyFolder"
The prefix = [01. , 02. ,03. , ...]

- trimChars.ps1		: .\trimChars.ps1
- trimChars_Recurse.ps1	: .\trimChars_Recurse.ps1

For trimChars, you can edit the number to trim in User-configurable parameters.

Please leave a comment if there are any improvements.
