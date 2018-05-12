local key = require('awful.key')
local ascreen = require('awful.screen')
local atag = require('awful.tag')
local util = require('awful.util')

local group = 'Tag'

local function setup_screen(options)
  return function (screen)
    atag(options.tags, screen, options.layouts[1])
  end
end

local function view_tag(tag_index)
  return function()
    local tag = ascreen.focused().tags[tag_index]
    if not tag then return end
    tag:view_only()
  end
end

local function toggle_tag(tag_index)
  return function()
    local tag = ascreen.focused().tags[tag_index]
    if not tag then return end
    atag.viewtoggle(tag)
  end
end

local function move_client(tag_index, options)
  return function()
    if not options.client.focus then return end
    local tag = options.client.focus.screen.tags[tag_index]
    if not tag then return end
    options.client.focus:move_to_tag(tag)
  end
end

local function toggle_client(tag_index, options)
  return function()
    if not options.client.focus then return end
    local tag = options.client.focus.screen.tags[tag_index]
    if not tag then return end
    options.client.focus:toggle_tag(tag)
  end
end

return function (options)
  options.global_keys = util.table.join(
    options.global_keys,
    key({options.modkey}, 'h', atag.viewprev, {
      description = 'focus next by index',
      group = group,
    }),
    key({options.modkey}, 'l', atag.viewnext, {
      description = 'focus previous by index',
      group = group,
    }),
    key({options.modkey}, '`', atag.history.restore, {
      description = 'jump to previous',
      group = group,
    }))
  for i,tag in pairs(options.tags) do
    local k = '#'..(i + 9)
    options.global_keys = util.table.join(
      options.global_keys,
      key({options.modkey}, k, view_tag(i), {
        description = 'go to tag '..tag,
        group = group,
      }),
      key({options.modkey, 'Control'}, k, toggle_tag(i), {
        description = 'toggle tag '..tag,
        group = group,
      }),
      key({options.modkey, 'Shift'}, k, move_client(i, options), {
        description = 'move focused client to tag '..tag,
        group = group,
      }),
      key({options.modkey, 'Control', 'Shift'}, k, toggle_client(i, options), {
        description = 'toggle focused client on tag '..tag,
        group = group,
      }))
  end
  ascreen.connect_for_each_screen(setup_screen(options))
end
