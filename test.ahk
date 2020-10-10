
;...
^G::send {BS}
#^+G::send {Del}
^N::send {Enter}
^E::send {Esc}

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

space & G::send {BS}
space & N::send {Enter}
space & E::send {Esc}

space & K::send {Up}
space & J::send {Down}
space & H::send {Left}
space & L::send {Right}
space & I::send {Home}
space & O::send {End}

space::Send, {space}

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