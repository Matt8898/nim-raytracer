import math
import math/vector
import math/shapes
import os

proc cast_ray(orig, dir: Vec3f, s: Sphere): Vec3f =
  let sphere_dist = high(float)
  if not s.ray_intersect(orig, dir, sphere_dist):
    return Vec3f(x: 0.2, y: 0.7, z: 0.8)
  return Vec3f(x: 0.4, y: 0.4, z: 0.3)

proc render(s: Sphere) =
  const width: int = 1920
  const height: int = 1080
  const fov: float = 90
  var framebuffer = newSeq[Vec3f](width * height)
  for j in 0..<height:
    for i in 0..<width:
      framebuffer[i + j * width] = Vec3f(x: cast[float](j)/cast[float](height), y: cast[float](i)/cast[float](width), z: 0)
  for j in 0..<height:
    for i in 0..<width:
      let x = (2.0 * (float(i) + 0.5)/ float(width) - 1) * tan(fov/2.0) * float(width)/float(height)
      let y = (2.0 * (float(j) + 0.5)/ float(height) - 1) * tan(fov/2.0)
      var dir = Vec3f(x: x, y: y, z: -1).normalize()
      framebuffer[i + j * width] = cast_ray(Vec3f(x: 0, y: 0, z: 0), dir, s)

  var outfile = open("out.ppm", fmWrite)
  outfile.write("P6\n", width, " ", height, "\n255\n")
  for i in 0..<(height * width):
    outfile.write char(255*(framebuffer[i]).x)
    outfile.write char(255*(framebuffer[i]).y)
    outfile.write char(255*(framebuffer[i]).z)

let s: Sphere = Sphere(center: Vec3f(x: -3, y: 0, z: -16), radius: 2)
render(s)
