# Path to your dictionary file
$filePath = "index.html"

# Path to your daily update file
$updatePath = "daily_update.txt"

# Create a backup before modifying
Copy-Item $filePath "$filePath.bak" -Force

# Read the main file
$content = Get-Content $filePath -Raw

# Read the new rows
$newRows = Get-Content $updatePath -Raw

if (-not $newRows) {
    Write-Host "daily_update.txt is empty. Paste your <tr> rows first."
    exit
}

# Replace ONLY the DAILY UPDATE section
$pattern = "(?s)(<!-- DAILY UPDATE START -->).*?(<!-- DAILY UPDATE END -->)"
$replacement = "`$1`r`n$newRows`r`n`$2"

if ($content -notmatch $pattern) {
    Write-Host "Markers not found. No changes made."
    exit
}

$updated = [regex]::Replace($content, $pattern, $replacement)

# Save updated file
Set-Content $filePath $updated -Encoding UTF8

# Git operations
git pull
git add .
git commit -m "Auto-update DAILY UPDATE section"
git push

Write-Host "Dictionary updated and deployed successfully."