
~j::
  Input, jout, I T0.1 V L1, {k}
  if(ErrorLevel == "EndKey:K"){
    SendInput, {BackSpace 2}
    Send, hoge
  }
Return

; ~j up::
;   Input, jout, I T0.1 V L1, {j}
;   if(ErrorLevel == "EndKey:J"){
;     SendInput, {BackSpace 2}
;     ChangeAppMainMode()
;   }
; Return