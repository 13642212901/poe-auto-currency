class Log {
    __New(filename) {
        this.filename := filename
        this.Destroy()
    }

    info(msg) {
        d := %A_YYYY%-%A_MM%-%A_DD% %A_Hour%:%A_Min%:%A_Sec%
        msg := %d`n% . %msg`n%
        FileAppend , %msg%, % this.filename
    }

    Destroy() {
        FileReadLine, d, % filename, 1
        arr := StrSplit(d, " ")
        if (arr[1] != %A_YYYY%-%A_MM%-%A_DD%) {
            FileDelete, this.filename
        }
    }
}