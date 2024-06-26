﻿/*
windows自带输入法的id,可以通过调用windows api GetKeyboardLayout来获取
微软拼音输入法 134481924
微软日文输入法 68224017
微软英文输入法 68224009 
*/
IMEmap:=Map(
"zh",134481924,
"jp",68224017,
"en",68224009
)
; enAppList :=[
; "pwsh.exe"
; ]
; 获取当前激活窗口所使用的IME的ID
getCurrentIMEID(){
    winID:=winGetID("A")
    ThreadID:=DllCall("GetWindowThreadProcessId", "UInt", WinID, "UInt", 0)
    InputLocaleID:=DllCall("GetKeyboardLayout", "UInt", ThreadID, "UInt")
    return InputLocaleID
}
; 使用IMEID激活对应的输入法
switchIMEbyID(IMEID){
    winTitle:=WinGetTitle("A")
    PostMessage(0x50, 0, IMEID,, WinTitle )
}

; 切换微软英文键盘
!1::{
    switchIMEbyID(IMEmap["en"])
    ; SetCapsLockState "alwaysoff"
}
; 切换微软拼音输入法
!2::{
    switchIMEbyID(IMEmap["zh"])
    ; SetCapsLockState "alwaysoff"
}
; 切换微软日文输入法
!3::{
    switchIMEbyID(IMEmap["jp"])
    ; SetCapsLockState "alwaysoff"
}

; 使用窗口组实现批量窗口的监视
GroupAdd "enAppGroup", "ahk_exe pwsh.exe" ;添加powershell
GroupAdd "enAppGroup", "ahk_exe Code.exe" ;添加 vscode
GroupAdd "enAppGroup", "ahk_exe WindowsTerminal.exe" ;添加windows terminal
; 循环等待知道窗口组的窗口激活，切换当前输入法为en,之后再等待当切换出当前窗口继续监视
Loop{
    WinWaitActive "ahk_group enAppGroup"
    currentWinID:= WinGetID("A")
    ; TrayTip Format("当前是{1}，切换为en输入法", WinGetTitle("A"))
    switchIMEbyID(IMEmap["en"])
    ; 从当且窗口切出，进行下一轮监视
    WinWaitNotActive(currentWinID)
}