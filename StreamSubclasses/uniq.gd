## A stream which only returns the item of a backing stream
extends "../stream.gd"

# source stream
var _src: _CL.StreamType
# last element to come from _src
var _last
# whether we have started streaming from _src
var _last_valid: bool = false


func _init(source) -> void:
    _src = _CL.Stream(source)


func next():
    if not _last_valid:
        _last = _src.next()
        _last_valid = true
        if _src._empty:
            self._empty = true
            return null
        return _last
    
    var next = _src.next()
    while not _src._empty and next == _last:
        next = _src.next()
    
    if _src._empty:
        self._empty = true
        return null
    
    _last = next
    return _last
