local FRICTION = 0.3

return function (ecs)
  for entity, vel in ecs:entitiesWithAll("vel") do
    vel.x = vel.x * (1 - FRICTION) if math.abs(vel.x) < 0.0001 then vel.x = 0 end
    vel.y = vel.y * (1 - FRICTION) if math.abs(vel.y) < 0.0001 then vel.y = 0 end

    if vel.x == 0 and vel.y == 0 then
      ecs:set(entity, "vel", nil)
    end
  end
end
