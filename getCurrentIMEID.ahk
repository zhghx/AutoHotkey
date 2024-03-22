getCurrentIMEID(){
  winID:=WinExist("A")
  ThreadID:=DllCall("GetWindowThreadProcessId", "Ptr", winID, "UInt", 0)
  InputLocaleID:=DllCall("GetKeyboardLayout", "UInt", ThreadID, "UInt")
  return InputLocaleID
}

; 当按下 Alt + F12 时显示当前输入法的IME ID
!F12:: ; Alt + F12
  currentIMEID := getCurrentIMEID()
  MsgBox, 当前输入法的IME ID是: %currentIMEID%
return