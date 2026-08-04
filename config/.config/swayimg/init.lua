-- ~/.config/swayimg/init.lua

--------------------------------------------------
-- General
--------------------------------------------------

swayimg.enable_overlay(false)
swayimg.enable_antialiasing(true)

swayimg.viewer.set_default_scale("optimal")
swayimg.viewer.enable_centering(true)
swayimg.viewer.enable_loop(true)

swayimg.viewer.set_window_background(0xff000000)
swayimg.viewer.set_image_background(0xff111111)

--------------------------------------------------
-- Image list
--------------------------------------------------

swayimg.imagelist.set_order("alpha")
swayimg.imagelist.enable_recursive(false)
swayimg.imagelist.enable_adjacent(true)

--------------------------------------------------
-- Text UI
--------------------------------------------------

swayimg.text.set_font("monospace")
swayimg.text.set_size(14)
swayimg.text.set_foreground(0xffcccccc)
swayimg.text.set_shadow(0xaa000000)

swayimg.viewer.set_text("topleft", {
    "{name}",
    "{format}",
    "{sizehr}",
    "{frame.width}x{frame.height}",
})

swayimg.viewer.set_text("topright", {
    "[{list.index}/{list.total}]",
})

swayimg.viewer.set_text("bottomleft", {
    "Zoom: {scale}%",
})

--------------------------------------------------
-- Gallery Look
--------------------------------------------------

swayimg.gallery.set_thumb_size(240)
swayimg.gallery.set_padding_size(12)
swayimg.gallery.set_border_size(3)

swayimg.gallery.set_selected_scale(1.08)

swayimg.gallery.set_window_color(0xff111111)
swayimg.gallery.set_selected_color(0xff222222)
swayimg.gallery.set_unselected_color(0xff111111)

--------------------------------------------------
-- Helpers
--------------------------------------------------

local function zoom(factor)
    local scale = swayimg.viewer.get_scale()
    swayimg.viewer.set_abs_scale(scale * factor)
end

local function move(dx, dy)
    local pos = swayimg.viewer.get_position()
    swayimg.viewer.set_abs_position(pos.x + dx, pos.y + dy)
end

--------------------------------------------------
-- Viewer Keybinds
--------------------------------------------------

swayimg.viewer.bind_reset()

-- Open gallery
swayimg.viewer.on_key("g", function()
    swayimg.set_mode("gallery")
end)

-- Navigation
swayimg.viewer.on_key("n", function()
    swayimg.viewer.switch_image("next")
end)

swayimg.viewer.on_key("p", function()
    swayimg.viewer.switch_image("prev")
end)

swayimg.viewer.on_key("Shift+j", function()
    swayimg.viewer.switch_image("next")
end)

swayimg.viewer.on_key("Shift+k", function()
    swayimg.viewer.switch_image("prev")
end)

-- Movement
swayimg.viewer.on_key("h", function()
    move(-40, 0)
end)

swayimg.viewer.on_key("j", function()
    move(0, 40)
end)

swayimg.viewer.on_key("k", function()
    move(0, -40)
end)

swayimg.viewer.on_key("l", function()
    move(40, 0)
end)

-- Zoom
swayimg.viewer.on_key("Equal", function()
    zoom(1.1)
end)

swayimg.viewer.on_key("Minus", function()
    zoom(0.9)
end)

swayimg.viewer.on_key("z", function()
    swayimg.viewer.set_fix_scale("fit")
end)

swayimg.viewer.on_key("w", function()
    swayimg.viewer.set_fix_scale("width")
end)

swayimg.viewer.on_key("0", function()
    swayimg.viewer.set_fix_scale("real")
end)

swayimg.viewer.on_key("BackSpace", function()
    swayimg.viewer.set_fix_scale("optimal")
end)

-- Rotate
swayimg.viewer.on_key("[", function()
    swayimg.viewer.rotate(270)
end)

swayimg.viewer.on_key("]", function()
    swayimg.viewer.rotate(90)
end)

-- Flip
swayimg.viewer.on_key("m", function()
    swayimg.viewer.flip_vertical()
end)

swayimg.viewer.on_key("Shift+m", function()
    swayimg.viewer.flip_horizontal()
end)

-- Fullscreen
swayimg.viewer.on_key("f", function()
    swayimg.set_fullscreen()
end)

-- Reload
swayimg.viewer.on_key("r", function()
    swayimg.viewer.reload()
end)

-- Quit
swayimg.viewer.on_key("q", function()
    swayimg.exit()
end)

--------------------------------------------------
-- Mouse
--------------------------------------------------

swayimg.viewer.on_mouse("Ctrl-MouseScrollUp", function()
    zoom(1.1)
end)

swayimg.viewer.on_mouse("Ctrl-MouseScrollDown", function()
    zoom(0.9)
end)

--------------------------------------------------
-- Gallery Keybinds
--------------------------------------------------

swayimg.gallery.bind_reset()

-- Return to viewer
swayimg.gallery.on_key("g", function()
    swayimg.set_mode("viewer")
end)

swayimg.gallery.on_key("Return", function()
    local image = swayimg.gallery.get_image()

    if image and image.path then
        swayimg.viewer.open(image.path)
        swayimg.set_mode("viewer")
    end
end)


-- Vim movement
swayimg.gallery.on_key("h", function()
    swayimg.gallery.switch_image("left")
end)

swayimg.gallery.on_key("j", function()
    swayimg.gallery.switch_image("down")
end)

swayimg.gallery.on_key("k", function()
    swayimg.gallery.switch_image("up")
end)

swayimg.gallery.on_key("l", function()
    swayimg.gallery.switch_image("right")
end)

-- Page movement
swayimg.gallery.on_key("Ctrl+d", function()
    swayimg.gallery.switch_image("pgdown")
end)

swayimg.gallery.on_key("Ctrl+u", function()
    swayimg.gallery.switch_image("pgup")
end)

-- Quit
swayimg.gallery.on_key("q", function()
    swayimg.exit()
end)

--------------------------------------------------
-- Start in gallery mode
--------------------------------------------------

swayimg.on_initialized(function()
    swayimg.set_mode("gallery")
end)
