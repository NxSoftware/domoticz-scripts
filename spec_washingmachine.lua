require 'domotest'
require 'busted.runner'()

context('When the washing machine energy usage', function()

  local script_name = 'script_device_washingmachine.lua'

  describe('is above the tracking threshold', function()

    describe('and the cycle is already being tracked', function()
      commandArray = domotest(script_name, {
        devicechanged = { ['Washing Machine (W)_Utility'] = 4.1 },
        uservariables = { ['Washing Machine Active'] = 'On' }
      })

      it('nothing happens', function()
        assert.are.same({}, commandArray)
      end)
    end)

    describe('and the cycle is not being tracked', function()
      commandArray = domotest(script_name, {
        devicechanged = { ['Washing Machine (W)_Utility'] = 4.1 },
        uservariables = { ['Washing Machine Active'] = 'Off' }
      })

      it('the tracking variable is set', function()
        assert.are.same({
          ['Variable:Washing Machine Active'] = 'On'
        }, commandArray)
      end)
    end)

  end)

  describe('is at (or below) the tracking threshold', function()

    describe('and the cycle is not being tracked', function()
      commandArray = domotest(script_name, {
        devicechanged = { ['Washing Machine (W)_Utility'] = 1.4 },
        uservariables = { ['Washing Machine Active'] = 'Off' }
      })

      it('nothing happens', function()
        assert.are.same({}, commandArray)
      end)
    end)

    describe('and the cycle is being tracked', function()
      commandArray = domotest(script_name, {
        devicechanged = { ['Washing Machine (W)_Utility'] = 1.4 },
        uservariables = { ['Washing Machine Active'] = 'On' }
      })

      it('the tracking variable is RESET', function()
        assert.are.same(
          'Off',
          commandArray['Variable:Washing Machine Active']
        )
      end)

      it('a notification is sent', function()
        assert.are.same(
          '#Your washing has finished',
          commandArray['SendNotification']
        )
      end)
    end)

  end)

end)
