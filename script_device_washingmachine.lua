commandArray = {}

local energy_usage = devicechanged['Washing Machine Energy']

if energy_usage == nil then
  return commandArray
end

local tracking_state = uservariables['Washing Machine Active']
local start_tracking_threshold = 10
local stop_tracking_threshold = 2
local desired_tracking_state = nil

if tracking_state == 'Off' then
  if energy_usage > start_tracking_threshold then
    desired_tracking_state = 'On'
  end
elseif tracking_state == 'On' then
  if energy_usage <= stop_tracking_threshold then
    desired_tracking_state = 'Off'
  end
end

if desired_tracking_state then
  commandArray['Variable:Washing Machine Active'] = desired_tracking_state
end

return commandArray
