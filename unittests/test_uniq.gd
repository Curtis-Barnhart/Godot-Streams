extends GutTest

const CL = preload("../StreamClassLoader.gd")


func test_no_duplicates() -> void:
    self.assert_eq_deep(
        CL.Uniq([1, 2, 3, 4, 5]).as_array(),
        [1, 2, 3, 4, 5]
    )


func test_consecutive_duplicates() -> void:
    self.assert_eq_deep(
        CL.Uniq([1, 1, 2, 2, 3, 3, 4, 4]).as_array(),
        [1, 2, 3, 4]
    )


func test_non_consecutive_duplicates() -> void:
    self.assert_eq_deep(
        CL.Uniq([1, 2, 1, 3, 2, 4, 3, 5]).as_array(),
        [1, 2, 1, 3, 2, 4, 3, 5]
    )


func test_empty() -> void:
    self.assert_eq_deep(
        CL.Uniq([]).as_array(),
        []
    )


func test_single_element() -> void:
    self.assert_eq_deep(
        CL.Uniq([42]).as_array(),
        [42]
    )
