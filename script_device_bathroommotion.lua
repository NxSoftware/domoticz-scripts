commandArray = {}

if devicechanged['Bathroom Motion'] == 'On' then
  if timeofday['Nighttime'] then
    commandArray['Bathroom Lights'] = 'On'
  end
else
  commandArray['Bathroom Lights'] = 'Off'
end

return commandArray
