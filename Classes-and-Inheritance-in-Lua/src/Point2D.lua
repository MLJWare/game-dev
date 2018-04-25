local Point2D = {}                             -- define `Point2D` as a new "class"
Point2D.__index = Point2D                      -- allow "instances" to access the methods of the class

function Point2D:new(x, y)                     -- constructor for `Point2D` (note the use of `:`)
  local instance = setmetatable({}, self)      -- create a new "instance" of the class
  instance._x = x or 0                         -- set the fields of the instance
  instance._y = y or 0                         -- "private" variables are often indicated using a preceding `_`
  return instance                              -- remember to return the new instance
end

function Point2D:getX()                        -- instance method (note the use of `:`)
  return self._x
end

function Point2D:getY()                        -- instance method (note the use of `:`)
  return self._y
end

return Point2D
