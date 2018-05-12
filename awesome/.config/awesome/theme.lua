local xresources = require('beautiful.xresources')

local images_dir = os.getenv('HOME')..'/.config/awesome/images'
local text_colors = {
  focus = '#ffffff',
  urgent = '#c1cbcf',
  normal = '#84979f',
  minimal = '#46636f',
  hidden = '#082f3f',
}
local dpi = xresources.apply_dpi
local wibar_height = dpi(23)
local theme = {
  bg_normal = text_colors.hidden,
  border_width = dpi(1),
  fg_focus = text_colors.focus,
  fg_urgent = text_colors.urgent,
  fg_normal = text_colors.normal,
  fg_minimize = text_colors.minimal,
  font = 'Fira Sans medium 9',
  layout_dwindle = images_dir..'/layout/dwindle.png',
  layout_fairv = images_dir..'/layout/fairv.png',
  layout_fairh = images_dir..'/layout/fairh.png',
  layout_floating = images_dir .. '/layout/floating.png',
  layout_magnifier = images_dir..'/layout/magnifier.png',
  layout_max = images_dir..'/layout/max.png',
  layout_spiral = images_dir..'/layout/spiral.png',
  layout_tile = images_dir..'/layout/tile.png',
  layout_tileleft = images_dir..'/layout/tileleft.png',
  layout_tilebottom = images_dir..'/layout/tilebottom.png',
  layout_tiletop = images_dir..'/layout/tiletop.png',
  taglist_fg_focus = text_colors.focus,
  taglist_fg_urgent = text_colors.urgent,
  taglist_fg_occupied = text_colors.normal,
  taglist_fg_volatile = text_colors.minimal,
  taglist_fg_empty = text_colors.hidden,
  useless_gap = wibar_height / 2,
  wallpaper = images_dir..'/wallpaper.png',
  wibar_height = wibar_height,
}

return theme
