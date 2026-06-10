tell application "Safari"
    activate
    set theTab to current tab of front window
    set res to do JavaScript "document.body.innerText;" in theTab
    return res
end tell
