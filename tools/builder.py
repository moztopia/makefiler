#!/usr/bin/env python3
import os
import json

# Configuration
ROOT_DIR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
DIST_DIR = os.path.join(ROOT_DIR, "dist")
OUTPUT_FILE = os.path.join(DIST_DIR, "makefiler_installer.py")

INSTALLER_TEMPLATE = """#!/usr/bin/env python3
import os
import sys

# Embedded Files
FILES = {files_json}

def install(target_dir):
    if not os.path.exists(target_dir):
        try:
            os.makedirs(target_dir)
        except OSError as e:
            print(f"Error creating directory {{target_dir}}: {{e}}")
            sys.exit(1)

    print(f"Installing Makefiler to {target_dir}...")

    for file_path, content in FILES.items():
        full_path = os.path.join(target_dir, file_path)
        dir_name = os.path.dirname(full_path)
        
        if dir_name and not os.path.exists(dir_name):
            os.makedirs(dir_name)
            
        with open(full_path, "w", encoding="utf-8") as f:
            f.write(content)
        
        print(f"  Created {file_path}")

    print(f"\\n✅ Makefiler installed successfully in {target_dir}!")
    print("Run 'make help' to get started.")

if __name__ == "__main__":
    target = "."
    if len(sys.argv) > 1:
        target = sys.argv[1]
    
    abs_target = os.path.abspath(target)
    
    # ANSI colors
    RED = "\\033[31m"
    RESET = "\\033[0m"
    
    print(f"We are getting ready to install makefiler {RED}{abs_target}{RESET}.")
    response = input("Are you sure? y/N ").strip().lower()
    
    if response != 'y':
        print("Installation aborted.")
        sys.exit(0)
        
    install(target)
"""

def read_file(path):
    with open(path, "r", encoding="utf-8") as f:
        return f.read()

def main():
    files_to_embed = {}
    
    # Add Makefile
    makefile_path = os.path.join(ROOT_DIR, "Makefile")
    if os.path.exists(makefile_path):
        files_to_embed["Makefile"] = read_file(makefile_path)
    else:
        print(f"Error: Makefile not found at {makefile_path}")
        return

    # Add contents of makefiler directory
    makefiler_dir = os.path.join(ROOT_DIR, "makefiler")
    if os.path.exists(makefiler_dir):
        for filename in os.listdir(makefiler_dir):
            if filename.endswith(".mk"):
                file_path = os.path.join(makefiler_dir, filename)
                files_to_embed[f"makefiler/{filename}"] = read_file(file_path)
    
    # Generate Installer
    if not os.path.exists(DIST_DIR):
        os.makedirs(DIST_DIR)
        
    installer_content = INSTALLER_TEMPLATE.replace(
        "{files_json}", 
        json.dumps(files_to_embed, indent=4)
    )
    
    with open(OUTPUT_FILE, "w", encoding="utf-8") as f:
        f.write(installer_content)
    
    # Make executable
    os.chmod(OUTPUT_FILE, 0o755)
    
    print(f"Installer generated at: {OUTPUT_FILE}")

if __name__ == "__main__":
    main()
