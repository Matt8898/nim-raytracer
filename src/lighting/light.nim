import ../math/vector

type Light* = ref object of RootObj
  position*: Vec3f
  intensity*: float
