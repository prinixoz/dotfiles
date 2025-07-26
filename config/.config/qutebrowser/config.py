config.load_autoconfig()  # or config.load_autoconfig(False) if you're not using GUI settings

# Hide parts from browser
c.tabs.show = "never"
c.statusbar.show = "never"

# Disable history
c.url.default_page = "about:blank"
c.url.start_pages = ["about:blank"]

# Disable all cookies
c.content.cookies.accept = "never"

# Enable dark mode for websites
c.colors.webpage.darkmode.enabled = True

# Optional: Prefer dark color schemes from websites (if they support it)
c.colors.webpage.preferred_color_scheme = "dark"

# UI colors (tabs, status bar, etc.)
c.colors.statusbar.normal.bg = "#1e1e1e"
c.colors.statusbar.insert.bg = "#005f87"
c.colors.statusbar.passthrough.bg = "#875f00"
c.colors.statusbar.command.bg = "#2e2e2e"
c.colors.tabs.bar.bg = "#1e1e1e"
c.colors.tabs.odd.bg = "#2e2e2e"
c.colors.tabs.even.bg = "#2e2e2e"
c.colors.tabs.selected.odd.bg = "#444444"
c.colors.tabs.selected.even.bg = "#444444"
c.colors.completion.category.bg = "#1e1e1e"
c.colors.completion.item.selected.bg = "#444444"

c.editor.command = ["alacritty", "-e", "nvim", "{}"]

c.content.cookies.accept = "no-3rdparty"
c.content.headers.referer = "same-domain"
c.content.webgl = False
c.content.canvas_reading = False

{
    "DEFAULT": "https://duckduckgogg42xjoc72x3sjasowoarfbgcmvfimaftt6twagswzczad.onion/?q={}",
    "wa": "https://wiki.archlinux.org/?search={}",
}
