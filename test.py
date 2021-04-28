hex_string = "0xaa0176040000000100d61f55"

bytes_object = bytes.fromhex(hex_string)

ascii_string = bytes_object.decode("ASCII")

print(ascii_string)
