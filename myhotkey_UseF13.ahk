
; ChangeKeyを使用してCapsLockをF13にした場合
; Caps2CtrlなどでCapsLockをCtrlにするとhjklを長押ししたときにhjklが入り込むバグを
; 修正するため

;---
F13 & q::send {Blind}^q
F13 & w::send {Blind}^w
F13 & e::send {Blind}^e
F13 & r::send {Blind}^r
F13 & t::send {Blind}^t
F13 & y::send {Blind}^y
F13 & u::send {Blind}^u
; F13 & i::send {Blind}^i
; F13 & o::send {Blind}^o
F13 & p::send {Blind}^p
F13 & a::send {Blind}^a
F13 & s::send {Blind}^s
F13 & d::send {Blind}^d
F13 & f::send {Blind}^f
; F13 & g::send {Blind}^g
; F13 & h::send {Blind}^h
; F13 & j::send {Blind}^j
; F13 & k::send {Blind}^k
; F13 & l::send {Blind}^l
F13 & z::send {Blind}^z
F13 & x::send {Blind}^x
F13 & c::send {Blind}^c
F13 & v::send {Blind}^v
F13 & b::send {Blind}^b
F13 & n::send {Blind}^n
F13 & m::send {Blind}^m
F13 & 1::send {Blind}^1
F13 & 2::send {Blind}^2
F13 & 3::send {Blind}^3
F13 & 4::send {Blind}^4
F13 & 5::send {Blind}^5
F13 & 6::send {Blind}^6
F13 & 7::send {Blind}^7
F13 & 8::send {Blind}^8
F13 & 9::send {Blind}^9
F13 & 0::send {Blind}^0
F13 & -::send {Blind}^-
F13 & /::send {Blind}^/
F13 & `;::send {Blind}^`;
F13 & Tab::send {Blind}^{Tab}
F13 & [::send {Blind}^[
F13 & ]::send {Blind}^]
F13 & Space::send {Blind}^{Space}

;---

F13 & G::send {BS}

;cursol move 
F13 & K::send {Blind}{Up}
F13 & J::send {Blind}{Down}
F13 & H::send {Blind}{Left}
F13 & L::send {Blind}{Right}
F13 & I::send {Blind}{Home}
F13 & O::send {Blind}{End}

F13 & Up::Send    {Blind}{PgUp}
F13 & Down::Send  {Blind}{PgDn}
F13 & Left::Send  {Blind}{Home}
F13 & Right::Send {Blind}{End}

F13 & vk1D::Send {PgDn}
F13 & vk1C::Send {PgUp}
;vk1D & f::Send #{Tab}

vk1D::Send ^#{Left}
vk1C::Send ^#{Right}
; +vk1C::Send {PgUp}

; vscode
#if WinActive("ahk_exe Code.exe")


;２連続入力に対応
; ~i up::
;   Input, iout, I T0.1 V L1, {i}
;   if(ErrorLevel == "EndKey:I"){
;     SendInput, {BackSpace 2}
;     Send, ^#{Left}
;   }
; Return
