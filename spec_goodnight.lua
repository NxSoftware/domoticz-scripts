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

  describe('is off', function()

    commandArray = domotest(script_name, {
      devicechanged = { ['Bedtime'] = 'Off' }
    })

    it('nothing happens', function()
      assert.are.same({}, commandArray)
    end)
  end)

  describe('turns on', function()

    local commands = {
      ['devicechanged'] = { ['Bedtime'] = 'On' }
    }

    describe('and the LIVING ROOM LIGHT is OFF', function()
      commands['otherdevices_svalues'] = { ['Living Room Light'] = '0' }
      commandArray = domotest(script_name, commands)

      it("don't change the living room light state", function()
        assert.is_nil(commandArray['Living Room Light'])
      end)
    end)

    describe('and the DINING AREA LIGHT is OFF', function()
      commands['otherdevices_svalues'] = { ['Dining Area Light'] = '0' }
      commandArray = domotest(script_name, commands)

      it("don't change the dining area light state", function()
        assert.is_nil(commandArray['Dining Area Light'])
      end)
    end)

    describe('and the LIVING ROOM LIGHT is ON', function()
      commands['otherdevices_svalues'] = { ['Living Room Light'] = '100' }
      commandArray = domotest(script_name, commands)

      it('immediately set the brightness to 15%', function()
        assert.is.equal('Set Level 15', commandArray[1]['Living Room Light'])
      end)

      it('turn off the light after 20 seconds', function()
        assert.is.equal('Off AFTER 20', commandArray[2]['Living Room Light'])
      end)
    end)

    describe('and the DINING AREA LIGHT is ON', function()
      commands['otherdevices_svalues'] = { ['Dining Area Light'] = '37' }
      commandArray = domotest(script_name, commands)

      it('immediately set the brightness to 15%', function()
        assert.is.equal('Set Level 15', commandArray[3]['Dining Area Light'])
      end)

      it('turn off the light after 20 seconds', function()
        assert.is.equal('Off AFTER 20', commandArray[4]['Dining Area Light'])
      end)
    end)

    it('set the LANDING LIGHT to 50%', function()
      assert.is.equal('Set Level 50', commandArray[5]['Landing Light'])
    end)

    it('turn off the LANDING light after 60 seconds', function()
      assert.is.equal('Off AFTER 60', commandArray[6]['Landing Light'])
    end)

  end)

end)
