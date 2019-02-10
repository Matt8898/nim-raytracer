import ../math/vector

type Material* = ref object of RootObj
  diffuse_color*: Vec3f
