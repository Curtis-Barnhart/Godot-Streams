extends GutTest

const CL = preload("../StreamClassLoader.gd")


func test_repeat() -> void:
    self.assert_eq_deep(
        CL.Repeat(42).take(5).as_array(),
        [42, 42, 42, 42, 42]
    )
