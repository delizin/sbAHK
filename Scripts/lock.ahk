; Forces only one instance of this script
#SingleInstance force

; Set application path and desired window title
sbLocation = "C:\Shadowbane - Throne of Oblivion\sb.exe"
windowTitle = sbLock

/* 
    If our scripted window isn't running then launch it
    and give it our unique title
*/
IfWinNotExist, windowTitle
{
    run, %sbLocation%
    WinWaitActive, Shadowbane
    WinSetTitle, Shadowbane, , %windowTitle%
}
; Get window's unique identifier
WinGet, sbID, ID, %windowTitle%

; Launch script with Window Key + Alt + 1
!#1::
Loop
{
    ; Send 1 to sb application id
    ControlSend,, 1, ahk_id %sbID%
    ; Sleep 1 second (1000 ms)
    Sleep, 1000
}

; Pause pauses the script
Pause::Pause
; Escape closes the script
Esc::ExitApp