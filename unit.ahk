ArraySearch(val, array)
{
    res := false
    For key, value in array {
        if (val == value) {
            res = true
            return res
        }
    }
    return res
}