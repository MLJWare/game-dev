-- "imports"
local Point2D     = require "Point2D"
local Point3D     = require "Point3D"
local Position    = require "Position"

-- Testing Point2D class
local point = Point2D:new(10, 20)
print( point:getX(), point:getY() )            -- prints:  10   20

-- Testing Position class
local pos = Position:new(10, 20)
print( pos:getX(), pos:getY() )                -- prints:  10   20
pos:move(5, -5)
print( pos:getX(), pos:getY() )                -- prints:  15   15

-- Testing Point3D class
local p3 = Point3D:new(10, 20, 30)
print( p3:getX(), p3:getY(), p3:getZ() )       -- prints:  10   20   30
