
import sys

def decode_int(data, offset, length, signed = False):
    return int.from_bytes(data[offset:offset+length], byteorder = 'little', signed = signed)

class ObjectInfo:

    def __init__(self):
        self.y = 0
        self.x = 0
        self.x_m = 0
        self.tile = 0
        self.attr = 0

    @staticmethod
    def decode(data, offset):
        result = ObjectInfo()

        result.y = decode_int(data, offset+0, 1, True)
        result.x = decode_int(data, offset+1, 1, True)
        result.x_m = decode_int(data, offset+2, 1, True)
        result.tile = decode_int(data, offset+3, 1)
        result.attr = decode_int(data, offset+4, 1)

        return result

class SpriteFrame:

    def __init__(self):
        self.unknown_1 = 0
        self.objects = []

    @staticmethod
    def decode(data, offset):
        result = SpriteFrame()

        object_count = decode_int(data, offset+0, 1)
        result.unknown_1 = decode_int(data, offset+1, 1)

        for i in range(object_count):
            result.objects.append(ObjectInfo.decode(data, offset+2+i*5))

        return result

class Sprite:

    def __init__(self):
        self.frame_addrs = []

    @staticmethod
    def decode(data, offset):
        result = Sprite()

        min_addr = 0x7FFF

        while offset+len(result.frame_addrs)*2 < addr_2_offset(min_addr):
            addr = decode_int(data, offset+len(result.frame_addrs)*2, 2)

            result.frame_addrs.append(addr)
            min_addr = min(min_addr, addr)

        return result

class SpriteInfo:

    def __init__(self):
        self.data_bank = 0
        self.data_addr = 0
        self.unknown_2 = 0

    @staticmethod
    def decode(data, offset = 0):
        result = SpriteInfo()

        result.data_addr = decode_int(data, offset+0, 2)
        result.unknown_2 = decode_int(data, offset+2, 1, True)
        result.data_bank = decode_int(data, offset+3, 1)

        return result

def addr_2_offset(addr):
    return addr & 0x3FFF

def read_bank(f, bank_num):
    f.seek(bank_num * 0x4000)
    return f.read(0x4000)

def read_frame(f, bank, addr):
    bank_data = read_bank(f, bank)
    return SpriteFrame.decode(bank_data, addr_2_offset(addr))

def read_sprite(f, bank, addr):
    bank_data = read_bank(f, bank)
    return Sprite.decode(bank_data, addr_2_offset(addr))

def main(args):
    try:
        rom_filename = args[0]

    except IndexError:
        sys.exit(f"Usage: [python 3] {sys.argv[0]} ROM")

    BANK = 0x26
    ADDR = 0x4000
    AMNT = 185

    names = {}
    names[(BANK, ADDR)] = f"Data_{BANK:02X}_{ADDR:04X}"

    sprites = {}

    with open(rom_filename, 'rb') as f:
        bank_data = read_bank(f, BANK)

        print(f"    section \"bank{BANK:02X}\", romx, bank[${BANK:02X}]")
        print("")
        print(f"{names[(BANK, ADDR)]}::")

        for i in range(AMNT):
            offset = addr_2_offset(ADDR) + 4*i
            sprite_info = SpriteInfo.decode(bank_data, offset)

            bank = sprite_info.data_bank
            addr = sprite_info.data_addr

            names[(bank, addr)] = f"Sprite_{bank:02X}_{addr:04X}"

            sprites[(bank, addr)] = read_sprite(f, bank, addr)

            print(f"    SpriteInfo {names[(bank, addr)]}, {sprite_info.unknown_2} ; {i}")

        print("")

        for bank, addr in sorted(sprites.keys(), key = lambda t: (t[0] << 16) + t[1]):
            sprite = sprites[(bank, addr)]

            frame_names = {}

            for a in sprite.frame_addrs:
                frame_names[a] = f".frame_{a:04X}"

            print(f"    section \"sprite_{bank:02X}_{addr:04X}\", romx[${addr:04X}], bank[${bank:02X}]")
            print("")
            print(f"{names[(bank, addr)]}::")

            for i, a in enumerate(sprite.frame_addrs):
                print(f"    dw {frame_names[a]} ; {i}")

            print("")

            visited = set()

            for a in sorted(sprite.frame_addrs):
                if a in visited:
                    continue

                visited.add(a)

                print(f"{frame_names[a]}:")

                frame = read_frame(f, bank, a)

                print(f"    db {len(frame.objects)}, {frame.unknown_1}")

                for object_info in frame.objects:
                    print(f"    db {object_info.y:3}, {object_info.x}, {object_info.x_m}, ${object_info.tile:02X}, ${object_info.attr:02X}")

                print("")

if __name__ == '__main__':
    main(sys.argv[1:])
