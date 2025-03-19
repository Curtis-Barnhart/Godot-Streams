## Concat concatenates multiple streams.
extends "../stream.gd"

# source stream
var _srcs: Array[_CL.StreamType]
var _index: int = 0


func _init(sources: Array) -> void:
    _srcs.assign(sources.map(
        func (variant): return _CL.Stream(variant)
    ))


func next():
    while true:
        while _index < _srcs.size() and _srcs[_index]._empty:
            _index += 1
        
        if _index >= _srcs.size() or _srcs[_index]._empty:
            self._empty = true
            return null
        
        var candidate = _srcs[_index].next()
        if _srcs[_index]._empty:
            continue
        else:
            return candidate
