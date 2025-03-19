extends GutTest

const CL = preload("../StreamClassLoader.gd")


func test_map() -> void:
    self.assert_eq_deep(
        CL.Map([1, 2, 3, 4], func(x): return x * x).as_array(),
        [1, 4, 9, 16]
    )


func test_identity_function() -> void:
    self.assert_eq_deep(
        CL.Map([10, 20, 30], func(x): return x).as_array(),
        [10, 20, 30]
    )


func test_empty_stream() -> void:
    self.assert_eq_deep(
        CL.Map([], func(x): return x * 2).as_array(),
        []
    )
