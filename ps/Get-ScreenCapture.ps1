function Get-ScreenCapture {
    begin {
        Add-Type -AssemblyName System.Drawing
        $jpegCodec = [Drawing.Imaging.ImageCodecInfo]::GetImageEncoders() | 
            Where-Object { $_.FormatDescription -eq "JPEG" }
    }
    process {
        # Start-Sleep -Milliseconds 250
        # if ($OfWindow) {            
        #     [Windows.Forms.Sendkeys]::SendWait("%{PrtSc}")        
        # } else {
        #     [Windows.Forms.Sendkeys]::SendWait("{PrtSc}")        
        # }
        # Start-Sleep -Milliseconds 250
        Write-Output "Starting Get-ScreenCapture.ps1"
        $bitmap = [Windows.Forms.Clipboard]::GetImage()    
        $ep = New-Object Drawing.Imaging.EncoderParameters  
        $ep.Param[0] = New-Object Drawing.Imaging.EncoderParameter ([System.Drawing.Imaging.Encoder]::Quality, [long]100)  
        $screenCapturePathBase = "$pwd\ScreenCapture"
        $screenCapturePathBase = "C:\tools\ScreenCapture\"
        $path = "C:\tools\ScreenCapture\$filename $(get-date -f yyyy-MM-dd)$ext"
        $c = 0
        while (Test-Path "${screenCapturePathBase}${c}.jpg") {
            $c++
        }
        Write-Output ${screenCapturePathBase}${c}
        $bitmap.Save("${screenCapturePathBase}${c}.jpg", $jpegCodec, $ep)
        Write-Output "..." + $path
        #$bitmap.Save("${path}${c}.jpg", $jpegCodec, $ep)
    }
}