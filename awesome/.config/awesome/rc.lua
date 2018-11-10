require('awful.autofocus')
local focus = require('awful.client.focus')
local suit = require('awful.layout.suit')
local placement = require('awful.placement')
local rules = require('awful.rules')
local ascreen = require('awful.screen')
local beautiful = require('beautiful')

local options = {
  awesome = awesome,
  client = client,
  client_buttons = {},
  client_keys = {},
  global_keys = {},
  layouts = {
    suit.tile,
    suit.fair.horizontal,
    suit.max,
  },
  modkey = 'Mod1',
  screen = screen,
  tags = {1, 2, 3, 4, 5, 6, 7, 8, 9, 0},
  transparency = os.execute('which compton && (compton -b || true)'),
}

os.execute('which redshift && (pidof redshift || redshift &)')
os.execute('which unclutter && (pidof unclutter || unclutter -root &)')
os.execute('which urxvtd && (pidof urxvtd || urxvtd &)')
os.execute('which vmware-user-suid-wrapper && vmware-user-suid-wrapper')
os.execute('which xrdb && xrdb -merge ~/.Xresources')
require('.awesome')(options)
require('.bar')(options)
require('.client')(options)
require('.launcher')(options)
require('.layout')(options)
require('.tags')(options)

rules.rules = {
  {
    rule = {},
    properties = {
      border_width = beautiful.border_width,
      border_color = beautiful.border_normal,
      focus = focus.filter,
      raise = true,
      keys = options.client_keys,
      buttons = options.client_buttons,
      screen = ascreen.preferred,
      placement = placement.no_overlap + placement.no_offscreen,
      size_hints_honor = false,
    },
  },
  {
    rule_any = {
      instance = {
        'DTA',  -- Firefox addon DownThemAll.
        'copyq',  -- Includes session name in class.
      },
      class = {
        'Arandr',
        'Gpick',
        'Kruler',
        'MessageWin',  -- kalarm.
        'Sxiv',
        'Wpa_gui',
        'pinentry',
        'veromix',
        'xtightvncviewer',
      },
      name = {
        'Event Tester',  -- xev.
      },
      role = {
        'AlarmWindow',  -- Thunderbird's calendar.
        'pop-up',       -- e.g. Google Chrome's (detached) Developer Tools.
      },
    },
    properties = {
      floating = true,
    },
  },
}
root.keys(options.global_keys)
