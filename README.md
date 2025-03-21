# Godot-Streams

## Overview

This library provides a set of functional-style streaming utilities for Godot 4,
enabling efficient and expressive data processing.
Inspired by functional programming paradigms, it introduces streams to Godot,
allowing operations like mapping, folding,
and zipping over collections.

## Features

- **Streams for Godot**: Enables processing sequences of data
without materializing entire collections in memory.
- **Functional Programming Utilities**: Provides common operations like
`map`, `foldl`, `zip`, and more.
- **Composable and Lazy Evaluation**: Operations can be chained together
and evaluated only when needed.

## A Few Provided Functions

Some of the common utilities this library provides include
(this list is not exhaustive):

- **`Zip`**: Combines multiple sequences element-wise into tuples.
- **`Map`**: Transforms each element of a stream using a provided function.
- **`Filter`**: Removes elements that do not satisfy a given predicate.
- **`Foldl`**: Reduces a stream to a single value using a left-associative function.
- **`Enumerate`**: Attaches an index to each element of a stream.
- **`Concat`**: Flattens a stream of streams into a single stream.
- **`ArrayView`**: Provides a lightweight wrapper over arrays, treating them as streams.

## Installation

Add this repository as a git submodule in the `addons` folder of your
Godot project with
`git submodule add https://github.com/Curtis-Barnhart/Godot-Streams.git`.

Technically you could add it in any other location in your project,
but this way Godot ignores warnings,
which I find particularly helpful because there is about 0 static typing
in this library,
and I like to enforce static typing in my projects through errors.

## Usage

Godot-Streams provides a single class name (`GStreams`)
(I am a little bit salty that Godot does not support namespaces)
through which all of its functionality is available.
If for some reason this conflicts with an existing class name
or for some other reason you really wish this single class was named
something else, you can actually just change it
(in `Godot-Streams/StreamClassLoader.gd`),
as it is not referenced anywhere within the library.

All the different streams can be accessed through static methods in `GStreams`.
For instance, to create a zipped stream:

```gdscript
var stream: GStreams.StreamType = GStreams.Zip([[1, 2, 3], [4, 5, 6]])
print(stream.as_array())  # Output: [[1, 4], [2, 5], [3, 6]]
```

Many streams that are built from only a single input stream
can also be created by methods on streams.
For instance,

```gdscript
# Equivalent
var stream_static: GStreams.StreamType = GStreams.Drop([1, 2, 3, 4, 5], 3)
var stream_instance: GStreams.StreamType = GStreams([1, 2, 3, 4, 5]).drop(3)
```

All the methods for accumulating streams are similarly exposed
both in the GStreams class and directly as methods on streams.

```
var stream: GStreams.StreamType = GStreams.Stream([1, 2, 3])
# Equivalent
GStreams.as_array(stream)
stream.as_array()
```

Other types can be coerced to streams as well, including
null, bool, int, String, Callable, and Array.
Custom objects can also define a method `as_stream() -> GStreams.StreamType`,
which will be used to define what is returned when such an object
is coerced to a stream.
Objects are coerced to streams by calling `GStreams.Stream(obj)`.

## Testing

The library includes unit tests using [GUT](https://github.com/bitwes/Gut).
To run the tests:

1. Install the `GUT` testing framework.
2. Add `Godot-Streams/unittests` as a testing directory to GUT.
3. Run tests.

## License

This project is released under the GPLv3 License.

