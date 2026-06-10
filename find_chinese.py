import os
import re

def find_chinese(directory):
    pattern = re.compile(r'[\u4e00-\u9fa5]')
    for root, dirs, files in os.walk(directory):
        if 'node_modules' in dirs:
            dirs.remove('node_modules')
        if '.git' in dirs:
            dirs.remove('.git')
        for file in files:
            if file.endswith(('.tsx', '.ts')):
                path = os.path.join(root, file)
                try:
                    with open(path, 'r', encoding='utf-8') as f:
                        lines = f.readlines()
                        for i, line in enumerate(lines):
                            if pattern.search(line):
                                print(f"{path}:{i+1}:{line.strip()}")
                except Exception as e:
                    pass

find_chinese('components')
find_chinese('pages')
find_chinese('src')
