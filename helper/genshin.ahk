#SingleInstance Force
#InstallMouseHook
#Include expedition.ahk
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

repeatClickLeft:=1
spaceWait:=0
resolution:="2560x1440"
Gui, Add, Text, w400 h16, Usage:
Gui, Add, Text, w400 h16 y+5, F键   连发
Gui, Add, Text, w400 h16 y+5, Space 连发
Gui, Add, Text, w400 h16 y+5, F6    探索派遣 

Gui, Add, Text, w400 h16 y+10, Options:

Gui, Add, CheckBox,w400 h16 y+5 gOnSubmmit vrepeatClickLeft Checked, 左键连发，长按鼠标前侧键触发
Gui, Add, CheckBox,w400 h16 y+5 gOnSubmmit vspaceWait, 空格连发延迟触发，离开浪船需要长按空格

Gui, Add, Text,  h16 y+5, 分辨率
Gui, Add, DropDownList, x+16 yp-2 gOnSubmmit Choose1 vresolution, 2560x1440|1920x1080

Gui, Add, Button, xm y+10 gOnClickDebugInfo Default w80, Debug Info

Gui, Show
Return

GuiEscape:
GuiClose:
ExitApp

OnSubmmit:
    Gui, Submit, Nohide
Return

OnClickDebugInfo:
    MsgBox, 
    (
repeatClickLeft:    %repeatClickLeft%
spaceWait:          %spaceWait%
resolution:         %resolution%
    )
Return

; #IfWinActive ahk_exe YuanShen.exe

; 按住空格等于狂按空格（按住 1.3 秒之后才触发，因为离开浪船需要按住空格）
~*Space::
    KeyWait, Space, T0.3 ; at least wait 0.3s
    If Not ErrorLevel
    {
        Return
    }
    if spaceWait 
    {
        KeyWait, Space, T1
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

; 探索派遣
F6::
    Switch resolution
    {
    Case "2560x1440": Use2560x1440()
    Case "1920x1080": Use1920x1080()
    }
    ExpeditionAll()
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
