class Config {
	__New(file) {
        this.file := file
    }

    Get(type, name) {
        file := this.file
        IniRead, value, %file%, %type%, %name%
        return value
    }

    GetType(type) {
        file := this.file
        IniRead, value, %file%, %type%
        return value
    }

}
