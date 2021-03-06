#Include, UserInput.ahk
#Include, Criteria.ahk

class App {
    __New(name) {
        this.s := 1
        this.name := name
    }
    initConfig() {
        if (A_ScreenWidth >= 1980 && A_ScreenWidth < 2560) {
            this.c := new Config("config_1080.ini")
        }
        if (A_ScreenWidth >= 2560 && A_ScreenWidth < 3840) {
            this.c := new Config("config_2k.ini")
        }
        if (A_ScreenWidth >= 3840) {
            this.c := new Config("config_4k.ini")
        }
        if (A_ScreenWidth < 1980) {
            this.c := new Config("config_mini.ini")
        }
    }
    initCoordinate(c, name) {
        this.scouring := new CoordinateGroup(c.GetType("scouring"))
        this.currency := new CoordinateGroup(c.GetType(name))
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
        Loop, 20 {
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

class CoordinateGroup {
    __New(str) {
        this.DecodeCoordinate(str)
    }
    Push(corrdinate) {
        this.data.Push(corrdinate)
    }

    DecodeCoordinate(str) {
        this.data := []
        arr := StrSplit(str, "`n")
        if (arr.length() = 0) {
            MsgBox, % Recode("配置错误")
            return
        }
        for index, val in arr {
            this.Push(new Coordinate(val))
        }
    }
    Use(objX, objY) {
        res := 0
        for index, val in this.data {
            if (val.status = 1 && val.Use()) {
                res := 1
                Break
            } else {
                val.status := 0
            }
        }
        if (res = 0) {
            MsgBox, % Recode("通货不足")
            return false
        }
        random,r,0,5
        objX := r + objX
        objY := r + objY
        MouseMove, % objX, % objY
        Sleep, 25
        Send {LButton}
        Sleep, 100
        return true
    }
}

class Coordinate {
    __New(str) {
        this.status := 1
        this.DecodeCoordinate(str)
    }

    Use() {
        Clipboard := ""
        random,r,0,5
        X := this.X + r
        Y := this.Y + r
        MouseMove, % X, % Y
        Sleep, 25
        Loop, 20 {
            Send ^c
            input := Clipboard
            if (input != "") {
                Send {RButton}
                Sleep, 25
                return true
            }
        }
        this.status := 0
        return false
    }

    DecodeCoordinate(str) {
        coordinateArr := StrSplit(str, ",")
        if (coordinateArr.length() != 2) {
            MsgBox, % Recode("坐标错误" . str)
            return
        }
        this.X := coordinateArr[1]
        this.Y := coordinateArr[2]
    }
}