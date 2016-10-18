require 'domotest'
require 'busted.runner'()

describe('Bathroom motion sensor', function()

  local script_name = 'script_device_bathroommotion.lua'
  local light_on_threshold_lux = 10

  describe('detects motion', function()

    describe('ambient light level is bright', function()

      commandArray = domotest(script_name, {
        devicechanged = { ['Bathroom Motion'] = 'On' },
        otherdevices = { ['Bathroom Lux'] = 11 },
        uservariables = { ['Bathroom Light On Lux'] = light_on_threshold_lux }
      })

      it('does nothing', function()
        assert.are.same({}, commandArray)
      end)

    end)

    describe('ambient light level is dim', function()

      commandArray = domotest(script_name, {
        devicechanged = { ['Bathroom Motion'] = 'On' },
        otherdevices = { ['Bathroom Lux'] = 9 },
        uservariables = { ['Bathroom Light On Lux'] = light_on_threshold_lux }
      })

      it('turns on the lights', function()
        assert.are.same({
          ['Bathroom Lights'] = 'On'
        }, commandArray)
      end)

    end)

  end)

  describe('reports no motion', function()

    commandArray = domotest(script_name, {
      devicechanged = { ['Bathroom Motion'] = 'Off' }
    })

    it('turns off the lights', function()
      assert.are.same({
        ['Bathroom Lights'] = 'Off'
      }, commandArray)
    end)

  end)

end)
