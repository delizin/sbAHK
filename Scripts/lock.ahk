; Forces only one instance of this script
#SingleInstance force

; Set application path and desired window title
sbLocation = "C:\DC\Shadowbane - Throne of Oblivion\sb.exe"

; Variables to keep track of repeated skills
; AOE state
aState := True
; Secondary State
sState := 1
; Mana State
mState := 1

/*
If our scripted window isn't running then launch it
and give it our unique title
*/
IfWinNotExist sbLock
{
    run, %sbLocation%
    WinWaitActive, Shadowbane
    WinSetTitle, Shadowbane, , sbLock
}
; Get window's unique identifier
WinGet, sbID, ID, sbLock

; Launch script with Window Key + Alt + 1
!`::
Loop
{
; Fires aoe twice
    Loop, 1
    {
; mental aoe
        ControlSend,, 3, ahk_id %sbID%
; 3.6 second cast time
        Sleep, 3600
; 10 sec cooldown
        If aState
            Sleep, 10000
        aState := not aState
    }
    
    /*
Secondary ability
order is:
- State 1 = stam heal (5)
- State 2 = stam heal (5)
- State 3 = heal (6)
- State 4 = Mana drain (7)
*/
    if sState = 1
    {
; Stam heal "Surpass Limits"
        ControlSend,, 5, ahk_id %sbID%
; Cast time 2.5 sec
        sleep, 2500
; Personal heal "Psychic Healing"
        ControlSend,, 6, ahk_id %sbID%
; Cast time 3 sec
        Sleep, 3000
; Remaining AoE cooldown
        Sleep, 7500
        sState++
	mState++
    }
    else if sState = 2
    {
; Stam heal "Surpass Limits"
        ControlSend,, 5, ahk_id %sbID%
; Cast time 2.5 sec
        sleep, 2800
; Stam heal "Surpass Limits"
        ControlSend,, 5, ahk_id %sbID%
; Cast time 2.5 sec
        sleep, 2800
; Personal heal "Psychic Healing"
        ControlSend,, 6, ahk_id %sbID%
; Cast time 3 sec
        Sleep, 3000
; Personal heal "Psychic Healing"
        ControlSend,, 6, ahk_id %sbID%
; Cast time 3 sec
        Sleep, 3000
; Remaining AoE cooldown
        Sleep, 4500
        sState := 1
    }



    if mState >= 4
    {
	; Drain mana
	ControlSend,, 7, ahk_id %sbID%
	sleep, 5000
	mState := 1
    }

}

; Pause pauses the script
Pause::Pause
; Escape closes the script
F12::ExitApp
