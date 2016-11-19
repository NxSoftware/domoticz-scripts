commandArray = {}

if devicechanged['Bottom Stairs Motion'] == nil
and devicechanged['Landing Motion'] == nil then
  return commandArray
end

local function get_current_motion(id)
  return devicechanged[id] or otherdevices[id]
end

local function landing_light_is_on()
  return tonumber(otherdevices_svalues['Landing Light']) > 0
end

local bottom_stairs_motion = get_current_motion('Bottom Stairs Motion')
local landing_motion = get_current_motion('Landing Motion')

if landing_light_is_on() then
  if bottom_stairs_motion == 'Off'
  and landing_motion == 'Off' then
    commandArray['Landing Light'] = 'Off'
  end
else
  if bottom_stairs_motion == 'On'
  or landing_motion == 'On' then
    commandArray['Landing Light'] = 'On'
  end
end

return commandArray
