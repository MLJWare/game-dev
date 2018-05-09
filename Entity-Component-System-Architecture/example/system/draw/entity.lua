return function (ecs)
  for entity, color, pos in ecs:entitiesWithAll("color", "pos") do
    love.graphics.setColor(color)
    love.graphics.circle("fill", pos.x, pos.y, 16)
  end
end
