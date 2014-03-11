#singleInstance forced

^`::
{
    tracking := true
    winGet, trackID, ID, Shadowbane
    
    loop
    {
        getKeyState, mmbState, MButton
        if tracking and (mmbState = "U")
        {
            controlSend,, 1, ahk_id %trackID%
        }
        sleep, 500
    }
}

esc::
{
    exitApp
}

enter::
{
    tracking := not tracking
    send, {enter}
}