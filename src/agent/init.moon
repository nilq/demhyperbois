class
  new: (...) =>
    @pos = {...}
    @rot = [(math.random -math.pi, math.pi) for i = 1, #@pos]

    @radius = 10

    @color = {
      math.random 0, 255
      math.random 0, 255
      math.random 0, 255
    }

    @eyes = {
      3
      3
    }

    @eye_pos = {}

    for e in *@eyes
      for i = 0, math.pi, math.pi / e
        table.insert @eye_pos, (radius, pos) -> {
          pos[1] + 100 * (radius / 2) * math.cos i
          pos[2] + 100 * (radius / 2) * math.sin i
          0
          0
        }

        table.insert @eye_pos, (radius, pos) -> {
          0
          pos[1] + 100 * (radius / 2) * math.cos i
          pos[2] + 100 * (radius / 2) * math.sin i
          0
        }

        table.insert @eye_pos, (radius, pos) -> {
          0
          0
          pos[1] + 100 * (radius / 2) * math.cos i
          pos[2] + 100 * (radius / 2) * math.sin i
        }

        table.insert @eye_pos, (radius, pos) -> {
          pos[1] + 100 * (radius / 2) * math.cos i
          0
          pos[2] + 100 * (radius / 2) * math.sin i
          0
        }


    wbuff [(ep @radius, @pos) for ep in *@eye_pos]

    @a = 0

  update: (dt) =>
    @a += dt

    @pos[1] = 400 * math.cos @a
    @pos[2] = 400 * math.sin @a

  draw: =>
    with thing.graphics
      love.graphics.setColor @color[1], @color[2], @color[3]
      .circle "fill", @pos, @radius

      love.graphics.setColor 0, 0, 0
      for e in *@eye_pos
        .line @pos, e @radius, @pos
