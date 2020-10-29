
global mode:=0

; in all mode

;...
^G::send {BS}

;cursol move 
^K::send {Up}
^J::send {Down}
^H::send {Left}
^L::send {Right}
^I::send {Home}
^O::send {End}

^+K::send +{Up}
^+J::send +{Down}
^+H::send +{Left}
^+L::send +{Right}
^+I::send +{Home}
^+O::send +{End}

^Up::Send {PgUp}
^Down::Send {PgDn}
^Left::Send {Home}
^Right::Send {End}

^+Up::Send +{PgUp}
^+Down::Send +{PgDn}
^+Left::Send +{Home}
^+Right::Send +{End}

vk1D::Send ^#{Left}
vk1C::Send ^#{Right}
vk1D & f::Send #{Tab}

~j up::
  Input, jout, J T0.1 V L1, {j}
  if(ErrorLevel == "EndKey:J"){
    SendInput, {BackSpace 2}
    mode = 1
  }
Return

#if mode = 0 
#if

#if mode = 1
j::Send {Down}
k::Send {Up}
l::Send {Right}
h::Send {Left}
g::Send {BackSpace}
i::
    mode = 0
    return
#if

; vscode
#if (WinActive("ahk_exe Code.exe"))
#if

;２連続入力に対応
; ~i up::
;   Input, iout, I T0.1 V L1, {i}
;   if(ErrorLevel == "EndKey:I"){
;     SendInput, {BackSpace 2}
;     Send, ^#{Left}
;   }
; Return
