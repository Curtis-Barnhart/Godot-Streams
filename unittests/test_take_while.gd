extends GutTest

const CL = preload("../StreamClassLoader.gd")


func test_take_while_nothing() -> void:
    self.assert_eq_deep(
        CL.TakeWhile([], func (_x: int) -> bool: return true).as_array(),
        []
    )


func test_take_while_all_false() -> void:
    self.assert_eq_deep(
        CL.TakeWhile([1, 3, 5, 7], func (n: int) -> bool: return (n % 2) == 0).as_array(),
        []
    )


func test_take_while_all_true() -> void:
    self.assert_eq_deep(
        CL.TakeWhile([0, 2, 4, 6], func (n: int) -> bool: return (n % 2) == 0).as_array(),
        [0, 2, 4, 6]
    )


func test_take_while_ends_false() -> void:
    self.assert_eq_deep(
        CL.TakeWhile([0, 2, 3, 5], func (n: int) -> bool: return (n % 2) == 0).as_array(),
        [0, 2]
    )


func test_take_while_alternating() -> void:
    self.assert_eq_deep(
        CL.TakeWhile([0, 1, 2, 3], func (n: int) -> bool: return (n % 2) == 0).as_array(),
        [0]
    )
