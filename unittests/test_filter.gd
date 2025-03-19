extends GutTest

const CL = preload("../StreamClassLoader.gd")


func test_filter_even_numbers() -> void:
    self.assert_eq_deep(
        CL.Filter([1, 2, 3, 4, 5, 6], func(x): return x % 2 == 0).as_array(),
        [2, 4, 6]
    )


func test_filter_greater_than_three() -> void:
    self.assert_eq_deep(
        CL.Filter([1, 2, 3, 4, 5], func(x): return x > 3).as_array(),
        [4, 5]
    )


func test_filter_empty_stream() -> void:
    self.assert_eq_deep(
        CL.Filter([], func(x): return x > 0).as_array(),
        []
    )


func test_filter_all_elements() -> void:
    self.assert_eq_deep(
        CL.Filter([1, 2, 3], func(x): return true).as_array(),
        [1, 2, 3]
    )


func test_filter_no_elements() -> void:
    self.assert_eq_deep(
        CL.Filter([1, 2, 3], func(x): return false).as_array(),
        []
    )
