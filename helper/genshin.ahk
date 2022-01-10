#SingleInstance Force
#InstallMouseHook
; some copied from https://github.com/ganlvtech/genshin-impact-ahk/blob/main/%E5%8E%9F%E7%A5%9E.ahk

; https://stackoverflow.com/questions/43298908/how-to-add-administrator-privileges-to-autohotkey-script
full_command_line := DllCall("GetCommandLine", "str")
if not (A_IsAdmin or RegExMatch(full_command_line, " /restart(?!\S)"))
{
    try ; leads to having the script re-launching itself as administrator
    {
        if A_IsCompiled
            Run *RunAs "%A_ScriptFullPath%" /restart
        else
            Run *RunAs "%A_AhkPath%" /restart "%A_ScriptFullPath%"
    }
    ExitApp
}

repeatClickLeft:=0
spaceWait:=0

Gui, Add, CheckBox,w400 h24 gOnSubmmit vrepeatClickLeft, 左键连发，长按鼠标前侧键触发
guicontrol,, vrepeatClickLeft, 1 ; set default checked
Gui, Add, CheckBox,w400 h24 gOnSubmmit vspaceWait, 空格连发延迟触发，离开浪船需要长按空格

Gui, Show
Return

GuiEscape:
GuiClose:
ExitApp

OnSubmmit:
    Gui, Submit, Nohide
Return

#IfWinActive ahk_exe YuanShen.exe

; 按住空格等于狂按空格（按住 1.3 秒之后才触发，因为离开浪船需要按住空格）
~*Space::
    if spaceWait 
    {
        KeyWait, Space, T1.3
        If Not ErrorLevel
        {
            Return
        }
    }
    Loop
    {
        Send, {Space}
        KeyWait, Space, T0.05
        If Not ErrorLevel
        {
            Break
        }
    }
Return

; 按住 f 等于狂按 f
*f::
    Loop
    {
        Send, {Blind}f
        KeyWait, f, T0.1
        If Not ErrorLevel
        {
            Break
        }
    }
Return

; 5个探索派遣
Expedition(x1, y1, x2, y2, x3, y3) {
    BlockInput, MouseMove
    MouseMove, x1, y1
    Sleep 50
    Click
    MouseMove, x2, y2
    Sleep 50
    Click
    MouseMove, 1650, 1000
    Click
    Sleep 250
    Click
    Sleep 250
    Click
    MouseMove, x3, y3
    Sleep 50
    Click
    BlockInput, MouseMoveOff
}

F6::
    ; 蒙德
    Expedition(150, 165, 1063, 333, 300, 150)
    Expedition(150, 165, 1176, 659, 300, 300)
    ; 璃月
    Expedition(150, 230, 724, 333, 300, 150)
    Expedition(150, 230, 961, 454, 300, 300)
    ; 稻妻
    Expedition(150, 300, 1101, 283, 300, 150)

    Sleep 400
    Send, {esc}
Return

~$XButton2::
    if repeatClickLeft
    {
        Loop
        {
            Click
            KeyWait, XButton2, T0.1
            If Not ErrorLevel
            {
                Break
            }
        }
    }
Return
