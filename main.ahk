#ifWinActive,ahk_exe pathofexile_x64.exe
hasRun := 2
history := 0
#Include, App.ahk
#Include, Config.ahk


alt := new App("alteration")
chance := new App("chance")
anc := new App("ancient")
alc := new App("alchemy")
chaos := new App("chaos")

!a::
if (hasRun = 2) {
	history := 1
    hasRun := 1
    alt.Run()
    hasRun := 2
}
return

!d::
if (hasRun = 2) {
	history := 2
    hasRun := 1
    chance.Run()
    hasRun := 2
}
return

!f::
if (hasRun = 2) {
	history := 3
    hasRun := 1
    anc.Run()
    hasRun := 2
}
return

!g::
if (hasRun = 2) {
	history := 4
    hasRun := 1
    alc.Run()
    hasRun := 2
}
return

!h::
if (hasRun = 2) {
	history := 5
    hasRun := 1
    chaos.Run()
    hasRun := 2
}
return

!s::
    alt.Stop()
    chance.Stop()
    anc.Stop()
    alc.Stop()
    chaos.Stop()
return
^s::
	Switch history {
	Case 1:
	    alt.ReStart()
	Case 2:
	    chance.ReStart()
	Case 3:
	    anc.ReStart()
	Case 4:
	    alc.ReStart()
	Case 5:
	    chaos.ReStart()
	}
return

!c::
if (hasRun = 2) {
	MouseGetPos, xpos, ypos
	msg := xpos . "," . ypos
	MsgBox, %msg%
	Clipboard := msg
}
return