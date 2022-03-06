
; ChangeKeyを使用してCapsLockをF13にした場合
; Caps2CtrlなどでCapsLockをCtrlにするとhjklを長押ししたときにhjklが入り込むバグを
; 修正するため

;---spjlekcial move---
; 変数定義は一番最初で実行しないと、謎のエラーが起きる
global mode := 0
global NormalMode := 0
global WinSelMode := 1 
global CommandMode := 0
global InsertMode := 1 
global SelectMode := 2 
global LineSelectMode := 3 
global NormalCopy := 0 
global LineSelectCopy :=1 


;;; Excel ;;;
#IfWinActive,ahk_exe EXCEL.exe

^c::
    if (emode = InsertMode) {
        send {Enter}
        send {Up}
        SpaceCnt := 0 
        emode := CommandMode
    }else if (emode = SelectMode){
        send {Up}
        send {Down}
        send {Esc}
        SpaceCnt := 0 
        emode := CommandMode
    }else if (emode = LineSelectMode){
        send {Up}
        send {Down}
        send {Esc}
        SpaceCnt := 0 
        emode := CommandMode
    }else{
        send {Esc}
        SpaceCnt := 0 
        emode := CommandMode
    }
return

^enter::
    if (emode = CommandMode) {
        emode := InsertMode 
        send {F2}
    }else{
        send {F2}
    }
return

+enter:: 
    if (emode = CommandMode) {
        Send !{Enter} 
    }else if (emode = SelectMode){
        if (SpaceCnt = 1){
            send ^+= 
            send +i
            send ^{Enter} 
        }else {
            send ^x{Down}{Up}{Up}{Up}{Up}{Up}{Up}^v
        }
    }else{
        Send !{Enter} 
    }
return

enter::
    if (emode = CommandMode) {
        if (SpaceCnt = 1){
            send {Down} 
            send +{Space} 
            send ^+=
            SpaceCnt := 0 
        }else {
            send {Enter}
        }
    }else if (emode = SelectMode){
        if (SpaceCnt = 1){
            send ^+= 
            send +d
            send ^{Enter} 
        }else {
            send ^x{Down}{Up}{Down}{Down}{Down}{Down}{Down}^v
        }
    }else if (emode = LineSelectMode){
        send ^x{Down}{Up}{Down}^v
    }else{
        send {Enter} 
    }
return

Space::
    if (emode = CommandMode) {
        SpaceCnt := 1
    }else if (emode = SelectMode){
        SpaceCnt := 1
    }else if (emode = LineSelectMode){
        SpaceCnt := 1
    }else {
        send {Space}
    }
return

Tab::
    if (emode = CommandMode) {
        send ^x{Right}^v
    }else if (emode = InsertMode){
        send {Tab}{Right}{Left} 
    }else if (emode = SelectMode){
        send ^x{Down}{Up}{Right}{Right}{Right}{Right}{Right}^v
    }else{
        send {Tab}
    }
return

+Tab::
    if (emode = CommandMode) {
        send ^x{Left}^v
    }else if (emode = InsertMode){
        send +{Tab}{Right}{Left} 
    }else if (emode = SelectMode){
        send ^x{Down}{Up}{Left}{Left}{Left}{Left}{Left}^v
    }else{
        send +{Tab}
    }
return

i::
    if (emode = CommandMode) {
        emode := InsertMode 
    }else{
        send i 
    }
return

v::
    if (emode = CommandMode) {
        emode := SelectMode 
        VisualCnt := 0
    }else if (emode = SelectMode){
        VisualCnt := VisualCnt + 1
        send +{Right}+{Right}
        send +{Down}+{Down}
    }else{
        send v 
    }
return

+v::
    if (emode = CommandMode) {
        send +{Space}
        emode := LineSelectMode 
    }else{
        send V 
    }
return

y::
    if (emode = CommandMode) {
        Keywait, y 
        Keywait, y, D, T0.1
        if (ErrorLevel = 1){
            send ^c 
            cmode := NormalCopy
        }else {
            send +{Space} 
            send ^c 
            cmode := LineSelectCopy 
        }
    }else if (emode = SelectMode){
        send ^c 
        emode := CommandMode
        cmode := NormalCopy
    }else if (emode = LineSelectMode){
        send ^c 
        emode := CommandMode
        cmode := LineSelectCopy 
    }else{
        send y 
    }
return

p::
    if (emode = CommandMode) {
        if (cmode = LineSelectCopy) {
            send {Down}+{Space}
            send ^+=
            send ^c
        }else {
            send ^v 
            send ^c 
        }
    }else if (emode = SelectMode){
        send ^v 
    }else if (emode = LineSelectMode){
        send ^+=
    }else{
        send p 
    }
return

u::
    if (emode = CommandMode) {
        send ^z 
    }else{
        send u 
    }
return

d::
    if (emode = CommandMode) {
        send +{Space} 
        send ^- 
    }else if (emode = SelectMode){
        send ^- 
        send +u
        send ^{Enter} 
    }else if (emode = LineSelectMode){
        send ^- 
        send {Up}
        send {Down}
        send {Esc}
        emode := CommandMode
    }else{
        send d 
    }
return

+d::
    if (emode = CommandMode) {
    }else if (emode = SelectMode){
        send ^- 
        send +l
        send ^{Enter}
        emode := CommandMode
    }else if (emode = LineSelectMode){
    }else{
        send +d 
    }
return

x::
    if (emode = CommandMode) {
        send {Delete} 
    }else if (emode = SelectMode){
        send ^x
        emode := CommandMode
    }else if (emode = LineSelectMode){
        send ^x
        emode := CommandMode
    }else{
        send x
    }
return

^r::
    if (emode = CommandMode) {
        send ^y
    }
return

h::
    if (emode = CommandMode) {
        if (SpaceCnt = 1){
            send {End}
            send {Left}
            SpaceCnt := 0 
        }else{
            send {Left}
        }
    }else if (emode = SelectMode){
        if (SpaceCnt = 1){
            send {End}
            send +{Left}
            SpaceCnt := 0 
        }else{
            send +{Left}
        }
    }else if (emode = LineSelectMode){
        if (SpaceCnt = 1){
            send {End}
            send +{Left}
            SpaceCnt := 0 
        }else{
            send +{Left}
        }
    }else{
        send  h
        emode := InsertMode
    }
return

j::
    if (emode = CommandMode) {
        if (SpaceCnt = 1){
            send {End}
            send {Down}
            SpaceCnt := 0 
        }else{
            send {Down}
        }
    }else if (emode = SelectMode){
        if (SpaceCnt = 1){
            send {End}
            send +{Down}
            SpaceCnt := 0 
        }else{
            send +{Down}
        }
    }else if (emode = LineSelectMode){
        if (SpaceCnt = 1){
            send {End}
            send +{Down}
            SpaceCnt := 0 
        }else{
            send +{Down}
        }
    }else{
        send j
        emode := InsertMode
    }
return

k::
    if (emode = CommandMode) {
        if (SpaceCnt = 1){
            send {End}
            send {Up}
            SpaceCnt := 0 
        }else{
            send {Up}
        }
    }else if (emode = SelectMode){
        if (SpaceCnt = 1){
            send {End}
            send +{Up}
            SpaceCnt := 0 
        }else{
            send +{Up}
        }
    }else if (emode = LineSelectMode){
        if (SpaceCnt = 1){
            send {End}
            send +{Up}
            SpaceCnt := 0 
        }else{
            send +{Up}
        }
    }else{
        send k 
        emode := InsertMode
    }
return

l::
    if (emode = CommandMode) {
        if (SpaceCnt = 1){
            send {End}
            send {Right}
            SpaceCnt := 0 
        }else{
            send {Right}
        }
    }else if (emode = SelectMode){
        if (SpaceCnt = 1){
            send {End}
            send +{Right}
            SpaceCnt := 0 
        }else{
            send +{Right}
        }
    }else if (emode = LineSelectMode){
        if (SpaceCnt = 1){
            send {End}
            send +{Right}
            SpaceCnt := 0 
        }else{
            send +{Right}
        }
    }else{
        send l 
        emode := InsertMode
    }
return

^h::
    if (emode = CommandMode) {
        send ^x{Down}{Up}{Left}^v
    }else if (emode = SelectMode){
        send ^x{Down}{Up}{Left}^v
    }else if (emode = LineSelectMode){
    }else{
        send {Left}
    }
return

^j::
    if (emode = CommandMode) {
        send ^x{Down}{Up}{Down}^v
    }else if (emode = SelectMode){
        send ^x{Down}{Up}{Down}^v
    }else if (emode = LineSelectMode){
    }else{
        send {Down}
    }
return

^k::
    if (emode = CommandMode) {
        send ^x{Down}{Up}{Up}^v
    }else if (emode = SelectMode){
        send ^x{Down}{Up}{Up}^v
    }else if (emode = LineSelectMode){
    }else{
        send {Up}
    }
return

^l::
    if (emode = CommandMode) {
        send ^x{Down}{Up}{Right}^v
    }else if (emode = SelectMode){
        send ^x{Down}{Up}{Right}^v
    }else if (emode = LineSelectMode){
    }else{
        send {Right}
    }
return

+h::
    if (emode = CommandMode) {
        if (SpaceCnt = 1){
            send {End}
            send {Left}
            SpaceCnt := 0 
        }else{
            send {Left}{Left}{Left}{Left}{Left}
        }
    }else if (emode = SelectMode){
        if (SpaceCnt = 1){
            send {End}
            send +{Left}
            SpaceCnt := 0 
        }else{
            send +{Left}
        }
    }else if (emode = LineSelectMode){
        if (SpaceCnt = 1){
            send {End}
            send +{Left}
            SpaceCnt := 0 
        }else{
            send +{Left}+{Left}+{Left}+{Left}+{Left}
        }
    }else{
        send  +h
        emode := InsertMode
    }
return

+j::
    if (emode = CommandMode) {
        if (SpaceCnt = 1){
            send {End}
            send {Down}
            SpaceCnt := 0 
        }else{
            send {Down}{Down}{Down}{Down}{Down}
        }
    }else if (emode = SelectMode){
        if (SpaceCnt = 1){
            send {End}
            send +{Down}
            SpaceCnt := 0 
        }else{
            send +{Down}
        }
    }else if (emode = LineSelectMode){
        if (SpaceCnt = 1){
            send {End}
            send +{Down}
            SpaceCnt := 0 
        }else{
            send +{Down}+{Down}+{Down}+{Down}+{Down}
        }
    }else{
        send +j
        emode := InsertMode
    }
return

+k::
    if (emode = CommandMode) {
        if (SpaceCnt = 1){
            send {End}
            send {Up}
            SpaceCnt := 0 
        }else{
            send {Up}{Up}{Up}{Up}{Up}
        }
    }else if (emode = SelectMode){
        if (SpaceCnt = 1){
            send {End}
            send +{Up}
            SpaceCnt := 0 
        }else{
            send +{Up}
        }
    }else if (emode = LineSelectMode){
        if (SpaceCnt = 1){
            send {End}
            send +{Up}
            SpaceCnt := 0 
        }else{
            send +{Up}+{Up}+{Up}+{Up}+{Up}
        }
    }else{
        send +k 
        emode := InsertMode
    }
return

+l::
    if (emode = CommandMode) {
        if (SpaceCnt = 1){
            send {End}
            send {Right}
            SpaceCnt := 0 
        }else{
            send {Right}{Right}{Right}{Right}{Right}
        }
    }else if (emode = SelectMode){
        if (SpaceCnt = 1){
            send {End}
            send +{Right}
            SpaceCnt := 0 
        }else{
            send +{Right}
        }
    }else if (emode = LineSelectMode){
        if (SpaceCnt = 1){
            send {End}
            send +{Right}
            SpaceCnt := 0 
        }else{
            send +{Right}+{Right}+{Right}+{Right}+{Right}
        }
    }else{
        send +l 
        emode := InsertMode
    }
return


Return
#IfWinActive

