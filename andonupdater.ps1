$outputPath = "C:\path\to\output.json"
$url = "http://tdbsorsvr034/andonILC/panelview/panelviewsocket.seam?panelId=5050&tpParm1=D0&tpParm2=N0"

Write-Host "Starting loop. Press Ctrl+C to stop." -ForegroundColor Green

while ($true) {
    try {
        $response = Invoke-WebRequest -Uri $url
        $result = $response.ParsedHtml.getElementById("form2Id:assembly2").innerText

        $data = [PSCustomObject]@{
            Timestamp = (Get-Date).ToString("yyyy-MM-dd HH:mm:ss")
            PanelId   = "5050"
            Assembly  = $result
        }

        $data | ConvertTo-Json | Out-File -FilePath $outputPath -Encoding UTF8

        Write-Host "[$($data.Timestamp)] Data saved successfully." -ForegroundColor Cyan
    }
    catch {
        Write-Host "[$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')] Error: $_" -ForegroundColor Red
    }

    Start-Sleep -Seconds 60
}