local ECSA    = require "ECSA"

local ecs
local systems = {
  update = {
    require "example.system.update.key-input";
    require "example.system.update.movement";
    require "example.system.update.friction";
  };
  draw = {
    require "example.system.draw.entity";
  };
}

function love.load(arg)
  ecs     = ECSA:new()

  local player = ecs:newEntity()
  ecs:set(player, "key-control", {})
  ecs:set(player, "pos"        , {x = 120, y = 100})
  ecs:set(player, "color"      , {0.7, 0.2, 0.8})
end

function love.update()
  for _, system in ipairs(systems.update) do
    system(ecs)
  end
end

function love.draw()
  for _, system in ipairs(systems.draw) do
    system(ecs, dt)
  end
end
