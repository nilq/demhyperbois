(fov) ->
  project = (...) ->
    point = {...}

    scale = fov / (fov + point[#point])

    _point = {}

    for c in *point
      _point[#_point + 1] = c * scale

      if #_point - (#point - 1) == 0
        return _point, scale

  project_to = (n, ...) ->
    a, scale = project ...

    switch n - #a
      when 0
        return a, scale
      else
        project_to n, unpack a

  ----------------------------------
  -- graphics
  ----------------------------------
  line = (p1, p2) ->
    a, s   = project_to 2, unpack p1
    a2, s2 = project_to 2, unpack p2

    with love.graphics
      .line a[1] * s, a[2] * s, a2[1] * s2, a2[2] * s2

  circle = (mode, p1, radius, segments) ->
    a, s = project_to 2, unpack p1

    with love.graphics
      .circle mode, a[1] * s, a[2] * s, radius * s, segments

  triangle = (mode, p1, p2, p3) ->
    a, s   = project_to 2, unpack p1
    a2, s2 = project_to 2, unpack p2
    a3, s3 = project_to 2, unpack p3

    with love.graphics
      .polygon mode, a[1], a[2], a2[1], a2[2], a3[1], a3[2]

  ----------------------------------
  -- transform
  ----------------------------------
  rotate_x = (y, z, ax, cy, cz) ->
    cos_x = math.cos ax
    sin_x = math.sin ax

    y_ = (y - cy) * cos_x - (z - cz) * sin_x
    z_ = (z - cy) * cos_x + (y - cy) * sin_x

    y_ + cy, z_ + cz

  rotate_y = (x, z, ay, cx, cz) ->
    cos_y = math.cos ay
    sin_y = math.sin ay

    x_ = (x - cx) * cos_y - (z - cz) * sin_y
    z_ = (z - cz) * cos_y + (x - cx) * sin_y

    x_ + cx, z_ + cz

  rotate_z = (x, y, az, cx, cy) ->
    cos_z = math.cos az
    sin_z = math.sin az

    x_ = (x - cx) * cos_z + (y - cy) * sin_z
    y_ = (y - cy) * cos_z - (x - cx) * sin_z

    x_ + cx, y_ + cy

  rotate_w = (x, y, aw, cx, cy) ->
    cos_w = math.cos aw
    sin_w = math.sin aw

    x_ = (x - cx) * cos_w + (y - cy) * sin_w
    y_ = (y - cy) * cos_w - (x - cx) * sin_w

    x_ + cx, y_ + cy

  {
    :project
    :project_to

    graphics: {
      :line
      :circle
      :triangle
    }

    transform: {
      :rotate_x
      :rotate_y
      :rotate_z
      :rotate_w
    }
  }
