commandArray = {}

local on_threshold = tonumber(uservariables['Bathroom Light On Lux'] or 0)
local bathroom_motion = devicechanged['Bathroom Motion']
local bathroom_lux = tonumber(otherdevices_svalues['Bathroom Lux'])
local desired_lights_state = nil

if bathroom_motion == 'On' then
  if bathroom_lux <= on_threshold then
    desired_lights_state = 'On'
  end
elseif bathroom_motion == 'Off' then
  if otherdevices['Bathroom Lights'] == 'On' then
    desired_lights_state = 'Off'
  end
end

if desired_lights_state then
  commandArray['Bathroom Lights'] = desired_lights_state
end

return commandArray
