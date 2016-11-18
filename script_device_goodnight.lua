commandArray = {}

if devicechanged['Bedtime'] ~= 'On' then
  return commandArray
end

local living_room_light_id = 'Living Room Light'
local dining_area_light_id = 'Dining Area Light'
local landing_light_id = 'Landing Light'

if otherdevices[living_room_light_id] == 'On' then
  commandArray[1] = {
    [living_room_light_id] = 'Set Level 15'
  }
  commandArray[2] = {
    [living_room_light_id] = 'Off AFTER 20'
  }
end

if otherdevices[dining_area_light_id] == 'On' then
  commandArray[3] = {
    [dining_area_light_id] = 'Set Level 15'
  }
  commandArray[4] = {
    [dining_area_light_id] = 'Off AFTER 20'
  }
end

commandArray[5] = {
  [landing_light_id] = 'Set Level 50'
}
commandArray[6] = {
  [landing_light_id] = 'Off AFTER 60'
}

return commandArray
