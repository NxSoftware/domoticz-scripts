commandArray = {}

if devicechanged['Chill'] ~= 'On' then
  return commandArray
end

local living_room_light_id = 'Living Room Light'
local dining_area_light_id = 'Dining Area Light'

commandArray[1] = {
  [dining_area_light_id] = 'Set Level 40'
}

commandArray[2] = {
  [living_room_light_id] = 'Off'
}

return commandArray