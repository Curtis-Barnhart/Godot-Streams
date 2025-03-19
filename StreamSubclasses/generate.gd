## Generates a stream by calling a function for elements.
extends "../stream.gd"

# element generation function
var _gen: Callable


func _init(generator: Callable) -> void:
    _gen = generator


func next():
    return _gen.call()
