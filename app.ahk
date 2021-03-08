#Include, UserInput.ahk
#Include, Criteria.ahk
#Include, Currency.ahk

class App {
    __New(name) {
        this.s := 1
        this.name := name
        this.scouring := []
        this.currency:= []
    }
    initConfig() {
        if (A_ScreenWidth >= 1920 && A_ScreenWidth < 2560) {
            this.c := new Config("config_1080.ini")
        }
        if (A_ScreenWidth >= 2560 && A_ScreenWidth < 3840) {
            this.c := new Config("config_2k.ini")
        }
        if (A_ScreenWidth >= 3840) {
            this.c := new Config("config_4k.ini")
        }
        if (A_ScreenWidth < 1920) {
            this.c := new Config("config_mini.ini")
        }
    }
    initCoordinate(c, name) {
        f := CurrencyGroupFactory()
        this.scouring := f.getByDecodeCurrencyType(c.GetType("scouring"))
        this.currency := f.getByDecodeCurrencyType(c.GetType(name))
    }
    Stop() {
        this.s := 2
    }
    Start() {
        this.initConfig()
        this.initCoordinate(this.c, this.name)
        this.s := 1
        res := 0
        while res = 0 {
            if (this.useScoure) {
                if (!this.scouring.Use(this.objX, this.objY)) {
                    this.Stop()
                    Break
                }
            }
            ;通货
            if (!this.currency.Use(this.objX, this.objY)) {
                this.Stop()
                Break
            }
            if (this.s = 2) {
                MsgBox, % Recode("手动停止")
                Break
            }
            ;检测
            res := this.check()
        }
    }
    Run() {
        this.initConfig()
        this.initCoordinate(this.c, this.name)
        MouseGetPos, xpos, ypos 
        this.useScoure := new UseScoureBranch().Run("")
        this.objX := xpos
        this.objY := ypos
        c := new UserInputController()
        this.l := c.Run()
        confirmCriteria:= new CheckCriteria()
        confirmCriteria.set(this.l.Print())
        if (confirmCriteria.Run("") = 1) {
            this.Start()
            MsgBox, % Recode("完成")
        }
    }
    ReStart() {
        this.Start()
    }

    check() {
        input := this.getAttr()
        if (input = "") {
            return 1
        }
        res := this.l.Check(input)
        FileAppend , %input%, log.txt
        if (res = 1) {
            FileAppend , success`n`n, log.txt
        } else {
            FileAppend , error`n`n, log.txt
        }
        return res
    }

    getAttr() {
        Clipboard := ""
        lastClipboard := Clipboard
        l := this.l
        Send ^c
        input := Clipboard
        Loop, 50 {
            if (input = lastClipboard) {
                input := Clipboard
                sleep, 10
            } else {
                Break
            }
        }
        if (input = "") {
            this.Stop()
            MsgBox, % Recode("没有目标物品")
            return ""
        } else {
            return input
        }
    }
}
