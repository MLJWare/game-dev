local function ikey(key)
  return love.keyboard.isDown(key) and 1 or 0
end

local SPEED = 4

return function (ecs)
  for entity, isPlayer in ecs:entitiesWithAny("key-control") do
    local dx = ikey"right" - ikey"left"
    local dy = ikey"down"  - ikey"up"

    if dx ~= 0 or dy ~= 0 then
      ecs:set(entity, "vel", {x = dx*SPEED, y = dy*SPEED})
    end
  end
end
