require 'domotest'
require 'busted.runner'()

local script_name = 'script_device_landingmotion.lua'
local on_threshold = '10'
local commands = {
  uservariables = { ['Landing Light On Lux'] = on_threshold }
}

describe('When neither BOTTOM STAIRS SENSOR nor LANDING SENSOR reports a change', function()

  commandArray = domotest(script_name, {
    devicechanged = { ['Bathroom Motion'] = 'On' }
  })

  it('nothing happens', function()
    assert.are.same({}, commandArray)
  end)
end)

describe('When the LANDING LIGHT', function()
  commands['otherdevices_svalues'] = {
    ['Landing Light'] = ''
  }

  describe('is OFF', function()
    commands['otherdevices_svalues']['Landing Light'] = '0'

    describe('and the BOTTOM STAIRS SENSOR', function()
      commands['devicechanged'] = {
        ['Bottom Stairs Motion'] = ''
      }

      describe('reports NO motion', function()
        commands['devicechanged']['Bottom Stairs Motion'] = 'Off'

        describe('and the LANDING SENSOR', function()
          commands['otherdevices'] = {
            ['Landing Motion'] = ''
          }

          describe('has NO motion', function()
            commands['otherdevices']['Landing Motion'] = 'Off'

            it('nothing happens', function()
              commandArray = domotest(script_name, commands)
              assert.are.same({}, commandArray)
            end)
          end)

          describe('has MOTION', function()
            commands['otherdevices']['Landing Motion'] = 'On'

            describe('and the LANDING LUX is HIGH', function()
              commands['otherdevices_svalues']['Landing Lux'] = 11

              it('nothing happens', function()
                commandArray = domotest(script_name, commands)
                assert.are.same({}, commandArray)
              end)
            end)

            describe('and the LANDING LUX is LOW', function()
              commands['otherdevices_svalues']['Landing Lux'] = 9

              it('turn ON the LANDING LIGHT', function()
                commandArray = domotest(script_name, commands)
                assert.are.same({
                  ['Landing Light'] = 'On'
                }, commandArray)
              end)
            end)
          end)
        end)
      end)

      describe('reports MOTION', function()
        commands['devicechanged']['Bottom Stairs Motion'] = 'On'

        it('turn ON the LANDING LIGHT', function()
          commandArray = domotest(script_name, commands)
          assert.are.same({
            ['Landing Light'] = 'On'
          }, commandArray)
        end)
      end)
    end)

    describe('and the LANDING SENSOR', function()
      commands['devicechanged'] = {
        ['Landing Motion'] = ''
      }

      describe('reports NO motion', function()
        commands['devicechanged']['Landing Motion'] = 'Off'

        describe('and the BOTTOM STAIRS SENSOR', function()
          commands['otherdevices'] = {
            ['Bottom Stairs Motion'] = ''
          }

          describe('has NO motion', function()
            commands['otherdevices']['Bottom Stairs Motion'] = 'Off'

            it('nothing happens', function()
              commandArray = domotest(script_name, commands)
              assert.are.same({}, commandArray)
            end)
          end)

          describe('has MOTION', function()
            commands['otherdevices']['Bottom Stairs Motion'] = 'On'

            it('turn ON the LANDING LIGHT', function()
              commandArray = domotest(script_name, commands)
              assert.are.same({
                ['Landing Light'] = 'On'
              }, commandArray)
            end)
          end)
        end)
      end)

      describe('reports MOTION', function()
        commands['devicechanged']['Landing Motion'] = 'On'

        it('turn ON the LANDING LIGHT', function()
          commandArray = domotest(script_name, commands)
          assert.are.same({
            ['Landing Light'] = 'On'
          }, commandArray)
        end)
      end)
    end)
  end)

  describe('is ON', function()
    commands['otherdevices_svalues']['Landing Light'] = '30'

    describe('and the BOTTOM STAIRS SENSOR', function()
      commands['devicechanged'] = {
        ['Bottom Stairs Motion'] = ''
      }

      describe('reports NO motion', function()
        commands['devicechanged']['Bottom Stairs Motion'] = 'Off'

        describe('and the LANDING SENSOR', function()
          commands['otherdevices'] = {
            ['Landing Motion'] = ''
          }

          describe('has NO motion', function()
            commands['otherdevices']['Landing Motion'] = 'Off'

            it('turn OFF the LANDING LIGHT', function()
              commandArray = domotest(script_name, commands)
              assert.are.same({
                ['Landing Light'] = 'Off'
              }, commandArray)
            end)
          end)

          describe('has MOTION', function()
            commands['otherdevices']['Landing Motion'] = 'On'

            it('nothing happens', function()
              commandArray = domotest(script_name, commands)
              assert.are.same({}, commandArray)
            end)
          end)
        end)
      end)

      describe('reports MOTION', function()
        commands['devicechanged']['Bottom Stairs Motion'] = 'On'

        it('nothing happens', function()
          commandArray = domotest(script_name, commands)
          assert.are.same({}, commandArray)
        end)
      end)
    end)

    describe('and the LANDING SENSOR', function()
      commands['devicechanged'] = {
        ['Landing Motion'] = ''
      }

      describe('reports NO motion', function()
        commands['devicechanged']['Landing Motion'] = 'Off'

        describe('and the BOTTOM STAIRS SENSOR', function()
          commands['otherdevices'] = {
            ['Bottom Stairs Motion'] = ''
          }

          describe('has NO motion', function()
            commands['otherdevices']['Bottom Stairs Motion'] = 'Off'

            it('turn OFF the LANDING LIGHT', function()
              commandArray = domotest(script_name, commands)
              assert.are.same({
                ['Landing Light'] = 'Off'
              }, commandArray)
            end)
          end)

          describe('has MOTION', function()
            commands['otherdevices']['Bottom Stairs Motion'] = 'On'

            it('nothing happens', function()
              commandArray = domotest(script_name, commands)
              assert.are.same({}, commandArray)
            end)
          end)
        end)
      end)

      describe('reports MOTION', function()
        commands['devicechanged']['Landing Motion'] = 'On'

        it('nothing happens', function()
          commandArray = domotest(script_name, commands)
          assert.are.same({}, commandArray)
        end)
      end)
    end)
  end)
end)
