; Forces only one instance of this script
#SingleInstance force

; Set application path and desired window title
sbLocation = "C:\Shadowbane - Throne of Oblivion\sb.exe"
windowTitle = sbLock

; Variables to keep track of repeated skills
; AOE state
aState := 1
; Secondary State
sState := 1

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
    ; Fires aoe twice
    While, aState <= 2
    {
        ; mental aoe
        ControlSend,, 3, ahk_id %sbID%
        ; 3.6 second cast time
        Sleep, 3600
        ; 10 sec cooldown
        if aState <= 1
        {
            ; Skip second cooldown wait
            Sleep, 10000
        }
        aState++
    }
    aState := 1
    
    /*
        Secondary ability
        order is:
        - State 1 = stam heal (5)
        - State 2 = stam heal (5)
        - State 3 = heal (6)
    */
    if sState = 1 or sState = 2
    {
        ; Stam heal "Surpass Limits"
        ControlSend,, 5, ahk_id %sbID%
        ; Cast time 2.5 sec
        sleep, 2500
        ; Remaining AoE cooldown
        Sleep, 7500
        sState++
    }
    else if sState = 3
    {
        ; Personal heal "Psychic Healing"
        ControlSend,, 6, ahk_id %sbID%
        ; Cast time 3 sec
        Sleep, 3000
        ; Remaining AoE cooldown
        Sleep, 7000
        sState := 1
    }
}

; Pause pauses the script
Pause::Pause
; Escape closes the script
Esc::ExitApp
