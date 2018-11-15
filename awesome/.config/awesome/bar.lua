local key = require('awful.key')
local prompt = require('awful.prompt')
local ascreen = require('awful.screen')
local spawn = require('awful.spawn')
local util = require('awful.util')
local wibar = require('awful.wibar')
local layoutbox = require('awful.widget.layoutbox')
local prompt_widget = require('awful.widget.prompt')
local taglist = require('awful.widget.taglist')
local beautiful = require('beautiful')
local align = require('wibox.layout.align')
local fixed = require('wibox.layout.fixed')
local systray = require('wibox.widget.systray')
local textclock = require('wibox.widget.textclock')

local bars = {}
local bar_autohide_opacity = 0
local bar_visible = {
  mouse = false,
  prompt = false,
}
local group = 'Bar'
local prompt_box = prompt_widget()
local system_tray = systray()
local text_clock = textclock('%A · %B %d · %I:%M')

local function redraw_bar(screen)
  local visible = false
  for _, visible_sub in pairs(bar_visible) do
    visible = visible or visible_sub
  end
  bars[screen].opacity = visible and 1 or bar_autohide_opacity
end

local function redraw_bars()
  ascreen.connect_for_each_screen(redraw_bar)
end

local function hide_bars_via_mouse()
  bar_visible.mouse = false
  redraw_bars()
end

local function show_bars_via_mouse()
  bar_visible.mouse = true
  redraw_bars()
end

local function hide_bars_via_prompt()
  bar_visible.prompt = false
  redraw_bars()
end

local function show_bars_via_prompt()
  bar_visible.prompt = true
  redraw_bars()
end

local function toggle_autohide_bar()
  bar_autohide_opacity = bar_autohide_opacity ~= 1 and 1 or 0
  redraw_bars()
end

local function lua_prompt()
  show_bars_via_prompt()
  prompt.run {
    prompt = ' Lua: ',
    textbox = prompt_box.widget,
    exe_callback = util.eval,
    done_callback = hide_bars_via_prompt,
    history_path = util.get_cache_dir()..'/history_eval',
  }
end

local function run_prompt()
  show_bars_via_prompt()
  prompt.run {
    prompt = ' Exec: ',
    textbox = prompt_box.widget,
    exe_callback = spawn,
    done_callback = hide_bars_via_prompt,
    history_path = util.get_cache_dir()..'/history',
  }
end

local function setup_bar(screen)
  local bar = bars[screen]
  if bar then
    bar:remove()
    bars[screen] = nil
  end
  bar = wibar {
    position = 'top',
    screen = screen,
  }
  bars[screen] = bar
  bar:setup {
    layout = align.horizontal,
    expand = 'none',
    {
      layout = fixed.horizontal,
      prompt_box,
      taglist(screen, taglist.filter.all),
    },
    text_clock,
    {
      layout = fixed.horizontal,
      system_tray,
      layoutbox(screen),
    },
  }
  bar:struts {
    top = 0,
  }
  bar:connect_signal('mouse::enter', show_bars_via_mouse)
  bar:connect_signal('mouse::leave', hide_bars_via_mouse)
end

return function(options)
  options.global_keys = util.table.join(
    options.global_keys,
    key({options.modkey}, 'space', toggle_autohide_bar, {
      description = 'toggle autohide',
      group = group,
    }),
    key({options.modkey}, 'Return', run_prompt, {
      description = 'run prompt',
      group = group,
    }),
    key({options.modkey, 'Control'}, 'Return', lua_prompt, {
      description = 'lua execute prompt',
      group = group,
    }))
  ascreen.connect_for_each_screen(setup_bar)
  redraw_bars()
end
