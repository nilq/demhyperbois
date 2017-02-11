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

    @eye_pos = {
      .line @pos, {
        @pos[1] + 100 * (@radius / 2) * math.cos i
        @pos[2] + 100 * (@radius / 2) * math.sin i
        0
        0
      }

      .line @pos, {
        0
        @pos[1] + 100 * (@radius / 2) * math.cos i
        @pos[2] + 100 * (@radius / 2) * math.sin i
        0
      }

      .line @pos, {
        0
        0
        @pos[1] + 100 * (@radius / 2) * math.cos i
        @pos[2] + 100 * (@radius / 2) * math.sin i
      }

      .line @pos, {
        @pos[1] + 100 * (@radius / 2) * math.cos i
        0
        @pos[2] + 100 * (@radius / 2) * math.sin i
        0
      }

      .line @pos, {
        @pos[1] + 100 * (@radius / 2) * math.cos i
        0
        0
        @pos[2] + 100 * (@radius / 2) * math.sin i
      }

      .line @pos, {
        0
        @pos[2] + 100 * (@radius / 2) * math.sin i
        0
        @pos[1] + 100 * (@radius / 2) * math.cos i
      }
    }

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
      for e in *@eyes
        for i = 0, math.pi, math.pi / e
