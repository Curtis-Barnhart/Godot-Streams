extends GutTest

const CL = preload("../StreamClassLoader.gd")


func test_concat_two_streams() -> void:
    self.assert_eq_deep(
        CL.Concat([
            [1, 2, 3],
            [4, 5, 6]
        ]).as_array(),
        [1, 2, 3, 4, 5, 6]
    )


func test_concat_multiple_streams() -> void:
    self.assert_eq_deep(
        CL.Concat([
            ["a", "b"],
            ["c"],
            ["d", "e", "f"]
        ]).as_array(),
        ["a", "b", "c", "d", "e", "f"]
    )


func test_concat_with_empty_streams() -> void:
    self.assert_eq_deep(
        CL.Concat([
            [],
            [1, 2, 3],
            [],
            [4, 5]
        ]).as_array(),
        [1, 2, 3, 4, 5]
    )


func test_concat_all_empty() -> void:
    self.assert_eq_deep(
        CL.Concat([[], [], []]).as_array(),
        []
    )


func test_concat_single_stream() -> void:
    self.assert_eq_deep(
        CL.Concat([[7, 8, 9]]).as_array(),
        [7, 8, 9]
    )
