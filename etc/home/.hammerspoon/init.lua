hs.hotkey.bind({ "cmd", "alt", "ctrl" }, "W", function()
    hs.notify.new({ title = "Hammerspoon", informativeText = "Hello World" }):send()
end)


hs.hotkey.bind({ "cmd", "alt", "ctrl" }, "A", function()
    -- hs.alert.closeAll(0.0)
    local code = [[tell application "System Events"
        tell process "NotificationCenter"
            set numwins to (count windows)
            repeat with i from numwins to 1 by -1
                click button "Close" of window i
            end repeat
        end tell
    end tell]]
    hs.osascript.applescript(code)
end)


