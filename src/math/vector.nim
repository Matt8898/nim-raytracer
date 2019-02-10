import math

type
  Vec3f* = ref object of RootObj
    x*, y*, z*: float

proc `+`* (v, u: Vec3f): Vec3f =
  return Vec3f(x: v.x + u.x, y: v.y + u.y, z: v.z + u.z)

proc `-`* (v, u: Vec3f): Vec3f =
  return Vec3f(x: v.x - u.x, y: v.y - u.y, z: v.z - u.z)

proc `*`*(v, u: Vec3f): float =
  return v.x * u.x + v.y * u.y + v.z * u.z

proc `*`*(v: Vec3f, u: float): Vec3f =
  return Vec3f(x: u * v.x, y: u * v.y, z: u * v.z)

func norm*(v: Vec3f): float =
  return sqrt(v.x * v.x + v.y * v.y + v.z * v.z)

func normalize*(v: Vec3f): Vec3f =
  let norm = v.norm
  return Vec3f(x: v.x / norm, y: v.y / norm, z: v.z / norm)
