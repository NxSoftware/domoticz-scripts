require 'domotest'
require 'busted.runner'()

local script_name = 'script_device_goodnight.lua'

describe('When a device changes', function()

  commandArray = domotest(script_name, {
    devicechanged = { ['Bathroom Motion'] = 'On' }
  })

  it('nothing happens', function()
    assert.are.same({}, commandArray)
  end)

end)

describe('When the BEDTIME device', function()

  describe('turns off', function()
    commandArray = domotest(script_name, {
      devicechanged = { ['Bedtime'] = 'Off' }
    })

    it('nothing happens', function()
      assert.are.same({}, commandArray)
    end)
  end)

  describe('turns on', function()
    commandArray = domotest(script_name, {
      ['devicechanged'] = { ['Bedtime'] = 'On' }
    })

    it('immediately set the LIVING ROOM LIGHT brightness to 15%', function()
      assert.is.equal('Set Level 15', commandArray[1]['Living Room Light'])
    end)

    it('turn off the LIVING ROOM LIGHT after 20 seconds', function()
      assert.is.equal('Off AFTER 20', commandArray[2]['Living Room Light'])
    end)

    it('immediately set the DINING AREA LIGHT brightness to 20%', function()
      assert.is.equal('Set Level 20', commandArray[3]['Dining Area Light'])
    end)

    it('turn off the DINING AREA LIGHT after 20 seconds', function()
      assert.is.equal('Off AFTER 20', commandArray[4]['Dining Area Light'])
    end)

    it('set the LANDING LIGHT to 50%', function()
      assert.is.equal('Set Level 50', commandArray[5]['Landing Light'])
    end)

    it('turn off the LANDING LIGHT after 60 seconds', function()
      assert.is.equal('Off AFTER 60', commandArray[6]['Landing Light'])
    end)

    it('set the TOP LANDING LIGHT to 50%', function()
      assert.is.equal('Set Level 50', commandArray[7]['Top Landing Light'])
    end)

    it('turn off the TOP LANDING LIGHT after 60 seconds', function()
      assert.is.equal('Off AFTER 60', commandArray[8]['Top Landing Light'])
    end)

  end)

end)
