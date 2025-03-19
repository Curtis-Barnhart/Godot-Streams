## ArrayView provides a simple wrapper over an array.
extends "../stream.gd"

# array to iterate
var _arr: Array
# index into the array we are iterating
var _it: int


func _init(array: Array) -> void:
    _arr = array
    _it = 0


func next():
    if _it >= _arr.size():
        self._empty = true
        return null
    
    var val = _arr[_it]
    _it += 1
    return val
