return function (ecs)
  for entity, vel, pos in ecs:entitiesWithAll("vel", "pos") do
    pos.x = pos.x + vel.x
    pos.y = pos.y + vel.y
  end
end
