extends GutTest

const CL = preload("../StreamClassLoader.gd")


func test_positive_step() -> void:
    self.assert_eq_deep(
        CL.IRange(1, 5, 1).as_array(),
        [1, 2, 3, 4]
    )


func test_negative_step() -> void:
    self.assert_eq_deep(
        CL.IRange(5, 1, -1).as_array(),
        [5, 4, 3, 2]
    )


func test_zero_step() -> void:
    self.assert_eq_deep(
        CL.IRange(1, 5, 0).take(5).as_array(),
        [1, 1, 1, 1, 1]
    )
    
    self.assert_eq_deep(
        CL.IRange(1, 1, 0).take(5).as_array(),
        []
    )


func test_single_element_range() -> void:
    self.assert_eq_deep(
        CL.IRange(3, 4, 1).as_array(),
        [3]
    )


func test_empty_range() -> void:
    self.assert_eq_deep(
        CL.IRange(5, 5, 1).as_array(),
        []
    )
