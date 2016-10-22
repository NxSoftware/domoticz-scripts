commandArray = {}

local on_threshold = uservariables['Bathroom Light On Lux']
local bathroom_motion = devicechanged['Bathroom Motion']
local desired_lights_state = nil

if bathroom_motion == 'On' then
  if otherdevices['Bathroom Lux'] <= on_threshold then
    desired_lights_state = 'On'
  end
elseif otherdevices['Bathroom Lights'] == 'On' then
  desired_lights_state = 'Off'
end

if desired_lights_state then
  commandArray['Bathroom Lights'] = desired_lights_state
end

return commandArray
