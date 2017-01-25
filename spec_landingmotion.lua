require 'domotest'
require 'busted.runner'()

local script_name = 'script_device_landingmotion.lua'
local motion_sensors = {'Bottom Stairs Motion', 'Landing Motion'}
local on_threshold = '10'
local commands = {
  uservariables = { ['Landing Light On Lux'] = on_threshold }
}

describe('When no MOTION SENSORS report a change', function()
  commandArray = domotest(script_name, {
    devicechanged = { ['Bathroom Motion'] = 'On' }
  })

  it('nothing happens', function()
    assert.are.same({}, commandArray)
  end)
end)

describe('When the LANDING LUX is HIGH', function()
  commands['otherdevices_svalues'] = {
    ['Landing Lux'] = '9'
  }
  commands['devicechanged'] = {}

  it('nothing happens', function()
    assert.are.same({}, commandArray)
  end)
end)

describe('When the LANDING LIGHT', function()
  commands['otherdevices_svalues'] = {
    ['Landing Light'] = '',
    ['Landing Lux'] = 9
  }

  describe('is OFF', function()
    commands['otherdevices_svalues']['Landing Light'] = '0'

    describe('and a MOTION SENSOR', function()
      describe('reports NO motion', function()
        it('nothing happens', function()
          commands['devicechanged'] = {
            ['Bottom Stairs Motion'] = 'Off'
          }
          commands['otherdevices'] = {
            ['Landing Motion'] = 'Off'
          }
          commandArray = domotest(script_name, commands)
          assert.are.same({}, commandArray)
        end)
      end)

      describe('reports MOTION', function()
        commands['devicechanged'] = {}
        
        it('turn ON the LANDING LIGHT', function()
          for i, sensor in ipairs(motion_sensors) do
            commands['devicechanged'] = {
              [sensor] = 'On'
            }
            commandArray = domotest(script_name, commands)
            assert.are.same({
              ['Landing Light'] = 'On'
            }, commandArray)
          end
        end)
      end)
    end)
  end)

  describe('is ON', function()
    commands['otherdevices_svalues']['Landing Light'] = '30'

    describe('and the BOTTOM STAIRS MOTION SENSOR', function()
      describe('reports NO motion', function()
        commands['devicechanged'] = {
          ['Bottom Stairs Motion'] = 'Off'
        }
        
        describe('and the LANDING MOTION SENSOR', function()
          describe('has NO motion', function()
            commands['otherdevices'] = {
              ['Landing Motion'] = 'Off'
            }
            it('turn OFF the LANDING LIGHT', function()
              commandArray = domotest(script_name, commands)
              assert.are.same({
                ['Landing Light'] = 'Off'
              }, commandArray)
            end)
          end)
          
          describe('has motion', function()
            commands['otherdevices'] = {
              ['Landing Motion'] = 'On'
            }
            it('nothing happens', function()
              commandArray = domotest(script_name, commands)
              assert.are.same({}, commandArray)
            end)
          end)
        end)
      end)
    end)
    
    describe('and the LANDING MOTION SENSOR', function()
      describe('reports NO motion', function()
        commands['devicechanged'] = {
          ['Landing Motion'] = 'Off'
        }
        describe('and the BOTTOM STAIRS SENSOR', function()
          describe('has NO motion', function()
            commands['otherdevices'] = {
              ['Bottom Stairs Motion'] = 'Off'
            }
            it('turn OFF the LANDING LIGHT', function()
              commandArray = domotest(script_name, commands)
              assert.are.same({
                ['Landing Light'] = 'Off'
              }, commandArray)
            end)
          end)
          
          describe('has motion', function()
            commands['otherdevices'] = {
              ['Bottom Stairs Motion'] = 'On'
            }
            it('nothing happens', function()
              commandArray = domotest(script_name, commands)
              assert.are.same({}, commandArray)
            end)
          end)
        end)
      end)
    end)
    
  end)
end)
