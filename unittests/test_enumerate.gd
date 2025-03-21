extends GutTest

const CL = preload("../StreamClassLoader.gd")


func test_enumerate_nothing() -> void:
    self.assert_eq_deep(
        CL.Enumerate([]).as_array(),
        []
    )


func test_enumerate_something() -> void:
    self.assert_eq_deep(
        CL.Enumerate(["hello", "there", "world"]).as_array(),
        [[0, "hello"], [1, "there"], [2, "world"]]
    )
