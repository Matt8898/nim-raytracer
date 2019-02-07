import math/vector
import os

proc render() =
  const width: int = 1920
  const height: int = 1080
  var framebuffer = newSeq[Vec3f](width * height)
  for j in 0..<height:
    for i in 0..<width:
      framebuffer[i + j * width] = Vec3f(x: cast[float](j)/cast[float](height), y: cast[float](i)/cast[float](width), z: 0)
  var outfile = open("out.ppm", fmWrite)
  outfile.write("P6\n", width, " ", height, "\n255\n")
  for i in 0..<(height * width):
    outfile.write char(255*(framebuffer[i]).x)
    outfile.write char(255*(framebuffer[i]).y)
    outfile.write char(255*(framebuffer[i]).z)

let a = Vec3f(x: 0, y: 0, z: 0)
let b = Vec3f(x: 0, y: 0, z: 0)

render()
