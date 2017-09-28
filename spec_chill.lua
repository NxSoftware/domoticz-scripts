require 'domotest'
require 'busted.runner'()

local script_name = 'script_device_chill.lua'

describe('When a device changes', function()

  commandArray = domotest(script_name, {
    devicechanged = { ['Bathroom Motion'] = 'On' }
  })

  it('nothing happens', function()
    assert.are.same({}, commandArray)
  end)

end)

describe('When the CHILL device', function()

  describe('turns off', function()
    commandArray = domotest(script_name, {
      devicechanged = { ['Chill'] = 'Off' }
    })

    it('nothing happens', function()
      assert.are.same({}, commandArray)
    end)
  end)

  describe('turns on', function()
    commandArray = domotest(script_name, {
      ['devicechanged'] = { ['Chill'] = 'On' }
    })

    it('immediately set the DINING AREA LIGHT brightness to 40%', function()
      assert.is.equal('Set Level 40', commandArray[1]['Dining Area Light'])
    end)

    it('immediately turn off the LIVING ROOM LIGHT', function()
      assert.is.equal('Off', commandArray[2]['Living Room Light'])
    end)
  end)

end)