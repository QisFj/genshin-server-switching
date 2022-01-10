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


ExpeditionCharacter(targetPosX, targetPoxY, charPosX, charPosY){
    BlockInput, MouseMove
    Click %targetPosX%, %targetPoxY%
    Sleep 100
    Click 2300, 1360 ; 领取
    Sleep 250
    Click ; 关闭 领取页
    Sleep 100
    Click 2400, 900 ; 20h
    Sleep 100
    Click 2300, 1360 ; 选择角色
    Sleep 250
    Click %charPosX%, %charPosY%
    Sleep 250
    BlockInput, MouseMoveOff
}

; 探索派遣
F6:: ; only work on 2560 x 1440
    Send, {f}
    Sleep 500
    Send, {f}
    Sleep 500
    Click 1800, 880 ; 蒙德 凯瑟琳
    Sleep 500

    ; 蒙德
    Click 180, 220
    Sleep 500

    ExpeditionCharacter(1400, 450, 160, 220) ; 低语森林     菲谢尔
    ExpeditionCharacter(1600, 900, 160, 390) ; 达达乌帕谷   班尼特

    ; 璃月
    Click 180, 310
    Sleep 500
    
    ExpeditionCharacter(1300, 600, 160, 220) ; 摇光滩   刻晴
    ExpeditionCharacter(1075, 745, 160, 390) ; 归离原   重云

    ; 稻妻
    Click 180, 410
    Sleep 800
    
    ExpeditionCharacter(1100, 1100, 160, 220) ; 踏鞴砂  九条裟罗

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
