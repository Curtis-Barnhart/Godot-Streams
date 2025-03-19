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


static func _array_or_stream(arr_str) -> _CL.StreamType:
    if is_instance_of(arr_str, _CL.Stream):
        return arr_str
    if typeof(arr_str) == TYPE_ARRAY:
        return _CL.ArrayView(arr_str)
    else:
        assert(false, "tried to make stream out of non array/stream object.")
    return null


static func _arrays_or_streams(arrs_strs: Array) -> Array[_CL.StreamType]:
    return arrs_strs.map(
        func (a_s):
            return _CL._ArrayView._array_or_stream(a_s)
    ) as Array[_CL.StreamType]
