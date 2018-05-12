local hotkeys_popup = require('awful.hotkeys_popup.widget')
local key = require('awful.key')
local layout = require('awful.layout')
local ascreen = require('awful.screen')
local util = require('awful.util')
local beautiful = require('beautiful')
local color = require('gears.color')
local gwallpaper = require('gears.wallpaper')
local naughty = require('naughty')
local theme = require('.theme')

local group = 'Awesome'
local in_error = false

local function notify_error(error)
  if in_error then return end
  in_error = true
  naughty.notify {
    preset = naughty.config.presets.critical,
    title = 'Oops, an error happened!',
    text = tostring(error),
  }
  in_error = false
end

local function set_wallpaper(screen)
  if not beautiful.wallpaper then return end
  local wallpaper = beautiful.wallpaper
  if type(wallpaper) == 'function' then
    wallpaper = wallpaper(screen)
  end
  gwallpaper.maximized(wallpaper, screen, false)
end

return function(options)
  options.awesome.connect_signal('debug::error', notify_error)
  beautiful.init(theme)
  layout.layouts = options.layouts
  ascreen.connect_for_each_screen(set_wallpaper)
  options.screen.connect_signal('property::geometry', set_wallpaper)
  options.global_keys = util.table.join(
    options.global_keys,
    key({options.modkey}, '/', hotkeys_popup.show_help, {
      description = 'show help',
      group = group,
    }),
    key({options.modkey, 'Control'}, 'r', options.awesome.restart, {
      description = 'reload awesome',
      group = group,
    }),
    key({options.modkey, 'Control', 'Shift'}, 'q', options.awesome.quit, {
      description = 'quit awesome',
      group = group,
    }))
end
