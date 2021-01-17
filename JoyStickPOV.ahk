#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

#Persistent  ; Keep this script running until the user explicitly exits it.
SetTimer, WatchPOV, 0
return

WatchPOV:
POV := GetKeyState("JoyPOV")  ; Get position of the POV control.

; Key To Hold Down is for Up and Down primarily
KeyToHoldDownPrev := KeyToHoldDown  ; Prev now holds the key that was down before (if any).

; While Key2 To Hold Down is for Left and Right primarily
Key2ToHoldDownPrev := Key2ToHoldDown

; Some joysticks might have a smooth/continous POV rather than one in fixed increments.
; To support them all, use a range:
if (POV < 0)   ; No angle to report
{
    KeyToHoldDown := ""
    Key2ToHoldDown := ""
}
else if ((POV >= 0 and POV <= 2250) or (POV >= 33750 and POV <= 35999))
{
    KeyToHoldDown := "Up"
    Key2ToHoldDown := ""
}
else if POV between 2251 and 6750
{
    KeyToHoldDown := "Up"
    Key2ToHoldDown := "Right"
}
else if POV between 6751 and 11250
{
    KeyToHoldDown := ""
    KeyToHoldDown := "Right"
}
else if POV between 11251 and 15750
{
    KeyToHoldDown := "Down"
    Key2ToHoldDown := "Right"
}
else if POV between 15751 and 20250
{
    KeyToHoldDown := "Down"
    Key2ToHoldDown := ""
}
else if POV between 20251 and 24750
{
    KeyToHoldDown := "Down"
    Key2ToHoldDown := "Left"
}
else if POV between 24751 and 29250
{
    KeyToHoldDown := ""
    Key2ToHoldDown := "Left"
}
else if POV between 29251 and 33750
{
    KeyToHoldDown := "Up"
    Key2ToHoldDown := "Left"
}

if (KeyToHoldDown != KeyToHoldDownPrev)
{
    SetKeyDelay -1  ; Avoid delays between keystrokes.
    if KeyToHoldDownPrev   ; There is a previous key to release.
        Send, {%KeyToHoldDownPrev% up}  ; Release it.
    if KeyToHoldDown   ; There is a key to press down.
        Send, {%KeyToHoldDown% down}  ; Press it down.
}

if (Key2ToHoldDown != Key2ToHoldDownPrev)
{
    SetKeyDelay -1  ; Avoid delays between keystrokes.
    if Key2ToHoldDownPrev   ; There is a previous key to release.
        Send, {%Key2ToHoldDownPrev% up}  ; Release it.
    if Key2ToHoldDown   ; There is a key to press down.
        Send, {%Key2ToHoldDown% down}  ; Press it down.
}
return
