-- Extra autostart processes.
-- o.launch_on_start("my-service")

-- Chat hub on workspace 10; returns to the workspace you were on when done.
o.launch_on_start("/home/bady/.local/bin/chat-hub --background")

-- WireGuard VPN on at login; the VPN button in the bar switches it off/on (see ~/.config/omarchy/bar/scripts/wireguard-toggle).
o.launch_on_start("/home/bady/.config/omarchy/bar/scripts/wireguard-autostart")
