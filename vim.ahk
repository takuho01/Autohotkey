#UseHook
SetTitleMatchMode, 2 ;WinActiveの挙動を部分一致検索に変える。

;;----------------------------------------------------
;; モード管理変数
;;----------------------------------------------------
global NOMAL_MAIN_MODE := 0
global NOMAL_SUB_MODE := 1
global APP_MAIN_MODE := 2
global APP_SUB_MODE := 3
global SELECT_APP_MODE := 4

global mode := APP_MAIN_MODE

;;----------------------------------------------------
;; ATOMモード用変数
;;----------------------------------------------------
global ATOM_MOVING_TEXT_MODE := 0
global ATOM_SELECTING_TEXT_MODE := 1
global ATOM_SELECTING_KUKEI_TEXT_MODE := 2

global atom_cursor_mode := ATOM_MOVING_TEXT_MODE

global atom_window_is_tree_view := false

;;----------------------------------------------------
;; モード変更ルーチン
;;----------------------------------------------------

ChangeNomalMainMode() {
    mode := NOMAL_MAIN_MODE
}

ChangeNomalSubMode() {
    mode := NOMAL_SUB_MODE
}

ChangeAppMainMode() {
    if (WinActive("ahk_exe atom.exe")) {
        Send, {Esc} 
        atom_cursor_mode := ATOM_MOVING_TEXT_MODE
    }
    else if (WinActive("ahk_exe chrome.exe")) {
    }
    else if (WinActive("ahk_exe FreeCommander.EXE")) {
        free_commander_is_file_selecting := false
    }
    mode := APP_MAIN_MODE
}

ChangeAppSubMode() {
    if (WinActive("ahk_exe atom.exe")) {
        atom_window_is_tree_view := false
    }
    mode := APP_SUB_MODE
}

ChangeSelectAppMode() {
    mode := SELECT_APP_MODE
}
;;----------------------------------------------------
;; すべてのモードで共通
;;----------------------------------------------------
sc03a::
    Send, !{Tab}
return

;;無変換
vk1D::
    ; ChangeNomalSubMode()
    while (GetKeyState("sc07B", "P")) {
        Sleep, 100
    }
    ChangeAppMainMode()
return

;;変換
vk1C::
    ; ChangeAppSubMode()
    while (GetKeyState("sc079", "P")) {
        Sleep, 100
    }
    ChangeNomalMainMode()
return

;;----------------------------------------------------
;; ノーマルモード動作
;;----------------------------------------------------
#if (mode = APP_MAIN_MODE)

;; 削除
x::
    Send,{BS} 
return

g::
    Send,{BS} 
return

;; コピー、貼り付け、切り取り、元に戻す
c::
    Send, ^c
    Send, {Esc}
    atom_cursor_mode := ATOM_MOVING_TEXT_MODE
return
v::
    Send, ^v
    Send, {Esc}
    atom_cursor_mode := ATOM_MOVING_TEXT_MODE
return
z::
    Send, ^z
return

i::
    ChangeNomalMainMode()
return

Space::
    ChangeNomalMainMode()
return

;; 移動
k::
    if (atom_cursor_mode = ATOM_MOVING_TEXT_MODE)
        Send, {Up}
    else if (atom_cursor_mode = ATOM_SELECTING_TEXT_MODE)
        Send, +{Up}
    else if (atom_cursor_mode = ATOM_SELECTING_KUKEI_TEXT_MODE)
        Send, ^!{Up}
return

j::
    if (atom_cursor_mode = ATOM_MOVING_TEXT_MODE)
        Send, {Down}
    else if (atom_cursor_mode = ATOM_SELECTING_TEXT_MODE)
        Send, +{Down}
    else if (atom_cursor_mode = ATOM_SELECTING_KUKEI_TEXT_MODE)
        Send, ^!{Down}
return

h::
    if (atom_cursor_mode = ATOM_MOVING_TEXT_MODE)
        Send, {Left}
    else if (atom_cursor_mode = ATOM_SELECTING_TEXT_MODE)
        Send, +{Left}
    else if (atom_cursor_mode = ATOM_SELECTING_KUKEI_TEXT_MODE)
        Send, +{Left}
return

l::
    if (atom_cursor_mode = ATOM_MOVING_TEXT_MODE)
        Send, {Right}
    else if (atom_cursor_mode = ATOM_SELECTING_TEXT_MODE)
        Send, +{Right}
    else if (atom_cursor_mode = ATOM_SELECTING_KUKEI_TEXT_MODE)
        Send, +{Right}
return

;; 大きく移動
e::
    if (atom_cursor_mode = ATOM_MOVING_TEXT_MODE)
        Send, {PgUp}
    else if (atom_cursor_mode = ATOM_SELECTING_TEXT_MODE)
        Send, +{Up 10}
    else if (atom_cursor_mode = ATOM_SELECTING_KUKEI_TEXT_MODE)
        Send, ^!{Up 10}
return

d::
    if (atom_cursor_mode = ATOM_MOVING_TEXT_MODE)
        Send, {PgDn}
    else if (atom_cursor_mode = ATOM_SELECTING_TEXT_MODE)
        Send, +{Down 10}
    else if (atom_cursor_mode = ATOM_SELECTING_KUKEI_TEXT_MODE)
        Send, ^!{Down 10}
return

s::
    if (atom_cursor_mode = ATOM_MOVING_TEXT_MODE)
        Send, {Home}
    else if (atom_cursor_mode = ATOM_SELECTING_TEXT_MODE)
        Send, +{Home}
    else if (atom_cursor_mode = ATOM_SELECTING_KUKEI_TEXT_MODE)
        Send, +{Left 3}
return

f::
    if (atom_cursor_mode = ATOM_MOVING_TEXT_MODE)
        Send, {End}
    else if (atom_cursor_mode = ATOM_SELECTING_TEXT_MODE)
        Send, +{End}
    else if (atom_cursor_mode = ATOM_SELECTING_KUKEI_TEXT_MODE)
        Send, +{Right 3}
return

;;;; 選択モードでは連続してshift + 移動キーを送り続きるが、次のキーを押下したときに
;;;; shiftが入りっぱなしになる問題が発生したため、暫定対応として以下のキーを無視する。

a::
; b::
; c::
; d::
; e::
; f::
; g::
; h::
; i::
; j::
; k::
; l::
m::
; n::
o::
p::
q::
r::
; s::
t::
u::
; v::
w::
; x::
y::
; z::


+i::return
+k::return
+j::return
+l::return
+e::return
+d::return
+s::return
+f::return




~-::
~^::
~\::
~@::
~[::
    ~;::
    ; ~vkBAsc028::    ;; :のキーコード
~]::
~,::
~.::
    ;;~/::
    ; ~vkE2sc073::    ;; \のキーコード
~+-::
~+^::
~+\::
~+@::
~+[::
    ~+;::
    ; ~+vkBAsc028::   ;; :のキーコード
~+]::
~+,::
~+.::
~+/::
    ; ~+vkE2sc073::   ;; \のキーコード
    ; ~Space::
~!::
~"::
~#::
~$::
~%::
~&::
~'::
~(::
~)::
~+q::
~+w::
~+r::
~+y::
~+u::
~+o::
~+p::
~+a::
~+g::
~+h::
~+z::
~+x::
~+c::
~+v::
~+b::
~+n::
~+m::

return

#if

;;----------------------------------------------------
;; インサートモード
;;----------------------------------------------------
#if (mode = NOMAL_MAIN_MODE)
    
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

^Up::Send {PgUp}
^Down::Send {PgDn}
^Left::Send {Home}
^Right::Send {End}

^+Up::Send +{PgUp}
^+Down::Send +{PgDn}
^+Left::Send +{Home}
^+Right::Send +{End}

; ~j up::
;   Input, jout, I T0.1 V L1, {j}
;   if(ErrorLevel == "EndKey:J"){
;     SendInput, {BackSpace 2}
;     ChangeAppMainMode()
;   }
; Return

~j::
  Input, jout, I T0.3 V L1, {k}
  if(ErrorLevel == "EndKey:K"){
    SendInput, {BackSpace 2}
    ChangeAppMainMode()
  }
Return

; ~Space up::
;     Input, Spaceout, I T0.2 V L1, {Space}
;     if(ErrorLevel == "EndKey:Space"){
;         SendInput, {BackSpace 2}
;         ChangeAppMainMode()
;     }
; Return

return

#if