commandArray = {}

if devicechanged['Bedtime'] ~= 'On' then
  return commandArray
end

local living_room_light_id = 'Living Room Light'
local living_room_light_state = tonumber(otherdevices_svalues[living_room_light_id]) or 0
local dining_area_light_id = 'Dining Area Light'
local dining_area_light_state = tonumber(otherdevices_svalues[dining_area_light_id]) or 0
local landing_light_id = 'Landing Light'

if living_room_light_state > 0 then
  commandArray[1] = {
    [living_room_light_id] = 'Set Level 15'
  }
  commandArray[2] = {
    [living_room_light_id] = 'Off AFTER 20'
  }
end

if dining_area_light_state > 0 then
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
