## Zip together multiple streams.
## If a single stream runs out, the zip will end.
extends"../stream.gd"

# source streams
var _srcs: Array[_CL.StreamType]


func _init(sources: Array) -> void:
    _srcs.assign(sources.map(
        func (variant): return _CL.Stream(variant)
    ))


func next():
    var package: Array = _srcs.map(
        func (stream: _CL.StreamType): return stream.next()
    )
    
    if _CL.any(_CL.Map(
        _srcs, func (stream: _CL.StreamType): return stream._empty
    )):
        self._empty = true
    
    return package
