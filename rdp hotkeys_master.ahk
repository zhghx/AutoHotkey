#Persistent
SetTimer, ReloadOnRDPMaximized, 500
return

ReloadOnRDPMaximized:
If WinActive("ahk_class TscShellContainerClass")
{
    WinGet, maxOrMin, MinMax, ahk_class TscShellContainerClass

    if (maxOrMin = 0) {
        WinGetPos, PosX, PosY, WinWidth, WinHeight, ahk_class TscShellContainerClass

        if (PosY = 0) {
            ; it is fully maximized therefore reload "script.ahk"
            Run, %A_AhkPath% "%A_ScriptDir%\rdp hotkeys_slave.ahk"  ; 使用 %A_AhkPath% 和 %A_ScriptDir% 内置变量

            ; wait until window gets deactivated so you don't reload it again.
            WinWaitNotActive, ahk_class TscShellContainerClass

        }
    }
}