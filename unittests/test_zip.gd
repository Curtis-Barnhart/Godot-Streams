extends GutTest

const CL = preload("../StreamClassLoader.gd")


func test_basic() -> void:
    self.assert_eq_deep(
        CL.Zip([
            [1, 2, 3],
            [2, 3, 4]
        ]).as_array(),
        [[1, 2], [2, 3], [3, 4]]
    )


func test_one() -> void:
    self.assert_eq_deep(
        CL.Zip([[1, 2, 3]]).as_array(),
        [[1], [2], [3]]
    )


func test_many() -> void:
    self.assert_eq_deep(
        CL.Zip([
            [1, 2, 3],
            [2, 3, 4],
            [3, 4, 5],
            [4, 5, 6],
            [5, 6, 7]
        ]).as_array(),
        [[1, 2, 3, 4, 5], [2, 3, 4, 5, 6], [3, 4, 5, 6, 7]]
    )


func test_empty() -> void:
    self.assert_eq_deep(
        CL.Zip([[], []]).as_array(),
        []
    )


func test_different_sizes() -> void:
    self.assert_eq_deep(
        CL.Zip([[1, 2, 3, 4], [1, 2]]).as_array(),
        [[1, 1], [2, 2]]
    )
