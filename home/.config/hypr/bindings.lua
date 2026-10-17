-- Keep only your personal keybinding overrides here. Add new bindings or
-- unbind defaults before replacing them.

-- See current bindings and descriptions:
--   omarchy menu keybindings --print

-- To disable every Omarchy default binding, set this in
-- ~/.config/hypr/hyprland.lua before require("default.hypr.omarchy"), then add
-- only the bindings you want below:
--   omarchy_default_bindings = false

-- To disable all preinstalled app/webapp bindings, set:
--   omarchy_preinstalled_bindings = false

-- Add a new binding.
-- o.bind("SUPER + SHIFT + R", "SSH", "alacritty -e ssh your-server")

-- Change an existing binding by unbinding it first, then binding the key again.
-- This example changes SUPER+SPACE from the launcher to the Omarchy root menu.
-- hl.unbind("SUPER + SPACE")
-- o.bind("SUPER + SPACE", "Omarchy menu", "omarchy-menu toggle root")

-- Disable a default binding without replacing it.
-- hl.unbind("SUPER + SHIFT + B")

-- Chat hub: Telegram, Discord, Messenger, Instagram, WhatsApp, Teams as tabs on workspace 10.
o.bind("SUPER + M", "Chat hub", "/home/bady/.local/bin/chat-hub")
-- Omarchy binds SUPER + ALT + 1..5 to group tabs; add the sixth (Teams).
o.bind("SUPER + ALT + code:15", "Switch to group window 6", hl.dsp.group.active({ index = 6 }))
-- Show the chat hub controls legend as a notification.
o.bind("SUPER + ALT + M", "Chat hub help", "/home/bady/.local/bin/chat-hub-help")

-- Emby client (Tsukimi): open or focus.
o.bind("SUPER + SHIFT + V", "Emby (Tsukimi)", "/home/bady/.local/bin/tsukimi-open")
-- Emby downloader (emby-dl) in a floating terminal.
o.bind("SUPER + ALT + V", "Emby download", "/home/bady/.local/bin/emby-dl-window")

-- Cinema mode: no idle lock/screensaver, no notifications, bar hidden (toggle).
o.bind("SUPER + SHIFT + K", "Kino mode", "/home/bady/.local/bin/kino toggle")

-- Remote desktop: bring the VPN up when needed, open a Remmina profile (see ~/.local/bin/remote).
o.bind("SUPER + SHIFT + R", "Remote desktop", "/home/bady/.local/bin/remote-window")

-- Logitech MX Keys examples:
-- o.bind("SUPER + SHIFT + S", nil, "omarchy-capture-screenshot")
-- o.bind("SUPER + H", nil, "voxtype record toggle")
-- o.bind("SUPER + PERIOD", nil, "omarchy-shell shell toggle omarchy.emojis")

-- Shortcut learning: full cheat sheet as a notification (random tips also arrive via keytip.timer).
o.bind("SUPER + CTRL + ALT + K", "Cheat sheet", "/home/bady/.local/bin/keytip all")

-- Volume above 100%: Omarchy's default caps at 100, this wrapper goes to 150% (software gain).
hl.unbind("XF86AudioRaiseVolume")
hl.unbind("XF86AudioLowerVolume")
hl.unbind("ALT + XF86AudioRaiseVolume")
hl.unbind("ALT + XF86AudioLowerVolume")
o.bind("XF86AudioRaiseVolume", "Volume up", "/home/bady/.local/bin/volume-boost raise", { locked = true, repeating = true })
o.bind("XF86AudioLowerVolume", "Volume down", "/home/bady/.local/bin/volume-boost lower", { locked = true, repeating = true })
o.bind("ALT + XF86AudioRaiseVolume", "Volume up precise", "/home/bady/.local/bin/volume-boost +1", { locked = true, repeating = true })
o.bind("ALT + XF86AudioLowerVolume", "Volume down precise", "/home/bady/.local/bin/volume-boost -1", { locked = true, repeating = true })
