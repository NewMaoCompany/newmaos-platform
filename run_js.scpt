tell application "Google Chrome"
    activate
    set theTab to active tab of front window
    set jsCode to "(function() { return document.body.innerText; })();"
    set res to execute theTab javascript jsCode
    return res
end tell
