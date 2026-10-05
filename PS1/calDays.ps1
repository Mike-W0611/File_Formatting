# Prompt for dates
$StartDate = Get-Date (Read-Host "Enter Start Date (yyyy-MM-dd)")
$EndDate   = Get-Date (Read-Host "Enter End Date (yyyy-MM-dd)")

# Validate input
if ($EndDate -lt $StartDate) {
    Write-Host "Error: End Date cannot be earlier than Start Date." -ForegroundColor Red
    exit
}

# Total days (inclusive)
$TotalDays = ($EndDate - $StartDate).Days + 1

# Count workdays
$Workdays = 0

for ($Date = $StartDate; $Date -le $EndDate; $Date = $Date.AddDays(1)) {
    if ($Date.DayOfWeek -ne "Saturday" -and $Date.DayOfWeek -ne "Sunday") {
        $Workdays++
    }
}

# Count non-workdays
$NonWorkdays = $TotalDays - $Workdays

# Weeks as mixed fraction
$WholeWeeks = $TotalDays / 7 - ($TotalDays % 7 / 7)
$RemainingDays = $TotalDays % 7

if ($RemainingDays -eq 0) {
    $WeeksFraction = "$WholeWeeks"
}
else {
    $WeeksFraction = "$WholeWeeks week(s) $RemainingDays day(s)"
}

# Calculate months + remaining days
$MonthCount = 0
$TempDate = $StartDate

while ($TempDate.AddMonths(1) -le $EndDate) {
    $TempDate = $TempDate.AddMonths(1)
    $MonthCount++
}

$RemainDays = ($EndDate - $TempDate).Days

$MonthResult = "$MonthCount month(s) $RemainDays day(s)"

# Get weekday names
$StartDayName = $StartDate.DayOfWeek
$EndDayName   = $EndDate.DayOfWeek

# Output
Write-Host ""
Write-Host "Start Date      : $($StartDate.ToString('yyyy-MM-dd')), $StartDayName"
Write-Host "End Date        : $($EndDate.ToString('yyyy-MM-dd')), $EndDayName"
Write-Host "Note: start date and end date also counted in total days" -ForegroundColor Green
Write-Host "Total Days      : $TotalDays"
Write-Host "Workdays        : $Workdays"
Write-Host "Non-Workdays    : $NonWorkdays"
Write-Host "Weeks           : $WeeksFraction"
Write-Host "Months          : $MonthResult"