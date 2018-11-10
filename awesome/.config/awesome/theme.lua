local xresources = require('beautiful.xresources')

local images_dir = os.getenv('HOME')..'/.config/awesome/images'
local colors = {
  focus = '#ffffff',
  urgent = '#c1cbcf',
  normal = '#84979f',
  minimal = '#46636f',
  hidden = '#082f3f',
}
local dpi = xresources.apply_dpi
local wibar_height = dpi(23)

return function(options)
  return {
    bg_normal = options.transparency and colors.hidden..'00' or colors.hidden,
    border_width = dpi(1),
    fg_focus = colors.focus,
    fg_urgent = colors.urgent,
    fg_normal = colors.normal,
    fg_minimize = colors.minimal,
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
    taglist_fg_focus = colors.focus,
    taglist_fg_urgent = colors.urgent,
    taglist_fg_occupied = colors.normal,
    taglist_fg_volatile = colors.minimal,
    taglist_fg_empty = colors.hidden,
    useless_gap = wibar_height / 2,
    wallpaper = images_dir..'/wallpaper.png',
    wibar_height = wibar_height,
  }
end
