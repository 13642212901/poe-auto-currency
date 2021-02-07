#Include, app.ahk
#Include, TestListen.ahk
#Include, ImageListen.ahk

app := new App

l1 := new TestListen
app.Append(l1)

l2 := new ImageListen
app.Append(l2)

app.Run()

w::
    l2.Hit()
return

q::
    l1.Hit()
return

; y::
;     Send ^c
;     MsgBox, %clipboard%
; return