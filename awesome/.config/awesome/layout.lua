local key = require('awful.key')
local alayout = require('awful.layout')
local suit = require('awful.layout.suit')
local ascreen = require('awful.screen')
local tag = require('awful.tag')
local util = require('awful.util')

local group = 'Layout'
local master_width_factor = 0.02

local function cycle_layout()
  alayout.inc(1)
end

local function decrease_master_clients()
  tag.incnmaster(-1, nil, true)
end

local function decrease_master_width()
  tag.incmwfact(-master_width_factor)
end

local function increase_master_clients()
  tag.incnmaster(1, nil, true)
end

local function increase_master_width()
  tag.incmwfact(master_width_factor)
end

local function toggle_floating(options)
  local last_layouts = {}
  return function()
    local screen = ascreen.focused()
    local layout = alayout.get(screen)
    if layout == suit.floating then
      alayout.set(last_layouts[screen.index], screen.selected_tag)
    else
      last_layouts[screen.index] = layout
      alayout.set(suit.floating, screen.selected_tag)
    end
  end
end

return function(options)
  options.global_keys = util.table.join(
    options.global_keys,
    key({options.modkey, 'Control'}, 'space', cycle_layout, {
      description = 'cycle',
      group = group,
    }),
    key({options.modkey}, 't', toggle_floating(options), {
      description = 'toggle floating',
      group = group,
    }),
    key({options.modkey, 'Control'}, 'j', decrease_master_clients, {
      description = 'increase master clients',
      group = group,
    }),
    key({options.modkey, 'Control'}, 'k', increase_master_clients, {
      group = group,
      description = 'decrease master clients',
    }),
    key({options.modkey, 'Control'}, 'h', decrease_master_width, {
      description = 'increase master width',
      group = group,
    }),
    key({options.modkey, 'Control'}, 'l', increase_master_width, {
      description = 'decrease master width',
      group = group,
    }))
end
