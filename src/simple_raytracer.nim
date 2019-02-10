import math
import math/vector
import math/shapes
import material/material
import lighting/light
import os

proc scene_intersect(orig: Vec3f, dir: Vec3f, spheres: seq[Sphere], hit: var Vec3f, N: var Vec3f, material: var Material): bool =
  var spheres_dist = high(float)
  for sphere in spheres:
    var dist_i: float = 0.0
    if(sphere.ray_intersect(orig, dir, dist_i) and dist_i < spheres_dist):
      spheres_dist = dist_i
      hit = orig + dir * dist_i
      N = (hit - sphere.center).normalize()
      material = sphere.material
  return spheres_dist < 1000


proc cast_ray(orig, dir: Vec3f, s: seq[Sphere], lights: seq[Light]): Vec3f =
  var point, N: Vec3f
  var material: Material
  if not scene_intersect(orig, dir, s, point, N, material):
    return Vec3f(x: 0.2, y: 0.7, z: 0.8)
  var diffuse_intensity = 0.0
  for light in lights:
    var light_dir: Vec3f = (light.position - point).normalize()
    diffuse_intensity = diffuse_intensity + light.intensity * max(0.0, light_dir * N)
  return material.diffuse_color * diffuse_intensity

proc render(s: seq[Sphere], lights: seq[Light]) =
  const width: int = 2560
  const height: int = 1440
  const fov: float = PI/2
  var framebuffer = newSeq[Vec3f](width * height)
  for j in 0..<height:
    for i in 0..<width:
      framebuffer[i + j * width] = Vec3f(x: cast[float](j)/cast[float](height), y: cast[float](i)/cast[float](width), z: 0)
  for j in 0..<height:
    for i in 0..<width:
      let x = (2.0 * (float(i) + 0.5)/ float(width) - 1) * tan(fov/2.0) * float(width)/float(height)
      let y = (2.0 * (float(j) + 0.5)/ float(height) - 1) * tan(fov/2.0)
      var dir = Vec3f(x: x, y: y, z: -1).normalize()
      framebuffer[i + j * width] = cast_ray(Vec3f(x: 0, y: 0, z: 0), dir, s, lights)

  var outfile = open("out.ppm", fmWrite)
  outfile.write("P6\n", width, " ", height, "\n255\n")
  for i in 0..<(height * width):
    outfile.write char(255*(framebuffer[i]).x)
    outfile.write char(255*(framebuffer[i]).y)
    outfile.write char(255*(framebuffer[i]).z)

var ss: seq[Sphere] = newSeq[Sphere](0)
let ivory = Material(diffuse_color: Vec3f(x: 0.4, y: 0.4, z: 0.3))
let red_rubber = Material(diffuse_color: Vec3f(x: 0.3, y: 0.1, z: 0.1))
ss.add(Sphere(center: Vec3f(x: -3, y: 0, z: -8), radius: 1, material: ivory))
ss.add(Sphere(center: Vec3f(x: +4, y: 2, z: -7), radius: 1, material: red_rubber))
let l = Light(position: Vec3f(x: -5, y: 0, z: 5), intensity: 1.5)
let ls = @[l]
render(ss, ls)
