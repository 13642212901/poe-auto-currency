class UserInputController {
    Run() {
        input := new CriteriaInput()
        g := new Group(1)
        l := new Link(g)
        input.Run(l)
        return l
    }
}

class CriteriaInput {
    Run(resLink) {
        i := new UserInput()
        res := i.Ask(ReCode("匹配的词缀"), "")
        if (res = "") {
            return
        }
        resLink.criteria.Push(new Criteria(res))
        box := new ContinueBranch()
        box.Run(resLink)
    }
}

class UserInput {
    Ask(title, prompt) {
        InputBox, input, %title%, %prompt% ,
        return input
    }
}


class ContinueBranch extends Branch {
    Tips() {
        return "是否继续添加"
    }
    Yes(resLink) {
        input := new CriteriaInput()
        input.Run(resLink)
    }
    No(resLink) {
        box := new AddGroupBranch()
        box.Run(resLink)
    }
}

class UseScoureBranch extends Branch {
    Tips() {
        return "是否重铸"
    }
    Yes(resLink) {
    }
    No(resLink) {
    }
}

class AddGroupBranch extends Branch {
    Tips() {
        return "是否添加分组"
    }
    Yes(resLink) {
        g := new Group(1)
        l := new Link(g)
        resLink.next := l
        input := new CriteriaInput()
        input.Run(resLink.next)
    }
    No(resLink) {
        
    }
}


class CheckCriteria extends Branch {
    Tips() {
        return this.message
    }
    Yes(resLink) {
    }
    No(resLink) {
    }
    set(message) {
        this.message := message
    }
}

class Branch {
    Run(resLink) {
        desc := ReCode(this.Tips())
        MsgBox , 4, , %desc%
        IfMsgBox Yes 
            res := 1
        IfMsgBox NO
            res := 0
        if (res = 1) {
            this.Yes(resLink)
        } else {
            this.No(resLink)
        }
        return res
    }
}

ReCode(str){
    Pagecode := "UTF-8"
    FileAppend, %str%, this.deleteme
    file := FileOpen("this.deleteme", "r")
    FileDelete, *.deleteme
    file.Encoding := Pagecode
    strA := file.Read()
    file.Close()
    return strA
}