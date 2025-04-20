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


## Creates a Drop stream from this one,
## which skips the first [code]count[/code] elements of this stream.[br][br]
##
## [param count]: The number of elements to drop from this stream.[br]
## [param return]: A Stream which does not include the first [code]count[/code]
##      elements of this Stream.
func drop(count: int) -> _CL.StreamType:
    return _CL.Drop(self, count)


## Creates an Enumerate stream from this one,
## which adds an index to every element from this stream
## (e.g. [0, <element>], [1, <element>], ...)[br][br].
##
## [param return]: A Stream with an index attached to
##      every element of this stream.
func enumerate() -> _CL.StreamType:
    return _CL.Enumerate(self)


## Creates a Filter stream from this one,
## which removes elements that do not satisfy [code]filter_func[/code].[br][br]
##
## [param filter_func]: A Callable that returns [code]true[/code] for elements to keep
##      and [code]false[/code] for elements to discard.[br]
## [param return]: A Stream containing only elements for which [code]filter_func[/code] returns [code]true[/code].
func filter(filter_func: Callable) -> _CL.StreamType:
    return _CL.Filter(self, filter_func)


## Creates a Map stream from this one,
## which applies [code]map_func[/code] to each element of this stream.[br][br]
##
## [param map_func]: A Callable that transforms each element.[br]
## [param return]: A Stream containing the results of applying [code]map_func[/code] to
##      each element.
func map(map_func: Callable) -> _CL.StreamType:
    return _CL.Map(self, map_func)


## Creates a Take stream from this one,
## which limits the number of elements to [code]count[/code].[br][br]
##
## [param count]: The maximum number of elements to yield.[br]
## [param return]: A Stream containing only
##      the first [code]count[/code] elements from this Stream.
func take(count: int) -> _CL.StreamType:
    return _CL.Take(self, count)


## Creates a Reverse stream from this one.[br][br]
##
## [param return]: A stream iterating over this one's elements in reverse order.
func reverse() -> _CL.StreamType:
    return _CL.Reverse(self)


## Creates a TakeWhile stream from this one, which takes from the elements of
## this stream while predicate called on those elements is true.
## As soon as the predicate tests false,
## the stream ends.[br][br]
##
## [param predicate]: A Callable mapping from elements of this stream to
##      [code]bool[/code], determining which elements to keep.[br]
## [param return]: A stream consisting of this stream's elements
##      up until [code]predicate[/code] tests false on one of them.
func take_while(predicate: Callable) -> _CL.StreamType:
    return _CL.TakeWhile(self, predicate)


## Creates a Uniq stream from this one,
## which removes consecutive duplicate elements.[br][br]
##
## [param return]: A Stream with consecutive duplicate elements removed.
func uniq() -> _CL.StreamType:
    return _CL.Uniq(self)

#######################
# Stream accumulators #
#######################

## Returns [code]true[/code] if any element in the stream evaluates to [code]true[/code].[br][br]
##
## [param return]: [code]true[/code] if at least one element is truthy,
##      [code]false[/code] otherwise.
func any() -> bool:
    return _CL.any.call(self)


## Returns [code]true[/code] if all elements in the stream evaluate to [code]true[/code].[br][br]
##
## [param return]: [code]true[/code] if all elements are truthy, [code]false[/code] otherwise.
func all() -> bool:
    return _CL.all.call(self)


## Converts this stream into an array containing all its elements.[br][br]
##
## [param return]: An array of elements from the stream.
func as_array() -> Array:
    return _CL.as_array.call(self)


## Converts this stream into a dictionary where each unique element
## is a key with a value of [code]null[/code].[br][br]
##
## [param return]: A dictionary representing the unique elements of the stream.
func as_set() -> Dictionary:
    return _CL.as_set.call(self)


## Reduces the stream using [code]function[/code], accumulating the result
## from left to right, starting with [code]initial[/code].[br][br]
##
## [param function]: A Callable that takes the accumulator and the next element
##      and returns the new accumulator value.[br]
## [param initial]: The starting value for the accumulation.[br]
## [param return]: The final accumulated result after applying [code]function[/code] to all elements.
func foldl(function: Callable, initial):
    return _CL.foldl.call(self, function, initial)


## Returns the number of elements in this stream.[br][br]
##
## [param return]: The number of elements in [code]source[/code].
func size() -> int:
    return _CL.size(self)


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
