#!/usr/bin/env python3
from PIL import Image
import sys

def imageToGlyphs(image_path, output_file="font8x8.hex"):
    # Open the image
    img = Image.open(image_path).convert("L")  # convert to grayscale
    width, height = img.size
    
    # Ensure width and height are multiples of 8
    if width % 8 != 0 or height % 8 != 0:
        print(f"Image size ({width}x{height}) is not divisible by 8. Resizing...")
        new_width = (width // 8) * 8
        new_height = (height // 8) * 8
        img = img.resize((new_width, new_height), Image.NEAREST)
        width, height = img.size

    # Convert image to 1-bit (black & white)
    img = img.point(lambda p: 0 if p < 128 else 1, mode="1")

    glyphs = []

    # Process each 8x8 block
    for y_block in range(0, height, 8):
        for x_block in range(0, width, 8):
            glyph = []
            for row in range(8):
                byte = 0
                for col in range(8):
                    pixel = img.getpixel((x_block + col, y_block + row))
                    byte |= (pixel & 1) << (7 - col)
                glyph.append(byte)
            glyphs.append(glyph)

    # Write to hex file
    with open(output_file, "w") as f:
        for glyph in glyphs:
            for row in glyph:
                f.write(f"{row:02X}\n")

    print(f"Done! {len(glyphs)} glyphs written to {output_file}")

if __name__ == "__main__":
    if len(sys.argv) < 2:
        print("Usage: python3 imageToGlyphs.py input.png [output.hex]")
        sys.exit(1)
    input_image = sys.argv[1]
    output_file = sys.argv[2] if len(sys.argv) >= 3 else "font8x8.hex"
    imageToGlyphs(input_image, output_file)
