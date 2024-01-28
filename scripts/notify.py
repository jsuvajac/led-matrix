#! /usr/bin/python3
import time
import math
import socket
from time import sleep, time
from pprint import pprint
import random

def lerp(a, b, t):
    return a + t * (b - a)

def sin01(x):
    return .5 * (math.sin(x) + 1)

def clamp(a, b, v):
    if (v >= a and v <= b):
        return v
    elif (v >= a):
        return b
    else:
        return a

def notify(run_time):
    client_socket = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)

    size = 7
    buffer = [0] * (2 + size * size * 3)
    buffer[0] = 2
    buffer[1] = 1

    fps = 120
    dt = 1/fps
    length = fps * run_time

    brightness_buffer = [[0 for x in range(size)] for y in range(size)]
    for y in range(size):
        for x in range(size):
            brightness_buffer[y][x] = lerp(1, random.random(), .9)

    for t in range(length):
        p = t/(length)
        frame_start = time()

        for y in range(size):
            for x in range(size):

                r1 = lerp(0, 255, sin01(y + x - t * .1 + 0)) * brightness_buffer[x][y]
                g1 = lerp(0, 255, sin01(y + x - t * .1 + 1)) * brightness_buffer[x][y]
                b1 = lerp(0, 255, sin01(y + x - t * .1 + 3)) * brightness_buffer[x][y]

                r2 = clamp(0, 255, sin01(.5 * .1 * t * .5) * 255)
                g2 = clamp(0, 255, sin01(.5 * .3 * t * .5) * 255)
                b2 = clamp(0, 255, sin01(.5 * .4 * t * .5) * 255)

                r = lerp(r1, r2, 0)
                g = lerp(g1, g2, 0)
                b = lerp(b1, b2, 0)

                r = round(r * (1 - p * p * p * p))
                g = round(g * (1 - p * p * p * p))
                b = round(b * (1 - p * p * p * p))

                
                buffer[2 + x * 3 + y * size * 3 + 0] = r
                buffer[2 + x * 3 + y * size * 3 + 1] = g
                buffer[2 + x * 3 + y * size * 3 + 2] = b

        frame_end = time()
        diff = frame_end - frame_start
        processing = diff

        client_socket.sendto(bytes(buffer), ("192.168.40.2", 65506))
        s = time()
        send = s - frame_end

        while diff < dt:
            sleep(.0001)
            frame_end = time()
            diff = frame_end - frame_start
        
        # print(processing / dt * 100)#, send / dt * 100, (time() - s) / dt * 100)


if __name__ == '__main__':
    import os
    import sys

    pid = os.fork()
    length = 3 if len(sys.argv) != 2 else int(sys.argv[1])

    if pid == 0:
        notify(length)
