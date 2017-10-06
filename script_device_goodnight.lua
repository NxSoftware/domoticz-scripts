commandArray = {}

if devicechanged['Bedtime'] ~= 'On' then
  return commandArray
end

local living_room_light_id = 'Living Room Light'
local dining_area_light_id = 'Dining Area Light'
local hall_light_id = 'Hall Light'
local landing_light_id = 'Landing Light'
local top_landing_light_id = 'Top Landing Light'
local bed_lights_id = 'Bed Lights'

commandArray[1] = {
  [living_room_light_id] = 'Set Level 30'
}
commandArray[2] = {
  [dining_area_light_id] = 'Set Level 20'
}
commandArray[3] = {
  [landing_light_id] = 'Set Level 50'
}
commandArray[4] = {
  [top_landing_light_id] = 'Set Level 50'
}
commandArray[5] = {
  [bed_lights_id] = 'On'
}
commandArray[6] = {
  [living_room_light_id] = 'Off AFTER 20'
}
commandArray[7] = {
  [dining_area_light_id] = 'Off AFTER 20'
}
commandArray[8] = {
  [hall_light_id] = 'Off AFTER 20'
}
commandArray[9] = {
  [landing_light_id] = 'Off AFTER 60'
}
commandArray[10] = {
  [top_landing_light_id] = 'Off AFTER 60'
}

return commandArray
