class Currency {
    __New(X, Y) {
        this.status := 1
        this.X := X
        this.Y := Y
    }
    Use(X, Y) {
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
}

class CurrencyGroup {
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

    Push(corrdinate) {
        this.data.Push(corrdinate)
    }
}

class CurrencyGroupFactory {
    getByDecodeCurrencyType(str) {
        arr := StrSplit(str, "`n")
        if (arr.length() = 0) {
            MsgBox, % Recode("配置错误")
            return
        }
        g := new CurrencyGroup()
        for index, val in arr {
            currency := this.DecodeCoordinate(val)
            g.Push(currency)
        }
        return g
    }

    DecodeCoordinate(str) {
        coordinateArr := StrSplit(str, ",")
        if (coordinateArr.length() != 2) {
            MsgBox, % Recode("坐标错误" . str)
            return
        }
        X := coordinateArr[1]
        Y := coordinateArr[2]
        return new Currency(X, Y)
    }
}