extends GutTest

const CL = preload("../StreamClassLoader.gd")


func test_generate_counter() -> void:
    var counter = [0]
    var generator = func():
        counter[0] += 1
        return counter[0]
    
    self.assert_eq_deep(
        CL.Generate(generator).take(5).as_array(),
        [1, 2, 3, 4, 5]
    )


func test_generate_fibonacci() -> void:
    var a: Array[int] = [0]
    var b: Array[int] = [1]
    var generator = func():
        var next = a[0]
        a[0] = b[0]
        b[0] = next + b[0]
        return next
    
    self.assert_eq_deep(
        CL.Generate(generator).take(7).as_array(),
        [0, 1, 1, 2, 3, 5, 8]
    )
