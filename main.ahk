#ifWinActive,ahk_exe pathofexile_x64.exe
hasRun := 2
#Include, App.ahk
#Include, Config.ahk



currencyApp := ""

!a::
if (hasRun = 2) {
	currencyApp:= new App("alteration")
    hasRun := 1
    currencyApp.Run()
    hasRun := 2
}
return

!d::
if (hasRun = 2) {
	currencyApp:= new App("chance")
    hasRun := 1
    currencyApp.Run()
    hasRun := 2
}
return

!f::
if (hasRun = 2) {
	currencyApp := new App("ancient")
    hasRun := 1
    currencyApp.Run()
    hasRun := 2
}
return

!g::
if (hasRun = 2) {
	currencyApp := new App("alchemy")
    hasRun := 1
    currencyApp.Run()
    hasRun := 2
}
return

!h::
if (hasRun = 2) {
	currencyApp := new App("chaos")
    hasRun := 1
    currencyApp.Run()
    hasRun := 2
}
return

!s::
    currencyApp.Stop()
return
^s::
	if (hasRun = 2) {
    	hasRun := 1
		currencyApp.ReStart()
    	hasRun := 2
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