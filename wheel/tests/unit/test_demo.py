import dfordbx.demo as dem
def test_demo():
    result = dem.my_wheel()
    resultJson = str(result)
    expectedResult = str("value")
    assert resultJson == expectedResult
