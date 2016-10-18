commandArray = {}

local on_threshold = uservariables['Bathroom Light On Lux']
local desired_lights_state = nil

if devicechanged['Bathroom Motion'] == 'On' then
  if otherdevices['Bathroom Lux'] <= on_threshold then
    desired_lights_state = 'On'
  end
else
  desired_lights_state = 'Off'
end

if desired_lights_state then
  commandArray['Bathroom Lights'] = desired_lights_state
end

return commandArray
