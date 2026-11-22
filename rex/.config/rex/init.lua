-- Rex config, migrated from ~/.tmux.conf and ~/.config/ghostty/config

-- tmux (prefix ctrl+s)
rex.bind("ctrl+s>ctrl+s", "pane.send_key", { key = "ctrl+s" })
rex.bind("ctrl+s>r", "client.config.reload")
rex.bind("ctrl+s>h", "pane.focus", { direction = "left" })
rex.bind("ctrl+s>j", "pane.focus", { direction = "down" })
rex.bind("ctrl+s>k", "pane.focus", { direction = "up" })
rex.bind("ctrl+s>l", "pane.focus", { direction = "right" })

-- Ghostty: tabs and windows
rex.bind("ctrl+shift+t", "client.tab.new")
rex.bind("ctrl+shift+n", "client.window.new")
rex.bind("ctrl+shift+w", "pane.close")
rex.bind("ctrl+shift+h", "client.tab.previous")
rex.bind("ctrl+shift+l", "client.tab.next")
rex.bind("alt+1", "client.tab.goto", { index = 1 })
rex.bind("alt+2", "client.tab.goto", { index = 2 })
rex.bind("alt+3", "client.tab.goto", { index = 3 })
rex.bind("alt+4", "client.tab.goto", { index = 4 })
rex.bind("alt+5", "client.tab.goto", { index = 5 })
rex.bind("alt+6", "client.tab.goto", { index = 6 })
rex.bind("alt+7", "client.tab.goto", { index = 7 })
rex.bind("alt+8", "client.tab.goto", { index = 8 })
rex.bind("alt+9", "client.tab.goto", { index = -1 })

-- Ghostty: splits
rex.bind("ctrl+shift+d", "pane.split", { direction = "right" })
rex.bind("ctrl+shift+e", "pane.split", { direction = "down" })
rex.bind("ctrl+shift+up", "pane.focus", { direction = "up" })
rex.bind("ctrl+shift+down", "pane.focus", { direction = "down" })
rex.bind("ctrl+shift+left", "pane.focus", { direction = "left" })
rex.bind("ctrl+shift+right", "pane.focus", { direction = "right" })
