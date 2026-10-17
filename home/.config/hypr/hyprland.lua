-- Learn how to configure Hyprland: https://wiki.hypr.land/Configuring/Start/

-- Omarchy's bootstrap keeps path setup out of this user config.
dofile((os.getenv("OMARCHY_PATH") or "/usr/share/omarchy") .. "/default/hypr/bootstrap.lua")

-- Disable all Omarchy default bindings. Add your own in hypr/bindings.lua.
-- omarchy_default_bindings = false
--
-- Or disable only bindings for Omarchy's preinstalled apps/web apps while
-- keeping core window-manager bindings:
-- omarchy_preinstalled_bindings = false

-- Load Omarchy defaults.
require("default.hypr.omarchy")

-- Put your personal overrides in these files. They're loaded after Omarchy's
-- defaults so package updates can improve the defaults without rewriting your
-- ~/.config/hypr files.
require("hypr.monitors")
require("hypr.input")
require("hypr.bindings")
require("hypr.looknfeel")
require("hypr.autostart")

-- Toggle config flags dynamically.
require("default.hypr.toggles")

-- Add any other personal Hyprland configuration below.
-- o.window("qemu", { workspace = "5" })

-- Chat apps open on workspace 10 as one tabbed group (see ~/.local/bin/chat-hub).
-- focus_on_activate = false: a new message never pulls you away from your work.
o.window(
  "^(chrome-(web\\.whatsapp\\.com|www\\.messenger\\.com|www\\.instagram\\.com|discord\\.com|teams\\.microsoft\\.com).*|org\\.telegram\\.desktop)$",
  { workspace = "10", group = "set", focus_on_activate = false }
)

-- Telegram's media viewer asks for fullscreen and the state sticks after it closes.
-- Ignore the app's own fullscreen requests (SUPER + F still works).
o.window("^org\\.telegram\\.desktop$", { suppress_event = "fullscreen" })

-- emby-dl runs in a centered floating terminal.
o.window("org.omarchy.emby-dl", { float = true })
o.window("org.omarchy.emby-dl", { center = true })
o.window("org.omarchy.emby-dl", { size = { 1300, 760 } })

-- remote (VPN + Remmina picker) is a small centered floating terminal.
o.window("org.omarchy.remote", { float = true })
o.window("org.omarchy.remote", { center = true })
o.window("org.omarchy.remote", { size = { 760, 320 } })

-- notif-mute (per-app notification switches) is a small centered floating terminal.
o.window("org.omarchy.notif-mute", { float = true })
o.window("org.omarchy.notif-mute", { center = true })
o.window("org.omarchy.notif-mute", { size = { 560, 340 } })
