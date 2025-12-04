#!/usr/bin/env python3
from PIL import Image

# === CONFIGURATION ===
IMAGE_FILE = "scary.png"      # your source image
OUTPUT_FILE = "scary2x2.hex"    # hex file for FPGA

# VGA screen / tilemap settings
SCREEN_W = 640
SCREEN_H = 480
TILE_W = 2
TILE_H = 2
MAP_W = SCREEN_W // TILE_W   # 320
MAP_H = SCREEN_H // TILE_H   # 240

# Centering region in pixels
X0, X1 = 310, 640
Y0, Y1 = 100, 430
REGION_W = X1 - X0
REGION_H = Y1 - Y0

# Load image
img = Image.open(IMAGE_FILE).convert("RGB")

# Scale image to fit the region in **tiles**, not pixels
region_tiles_w = REGION_W // TILE_W
region_tiles_h = REGION_H // TILE_H
img = img.resize((region_tiles_w, region_tiles_h), Image.Resampling.NEAREST)
img_w, img_h = img.size

# Create tilemap filled with 0x00 (black)
tilemap = [[0x00 for _ in range(MAP_W)] for _ in range(MAP_H)]

# Compute offsets in tiles to center the image in the specified region
offset_x = X0 // TILE_W + ((region_tiles_w - img_w) // 2)
offset_y = Y0 // TILE_H + ((region_tiles_h - img_h) // 2)

# Helper: convert RGB to 8-bit color for your bitgen
def rgb_to_8bit(r, g, b):
    r3 = r >> 5
    g3 = g >> 5
    b2 = b >> 6
    return (r3 << 5) | (g3 << 2) | b2

# Fill the tilemap: **one tile per 2×2 pixels**
for y in range(img_h):
    for x in range(img_w):
        r, g, b = img.getpixel((x, y))
        tilemap[offset_y + y][offset_x + x] = rgb_to_8bit(r, g, b)

# Write hex file
with open(OUTPUT_FILE, "w") as f:
    for row in tilemap:
        f.write(" ".join(f"{v:02X}" for v in row) + "\n")

print(f"{OUTPUT_FILE} generated successfully!")
