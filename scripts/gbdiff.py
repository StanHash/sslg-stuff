import sys

def diff_bytes(fa, fb, offset, length):
    fa.seek(offset)
    da = fa.read(length)

    fb.seek(offset)
    db = fb.read(length)

    for i in range(length):
        if da[i] != db[i]:
            yield (i, da[i], db[1])

def main(args):
    try:
        filename_a = args[0]
        filename_b = args[1]
        bank_count = int(args[2], base = 0)

    except IndexError:
        sys.exit(f"Usage: [python 3] {sys.argv[0]} FILE_A FILE_B BANKS")

    with open(filename_a, 'rb') as fa:
        with open(filename_b, 'rb') as fb:
            for bank in range(bank_count):
                offset = 0x4000 * bank
                length = 0x4000

                addr = 0 if bank == 0 else 0x4000

                for i, ba, bb in diff_bytes(fa, fb, offset, length):
                    print(f"{bank:02X}:{addr + i:04X} {ba:02X} {bb:02X}")

if __name__ == '__main__':
    main(sys.argv[1:])
