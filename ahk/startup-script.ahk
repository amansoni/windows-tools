#SingleInstance force
#Persistent
return

; swap caps and Esc
Capslock::Esc
Esc::Capslock

; Assign a hotkey to minimize the active window.
+^m::WinMinimize, A  

; display tooltip on clipboard change
OnClipboardChange:
ToolTip Clipboard: %A_EventInfo% 
Sleep 2000
ToolTip  ; Turn off the tip.
return

^+t::
EnvGet, SystemRoot, SystemRoot
Run %SystemRoot%\system32\WindowsPowerShell\v1.0\powershell.exe -ExecutionPolicy unrestricted, c:\src\
return

^+u::
; EnvGet, SystemRoot
Run "C:\Program Files\Oracle\VirtualBox\VBoxManage.exe" startvm Ubuntu
return

; login using ssh
^+s::
Run ssh -p 3022 limitingfactor@localhost

^+p::
counter++
count = 00000%counter%
stringright, count, count, 6
imagesavename=C:\tools\ScreenCapture\%count%.png

FileAppend, %ClipboardAll%, %imagesavename% ; The file extension does not matter.
;Clipboard := ClipSaved   ; Restore the original clipboard. Note the use of Clipboard (not ClipboardAll).
;ClipSaved =   ; Free the memory in case the clipboard was very large.

; NOT WORKING YET
; capture window as image to clipboard
^+w::
; Run %windir%\system32\SnippingTool.exe
WinActivate, ahk_class Microsoft-Windows-Tablet-SnipperToolbar
WinWaitActive, ahk_class Microsoft-Windows-Tablet-SnipperToolbar
Send !n
Send r
Send ^c
Send ^n