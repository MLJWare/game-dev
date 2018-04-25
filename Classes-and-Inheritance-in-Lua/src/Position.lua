local Point2D = require "Point2D"              -- import "Point2D"

local Position = {}                            -- define `Position` as a new class
Position.__index = Position                    -- allow instances to access the class methods

setmetatable(Position, {__index = Point2D})    -- make `Position` "inherit" from `Point2D`

function Position:move(dx, dy)                 -- instance method (note the use of `:`)
  self._x = self._x + (dx or 0)
  self._y = self._y + (dy or 0)
end

return Position
