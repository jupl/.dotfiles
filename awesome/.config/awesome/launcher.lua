local key = require('awful.key')
local spawn = require('awful.spawn')
local util = require('awful.util')
local beautiful = require('beautiful')
local menubar = require('menubar')

local group = 'Launcher'

local function launch_terminal()
  spawn('urxvtc')
end

return function(options)
  menubar.show_categories = false
  options.global_keys = util.table.join(
    options.global_keys,
    key({options.modkey, 'Shift'}, 'Return', menubar.show, {
      description = 'show the menubar',
      group = group,
    }),
    key({options.modkey}, ';', launch_terminal, {
      description = 'open a terminal',
      group = group,
    }))
end
