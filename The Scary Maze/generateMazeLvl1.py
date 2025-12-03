MAP_W, MAP_H = 64, 48
TILEMAP = [[0 for _ in range(MAP_W)] for _ in range(MAP_H)]

# Helper to fill tiles
def fill_tiles(x0, x1, y0, y1, val):
    for y in range(y0, y1+1):
        for x in range(x0, x1+1):
            TILEMAP[y][x] = val

# Fill rectangles (your maze coordinates mapped to tiles)
fill_tiles(31, 62, 10, 11, 0x05)   # magenta
fill_tiles(62, 63, 10, 11, 0x01)   # blue
fill_tiles(33, 33, 12, 19, 0x05)
fill_tiles(31, 63, 20, 22, 0x05)
fill_tiles(62, 63, 23, 29, 0x05)
fill_tiles(31, 63, 30, 34, 0x05)
fill_tiles(31, 34, 35, 39, 0x05)
fill_tiles(31, 63, 40, 47, 0x05)

# Write hex file
with open("mazeLvl1.hex","w") as f:
    for row in TILEMAP:
        f.write(" ".join(f"{x:02X}" for x in row) + "\n")

print("mazeLvl1.hex file generated successfully!")
