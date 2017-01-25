commandArray = {}

local bottom_stairs_sensor_id = 'Bottom Stairs Motion'
local landing_sensor_id = 'Landing Motion'

local bottom_stairs_motion = devicechanged[bottom_stairs_sensor_id]
local landing_motion = devicechanged[landing_sensor_id]

if bottom_stairs_motion == nil and landing_motion == nil then
  return commandArray
end

local function landing_light_is_on()
  return tonumber(otherdevices_svalues['Landing Light']) > 0
end

local landing_lux = tonumber(otherdevices_svalues['Landing Lux'])
local on_threshold = tonumber(uservariables['Landing Light On Lux'] or 0)

local function there_is_motion()
  return bottom_stairs_motion == 'On' or landing_motion == 'On'
end

local function there_is_no_motion() 
  return (bottom_stairs_motion or otherdevices[bottom_stairs_sensor_id]) == 'Off'
  and (landing_motion or otherdevices[landing_sensor_id]) == 'Off'
end

if landing_light_is_on() then
  if there_is_no_motion() then
    commandArray['Landing Light'] = 'Off'
  end
elseif there_is_motion() then
  if landing_lux < on_threshold then
    commandArray['Landing Light'] = 'On'
  end
end

return commandArray
