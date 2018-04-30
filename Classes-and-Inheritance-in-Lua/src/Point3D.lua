local Point2D = require "Point2D"              -- import "Point2D"

local Point3D = {}                             -- define `Point3D` as a new class
Point3D.__index = Point3D                      -- allow instances to access the methods of the class

setmetatable(Point3D, {__index = Point2D})     -- make `Point3D` inherit from `Point2D`

function Point3D.new(class, x, y, z)           -- constructor for `Point3D` (note the first parameter, `class`, referring to the class itself)
  local self = Point2D:new(x, y)               -- invoke the parent constructor
  setmetatable(self, class)                    -- make it an instance of this class
  self._z = z or 0                             -- add the remaining fields
  return self                                  -- remember to return the new instance
end

function Point3D:getZ()                        -- instance method (note the use of `:`)
  return self._z
end

return Point3D
