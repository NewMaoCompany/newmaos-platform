const fs = require('fs');

let current = fs.readFileSync('/Users/zhuchen/Downloads/newmaos---ap-calculus-mastery/pages/Forum.tsx', 'utf8');
const old = fs.readFileSync('/tmp/Forum.d53.tsx', 'utf8');

function extract(content, startStr, endStr) {
    const start = content.indexOf(startStr);
    const end = content.indexOf(endStr, start) + endStr.length;
    return content.substring(start, end);
}

// Revert handleRemoveFriend
const newHRF = extract(current, '    const handleRemoveFriend = async (friendId: string, event: React.MouseEvent) => {', '        });\n    };');
const oldHRF = extract(old, '    const handleRemoveFriend = async (friendId: string, event: React.MouseEvent) => {', '        });\n    };');
current = current.replace(newHRF, oldHRF);

// Revert fetchDMs
const newFDMs = extract(current, '    // Fetch DM Chats', '            setIsLoadingDMs(false);\n        }\n    };');
const oldFDMs = extract(old, '    // Fetch DM Chats', '            setIsLoadingDMs(false);\n        }\n    };');
current = current.replace(newFDMs, oldFDMs);

// Revert UI Button
const newUIBtn = extract(current, '                                                    {/* Action Buttons: Remove Friend / Chat */}', '                                                </button>\n                                            ))\n                                        )}');
const oldUIBtn = extract(old, '                                                    {/* Delete Friend Button */}', '                                                </button>\n                                            ))\n                                        )}');
current = current.replace(newUIBtn, oldUIBtn);

fs.writeFileSync('/Users/zhuchen/Downloads/newmaos---ap-calculus-mastery/pages/Forum.tsx', current);
console.log('Revert applied.');
