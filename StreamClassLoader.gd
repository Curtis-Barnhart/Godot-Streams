class_name GStreams
extends Object

const StreamType = preload("./stream.gd")
## Coercing constructor for a Stream.[br][br]
##
## If [code]source[/code] is [code]null[/code], returns an empty Stream.[br]
## If [code]source[/code] is a [bool] or an [int], returns an infinite stream
## of the value of [code]source[/code].[br]
## If [code]source[/code] is a [String], return a Stream over its characters.[br]
## If [code]source[/code] is an [Object], returns [code]source.as_stream()[/code].[br]
## If [code]source[/code] is an [Callable], returns a stream of successive calls to [code]source[/code].[br]
## If [code]source[/code] is an [Array], returns a Stream over its elements.[br][br]
##
## [param source]: The source of data to use for the stream.[br]
## [param return]: A Stream of that data.
static func Stream(source) -> StreamType:
    if is_instance_of(source, StreamType):
        return source
    
    match typeof(source):
        TYPE_NIL:
            return ArrayView([])
        TYPE_BOOL:
            return Repeat(source)
        TYPE_INT:
            return Repeat(source)
        TYPE_STRING:
            return ArrayView((source as String).split())
        TYPE_OBJECT:
            if (source as Object).has_method("as_stream"):
                return source.as_stream()
            else:
                push_error("Cannot make Object into Stream: Object does not define 'make_stream' method.")
                return null
        TYPE_CALLABLE:
            return Generate(source)
        TYPE_ARRAY:
            return ArrayView(source)
        var type_number:
            if type_number >= TYPE_MAX:
                assert(false, "bad type. update code.")
            push_error(
                "Cannot make %s into Stream." % [
                    "null",
                    "bool",
                    "int",
                    "float",
                    "String",
                    "Vector2",
                    "Vector2i",
                    "Rect2",
                    "Rect2i",
                    "Vector3",
                    "Vector3i",
                    "Transform2D",
                    "Vector4",
                    "Vector4i",
                    "Plane",
                    "Quaternion",
                    "AABB",
                    "Basis",
                    "Transform3D",
                    "Projection",
                    "Color",
                    "StringName",
                    "NodePath",
                    "RID",
                    "Object",
                    "Callable",
                    "Signal",
                    "Dictionary",
                    "Array",
                    "PackedByteArray",
                    "PackedInt32Array",
                    "PackedInt64Array",
                    "PackedFloat32Array",
                    "PackedFloat64Array",
                    "PackedStringArray",
                    "PackedVector2Array",
                    "PackedVector3Array",
                    "PackedColorArray",
                    "PackedVector4Array",
                ][type_number]
            )
            return null

const _ArrayView = preload("./StreamSubclasses/array_view.gd")
## Static constructor for ArrayView, which is a stream wrapper
## on top of an array.
##
## [param source]: the array to make an ArrayView for.
## @return: Stream which iterates over the elements of [code]source[/code].
static func ArrayView(source: Array) -> StreamType:
    return _ArrayView.new(source)


const _Concat = preload("./StreamSubclasses/concat.gd")
## Static constructor for Concat, which concatenates multiple streams
## into a single stream.
##
## [param sources]: an array of stream-likes to concatenate.
##      For a complete list of what data is coercible to a Stream,
##      see [code]static func Stream(source) -> StreamType[/code] in
##      [code]Godot-Streams/StreamClassLoader.gd[/code].[br]
## @return: Stream which iterates over all elements from [code]sources[/code] in order.
static func Concat(sources: Array) -> StreamType:
    return _Concat.new(sources)


const _Drop = preload("./StreamSubclasses/drop.gd")
## Static constructor for Drop, which skips the first [code]count[/code] elements
## of a stream.
## If [code]count[/code] is negative, skips the first 0 elements.[br][br]
##
## [param source]: Any Stream or source of data that is coercible to a Stream.
##      For a complete list of what data is coercible,
##      see [code]static func Stream(source) -> StreamType[/code] in
##      [code]Godot-Streams/StreamClassLoader.gd[/code].[br]
## [param count]: the number of elements to drop from the beginning.[br]
## [param return]: Stream that begins after [code]count[/code] elements have been skipped.
static func Drop(source, count: int) -> StreamType:
    return _Drop.new(source, count)


const _Filter = preload("./StreamSubclasses/filter.gd")
## Static constructor for Filter, which removes elements from a stream
## that do not satisfy a given predicate.[br][br]
##
## [param source]: Any Stream or source of data that is coercible to a Stream.
##      For a complete list of what data is coercible,
##      see [code]static func Stream(source) -> StreamType[/code] in
##      [code]Godot-Streams/StreamClassLoader.gd[/code].[br]
## [param filter]: a Callable that returns [code]true[/code] for elements to keep
##                and [code]false[/code] for elements to discard.[br]
## [param return]: Stream containing only elements for which [code]filter[/code] returns [code]true[/code].
static func Filter(source, filter: Callable) -> StreamType:
    return _Filter.new(source, filter)


const _Generate = preload("./StreamSubclasses/generate.gd")
## Static constructor for Generate, which produces an infinite stream
## by repeatedly calling a generator function.[br][br]
##
## [param generator]: a Callable that returns the next element in the stream
##                   each time it is invoked.[br]
## [param return]: Infinite stream that yields values generated by [code]generator[/code].
static func Generate(generator: Callable) -> StreamType:
    return _Generate.new(generator)


const _IRange = preload("./StreamSubclasses/i_range.gd")
## Static constructor for IRange, which generates an integer range
## with a specified step.
## If [code]step[/code] is 0 and [code]start[/code] != [code]stop[/code], generates an infinite
## number of values of [code]start[/code].[br][br]
##
## [param start]: the first number in the range.[br]
## [param stop]: the stopping point (exclusive).[br]
## [param step]: the amount by which to increment (or decrement).[br]
## [param return]: Stream that iterates over numbers from [code]start[/code] to [code]stop[/code] by [code]step[/code].
static func IRange(start: int, stop: int, step: int) -> StreamType:
    return _IRange.new(start, stop, step)


const _Map = preload("./StreamSubclasses/map.gd")
## Static constructor for Map, which applies a function to each element
## of a stream.[br][br]
##
## [param source]: Any Stream or source of data that is coercible to a Stream.
##      For a complete list of what data is coercible,
##      see [code]static func Stream(source) -> StreamType[/code] in
##      [code]Godot-Streams/StreamClassLoader.gd[/code].[br]
## [param map]: a Callable that transforms each element.[br]
## [param return]: Stream containing the results of applying [code]map[/code] to each element.
static func Map(source, map: Callable) -> StreamType:
    return _Map.new(source, map)


const _Repeat = preload("./StreamSubclasses/repeat.gd")
## Static constructor for Repeat, which creates an infinite stream
## that continuously yields the same value.[br][br]
##
## [param value]: the value to repeat.[br]
## [param return]: Infinite stream that produces [code]value[/code] indefinitely.
static func Repeat(value) -> StreamType:
    return _Repeat.new(value)


const _Take = preload("./StreamSubclasses/take.gd")
## Static constructor for Take, which limits a stream to the first [code]count[/code] elements.[br][br]
##
## [param source]: Any Stream or source of data that is coercible to a Stream.
##      For a complete list of what data is coercible,
##      see [code]static func Stream(source) -> StreamType[/code] in
##      [code]Godot-Streams/StreamClassLoader.gd[/code].[br]
## [param count]: the maximum number of elements to yield.[br]
## [param return]: Stream containing at most [code]count[/code] elements from [code]source[/code].
static func Take(source, count: int) -> StreamType:
    return _Take.new(source, count)


const _Uniq = preload("./StreamSubclasses/uniq.gd")
## Static constructor for Uniq, which removes consecutive duplicate elements
## from a stream.[br][br]
##
## [param source]: Any Stream or source of data that is coercible to a Stream.
##      For a complete list of what data is coercible,
##      see [code]static func Stream(source) -> StreamType[/code] in
##      [code]Godot-Streams/StreamClassLoader.gd[/code].[br]
## [param return]: Stream with consecutive duplicates removed.
static func Uniq(source) -> StreamType:
    return _Uniq.new(source)


const _Zip = preload("./StreamSubclasses/zip.gd")
## Static constructor for Zip, which merges multiple streams into one
## by pairing corresponding elements.
## If any single stream runs out, the whole stream will end.[br][br]
##
## [param sources]: an array of stream-likes to zip together.[br]
##      For a complete list of what data is coercible to a Stream,
##      see [code]static func Stream(source) -> StreamType[/code] in
##      [code]Godot-Streams/StreamClassLoader.gd[/code].[br]
## [param return]: Stream of arrays, where each array contains elements
##          from the same position in [code]sources[/code].
static func Zip(sources: Array) -> StreamType:
    return _Zip.new(sources)


## Returns [code]true[/code] if any element in the stream-like [code]source[/code]
## evaluates to [code]true[/code].[br][br]
##
## [param source]: Any Stream or source of data that is coercible to a Stream.
##      For a complete list of what data is coercible,
##      see [code]static func Stream(source) -> StreamType[/code] in
##      [code]Godot-Streams/StreamClassLoader.gd[/code].[br]
## [param return]: [code]true[/code] if at least one element is truthy, [code]false[/code] otherwise.
static func any(source) -> bool:
    var stream: StreamType = Stream(source)
    for x in stream:
        if x:
            return true
    return false


## Returns [code]true[/code] if all elements in the stream-like [code]source[/code]
## evaluate to [code]true[/code].[br][br]
##
## [param source]: Any Stream or source of data that is coercible to a Stream.
##      For a complete list of what data is coercible,
##      see [code]static func Stream(source) -> StreamType[/code] in
##      [code]Godot-Streams/StreamClassLoader.gd[/code].[br]
## [param return]: [code]true[/code] if all elements are truthy, [code]false[/code] otherwise.
static func all(source) -> bool:
    var stream: StreamType = Stream(source)
    for x in stream:
        if not x:
            return false
    return true


## Converts [code]source[/code] into an array containing all its elements.[br][br]
##
## [param source]: Any Stream or source of data that is coercible to a Stream.
##      For a complete list of what data is coercible,
##      see [code]static func Stream(source) -> StreamType[/code] in
##      [code]Godot-Streams/StreamClassLoader.gd[/code].[br]
## [param return]: An array of elements from [code]source[/code].
static func as_array(source) -> Array:
    var stream: StreamType = Stream(source)
    var ar: Array = []
    for x in stream:
        ar.push_back(x)
    return ar


## Converts [code]source[/code] into a dictionary where each unique element
## is a key with a value of [code]null[/code].[br][br]
##
## [param source]: Any Stream or source of data that is coercible to a Stream.
##      For a complete list of what data is coercible,
##      see [code]static func Stream(source) -> StreamType[/code] in
##      [code]Godot-Streams/StreamClassLoader.gd[/code].[br]
## [param return]: A dictionary representing the unique elements of [code]source[/code].
static func as_set(source) -> Dictionary:
    var stream: StreamType = Stream(source)
    var d: Dictionary = {}
    for x in stream:
        d.set(d, null)
    return d


## Reduces the stream-like [code]source[/code] using [code]function[/code], accumulating the result
## from left to right, starting with [code]initial[/code].[br][br]
##
## [param source]: Any Stream or source of data that is coercible to a Stream.
##      For a complete list of what data is coercible,
##      see [code]static func Stream(source) -> StreamType[/code] in
##      [code]Godot-Streams/StreamClassLoader.gd[/code].[br]
## [param function]: A Callable that takes the accumulator and the next element
##      and returns the new accumulator value.[br]
## [param initial]: The starting value for the accumulation.[br]
## [param return]: The final accumulated result after applying [code]function[/code] to all elements.
static func foldl(source, function: Callable, initial):
    var stream: StreamType = Stream(source)
    for x in stream:
        initial = function.call(initial, x)
    return initial
