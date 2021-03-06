import vector
import math
import ../material/material

type Sphere* = ref object of RootObj
  center*: Vec3f
  radius*: float
  material*: Material

func ray_intersect*(s: Sphere, origin, direction: Vec3f, t0: var float): bool =
  let L = s.center - origin
  let tca = L * direction
  let d2 = L*L - tca*tca
  if d2 > s.radius*s.radius:
    return false
  let thc = sqrt(s.radius*s.radius - d2)
  t0 = tca - thc
  let t1 = tca + thc
  if t0 < 0:
    t0 = t1
  if t0 < 0:
    return false
  return true
