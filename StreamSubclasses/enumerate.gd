## Enumerate adds an index stream to another stream.
extends "../stream.gd"

# array to iterate
var _src: GStreams.StreamType
var _itr: int = 0


func _init(source) -> void:
    _src = GStreams.Stream(source)


func next():
    var val = _src.next()
    if _src._empty:
        self._empty = true
        return [_itr, val]
    
    _itr += 1
    return [_itr - 1, val]
