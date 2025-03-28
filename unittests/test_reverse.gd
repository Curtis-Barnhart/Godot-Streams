extends GutTest

const CL = preload("../StreamClassLoader.gd")


func test_reverse_empty() -> void:
    self.assert_eq_deep(
        CL.Reverse([]).as_array(),
        []
    )


func test_reverse() -> void:
    self.assert_eq_deep(
        CL.Reverse([1, 2, 3, 4, 5]).as_array(),
        [5, 4, 3, 2, 1]
    )
