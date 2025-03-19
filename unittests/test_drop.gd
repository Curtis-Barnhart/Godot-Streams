extends GutTest

const CL = preload("../StreamClassLoader.gd")


func test_drop_normal() -> void:
    self.assert_eq_deep(
        CL.Drop([1, 2, 3, 4, 5], 3).as_array(),
        [4, 5]
    )


func test_drop_more_than_available() -> void:
    self.assert_eq_deep(
        CL.Drop([1, 2, 3], 5).as_array(),
        []
    )


func test_drop_zero() -> void:
    self.assert_eq_deep(
        CL.Drop([1, 2, 3, 4], 0).as_array(),
        [1, 2, 3, 4]
    )


func test_drop_negative() -> void:
    self.assert_eq_deep(
        CL.Drop([1, 2, 3, 4], -2).as_array(),
        [1, 2, 3, 4]
    )

func test_drop_from_empty() -> void:
    self.assert_eq_deep(
        CL.Drop([], 3).as_array(),
        []
    )
