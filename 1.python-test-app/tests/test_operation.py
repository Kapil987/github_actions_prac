from src.math_operation import add,sub

def test_add():
    assert add(2,3)==5
    assert add(-2,2)==0

def test_sub():
    assert sub(10,3)==7
    assert sub(20,5)==15
    assert sub(20,20)==0
    assert sub(5,6)==-1