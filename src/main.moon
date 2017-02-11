export thing = (require "math_stuff") 250

with love
  .graphics.setBackgroundColor 255, 100, 100
  .load = ->
    Agent = require "agent"

    export agents = {}

    for i = 1, 1
      table.insert agents, Agent (math.random 0, 800), (math.random 0, 800), (math.random 0, 800), (math.random 0, 800)

  export wbuff = (l) ->
    table.sort l, (a, b) ->
      a[4] > b[4]

  .update = (dt) ->
    wbuff agents

    for a in *agents
      a\update dt

  .draw = ->
    .graphics.push!
    .graphics.translate 400, 300

    for a in *agents
      a\draw!

    .graphics.pop!
