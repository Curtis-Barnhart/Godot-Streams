extends GutTest

const CL = preload("../StreamClassLoader.gd")


func test_empty_array() -> void:
    var view = CL.ArrayView([])
    self.assert_eq_deep(view.as_array(), [])


func test_single_element() -> void:
    var view = CL.ArrayView([42])
    self.assert_eq_deep(view.as_array(), [42])


func test_multiple_elements() -> void:
    var view = CL.ArrayView([1, 2, 3, 4, 5])
    self.assert_eq_deep(view.as_array(), [1, 2, 3, 4, 5])


func test_multiple_iterations() -> void:
    var view = CL.ArrayView([1, 2, 3, 4, 5])
    self.assert_eq_deep(view.as_array(), [1, 2, 3, 4, 5])
    self.assert_eq_deep(view.as_array(), [])
