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
IfWinNotExist sbSent
{
    run, %sbLocation%
    WinWaitActive, Shadowbane
    WinSetTitle, Shadowbane, , sbSent
}
; Get window's unique identifier
WinGet, sbID, ID, sbSent

; Launch script with Alt-`
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
    }
    
    if sState = 1
    {
; Personal heal "Psychic Healing"
        ControlSend,, 6, ahk_id %sbID%
; Cast time 3 sec
        Sleep, 3000
        sState++
	mState++
    }
    else if sState = 2
    {
; Stam heal "Surpass Limits"
        ControlSend,, 5, ahk_id %sbID%
; Cast time 2.5 sec
        sleep, 2800
        sState := 1
; Personal heal "Psychic Healing"
        ControlSend,, 6, ahk_id %sbID%
; Cast time 3 sec
        Sleep, 3000
    }



    if mState >= 1
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
