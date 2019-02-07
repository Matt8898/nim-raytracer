type
  Vec3f* = ref object of RootObj
    x*, y*, z*: float

proc `-`* (v, u: Vec3f): Vec3f =
  return Vec3f(x: v.x - u.x, y: v.y - u.y, z: v.z - u.z)
