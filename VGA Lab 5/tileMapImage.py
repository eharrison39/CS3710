#!/usr/bin/env python3
from PIL import Image

# === CONFIGURATION ===
IMAGE_FILE = "scary.png"        # input image
OUTPUT_FILE = "scary.hex"       # output hex file for FPGA
MAP_W = 64
MAP_H = 48
TILE_W = 10
TILE_H = 10

# Palette mapping: RGB -> 8-bit RRRGGGBB
def rgb_to_8bit(r, g, b):
    r3 = (r * 7) // 255   # 3-bit red
    g3 = (g * 7) // 255   # 3-bit green
    b2 = (b * 3) // 255   # 2-bit blue
    return (r3 << 5) | (g3 << 2) | b2

# Load image
img = Image.open(IMAGE_FILE).convert("RGB")
img_w, img_h = img.size

# Resize image to match tilemap size
img = img.resize((MAP_W, MAP_H), Image.NEAREST)

# Generate tilemap hex
tilemap = []

for y in range(MAP_H):
    row = []
    for x in range(MAP_W):
        # Get pixel color
        r, g, b = img.getpixel((x, y))
        # Convert to 8-bit tile color
        tile_val = rgb_to_8bit(r, g, b)
        row.append(f"{tile_val:02X}")
    tilemap.append(row)

# Write hex file
with open(OUTPUT_FILE, "w") as f:
    for row in tilemap:
        f.write(" ".join(row) + "\n")

print(f"{OUTPUT_FILE} generated successfully!")
