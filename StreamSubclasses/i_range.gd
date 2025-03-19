## A range function which returns integers from a start to a stop
## with a specified step.
extends "../stream.gd"

var _start: int
var _stop: int
var _step: int


func _init(start: int, stop: int, step: int) -> void:
    _start = start
    _stop = stop
    _step = step


func next() -> int:
    var temp: int = _start
    if _step == 0:
        if _start == _stop:
            self._empty = true
        return temp
    
    if _step > 0:
        if _start < _stop:
            _start += _step
        else:
            self._empty = true
        return temp
    
    if _start > _stop:
        _start += _step
    else:
        self._empty = true
    return temp
