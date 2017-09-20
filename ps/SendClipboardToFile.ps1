#https://docs.microsoft.com/en-za/powershell/module/Microsoft.PowerShell.Management/Get-Clipboard?view=powershell-5.0
function Log ($msg) { 
    process {
		#Add-Content c:\tools\ps\$MyInvocation.ScriptName "`n${msg}"
		Add-Content c:\tools\ps\CaptureClipboard.log "`n$(get-date -f yyyyMMdd-hhmmss) ${msg}"
	}
}

$data = Get-Clipboard -Format Text
if ($data -ne $null) {
	Log $data
	$hash=@{};
	
	$data|select-string -AllMatches '(http[s]?|[s]?ftp[s]?)(:\/\/)([^\s,]+)'|%{$hash."urls"=$_.Matches.value};
	Write-Host $hash
	foreach ($url in $hash) {
		Write-Host $url['urls']
		$response = Invoke-WebRequest -URI $url['urls']
		$response.AllElements | where {$_.innerhtml -like "*=*"} | Sort { $_.InnerHtml.Length } | Select InnerText -First 5
		Write-Host $response
	}	
}

$data = Get-Clipboard -Format FileDropList
if ($data -ne $null) {Log $data}

$data = Get-Clipboard -Format Image
if ($data -ne $null) {
	Add-Type -AssemblyName System.Drawing
	$jpegCodec = [Drawing.Imaging.ImageCodecInfo]::GetImageEncoders() | 
			Where-Object { $_.FormatDescription -eq "JPEG" }
	$ep = New-Object Drawing.Imaging.EncoderParameters  
	$ep.Param[0] = New-Object Drawing.Imaging.EncoderParameter ([System.Drawing.Imaging.Encoder]::Quality, [long]100)  
	$path = "C:\tools\ScreenCapture\$(get-date -f yyyyMMdd-hhmmss).jpg"
	Write-Host "${path}"
	$data.Save($path, $jpegCodec, $ep)
}

$data = Get-Clipboard -Format Audio
if ($data -ne $null) {Log $data}

