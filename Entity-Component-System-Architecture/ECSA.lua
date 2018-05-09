-- used to avoid errors when calling pairs/ipairs with a nil value
local EMPTY = {}

-- ensures the given table has the given key, instantiating it to an empty table if nil.
local function ensure (table, key)
  local data = table[key]
  if not data then
    data = {}
    table[key] = data
  end
  return data
end

local ECSA = {}
ECSA.__index = ECSA

-- Constructs a new ECSA instance
function ECSA.new(class)
  local self = setmetatable({}, class)
  self._ID = 0
  self._entityData = {}
  self._classData  = {}
  return self
end

-- returns a new 'unique' entity
function ECSA:newEntity()
  local entity = self._ID
  self._ID = entity + 1
  return entity
end

-- returns the component associated with a given class on an entity.
function ECSA:get(entity, class)
  if not (entity and class) then return nil end

  local components = self._entityData[entity]
  if not components then return nil end

  return components[class]
end

-- sets the component associated with a given class on an entity.
function ECSA:set(entity, class, data)
  if not (entity and class) then return nil end
  ensure(self._entityData, entity)[class ] = data
  ensure(self._classData , class )[entity] = data
  return data
end

-- removes the entity and all its associated components from the ECS,
-- and returns the associated components (as a table).
function ECSA:removeEntity(entity)
  if not entity then return nil end
  local components = self._entityData[entity]
  for class in pairs(components or EMPTY) do
    self._classData[class][entity] = nil
  end
  self._entityData[entity] = nil
  return components
end

-- returns an iterator that runs through all entitites with components
-- associated with _any_ of the classes specified.
function ECSA:entitiesWithAny(...)
  local classes = {...}
  return coroutine.wrap(function ()
    for _, class in ipairs(classes) do
      for entity, component in pairs(self._classData[class] or EMPTY) do
        coroutine.yield(entity, component, class)
      end
    end
  end)
end

-- returns whether the specified entity has a component associated with _any_
-- of the classes specified.
function ECSA:entityHasAny(entity, ...)
  local classes = {...}

  local components = self._entityData[entity]
  if not components then return false end

  for _, class in ipairs(classes or EMPTY) do
    if components[class] then return true end
  end
  return false
end

-- returns an iterator that runs through all entitites with "non-falsy"
-- components associated with _all_ of the classes specified.
function ECSA:entitiesWithAll(main_class, ...)
  local additional_classes = {...}
  return coroutine.wrap(function ()
    if not main_class then return end

    for entity, component in pairs(self._classData[main_class] or EMPTY) do
      local components = self._entityData[entity]
      local requested_components = { component }
      for i, class in ipairs(additional_classes) do
        local component = components[ class ]
        if not component then goto next_entity end
        requested_components[i + 1] = component
      end

      coroutine.yield(entity, unpack(requested_components))
      ::next_entity::
    end
  end)
end

-- returns whether the specified entity has a component associated with _all_
-- of the classes specified.
function ECSA:entityHasAll(entity, ...)
  local classes = {...}

  local components = self._entityData[entity]
  if not components then return false end

  for _, class in ipairs(classes) do
    if not components[class] then return false end
  end
  return true
end

return ECSA
