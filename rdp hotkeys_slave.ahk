#SingleInstance Force
#IfWinActive, ahk_exe mstsc.exe
;Send Alt+Win+Left when user types Ctrl+Alt+Left
^!Left::
send !#{Left}
return

;Send Alt+Win+Right when user types Ctrl+Alt+Right
^!Right::
send !#{Right}
return