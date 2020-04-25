rom = bytearray([0xea] * 32768)

with open("rom_ea.bin", "wb") as out_file:
    out_file.write(rom)
