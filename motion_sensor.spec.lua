require 'domotest'
require 'busted.runner'()

describe('Bathroom motion sensor', function()

  describe('detects motion at night', function()

    it('turns on the light', function()
      commandArray = domotest('script_device_bathroommotion.lua', {
        devicechanged = { ['Bathroom Motion'] = 'On' },
        timeofday = { ['Nighttime'] = true }
      })

      assert.are.same({
        ['Bathroom Lights'] = 'On'
      }, commandArray)
    end)

  end)

  describe('detects motion during the day', function()

    it('does nothing', function()
      commandArray = domotest('script_device_bathroommotion.lua', {
        devicechanged = { ['Bathroom Motion'] = 'On' },
        timeofday = { ['Nighttime'] = false }
      })

      assert.are.same({}, commandArray)
    end)

  end)

  describe('reports no motion', function()

    it('turns off the light', function()
      commandArray = domotest('script_device_bathroommotion.lua', {
        devicechanged = { ['Bathroom Motion'] = 'Off' }
      })

      assert.are.same({
        ['Bathroom Lights'] = 'Off'
      }, commandArray)
    end)

  end)

end)
