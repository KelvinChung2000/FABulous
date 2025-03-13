def check_bit_representation(value: int, bits: int) -> bool:
    if not isinstance(value, int):
        raise TypeError(f"Value must be an integer, got {value}")

    if bits <= 0:
        raise ValueError(f"Number of bits must be greater than 0, got {bits}")

    # For unsigned values (0 to 2^bits-1)
    if 0 <= value < (1 << bits):
        return True

    # For signed values (-2^(bits-1) to 2^(bits-1)-1)
    if -(1 << (bits - 1)) <= value < (1 << (bits - 1)):
        return True

    return False


class BBAWriter:
    def __init__(self, f):
        self.f = f

    def pre(self, s):
        print(f"pre {s}", file=self.f)

    def post(self, s):
        print(f"post {s}", file=self.f)

    def push(self, s):
        print(f"push {s}", file=self.f)

    def ref(self, r, comment=""):
        print(f"ref {r} {comment}", file=self.f)

    def slice(self, r, size, comment=""):
        print(f"ref {r} {comment}", file=self.f)
        print(f"u32 {size}", file=self.f)

    def str(self, s, comment=""):
        print(f"str |{s}| {comment}", file=self.f)

    def label(self, s):
        print(f"label {s}", file=self.f)

    def u8(self, n, comment=""):
        assert isinstance(n, int), n
        if not check_bit_representation(n, 8):
            raise ValueError(f"Value {n} is not representable with u8")
        print(f"u8 {n} {comment}", file=self.f)

    def u16(self, n, comment=""):
        assert isinstance(n, int), n
        if not check_bit_representation(n, 16):
            raise ValueError(f"Value {n} is not representable with u16")
        print(f"u16 {n} {comment}", file=self.f)

    def u32(self, n, comment=""):
        assert isinstance(n, int), n
        if not check_bit_representation(n, 32):
            raise ValueError(f"Value {n} is not representable with u32")
        print(f"u32 {n} {comment}", file=self.f)

    def pop(self):
        print("pop", file=self.f)
