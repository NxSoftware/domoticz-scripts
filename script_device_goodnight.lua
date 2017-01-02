commandArray = {}

if devicechanged['Bedtime'] ~= 'On' then
  return commandArray
end

local living_room_light_id = 'Living Room Light'
local dining_area_light_id = 'Dining Area Light'
local landing_light_id = 'Landing Light'
local top_landing_light_id = 'Top Landing Light'
local bed_lights_id = 'Bed Lights'

commandArray[1] = {
  [living_room_light_id] = 'Set Level 15'
}
commandArray[2] = {
  [living_room_light_id] = 'Off AFTER 20'
}
commandArray[3] = {
  [dining_area_light_id] = 'Set Level 20'
}
commandArray[4] = {
  [dining_area_light_id] = 'Off AFTER 20'
}
commandArray[5] = {
  [landing_light_id] = 'Set Level 50'
}
commandArray[6] = {
  [landing_light_id] = 'Off AFTER 60'
}
commandArray[7] = {
  [top_landing_light_id] = 'Set Level 50'
}
commandArray[8] = {
  [top_landing_light_id] = 'Off AFTER 60'
}
commandArray[9] = {
  [bed_lights_id] = 'On'
}

return commandArray
