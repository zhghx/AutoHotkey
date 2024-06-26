﻿IMEmap:=Map(
"zh",134481924,
"jp",68224017,
"en",68224009
)

; enAppList :=[2
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
    if (winTitle = "") {
        MsgBox("当前没有活动窗口。")
        return
    }
    if WinExist(winTitle) {
        PostMessage(0x50, 0, IMEID,, winTitle)
    } else {
        MsgBox("无法找到窗口：" winTitle)
    }
}

; 切换微软日文输入法（英文模式）
sc07B::{
    switchIMEbyID(IMEmap["jp"])
    Sleep(100)
    Send("{sc070}")
    Send("{sc029}")
    ; SetCapsLockState "alwaysoff"
}

; 切换微软日文输入法（日文模式）
sc079::{
    switchIMEbyID(IMEmap["jp"])
    Sleep(100)
    Send("{sc070}")
    ; SetCapsLockState "alwaysoff"
}

; 切换微软拼音输入法 !F2
sc070::{
    switchIMEbyID(IMEmap["zh"])
    ; SetCapsLockState "alwaysoff"
}