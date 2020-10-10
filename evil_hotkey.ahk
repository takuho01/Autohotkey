
;...
^G::send {BS}
#^+G::send {Del}
^N::send {Enter}
^E::send {Esc}

Space & G::send {BS}
Space & N::send {Enter}
Space & E::send {Esc}

;c ursol move 
Space & K::send {Up}
Space & J::send {Down}
Space & H::send {Left}
Space & L::send {Right}
Space & I::send {Home}
Space & O::send {End}

; ^Space & K::send +{Up}
; ^Space & J::send +{Down}
; ^Space & H::send +{Left}
; ^Space & L::send +{Right}
; ^Space & I::send +{Home}
; ^Space & O::send +{End}

Space & Up::Send {PgUp}
Space & Down::Send {PgDn}
Space & Left::Send {Home}
Space & Right::Send {End}

^+Up::Send +{PgUp}
^+Down::Send +{PgDn}
^+Left::Send +{Home}
^+Right::Send +{End} 

; vk1D::Send ^#{Left}
; vk1C::Send ^#{Right}
; vk1D & f::Send #{Tab}

; vk1D::Send {Space}
vk1C::Send {Space}
vk1D & f::Send #{Tab}

~Space up::
  Input, Spaceout, I T0.1 V L1, {Space}
  if(ErrorLevel == "EndKey:Space"){
    SendInput, {BackSpace 2}
    Send, hoge
  }
Return 
; ~o up::
;   Input, oout, I T0.1 V L1, {o}
;   if(ErrorLevel == "EndKey:O"){
;     SendInput, {BackSpace 2}
;     Send, ^#{Right}
;   }
; Return

