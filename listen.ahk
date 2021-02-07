class Listen
{
    LX := 0
    LY := 0
    RX := A_ScreenWidth
    RY := A_ScreenHeight
    imagePath := ""
    interval := 5000
    start := 0
    __New() {
        this.setPrew()
        this.prew := this.prew - this.interval
    }

    setPrew()
    {
        this.prew := A_Sec * 1000 + A_MSec
    }
    Hit()
    {
        if (this.start = 0) {
            this.start := 1
        } else {
            this.start := 0
        }
    }
}