## Map transforms a stream by a function.
extends "../stream.gd"

# source stream
var _src: _CL.StreamType
# mapping function
var _map: Callable


func _init(source, map: Callable) -> void:
    _src = _CL.Stream(source)
    _map = map


func next():
    var domain = _src.next()
    if _src._empty:
        self._empty = true
        return null
    return _map.call(domain)
