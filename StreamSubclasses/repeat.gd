## Repeat an element to create a stream.
extends "../stream.gd"

# value to repeat
var _v


func _init(value) -> void:
    _v = value


func next():
    return _v
