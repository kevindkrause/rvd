# Define the group name suffixes (everything after the 3-char branch code)
$groupSuffixes = @(
    "-BC-Committee",
    "-BRANCH-Secretaries",
    "-HCD-Overseers",
    "-RHCO-Overseers",
    "-SRV-OfficeSupport",
    "-SRV-TheocraticSchoolsDesk",
    "-SRV-TranslationDeskDeskman",
    "-SRV-TranslationDeskSupport",
    "-TRANS-RegionalProductionPersonnelResearchers"
)

# Define your branch codes
$branchCodes = Get-Content "branch-codes.txt"

$outputFile = "F:\ps\lco\branch-group-counts.csv"

# Write header
$headers = $groupSuffixes | ForEach-Object { $_ -replace '^-', '' }
"Branch," + ($headers -join ",") | Out-File -FilePath $outputFile -Encoding UTF8

# Write one row per branch
foreach ($branch in $branchCodes) {
    $row = $branch
    foreach ($suffix in $groupSuffixes) {
        $groupName = "$branch$suffix"
        try {
            $count = (Get-ADGroupMember -Identity $groupName -Recursive |
                      Where-Object { $_.objectClass -eq 'user' }).Count
        } catch {
            $count = "0"
        }
        $row += ",$count"
    }
    $row | Add-Content -Path $outputFile
}

Write-Host "Done. Output: $outputFile"