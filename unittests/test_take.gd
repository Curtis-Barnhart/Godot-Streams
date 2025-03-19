extends GutTest

const CL = preload("../StreamClassLoader.gd")


func test_take_normal() -> void:
    self.assert_eq_deep(
        CL.Take([1, 2, 3, 4, 5], 3).as_array(),
        [1, 2, 3]
    )


func test_take_more_than_available() -> void:
    self.assert_eq_deep(
        CL.Take([1, 2, 3], 5).as_array(),
        [1, 2, 3]
    )


func test_take_zero() -> void:
    self.assert_eq_deep(
        CL.Take([1, 2, 3, 4], 0).as_array(),
        []
    )


func test_take_negative() -> void:
    self.assert_eq_deep(
        CL.Take([1, 2, 3, 4], -2).as_array(),
        []
    )


func test_take_from_empty() -> void:
    self.assert_eq_deep(
        CL.Take([], 3).as_array(),
        []
    )
