$files = (git ls-tree -r --name-only origin/i18n/checkpoint-progress lib/l10n/) -split "`r?`n" | Where-Object { $_ -match '\.arb$' -and $_ -notmatch 'app_en\.arb' }
$enRaw = (git show origin/i18n/checkpoint-progress:lib/l10n/app_en.arb) | Out-String
$enJson = $enRaw | ConvertFrom-Json
$enKeys = @{}
foreach ($prop in $enJson.PSObject.Properties) {
    if ($prop.Name -notmatch '^@') {
        $enKeys[$prop.Name] = [string]$prop.Value
    }
}

Write-Host "Total English Baseline Keys: $($enKeys.Count)"

foreach ($f in $files) {
    if ([string]::IsNullOrWhiteSpace($f)) { continue }
    $raw = (git show "origin/i18n/checkpoint-progress:$f") | Out-String
    $json = $raw | ConvertFrom-Json
    $trans = 0
    $fallback = 0
    foreach ($p in $json.PSObject.Properties) {
        if ($p.Name -match '^@') { continue }
        $k = $p.Name
        $v = [string]$p.Value
        if ($enKeys.ContainsKey($k) -and $v -eq $enKeys[$k] -and $v.Length -gt 3 -and ($v -match '[a-zA-Z]')) {
            $fallback++
        } else {
            $trans++
        }
    }
    Write-Host "$f => Translated: $trans | English Fallback: $fallback"
}
