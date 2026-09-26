swayimg.viewer.on_key("n", function() swayimg.viewer.open("next") end)
swayimg.viewer.on_key("p", function() swayimg.viewer.open("prev") end)
swayimg.viewer.on_key("q", function() swayimg.exit() end)
swayimg.gallery.on_key("q", function() swayimg.exit() end)

swayimg.viewer.on_key("Escape", function() end)
swayimg.gallery.on_key("Escape", function() end)


swayimg.overlay = false -- Ensures it opens as a standard independent window
swayimg.antialiasing = true
swayimg.text.visible = false

swayimg.viewer.on_key("Shift+i", function()
    swayimg.text.visible = not swayimg.text.visible
end)

swayimg.gallery.on_key("Shift+i", function()
    swayimg.text.visible = not swayimg.text.visible
end)

swayimg.text.color = 0xffffffff      -- White text
swayimg.text.background = 0xff000000 -- Black background
swayimg.text.shadow = 0x00000000     -- Disable shadow (optional, for clean contrast)


-- Delete / Trash current image with 'd'
swayimg.viewer.on_key("d", function()
    local img = swayimg.viewer.get_image()
    if img and img.path then
        os.execute("gio trash " .. string.format("%q", img.path))
        swayimg.viewer.open("next")
    end
end)

swayimg.gallery.on_key("d", function()
    local img = swayimg.gallery.get_image()
    if img and img.path then
        os.execute("gio trash " .. string.format("%q", img.path))
        swayimg.gallery.reload()
    end
end)

-- Single 'y' to yank the actual image bytes to the clipboard
swayimg.viewer.on_key("y", function()
    local img = swayimg.viewer.get_image()
    if img and img.path then
        os.execute("wl-copy -t image/png < " .. string.format("%q", img.path))
        os.execute("notify-send 'Swayimg' 'Yanked image to clipboard'")
    end
end)

swayimg.gallery.on_key("y", function()
    local img = swayimg.gallery.get_image()
    if img and img.path then
        os.execute("wl-copy -t image/png < " .. string.format("%q", img.path))
        os.execute("notify-send 'Swayimg' 'Yanked image to clipboard'")
    end
end)

-- Shift+y to copy the file path
swayimg.viewer.on_key("Shift+y", function()
    local img = swayimg.viewer.get_image()
    if img and img.path then
        os.execute("echo -n " .. string.format("%q", img.path) .. " | wl-copy")
        os.execute("notify-send 'Swayimg' 'Copied path to clipboard'")
    end
end)

swayimg.gallery.on_key("Shift+y", function()
    local img = swayimg.gallery.get_image()
    if img and img.path then
        os.execute("echo -n " .. string.format("%q", img.path) .. " | wl-copy")
        os.execute("notify-send 'Swayimg' 'Copied path to clipboard'")
    end
end)

-- Rotate clockwise with 'r' (90 degrees)
swayimg.viewer.on_key("r", function() swayimg.viewer.rotate(90) end)
swayimg.gallery.on_key("r", function() swayimg.gallery.rotate(90) end)

-- Rotate counter-clockwise with Shift+r (270 degrees)
swayimg.viewer.on_key("Shift+r", function() swayimg.viewer.rotate(270) end)
swayimg.gallery.on_key("Shift+r", function() swayimg.gallery.rotate(270) end)

-- Rotate clockwise with 'r' (90 degrees)
swayimg.viewer.on_key("r", function() swayimg.viewer.rotate(90) end)
swayimg.gallery.on_key("r", function() swayimg.gallery.rotate(90) end)

-- Rotate counter-clockwise with Shift+r (270 degrees)
swayimg.viewer.on_key("Shift+r", function() swayimg.viewer.rotate(270) end)
swayimg.gallery.on_key("Shift+r", function() swayimg.gallery.rotate(270) end)

swayimg.viewer.on_key("z", function() swayimg.viewer.set_fix_scale("fit") end)
swayimg.viewer.on_key("0", function() swayimg.viewer.set_fix_scale("real") end)

swayimg.viewer.on_key("Ctrl+r", function() swayimg.viewer.reload() end)
