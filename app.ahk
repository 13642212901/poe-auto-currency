#Include, Listen.ahk
#Include, Unit.ahk

class App 
{
    __New() {
        this.listens := []
        this.keys := []
    }
    Run()
    {
        For Key, listen in this.listens {
            name := listen.name
            InputBox, interval, "延迟", , 
            listen.interval := interval
        }
        Loop {
            For Key, listen in this.listens {
                diff := Abs((A_Sec * 1000 + A_MSec) - listen.prew)
                max := listen.interval / 100
                if (max < 5) {
                    max := 5
                }
                Random, rand , %0% , %max%
                diff += Ceil(rand)
                if (listen.start = 1 && diff > listen.interval) {
                    bmp := listen.imagePath
                    if (listen.imagePath = "") {
                        listen.Run()
                        listen.setPrew()
                    } else {
                        lx := listen.LX
                        ly := listen.LY
                        rx := listen.RX
                        ry := listen.RY
                        ImageSearch, FoundX, FoundY, %lx%, %ly%, %rx%, %ry%, %bmp%
                        if (ErrorLevel = 0) {
                            listen.Run()
                            listen.setPrew()
                        }
                    }
                }
            } 
        }
    }

    Append(l)
    {
        this.listens.Push(l)
    }

}