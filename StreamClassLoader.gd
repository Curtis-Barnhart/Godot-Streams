class_name GStreams
extends Object

const StreamType = preload("./stream.gd")
static func Stream(source) -> StreamType:
    if is_instance_of(source, StreamType):
        return source
    
    match typeof(source):
        TYPE_NIL:
            return ArrayView([])
        TYPE_STRING:
            return ArrayView((source as String).split())
        TYPE_ARRAY:
            return ArrayView(source)
        TYPE_INT:
            return Repeat(source)
        TYPE_BOOL:
            return Repeat(source)
        TYPE_CALLABLE:
            return Generate(source)
        TYPE_OBJECT:
            if (source as Object).has_method("make_stream"):
                return source.make_stream()
            else:
                push_error("Cannot make Object into Stream: Object does not define 'make_stream' method.")
                return null
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
static func ArrayView(source: Array) -> StreamType:
    return _ArrayView.new(source)

const _Concat = preload("./StreamSubclasses/concat.gd")
static func Concat(sources: Array) -> StreamType:
    return _Concat.new(sources)

const _Drop = preload("./StreamSubclasses/drop.gd")
static func Drop(source, count: int) -> StreamType:
    return _Drop.new(source, count)

const _Filter = preload("./StreamSubclasses/filter.gd")
static func Filter(source, filter: Callable) -> StreamType:
    return _Filter.new(source, filter)

const _Generate = preload("./StreamSubclasses/generate.gd")
static func Generate(generator: Callable) -> StreamType:
    return _Generate.new(generator)

const _IRange = preload("./StreamSubclasses/i_range.gd")
static func IRange(start: int, stop: int, step: int) -> StreamType:
    return _IRange.new(start, stop, step)

const _Map = preload("./StreamSubclasses/map.gd")
static func Map(source, map: Callable) -> StreamType:
    return _Map.new(source, map)

const _Repeat = preload("./StreamSubclasses/repeat.gd")
static func Repeat(value) -> StreamType:
    return _Repeat.new(value)

const _Take = preload("./StreamSubclasses/take.gd")
static func Take(source, count: int) -> StreamType:
    return _Take.new(source, count)

const _Uniq = preload("./StreamSubclasses/uniq.gd")
static func Uniq(source) -> StreamType:
    return _Uniq.new(source)

const _Zip = preload("./StreamSubclasses/zip.gd")
static func Zip(sources) -> StreamType:
    return _Zip.new(sources)


static func any(source) -> bool:
    var stream: StreamType = Stream(source)
    for x in stream:
        if x:
            return true
    return false


static func all(source) -> bool:
    var stream: StreamType = Stream(source)
    for x in stream:
        if not x:
            return false
    return true


static func as_array(source) -> Array:
    var stream: StreamType = Stream(source)
    var ar: Array = []
    for x in stream:
        ar.push_back(x)
    return ar


static func as_set(source) -> Dictionary:
    var stream: StreamType = Stream(source)
    var d: Dictionary = {}
    for x in stream:
        d.set(d, null)
    return d


static func foldl(source, function: Callable, initial):
    var stream: StreamType = Stream(source)
    for x in stream:
        initial = function.call(initial, x)
    return initial
