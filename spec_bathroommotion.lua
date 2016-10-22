require 'domotest'
require 'busted.runner'()

describe('When the bathroom motion sensor', function()

  local script_name = 'script_device_bathroommotion.lua'
  local light_on_threshold_lux = '10'

  describe('detects motion', function()

    describe('and the ambient light level is bright', function()

      commandArray = domotest(script_name, {
        devicechanged = { ['Bathroom Motion'] = 'On' },
        otherdevices = { ['Bathroom Lux'] = '11' },
        uservariables = { ['Bathroom Light On Lux'] = light_on_threshold_lux }
      })

      it('nothing happens', function()
        assert.are.same({}, commandArray)
      end)

    end)

    describe('and the ambient light level is dim', function()

      commandArray = domotest(script_name, {
        devicechanged = { ['Bathroom Motion'] = 'On' },
        otherdevices = { ['Bathroom Lux'] = '9' },
        uservariables = { ['Bathroom Light On Lux'] = light_on_threshold_lux }
      })

      it('the lights turn on', function()
        assert.are.same({
          ['Bathroom Lights'] = 'On'
        }, commandArray)
      end)

    end)

    describe('a missing uservariable is defaulted', function()
      commandArray = domotest(script_name, {
        devicechanged = { ['Bathroom Motion'] = 'On' },
        otherdevices = { ['Bathroom Lux'] = '9' }
      })

      it('does nothing', function()
        assert.are.same({}, commandArray)
      end)

    end)

  end)

  describe('reports no motion', function()

    describe('and the lights are on', function()

      commandArray = domotest(script_name, {
        devicechanged = { ['Bathroom Motion'] = 'Off' },
        otherdevices = { ['Bathroom Lights'] = 'On' }
      })

      it('turn off the lights', function()
        assert.are.same({
          ['Bathroom Lights'] = 'Off'
        }, commandArray)
      end)

    end)

    describe('and the lights are off', function()

      commandArray = domotest(script_name, {
        devicechanged = { ['Bathroom Motion'] = 'Off' },
        otherdevices = { ['Bathroom Lights'] = 'Off' }
      })

      it('nothing happens', function()
        assert.are.same({}, commandArray)
      end)

    end)

  end)

end)
