import re

def check_jsx(file_path):
    with open(file_path, 'r') as f:
        lines = f.readlines()

    open_divs = 0
    start_line = 1438 # return statement
    
    print(f"Tracing DIVs from line {start_line}:")
    for i, line in enumerate(lines[start_line-1:], start=start_line):
        stripped = line.strip()
        if not stripped or stripped.startswith("//") or stripped.startswith("/*"):
            continue
            
        # Very simple count
        opens = line.count("<div")
        closes = line.count("</div>")
        
        if opens > 0 or closes > 0:
            old = open_divs
            open_divs += opens - closes
            print(f"{i}: {old} -> {open_divs} (+{opens}, -{closes}) | {stripped[:60]}")

check_jsx('/Users/zhuchen/Downloads/newmaos---ap-calculus-mastery/pages/Forum.tsx')
