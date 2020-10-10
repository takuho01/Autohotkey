
;...
^G::send {BS}
^E::send {Esc}

;cursol move
; ^K::send {Up}
; ^J::send {Down}
; ^H::send {Left}
; ^L::send {Right}
; ^I::send {Home}
; ^O::send {End}

; ^+K::send +{Up}
; ^+J::send +{Down}
; ^+H::send +{Left}
; ^+L::send +{Right}
; ^+I::send +{Home}
; ^+O::send +{End}

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