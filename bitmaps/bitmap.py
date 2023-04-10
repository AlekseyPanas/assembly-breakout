"""
Set DIMS = (width, height) of your bitmap in pixels
set MULT to the integer multiplier of the display (e.g screen size will be DIMS * MULT)
set color to the color of the bitmap (currently supports only single color)
set bg to the color of the screen background, which will represent transparent pixels in the final bitmap

Run in terminal
Use mouse left click to draw pixels on pygame screen
Hold shift and use left click to erase pixels back to transparency

Press Q to quit

Copy paste the printed string into your assembly code for a bitmap array.
The bitmap struct is as follows:

struct bitmap:
    int/word width
    int/word height
    int/word pixels[DIMS[0] * DIMS[1]]  // 0xff000000 represents transparent pixel
"""

import pygame
from pprint import pprint
import json
import time
import copy


DIMS = (115, 10)
MULT = 10
bg = (0, 0, 0)
color = (255, 50, 50)


def output(matrix):
    string = "BMP: .word "

    print("Please specify a file name (omit .json) to save progress (Enter nothing to skip)")
    inp = input(": ").strip().lower()

    if len(inp) != 0:
        with open("./" + inp + ".json", "w") as file:
            json.dump(matrix, file)

    # Write first two dimension numbers
    for d in DIMS:
        s = hex(d)[2:]
        while len(s) < 8:
            s = "0" + s
        string += "0x" + s + ", "

    for r in matrix:
        for c in r:
            if any(h == -1 for h in c):
                string += "0xff000000, "
            else:
                cols_str = ""
                for channel in c:
                    strn = hex(channel)[2:]
                    if len(strn) == 1:
                        strn = "0" + strn
                    cols_str += strn

                string += "0x00" + cols_str + ", "
    string = string[:len(string) - 2]
    print(string)


def file_name_or_b() -> tuple[bool, list]:
    while True:
        print("Please specify a complete file path, or 'B' to go back")
        path = input(": ").strip().lower()
        print()

        if len(path) == 1 and path[0] == 'b':
            return True, []

        try:
            with open(path, "r") as file:
                m = json.load(file)
                return False, m

        except FileNotFoundError:
            print("You did not enter a valid file")
            print()


def draw_rect(surf, col, x, y, mult):
    pygame.draw.rect(surf, col, pygame.Rect((x * mult, y * mult), (mult, mult)))


def get_color_input() -> list[int]:
    while 1:
        print("Please specify 3 comma separate 0-255 RGB values")
        inp = input(": ").strip().lower()
        print()

        spl = inp.split(",")
        if len(spl) != 3:
            print("You did not specify the correct number of values\n")
        else:
            try:
                col = [int(s.strip()) for s in spl]
                return col
            except Exception:
                print("Your input was invalid, try again\n")


screen = pygame.display.set_mode((DIMS[0] * MULT, DIMS[1] * MULT), pygame.DOUBLEBUF)
clock = pygame.time.Clock()
running = True
screen.fill(bg)

while 1:
    print("What would you like to do?\n"
          "[N] New Canvas\n"
          "[L] Load File\n"
          "[R] Recolor \n"
          "[I] Inflate")
    i = input(": ").strip().lower()[0]
    print()

    if i == "n":
        matrix = [[[-1, -1, -1] for _ in range(DIMS[0])] for _ in range(DIMS[1])]
        break

    elif i == "l":
        out = file_name_or_b()
        if not out[0]:
            matrix = out[1]

            # Change dims to match file
            DIMS = (len(matrix[0]), len(matrix))
            screen = pygame.display.set_mode((DIMS[0] * MULT, DIMS[1] * MULT), pygame.DOUBLEBUF)

            # Set color to matrix color and pre-draw the matrix on screen
            for i in range(len(matrix)):
                for j in range(len(matrix[i])):
                    c = matrix[i][j]
                    if c != [-1, -1, -1]:
                        color = tuple(copy.copy(c))
                        draw_rect(screen, color, j, i, MULT)

            break

    elif i == "r":
        out = file_name_or_b()
        if not out[0]:
            matrix = out[1]
            color = get_color_input()

            # Perform recolor
            for i in range(len(matrix)):
                for j in range(len(matrix[i])):
                    c = matrix[i][j]
                    if c != [-1, -1, -1]:
                        matrix[i][j] = color

            output(matrix)
            exit(0)

    elif i == "i":
        out = file_name_or_b()
        if not out[0]:
            matrix = out[1]

            # Double each row
            for i in range(len(matrix)):
                cols = len(matrix[i])
                count = 0
                j = 0
                while count < cols:
                    matrix[i].insert(j + 1, copy.deepcopy(matrix[i][j]))
                    j += 2
                    count += 1

            # double each column
            rows = len(matrix)
            count = 0
            i = 0
            while count < rows:
                matrix.insert(i + 1, copy.deepcopy(matrix[i]))
                i += 2
                count += 1

            output(matrix)
            exit(0)

    else:
        print("Please enter a valid command")


while running:
    for e in pygame.event.get():
        if e.type == pygame.QUIT or (e.type == pygame.KEYDOWN and e.key == pygame.K_q):
            running = False

    if pygame.mouse.get_pressed()[0]:
        p = pygame.mouse.get_pos()
        x = p[0] // MULT
        y = p[1] // MULT

        # Reset to BG (transparency)
        if pygame.key.get_pressed()[pygame.K_LSHIFT]:
            if matrix[y][x] != [-1, -1, -1]:
                matrix[y][x] = [-1, -1, -1]
                draw_rect(screen, bg, x, y, MULT)
        # Set to color
        else:
            if matrix[y][x] != list(color):
                matrix[y][x] = list(color)
                draw_rect(screen, color, x, y, MULT)

        clock.tick(100)
        pygame.display.set_caption(str(clock.get_fps()))

    pygame.display.update()

output(matrix)


"""
    .word 0x00170600,0x00000003,0x00ffe600,0x00000029,0x00000014,0x0000000f,0x0000000a,0x00000003,0x00ffe600,0x00000038,0x00000014,0x0000000f,0x0000000a,0x00000003,0x00ff0000,0x00000047,0x00000014,0x0000000f,0x0000000a,0x00000003,0x00ff6400,0x00000013,0x0000001e,0x0000000f,0x0000000a,0x00000003,0x00ff00fa,0x00000022,0x0000001e,0x0000000f,0x0000000a,0x00000003,0x00ff00fa,0x00000031,0x0000001e,0x0000000f,0x0000000a,0x00000003,0x0000ff00,0x00000040,0x0000001e,0x0000000f,0x0000000a,0x00000003,0x00ff0000,0x0000004f,0x0000001e,0x0000000f,0x0000000a,0x00000003,0x0000ff00,0x0000005e,0x0000001e,0x0000000f,0x0000000a,0x00000003,0x00ff00fa,0x0000000a,0x00000028
    .word 0x0000001e,0x0000000a,0x00000003,0x0000ff00,0x00000058,0x00000028,0x0000001e,0x0000000a,0x00000003,0x00ff00fa,0x00000013,0x00000032,0x0000000f,0x0000000a,0x00000003,0x00ff00fa,0x00000022,0x00000032,0x0000000f,0x0000000a,0x00000003,0x00ffe600,0x00000031,0x00000032,0x0000000f,0x0000000a,0x00000003,0x00ff6400,0x00000040,0x00000032,0x0000000f,0x0000000a,0x00000003,0x0000beff,0x0000004f,0x00000032,0x0000000f,0x0000000a,0x00000003,0x000000ff,0x0000005e,0x00000032,0x0000000f,0x0000000a,0x00000003,0x0000ff00,0x00000029,0x0000003c,0x0000000f,0x0000000a,0x00000003,0x00ff6400,0x00000038,0x0000003c,0x0000000f,0x0000000a,0x00000003,0x007300ff,0x00000047,0x0000003c,0x0000000f,0x0000000a,0x00000003,0x00ffe600,0x00000022,0x00000050,0x00000014,0x0000000a,0x00000003,0x00ffe600,0x00000036,0x00000050,0x00000014,0x0000000a,0x00000003,0x00ff00fa,0x0000004a,0x00000050,0x00000014,0x0000000a,0x00000000,0xff000000,0x00000000,0x00000000,0x00000000,0x00000000,0x00000000,0xff000000,0x00000000,0x00000000,0x00000000,0x00000000,0x00000000,0xff000000,0x00000000,0x00000000,0x00000000,0x00000000,0x00000000,0xff000000,0x00000000,0x00000000,0x00000000,0x00000000,0x00000000,0xff000000,0x00000000,0x00000000,0x00000000,0x00000000,0x00000000,0xff000000,0x00000000,0x00000000,0x00000000,0x00000000,0x00000000,0xff000000,0x00000000,0x00000000,0x00000000,0x00000000,0x00000000,0xff000000,0x00000000,0x00000000,0x00000000,0x00000000,0x00000000,0xff000000,0x00000000,0x00000000,0x00000000,0x00000000,0x00000000,0xff000000,0x00000000,0x00000000,0x00000000,0x00000000,0x00000000,0xff000000,0x00000000,0x00000000,0x00000000,0x00000000,0x00000000,0xff000000,0x00000000,0x00000000,0x00000000,0x00000000,0x00000000,0xff000000,0x00000000,0x00000000,0x00000000,0x00000000,0x00000000,0xff000000,0x00000000,0x00000000,0x00000000,0x00000000,0x00000000,0xff000000,0x00000000,0x00000000,0x00000000,0x00000000,0x00000000,0xff000000,0x00000000,0x00000000,0x00000000,0x00000000,0x00000000,0xff000000,0x00000000,0x00000000,0x00000000,0x00000000,0x00000000,0xff000000,0x00000000,0x00000000,0x00000000,0x00000000,0x00000000,0xff000000,0x00000000,0x00000000,0x00000000,0x00000000,0x00000000,0xff000000,0x00000000,0x00000000,0x00000000,0x00000000,0x00000000,0xff000000,0x00000000,0x00000000,0x00000000,0x00000000,0x00000000,0xff000000,0x00000000,0x00000000,0x00000000,0x00000000,0x00000000,0xff000000,0x00000000,0x00000000,0x00000000,0x00000000,0x00000000,0xff000000,0x00000000,0x00000000,0x00000000,0x00000000,0x00000000,0xff000000,0x00000000,0x00000000,0x00000000,0x00000000,0x00000000,0xff000000,0x00000000,0x00000000,0x00000000,0x00000000,0x00000000,0xff000000,0x00000000,0x00000000,0x00000000,0x00000000,0x00000000,0xff000000,0x00000000,0x00000000,0x00000000,0x00000000,0x00000000,0xff000000,0x00000000,0x00000000,0x00000000,0x00000000,0x00000000,0xff000000,0x00000000,0x00000000,0x00000000,0x00000000,0x00000000,0xff000000,0x00000000,0x00000000,0x00000000,0x00000000,0x00000000,0xff000000,0x00000000,0x00000000,0x00000000,0x00000000,0x00000000,0xff000000,0x00000000,0x00000000,0x00000000,0x00000000,0x00000000,0xff000000,0x00000000,0x00000000,0x00000000,0x00000000,0x00000000,0xff000000,0x00000000,0x00000000,0x00000000,0x00000000,0x00000000,0xff000000,0x00000000,0x00000000,0x00000000,0x00000000,0x00000000,0xff000000,0x00000000,0x00000000,0x00000000,0x00000000,0x00000000,0xff000000,0x00000000,0x00000000,0x00000000,0x00000000,0x00000000,0xff000000,0x00000000,0x00000000,0x00000000,0x00000000,0x00000000,0xff000000,0x00000000,0x00000000,0x00000000,0x00000000,0x00000000,0xff000000,0x00000000,0x00000000,0x00000000,0x00000000,0x00000000,0xff000000,0x00000000,0x00000000,0x00000000,0x00000000,0x00000000,0xff000000,0x00000000,0x00000000,0x00000000,0x00000000,0x00000000,0xff000000,0x00000000,0x00000000,0x00000000,0x00000000,0x00000000,0xff000000,0x00000000,0x00000000,0x00000000,0x00000000,0x00000000,0xff000000,0x00000000,0x00000000,0x00000000,0x00000000,0x00000000,0xff000000,0x00000000,0x00000000,0x00000000,0x00000000,0x00000000,0xff000000,0x00000000,0x00000000,0x00000000,0x00000000,0x00000000,0xff000000,0x00000000,0x00000000,0x00000000,0x00000000,0x00000000,0xff000000,0x00000000,0x00000000,0x00000000,0x00000000,0x00000000,0xff000000,0x00000000,0x00000000,0x00000000,0x00000000,0x00000000,0xff000000,0x00000000,0x00000000,0x00000000,0x00000000,0x00000000,0xff000000,0x00000000,0x00000000,0x00000000,0x00000000,0x00000000,0xff000000,0x00000000,0x00000000,0x00000000,0x00000000,0x00000000,0xff000000,0x00000000,0x00000000,0x00000000,0x00000000,0x00000000,0xff000000,0x00000000,0x00000000,0x00000000,0x00000000,0x00000000,0xff000000,0x00000000
    .word 0x00000000,0x00000000,0x00000000,0x008c8c8c,0x00000000,0x00000000,0x0000000a,0x00000076,0x008c8c8c,0x00000076,0x00000000,0x0000000a,0x00000076,0x008c8c8c,0x0000000a,0x00000000,0x0000006c,0x0000000a,0x008c8c8c,0x00000028,0x00000028,0x00000030,0x0000000a,0x008c8c8c,0x0000000a,0x00000050,0x00000018,0x0000000a,0x008c8c8c,0x0000005e,0x00000050,0x00000018,0x0000000a,0xff000000,0x00000000,0x00000000,0x00000000,0x00000000,0xff000000,0x00000000,0x00000000,0x00000000,0x00000000,0xff000000,0x00000000,0x00000000,0x00000000,0x00000000,0xff000000,0x00000000,0x00000000,0x00000000,0x00000000

"""
