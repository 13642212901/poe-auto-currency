class Criteria {
    __New(search) {
        this.search := search
        this.filter := []
        this.filter.Push(new StringInFilter())
        this.filter.Push(new NumericalBetweenFilter())
    }
    Check(input) {
        search := this.search
        matchArr := StrSplit(input, "`n")
        searchArr := StrSplit(search, ",")
        for index, filter in this.filter {
            matchArr := filter.doFilter(matchArr, searchArr)
        }
        if (matchArr.length() > 0) {
            return 0
        } else {
            return 1
        }
    }

    PushFilter(filter) {
        this.filter.Push(filter)
    }
}

class StringInFilter {
    doFilter(haystack, searchArr) {
        name := searchArr[1]
        res := 1
        matchArr := []
        for index, val in arr {
            StringGetPos, _, % val, % name
            if (ErrorLevel = 0) {
                matchArr.Push(val)
                res := 0
            }
        }
        return matchArr
    }
}

class NumericalBetweenFilter {
    doFilter(haystack, searchArr) {
        matchArr := []
        if (searchArr[2] != "" || searchArr[3] != "") {
            for index, val in arr {
                numRes := 1
                numArr := RegexMatches(val, "\d+(\.\d+)|\d+")
                if (searchArr[2] != "") {
                    for i, num in numArr {
                        if (searchArr[2] <= num) {
                            numRes := 2
                        }
                    }
                }
                if (numRes = 2 && searchArr[3] != "") {
                    numRes := 1
                    for i, num in numArr {
                        if (searchArr[3] >= num) {
                            numRes := 2
                        }
                    }
                }
                if (numRes = 2) {
                    matchArr.Push(val)
                }
            }
        }
        return matchArr
    }
}
class Group {
    __New(mode) {
        this.criteria := []
        this.mode := 1
    }
    Push(criteria) {
        this.criteria.Push(criteria)
    }
    Check(input) {
        res := false
        if (array.Length() = 0) {
            return true
        }
        for index, c in this.criteria {
            res := c.Check(input)
            if (res = 1 && this.mode = 1) {
                return false
            }
            if (res = 0 && this.mode = 2) {
                return true
            }
        }
        if (this.mode = 1) {
            return true
        } else {
            return false
        }
    }
    Print() {
        res := ""
        for index, c in this.criteria {
            res := res . c.search . "`n"
        }
        return res
    }
}

class Link {
    __New(criteria) {
        this.criteria := criteria
        this.next := ""
    }

    Check(input) {
        res := 0
        l := this
        while l != "" {
            res := l.criteria.Check(input)
            l := l.next
            if (res = 1) {
                Break
            }
        }
        return res
    }

    Print() {
        res := ""
        l := this
        while l != "" {
            str := l.criteria.Print()
            res :=  res . "分组`n" . str
            l := l.next
            res := res . "`n"
        }
        return res
    }
}

RegexMatches(Haystack,NeedleRegEx) {
    regex := ComObjCreate("VBScript.RegExp") ;利用VBScript.RegExpress进行正则表达式匹配
    regex.Global := true ;全局匹配
    regex.IgnoreCase := true ;忽略大小写
    regex.Pattern := NeedleRegEx ;设置正则表达式模式
    stringMatches := regex.Execute(Haystack) ;执行正则表达式
    Matches:= Object() ; 每个数组在使用前必须进行初始化
    ;Matches:= Object() 可以简化构造为 Matches:= []
    for match in stringMatches {
        Matches[A_INDEX]:=match.value ;Matches[1]表示匹配的第一项
    }
    regex:=Nothing
    Return Matches ;返回数组
}