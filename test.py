class Stuff():

    def __init__(self, things):
        self.things = things

    def __getitem__(self, key):
        if key == 0:
            return self.things
        raise KeyError("No poking me!")

    def __setitem__(self, key, value):
        print("called from stuff setitem")
        print(id(self[key]))
        print(id(value))
        if self[key] is value:
            return
        raise TypeError("No poking me!")
    
    def __ifloordiv__(self, other):
        self.divided_by = other
        return self


class Thing:
    def __ifloordiv__(self, other):
        self.divided_by = other
        return self


a = Stuff(Thing())
a[0] //= 2
a //= 3
print(a[0].divided_by)
print(a.divided_by)
