extends "../stream.gd"

var _src: _CL.StreamType
var _n: int


func _init(source, count) -> void:
    _src = _CL.Stream(source)
    _n = max(count, 0)


func next():
    var temp = _src.next()
    while _n > 0 and not _src._empty:
        temp = _src.next()
        _n -= 1
    
    if _src._empty:
        self._empty = true
    return temp
