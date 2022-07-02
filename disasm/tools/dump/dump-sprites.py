
import sys

def decode_int(data, offset, length, signed = False):
    return int.from_bytes(data[offset:offset+length], byteorder = 'little', signed = signed)

class SpriteObject:

    def __init__(self):
        self.y = 0
        self.x = 0
        self.x_m = 0
        self.tile = 0
        self.attr = 0

    def decode(self, data, offset):
        self.y = decode_int(data, offset+0, 1, True)
        self.x = decode_int(data, offset+1, 1, True)
        self.x_m = decode_int(data, offset+2, 1, True)
        self.tile = decode_int(data, offset+3, 1)
        self.attr = decode_int(data, offset+4, 1)
        return self

class SpriteFrame:

    def __init__(self):
        self.objects = []
        self.objects_unknown_1 = 0
        self.gfx = b''

    def decode_objects(self, data, offset):
        object_count = decode_int(data, offset+0, 1)
        self.objects_unknown_1 = decode_int(data, offset+1, 1)

        for i in range(object_count):
            self.objects.append(SpriteObject().decode(data, offset+2+i*5))

        return self

    def decode_gfx(self, data, offset):
        gfx_length = decode_int(data, offset+0, 2)
        self.gfx = data[offset+10:offset+10+gfx_length]
        return self
