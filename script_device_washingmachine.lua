commandArray = {}

local energy_usage = devicechanged['Washing Machine (W)_Utility']

if energy_usage == nil then
  return commandArray
end

local washing_machine_state_id = 'Washing Machine Active'
local tracking_state = uservariables[washing_machine_state_id]
local start_tracking_threshold = 10
local stop_tracking_threshold = 2
local update_command = 'Variable:' .. washing_machine_state_id

if tracking_state == 'Off' then
  if energy_usage > start_tracking_threshold then
    commandArray[update_command] = 'On'
  end
elseif tracking_state == 'On' then
  if energy_usage <= stop_tracking_threshold then
    commandArray[update_command] = 'Off'
    commandArray['SendNotification'] = '#Your washing has finished'
  end
end

return commandArray
