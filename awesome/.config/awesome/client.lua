local button = require('awful.button')
local aclient = require('awful.client')
local alayout = require('awful.layout')
local suit = require('awful.layout.suit')
local mouse = require('awful.mouse')
local placement = require('awful.placement')
local util = require('awful.util')
local key = require('awful.key')

local group = 'Client'

local function focus_client_via_mouse(options)
  return function(client)
    local layout = alayout.get(client.screen)
    if layout == suit.magnifier then return end
    if not aclient.focus.filter(client) then return end
    options.client.focus = client
  end
end

local function focus_next_client()
  aclient.focus.byidx(1)
end

local function focus_previous_client()
  aclient.focus.byidx(-1)
end

local function highlight_client(client)
  client.opacity = 1
end

local function kill_client(client)
  client:kill()
end

local function setup_client(options)
  return function(client)
    if not options.awesome.startup then
      aclient.setslave(client)
      return
    end
    if client.size_hints.user_position then return end
    if client.size_hints.program_position then return end
    placement.no_offscreen(client)
  end
end

local function swap_next_client()
  aclient.swap.byidx(1)
end

local function swap_previous_client()
  aclient.swap.byidx(-1)
end

local function toggle_maximize_client(client)
  client.maximized = not client.maximized
  client:raise()
end

local function unhighlight_client(client)
  client.opacity = 0.6
end

return function(options)
  options.global_keys = util.table.join(
    options.global_keys,
    key({options.modkey}, 'j', focus_previous_client, {
      description = 'focus next by index',
      group = group,
    }),
    key({options.modkey}, 'k', focus_next_client, {
      description = 'focus previous by index',
      group = group,
    }),
    key({options.modkey, 'Shift'}, 'j', swap_previous_client, {
      description = 'swap with next client by index',
      group = group,
    }),
    key({options.modkey, 'Shift'}, 'k', swap_next_client, {
      description = 'swap with previous client by index',
      group = group,
    }))
  options.client_buttons = util.table.join(
    options.client_buttons,
    button({options.modkey}, 1, mouse.client.move),
    button({options.modkey}, 3, mouse.client.resize))
  options.client_keys = util.table.join(
    options.client_keys,
    key({options.modkey, 'Control'}, 'q', kill_client, {
      description = 'kill',
      group = group,
    }),
    key({options.modkey}, 'm', toggle_maximize_client, {
      description = 'toggle maximize',
      group = group,
    }))
  options.client.connect_signal('manage', setup_client(options))
  options.client.connect_signal('mouse::enter', focus_client_via_mouse(options))
  options.client.connect_signal('focus', highlight_client)
  options.client.connect_signal('unfocus', unhighlight_client)
end
