#!/usr/bin/env pwsh

$CURRENT_DATE = Get-Date -Format "yyyy-MM-dd"
$EXPIRY_FILE = "/etc/user_expiry_dates"

Get-Content $EXPIRY_FILE | ForEach-Object {
    if ($_ -match "^([^:]+):(\d{4}-\d{2}-\d{2})$") {
        $username = $matches[1]
        $expiry_date = $matches[2]

        if ($CURRENT_DATE -ge $expiry_date) {
            usermod --lock --shell /usr/sbin/nologin $username
        }
    }
}
