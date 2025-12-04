#!/usr/bin/env python3
from PIL import Image

# === CONFIGURATION ===
IMAGE_FILE = "scary.png"
OUTPUT_FILE = "scary.hex"
MAP_W = 64
MAP_H = 48

# Target pixel rectangle on screen
X_MIN, X_MAX = 310, 640
Y_MIN, Y_MAX = 100, 430

SCREEN_W = X_MAX - X_MIN
SCREEN_H = Y_MAX - Y_MIN

# Convert RGB to 8-bit RRRGGGBB
def rgb_to_8bit(r, g, b):
    r3 = (r * 7) // 255
    g3 = (g * 7) // 255
    b2 = (b * 3) // 255
    return (r3 << 5) | (g3 << 2) | b2

# Load image
img = Image.open(IMAGE_FILE).convert("RGB")
orig_w, orig_h = img.size
aspect_ratio = orig_w / orig_h

# Map pixel rectangle to tilemap coordinates
tile_rect_w = int(MAP_W * SCREEN_W / 640)
tile_rect_h = int(MAP_H * SCREEN_H / 480)

# Determine new image size to fit inside tile rectangle
if (tile_rect_w / tile_rect_h) > aspect_ratio:
    new_h = tile_rect_h
    new_w = max(1, int(aspect_ratio * new_h))
else:
    new_w = tile_rect_w
    new_h = max(1, int(new_w / aspect_ratio))

img_resized = img.resize((new_w, new_h), Image.NEAREST)

# Create tilemap filled with black
tilemap = [[0x00 for _ in range(MAP_W)] for _ in range(MAP_H)]

# Compute offsets in tiles to center the image inside the rectangle
offset_x = int(MAP_W * (X_MIN / 640)) + (tile_rect_w - new_w) // 2
offset_y = int(MAP_H * (Y_MIN / 480)) + (tile_rect_h - new_h) // 2

# Clip offsets to ensure image stays in bounds
offset_x = max(0, min(MAP_W - new_w, offset_x))
offset_y = max(0, min(MAP_H - new_h, offset_y))

# Fill tilemap with image
for y in range(new_h):
    for x in range(new_w):
        tilemap[offset_y + y][offset_x + x] = rgb_to_8bit(*img_resized.getpixel((x, y)))

# Write hex file
with open(OUTPUT_FILE, "w") as f:
    for row in tilemap:
        f.write(" ".join(f"{val:02X}" for val in row) + "\n")

print(f"{OUTPUT_FILE} generated successfully! Image centered between pixels ({X_MIN},{Y_MIN}) and ({X_MAX},{Y_MAX}).")
