## Explanation of calling .ps1 files
1.Download the .ps1 files.
2.Open PowerShell on the folder that the files located.
3.Use the command to call the function.
4.Paste the document you need to rename in the folder "toFix".
5.Copy the path of the folder "toFix" and 
edit each of the .ps1 files that has parameter $FolderPath.
6.Call the function below.

- fileNameToCSV.ps1	: .\fileNameToCSV.ps1 "SourceOfFolderPath"
*If you wish to change the destination of outputting the CSV file, you can change the parameter of $OutputFile.

- renameFile.ps1	: .\renameFile.ps1 "SourceOfFolderPath"

- renameFolder.ps1	: .\renameFolder.ps1 "SourceOfFolderPath"

Please leave a comment if there are any improvements.