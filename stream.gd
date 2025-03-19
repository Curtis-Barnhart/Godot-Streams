## A stream which is generated on the fly instead of existing
## all at once in memory.
extends RefCounted

const _CL = preload("./StreamClassLoader.gd")

var _empty: bool = false


func _init() -> void:
    assert(false, "Cannot instantiate pure virtual class Stream.")


## Retrieve the next element of the stream
## Must be overriden by subclasses.
##
## @return: the next element of the stream
func next():
    pass

#######################
# Stream transformers #
#######################

func drop(count: int) -> _CL.StreamType:
    return _CL.Drop(self, count)


func filter(filter_func: Callable) -> _CL.StreamType:
    return _CL.Filter(self, filter_func)


func map(map_func: Callable) -> _CL.StreamType:
    return _CL.Map(self, map_func)


func take(count: int) -> _CL.StreamType:
    return _CL.Take(self, count)


func uniq() -> _CL.StreamType:
    return _CL.Uniq(self)

#######################
# Stream accumulators #
#######################

func any() -> bool:
    return _CL.any.call(self)


func all() -> bool:
    return _CL.all.call(self)


func as_array() -> Array:
    return _CL.as_array.call(self)


func as_set() -> Dictionary:
    return _CL.as_set.call(self)


func foldl(function: Callable, initial):
    return _CL.foldl.call(self, function, initial)


####################
# custom iterators #
####################

## For the "for x in ..." construct, cur holds the current element
## of the stream
var _cur
func _iter_init(_arg) -> bool:
    self._cur = self.next()
    return not self._empty


func _iter_next(_arg) -> bool:
    self._cur = self.next()
    return not self._empty


func _iter_get(_arg):
    return self._cur
