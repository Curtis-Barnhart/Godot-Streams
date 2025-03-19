## Filter filters streams by a test function.
extends "../stream.gd"

# source stream
var _src: _CL.StreamType
# filter function
var _filter: Callable


func _init(source, filter: Callable) -> void:
    _src = _CL.Stream(source)
    _filter = filter


func next():
    var tmp = _src.next()
    while not _src._empty and not _filter.call(tmp):
        tmp = _src.next()
    
    if _src._empty:
        self._empty = true
        return null
    
    return tmp
