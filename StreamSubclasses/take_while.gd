## TakeWhile keeps elements from a stream while a predicate is true.
extends "../stream.gd"

# array to iterate
var _src: GStreams.StreamType
var _pred: Callable


func _init(source, predicate: Callable) -> void:
    _src = GStreams.Stream(source)
    _pred = predicate


func next():
    if self._empty:
        return null

    var val = _src.next()
    if _src._empty or not _pred.call(val):
        self._empty = true
    
    return val
