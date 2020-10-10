
; https://qiita.com/skikkh/items/07c050a4cf62443d0a38を参照

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
;; FreeCommanderモード用変数
;;----------------------------------------------------
global free_commander_is_file_selecting := false

;;----------------------------------------------------
;; ライブラリモジュール
;;----------------------------------------------------
IME_SET(SetSts, WinTitle="A")    {
  ControlGet,hwnd,HWND,,,%WinTitle%
  if  (WinActive(WinTitle)) {
    ptrSize := !A_PtrSize ? 4 : A_PtrSize
      VarSetCapacity(stGTI, cbSize:=4+4+(PtrSize*6)+16, 0)
      NumPut(cbSize, stGTI,  0, "UInt")   ; DWORD   cbSize;
    hwnd := DllCall("GetGUIThreadInfo", Uint,0, Uint,&stGTI)
               ? NumGet(stGTI,8+PtrSize,"UInt") : hwnd
  }

    return DllCall("SendMessage"
          , UInt, DllCall("imm32\ImmGetDefaultIMEWnd", Uint,hwnd)
          , UInt, 0x0283  ;Message : WM_IME_CONTROL
          ,  Int, 0x006   ;wParam  : IMC_SETOPENSTATUS
          ,  Int, SetSts) ;lParam  : 0 or 1
}

;;----------------------------------------------------
;; 呼び出しごとにインクリメントされる数字を返す
;;----------------------------------------------------
global incl_num := 0
_InclementNum() {
    incl_num := incl_num + 1
    return incl_num
}

;;----------------------------------------------------
;; セレクト範囲の文字列を返す
;;----------------------------------------------------
_GetSelectingText() {
    cb_bk := ClipboardAll
    Clipboard :=
    Send, ^c
    ClipWait, 2
    if (ErrorLevel <> 0) {
        ; Error
        selecting_word := ""
    }
    else
    {
        selecting_word := Clipboard
    }
    Clipboard := cb_bk

    ;; Atomは、何も選択していない状態でコピーをすると一行コピーするため、
    ;; 最後の文字が改行であれば何も選択していないと推測する
    if (WinActive("ahk_exe sublime_text.exe") || WinActive("ahk_exe atom.exe")) && (_GetLastChar(selecting_word) == "`n") {
        selecting_word := ""
    }

    return %selecting_word%
}

;;----------------------------------------------------
;; 最後の文字を取得する
;;----------------------------------------------------
_GetLastChar(string_text) {
    StringRight, last_char, string_text, 1
    return last_char
}

;;----------------------------------------------------
;; テキストを貼り付ける
;;----------------------------------------------------
_PasteText(text) {
    cb_bk := ClipboardAll
    Clipboard :=
    Clipboard := text
    ClipWait, 2
    if (ErrorLevel <> 0) {
        MsgBox, "FAIL PasteText()"
    }
    if ("ahk_exe mintty.exe") {
        Send, +{Ins}
    }
    else {
        Send, ^v
    }
    Sleep, 500
    Clipboard := cb_bk
}

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
;; Atomアプリ固有モード
;;----------------------------------------------------
#if (WinActive("ahk_exe atom.exe")) && (mode = APP_MAIN_MODE)

;; 新規作成、削除
n::
    Send, {End}
    Send, {Enter}
    ChangeNomalMainMode()
b::
    Send, ^+k
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
x::
    Send, ^x
    Send, {Esc}
    atom_cursor_mode := ATOM_MOVING_TEXT_MODE
return
z::
    Send, ^z
return

;; 前を消す、後ろを消す
g::Send, {Bs}
h::Send, {Del}

;; 移動
i::
    if (atom_cursor_mode = ATOM_MOVING_TEXT_MODE)
        Send, {Up}
    else if (atom_cursor_mode = ATOM_SELECTING_TEXT_MODE)
        Send, +{Up}
    else if (atom_cursor_mode = ATOM_SELECTING_KUKEI_TEXT_MODE)
        Send, ^!{Up}
return

k::
    if (atom_cursor_mode = ATOM_MOVING_TEXT_MODE)
        Send, {Down}
    else if (atom_cursor_mode = ATOM_SELECTING_TEXT_MODE)
        Send, +{Down}
    else if (atom_cursor_mode = ATOM_SELECTING_KUKEI_TEXT_MODE)
        Send, ^!{Down}
return

j::
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

;; 探す
o::
    Send, ^f
return

;; 変更、一つ選択、グループ選択、グループ選択
r::
    Send, !{F3}
    ChangeNomalMainMode()
return
t::
    Send, ^d
return
+t::
    Send, ^u
return
y::
    Send, {Esc}
    atom_cursor_mode := ATOM_SELECTING_KUKEI_TEXT_MODE
return
u::
    Send, {Esc}
    atom_cursor_mode := ATOM_SELECTING_TEXT_MODE
return

/::
    text := _GetSelectingText()
    incl_num := _InclementNum()

    if (text = "") {
        debug_code = "Break %incl_num% : " //debug code
    }
    else {
        debug_code = "Break %incl_num% : %text% : " //debug code
    }
    Send, {End}
    Send, {Enter}
    _PasteText(debug_code)
return

;;;; 選択モードでは連続してshift + 移動キーを送り続きるが、次のキーを押下したときに
;;;; shiftが入りっぱなしになる問題が発生したため、暫定対応として以下のキーを無視する。
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
~vkE2sc073::    ;; :のキーコード
~]::
~,::
~.::
;;~/::
~vkBAsc028::    ;; \のキーコード
~+-::
~+^::
~+\::
~+@::
~+[::
~+;::
~+vkE2sc073::   ;; :のキーコード
~+]::
~+,::
~+.::
~+/::
~+vkBAsc028::   ;; \のキーコード
~Space::
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
    ChangeNomalMainMode()
return

#if

;;----------------------------------------------------
;; Atomアプリ固有モード（補助）
;;----------------------------------------------------
#if (WinActive("ahk_exe atom.exe")) && (mode = APP_SUB_MODE)

;; 新規作成、削除
n::
    Send, ^n
return
b::
    Send, ^w
return

;; コピー、貼り付け、切り取り、元に戻す
c::
v::
    Send, ^k
    Send, {Left}
return
x::
z::
    Send, ^k
    Send, ^w
return

;; 移動
i::
    Send, {Up}
return
k::
    Send, {Down}
return
j::
    Send, {Left}
    ;;Send, ^{PgUp}
return
l::
    Send, {Right}
    ;;Send, ^{PgDn}
return

;; 大きく移動
e::
    Send, {Esc}
    Send, \
return
d::
    Send, {Esc}
return
s::
    Send, ^{PgUp}
    ;;Send, {Esc}
    ;;Send, ^k
    ;;Send, ^p
return
f::
    Send, ^{PgDn}
    ;;Send, {Esc}
    ;;Send, ^k
    ;;Send, ^n
return

#if

;;----------------------------------------------------
;; Atom入力モード（補助）
;;----------------------------------------------------
#if (WinActive("ahk_exe atom.exe")) && (mode = NOMAL_SUB_MODE)

;; 移動
i::
    Send, {Up}
return
k::
    Send, {Down}
return
j::
    Send, {Left}
return
l::
    Send, {Right}
return

#if

;;----------------------------------------------------
;; Vimアプリ固有モード
;;----------------------------------------------------
#if (WinActive("ahk_exe vim.exe"))
sc079::
    IME_SET(0)
    Send, {Esc}
return
#if


;;----------------------------------------------------
;; 入力モード（補助）
;;----------------------------------------------------
#if (mode = NOMAL_SUB_MODE)

n::
    IME_SET(1)
return

e::
    IME_SET(0)
return

#if

;;----------------------------------------------------
;; すべてもモードで共通
;;----------------------------------------------------
sc03a::
    Send, !{Tab}
return

sc07B::
    ChangeNomalSubMode()
    while (GetKeyState("sc07B", "P")) {
        Sleep, 100
    }
    ChangeNomalMainMode()
return
sc079::
    ChangeAppSubMode()
    while (GetKeyState("sc079", "P")) {
        Sleep, 100
    }
    ChangeAppMainMode()
return
